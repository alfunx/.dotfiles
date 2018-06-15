local awful = require("awful")
local beautiful = require("beautiful")
local menubar = require("menubar")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local config = {}

function config.init(context)

    local _awesomemenu = {
        { "hotkeys", function() return false, hotkeys_popup.show_help end },
        { "manual", context.vars.terminal .. " man awesome" },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end },
    }

    awful.util._mainmenu = freedesktop.menu.build {
        icon_size = beautiful.menu_height or 16,
        before = {
            { "Awesome", _awesomemenu, beautiful.awesome_icon },
            -- Other triads can be put here
        },
        after = {
            { "Open terminal", context.vars.terminal },
            -- Other triads can be put here
        },
    }

    -- Set the Menubar terminal for applications that require it
    menubar.utils.terminal = context.vars.terminal

end

return config
