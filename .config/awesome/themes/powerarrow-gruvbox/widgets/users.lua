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
-- lain.widget.users

local function factory(args)
    local users   = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 120
    local settings = args.settings or function() end
    -- local cmd      = "users | wc -w"
    local cmd      = "echo \"$(users | wc -w)-$(tmux list-panes -a | wc -l)\" | bc"


    function users.update()
        helpers.async({ shell, "-c", cmd }, function(f)
            logged_in = f

            widget = users.widget
            settings()
        end)
    end

    helpers.newtimer("users", timeout, users.update)

    return users
end

return factory
