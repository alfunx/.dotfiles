
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")

local config = { }

function config.init(context)

    local bat
    gears.timer {
        timeout  = 180,
        call_now = true,
        callback = function()
            awful.spawn.easy_async({
                "cat", "/sys/class/power_supply/BAT0/capacity", "&&",
                "cat", "/sys/class/power_supply/AC/online",
            }, function(stdout)
                local level, ac = string.match(stdout, "([%d]+)\n([%d]+)")

                local level = tonumber(level)
                local ac = tonumber(ac) == 1

                if level > 10 or ac then return end
                if not bat then
                    bat = naughty.notify {
                        title = "Battery",
                        text = "Your battery is running low.\n"
                            .. "You should plug in your PC.",
                        preset = naughty.config.presets.critical,
                        timeout = 0,
                    }
                end
            end)
        end,
    }

end

return config
