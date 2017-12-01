--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Alphonse Mariyagnanaseelan

--]]

local helpers      = require("lain.helpers")
local shell        = require("awful.util").shell
local wibox        = require("wibox")
local lines, floor = io.lines, math.floor
local string       = { format = string.format,
                       gsub   = string.gsub }

-- Available updates
-- lain.widget.pacman

local function factory(args)
    local pacman   = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 900
    local settings = args.settings or function() end
    local cmd      = "if [ $(pacaur -k | wc -l) -gt 0  ]; then echo \"$(checkupdates | wc -l)+$(pacaur -k | wc -l)\"; else echo \"$(checkupdates | wc -l)\"; fi"

    function pacman.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            available = f

            widget = pacman.widget
            settings()
        end)
    end

    helpers.newtimer("pacman", timeout, pacman.update)

    return pacman
end

return factory
