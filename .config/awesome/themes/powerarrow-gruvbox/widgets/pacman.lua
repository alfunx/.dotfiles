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
                        gsub   = string.gsub }

-- Available updates
-- lain.widget.pacman

local function factory(args)
    local pacman   = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 900
    local notify   = args.notify or false
    local settings = args.settings or function() end
    local cmd      = "if [ $(pacaur -k | wc -l) -gt 0  ]; then echo \"$(checkupdates | wc -l)+$(pacaur -k | wc -l)\"; else echo \"$(checkupdates | wc -l)\"; fi"

    local update_count = 0

    function pacman.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            available = f

            widget = pacman.widget

            if tonumber(f) > update_count then
                awful.spawn.easy_async("/home/amariya/scripts/updates.sh", function(stdout, stderr, reason, exit_code)
                    naughty.notify({
                        title = "pacman & AUR updates",
                        text = string.gsub(stdout, '\n*$', ''),
                        timeout = 15
                    })
                end)
            end
            update_count = tonumber(f)

            settings()
        end)
    end

    helpers.newtimer("pacman", timeout, pacman.update)

    return pacman
end

return factory
