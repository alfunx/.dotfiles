
--[[

     Awesome WM configuration
     by Alphonse Mariyagnanaseelan

--]]

-- {{{ Libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local cairo         = require("lgi").cairo
local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi
local config        = require("config")

require("awful.autofocus")
require("awful.remote")
-- }}}

-- Localization
os.setlocale(os.getenv("LANG"))

-- {{{ Variable definitions
local context = {}

context.theme            = "blackout"

context.keys = {}
context.keys.modkey      = "Mod4"
context.keys.altkey      = "Mod1"
context.keys.ctrlkey     = "Control"
context.keys.shiftkey    = "Shift"
context.keys.l_key       = "h"
context.keys.r_key       = "l"
context.keys.u_key       = "k"
context.keys.d_key       = "j"

context.terminal    = "kitty"
context.browser     = "chromium"

awful.util.terminal = context.terminal
awful.util.scripts_dir = os.getenv("HOME") .. "/.bin"
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
    awesome.connect_signal("debug::error", function (err)
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

-- {{{ Theme
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), context.theme)
beautiful.init(theme_path)
beautiful.context = context
-- }}}

-- {{{ Config
config.widgets.init(context)
config.util.init(context)
config.menu.init(context)
config.keys.init(context)
config.keys_command.init(context)
config.keys_client.init(context)
config.rules.init(context)
config.signals.init(context)
config.screen.init(context)
-- }}}

-- {{{ Spawn
context.run_once {
    "redshift -c .config/redshift.conf &",
}

-- context.spawn_once("kitty", "kitty", awful.screen.focused().tags[2])
-- context.spawn_once("subl", "Sublime_text", tags[1][2])
-- context.spawn_once("chromium", "Chromium", tags[1][3])
-- context.spawn_once("thunar", "Thunar", tags[1][4])
-- context.spawn_once("xchat", "Xchat", tags[1][5])
-- context.spawn_once("kitty", "kitty", awful.tag.find_by_name(awful.screen.focused(), "2"))
-- }}}

-- naughty.dbus.config.mapping = {
--     {{urgency = "\1"}, naughty.config.presets.low},
--     {{urgency = "\2"}, naughty.config.presets.normal},
--     {{urgency = "\3"}, naughty.config.presets.critical}
-- }
