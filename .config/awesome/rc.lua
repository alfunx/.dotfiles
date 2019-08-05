
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

-- {{{ Libraries
--luacheck: push ignore

local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Global (for awesome-client)
awful = require("awful")
beautiful = require("beautiful")
gears = require("gears")
gtable = require("gears.table")
gdebug = require("gears.debug")
naughty = require("naughty")
config = require("config")

-- yaawl libs (for awesome-client)
inspect = require("yaawl.util").inspect
json = require("yaawl.util").json

-- Local
local awful = awful
local beautiful = beautiful
local gears = gears
local naughty = naughty
local config = config

require("awful.autofocus")
require("awful.remote")

--luacheck: pop
-- }}}

-- Localization
os.setlocale(os.getenv("LANG"))

-- {{{ Initialize context
config.context.init {

    theme = "blackout",

    keys = {

        modkey           = "Mod4",
        altkey           = "Mod1",
        ctrlkey          = "Control",
        shiftkey         = "Shift",
        leftkey          = "h",
        rightkey         = "l",
        upkey            = "k",
        downkey          = "j",
        leftkey_alt      = "Left",
        rightkey_alt     = "Right",
        upkey_alt        = "Up",
        downkey_alt      = "Down",

    },

    vars = {

        merge_tags       = false,
        sloppy_focus     = false,
        start_as_slave   = false,
        terminal         = "kitty ",
        browser          = "chromium ",
        net_iface        = "wlp58s0",
        ping_ip          = "8.8.8.8",
        cores            = 4,
        batteries        = { "BAT0" },
        ac               = "AC",
        checkupdate      = "checkupdates | sed 's/->/→/' | sort | column -t -c 70 -T 2,4",
     -- checkupdate      = "checkupdates | sed -E 's/->/→/;s/\\.g[^.-]+-/-/g' | sort | column -t -c 70 -T 2,4",
        scripts_dir      = os.getenv("HOME") .. "/.bin",
        secrets_dir      = os.getenv("HOME") .. "/.secrets",

    }

}
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    }
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        }
        in_error = false
    end)
end
-- }}}

-- -- {{{ Notifications
-- naughty.connect_signal("request::display", function(n)
--     naughty.layout.box {
--         notification = n,
--     }
-- end)
-- -- }}}

-- {{{ Deprecation warnings
awesome.connect_signal("debug::deprecation", function(hint, see, args) --luacheck: no unused
    naughty.notify {
        preset = naughty.config.presets.warn,
        title = "Deprecation",
        text = hint,
    }
end)
-- }}}

-- {{{ Debug hints
awesome.connect_signal("debug::index::miss", function(c, k) --luacheck: no unused
    naughty.notify {
        preset = naughty.config.presets.warn,
        title = "Debug: Index miss",
        text = c .. "." .. k,
    }
end)
awesome.connect_signal("debug::newindex::miss", function(c, k, v) --luacheck: no unused
    naughty.notify {
        preset = naughty.config.presets.warn,
        title = "Debug: New index miss",
        text = c .. "." .. k .. " = " .. v,
    }
end)
-- }}}

-- {{{ Auto DPI
-- awful.screen.set_auto_dpi_enabled(true)
-- }}}

-- {{{ Utils
config.brokers.init()
config.tags.init()
config.util.init()
config.util_theme.init()
-- }}}

-- {{{ Bindings
config.keys.init()
config.bindings_global.init()
config.bindings_client.init()
config.bindings_command.init()
config.bindings_taglist.init()
config.bindings_tasklist.init()
-- }}}

-- {{{ Theme
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
    os.getenv("HOME"), config.context.theme)
beautiful.init(theme_path)
-- }}}

-- {{{ Parts
config.menu.init()
config.popups.init()
config.sidebar.init()
-- }}}

-- {{{ Configs
config.wallpaper.init()
config.rules.init()
config.signals.init()
config.screens.init()
-- }}}

-- {{{ Spawn

-- awful.spawn {
--     config.context.vars.scripts_dir .. "/autolock"
-- }

-- util.spawn_once {
--     command = "kitty --class='kitty-main'",
--     class = "kitty-main",
--     tag = awful.screen.focused().tags[2],
--     callback = function(c)
--         c.maximized = true
--     end,
-- }

-- util.spawn_once("subl", "Sublime_text", tags[1][2])
-- util.spawn_once("chromium", "Chromium", tags[1][3])
-- util.spawn_once("thunar", "Thunar", tags[1][4])
-- util.spawn_once("xchat", "Xchat", tags[1][5])
-- util.spawn_once("kitty", "kitty", awful.tag.find_by_name(awful.screen.focused(), "2"))

-- }}}

-- naughty.dbus.config.mapping = {
--     {{urgency = "\1"}, naughty.config.presets.low},
--     {{urgency = "\2"}, naughty.config.presets.normal},
--     {{urgency = "\3"}, naughty.config.presets.critical}
-- }

-- {{{ Update brokers
config.brokers:update()
-- }}}
