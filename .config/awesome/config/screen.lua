local awful = require("awful")
local beautiful = require("beautiful")

local config = {}

function config.init(context)

    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", function(s)
        context.set_wallpaper(#s.clients)
    end)

    -- Create a wibox for each screen and add it
    awful.screen.connect_for_each_screen(function(s)
        beautiful.at_screen_connect(s)
        awesome.register_xproperty("_NET_WM_NAME", "string")
        s._wibox:set_xproperty("_NET_WM_NAME", "Wibar")
    end)

end

return config
