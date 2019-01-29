--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Alphonse Mariyagnanaseelan

--]]

local helpers      = require("lain.helpers")
local shell        = require("awful.util").shell
local wibox        = require("wibox")
local lines, floor = io.lines, math.floor
local string       = { format = string.format,
                       gsub   = string.gsub,
                       len    = string.len }

local function factory(args)
    local light    = { widget = wibox.widget.textbox() }
    local args     = args or { }
    local timeout  = args.timeout or 120
    local settings = args.settings or function() end
    local cmd      = "light -G"

    function light.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            percent = math.floor(f)

            widget = light.widget
            settings()
        end)
    end

    helpers.newtimer("light", timeout, light.update)

    return light
end

return factory
