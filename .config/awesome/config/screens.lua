
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")

local context = require("config.context")
local tags = require("config.tags")

local _config = { }

function _config.init()

    -- Move all off-screen windows to the visible area
    screen.connect_signal("property::geometry", function(s, old_geom)
        local geom = s.geometry

        if geom.x == old_geom.x and geom.y == old_geom.y then
            return
        end

        for _, c in pairs(client.get(s)) do
            if c.floating then
                awful.placement.no_offscreen(c)
            end
        end
    end)

    -- Create a wibox for each screen and add it
    screen.connect_signal("request::desktop_decoration", function(s)
        -- Set quake application
        if not s.quake then
            s.quake = lain.util.quake {
                app = context.vars.terminal,
            }
        end

        -- Add tags if there are none
        if #s.tags == 0 then
            awful.tag(tags.names, s, tags.layouts)
        end

        -- Set wibar
        if s._wibox then s._wibox:remove() end
        beautiful.at_screen_connect(s)
        awesome.register_xproperty("_NET_WM_NAME", "string")
        s._wibox:set_xproperty("_NET_WM_NAME", "Wibar")
    end)

end

return _config
