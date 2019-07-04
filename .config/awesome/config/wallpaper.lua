
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local beautiful = require("beautiful")
local gears = require("gears")
local unpack = unpack or table.unpack

local _config = { }

function _config.init()

    -- Blur wallpaper (only set if theme has blurred wallpaper)
    if beautiful.wallpaper_blur then
        local wallpaper_normal = beautiful.wallpaper
        local wallpaper_blur   = beautiful.wallpaper_blur

        -- Wallpaper function
        local wallpaper_fn = function(s)
            local wallpaper
            if #s.clients > 0 and wallpaper_blur then
                wallpaper = wallpaper_blur
            elseif wallpaper_normal then
                wallpaper = wallpaper_normal
            end

            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end

            return wallpaper
        end

        -- Reset beautiful.wallpaper
        beautiful.wallpaper = wallpaper_fn

        -- Connect to signals for blur effect
        screen.connect_signal("tag::history::update", wallpaper_fn)
        client.connect_signal("tagged", function(c) wallpaper_fn(c.screen) end)
        client.connect_signal("untagged", function(c) wallpaper_fn(c.screen) end)
        client.connect_signal("property::minimized", function(c) wallpaper_fn(c.screen) end)
    end

    -- Set wallpaper when requested
    local wallpaper_fn = beautiful.wallpaper_fn or gears.wallpaper.maximized
    screen.connect_signal("request::wallpaper", function(s)
        local wallpaper = beautiful.wallpaper

        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            require "naughty".notify {text="called"}
            wallpaper = wallpaper(s)
        end

        -- Pass beautiful.wallpaper_fn_args to wallpaper_fn if it exists
        if beautiful.wallpaper_fn_args then
            wallpaper_fn(wallpaper, s, unpack(beautiful.wallpaper_fn_args))
        else
            wallpaper_fn(wallpaper, s)
        end
    end)

end

return _config
