--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Alphonse Mariyagnanaseelan

--]]

local helpers       = require("lain.helpers")
local awful         = require("awful")
local shell         = require("awful.util").shell
local wibox         = require("wibox")
local naughty       = require("naughty")
local lines, floor  = io.lines, math.floor
local string        = { format = string.format,
                        gsub   = string.gsub,
                        len    = string.len}

-- Available updates
-- themes.powerarrow-gruvbox.widgets

local function factory(args)
    local pacman          = { widget = wibox.widget.textbox() }
    local args            = args or { }
    local timeout         = args.timeout or 900
    local settings        = args.settings or function() end
    local command         = args.command or ""
    local notify          = args.notify or "on"

    -- Example commands:
    -- pacman:          "checkpacman | sed 's/->/→/' | column -t",
    -- pacaur:          "pacaur -k --color never | sed 's/:: [a-zA-Z0-9]\\+ //' | sed 's/->/→/' | column -t",
    -- pacman & pacaur: "( checkpacman & pacaur -k --color never | sed 's/:: [a-zA-Z0-9]\\+ //' ) | sed 's/->/→/' | sort | column -t",
    -- dnf:             "dnf check-update --quiet",
    -- apt:             "apt-show-versions -u"
    -- pip:             "pip list --outdated --format=legacy"

    local notification_preset = args.notification_preset
    local notification_title = args.notification_title or "Updates"

    local update_count = 0

    function pacman.update(notify)
        helpers.async({ shell, "-c", command }, function(update_text)
            available  = tonumber((update_text:gsub('[^\n]', '')):len())
            widget = pacman.widget

            if available > update_count and notify == "on" then
                pacman.show_notification(update_text)
            end
            update_count = available
            settings()
        end)
    end

    function pacman.manual_update()
        -- Allways show notification
        update_count = -1
        pacman.update("on")
    end

    function pacman.show_notification(update_text)
        if not update_text or update_text == "" then
            notification_preset.text = "None."
        else
            notification_preset.text = string.gsub(update_text, '[\n%s]*$', '')
        end
        notification_preset.screen = (pacman.followtag and awful.screen.focused()) or 1

        if pacman.notification then
            naughty.destroy(pacman.notification)
        end
        pacman.notification = naughty.notify({
            preset = notification_preset,
            timeout = notification_preset.timeout or 15,
            title = notification_title,
        })
    end

    helpers.newtimer("pacman", timeout, function() pacman.update(notify) end)

    return pacman
end

return factory
