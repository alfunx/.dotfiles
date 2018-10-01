
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")
local beautiful = require("beautiful")

local config = { }

function config.init(context)

    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", function(s)
        context.util.set_wallpaper(#s.clients)
    end)

    -- Move all off-screen windows to the visible area
    screen.connect_signal("property::geometry", function(s, old_geom)
        local geom = s.geometry
        local xshift = geom.x - old_geom.x
        local yshift = geom.y - old_geom.y
        if xshift == 0 and yshift == 0 then
            return
        end
        for _, c in ipairs(client.get(s)) do
            local cgeom = c:geometry()
            c:geometry{ x = cgeom.x + xshift, y = cgeom.y + yshift }
        end
    end)

    -- Create a wibox for each screen and add it
    awful.screen.connect_for_each_screen(function(s)
        if s._wibox then s._wibox:remove() end
        beautiful.at_screen_connect(s)
        awesome.register_xproperty("_NET_WM_NAME", "string")
        s._wibox:set_xproperty("_NET_WM_NAME", "Wibar")
    end)

end

return config
