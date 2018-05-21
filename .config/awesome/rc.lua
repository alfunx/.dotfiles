
--[[

     Awesome WM configuration
     by Alphonse Mariyagnanaseelan

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local cairo         = require("lgi").cairo
local gears         = require("gears")
local awful         = require("awful")
local autofocus     = require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local remote        = require("awful.remote")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi
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

local function spawn_once(command, class, tag)
    -- create move callback
    local callback
    callback = function(c)
        if c.class == class then
            awful.client.movetotag(tag, c)
            client.remove_signal("manage", callback)
        end
    end
    client.add_signal("manage", callback)
    -- now check if not already running!
    local findme = command
    local firstspace = findme:find(" ")
    if firstspace then
        findme = findme:sub(0, firstspace-1)
    end
    -- finally run it
    awful.util.spawn_with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, command))
end

-- spawn_once("subl", "Sublime_text", tags[1][2])
-- spawn_once("chromium", "Chromium", tags[1][3])
-- spawn_once("thunar", "Thunar", tags[1][4])
-- spawn_once("xchat", "Xchat", tags[1][5])
-- spawn_once("kitty", "kitty", awful.tag.find_by_name(awful.screen.focused(), "2"))
-- spawn_once("kitty", "kitty", awful.screen.focused().tags[2])

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        local findme = cmd
        local firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

run_once {
    "redshift -c .config/redshift.conf &",
}
-- }}}

-- {{{ Variable definitions
local chosen_theme = "blackout"

local modkey       = "Mod4"
local altkey       = "Mod1"
local ctrlkey      = "Control"
local shiftkey     = "Shift"

local leftkey      = "h"
local rightkey     = "l"
local upkey        = "k"
local downkey      = "j"

local terminal     = "kitty"
local editor       = terminal .. " vim"
local browser      = "chromium"

awful.util.terminal = terminal
awful.util.scripts_dir = os.getenv("HOME") .. "/.bin"
awful.util.tagcolumns = 9
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
-- awful.util.tagnames = { "α", "β", "γ", "δ", "ϵ", "λ", "μ", "σ", "ω" }

awful.layout.layouts = {
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    -- lain.layout.cascade,
    lain.layout.cascade.tile,
    lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
    awful.layout.suit.floating,
}

awful.util.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

awful.util.taglist_buttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } }, {}, function(c)
                return c.minimized
            end)
        end
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 3
lain.layout.cascade.tile.ncol          = 2

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- }}}

-- {{{ Menu
local _awesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " man awesome" },
    { "edit config", string.format("%s %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

awful.util._mainmenu = freedesktop.menu.build {
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", _awesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    },
}

menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Blur Wallpaper
local set_wallpaper = function() end
if beautiful.wallpaper_blur then
    set_wallpaper = function(clients)
        local wallpaper
        if clients > 0 then
            if beautiful.wallpaper_blur then
                wallpaper = beautiful.wallpaper_blur
            end
        else
            if beautiful.wallpaper then
                wallpaper = beautiful.wallpaper
            end
        end

        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(client.screen)
        end

        gears.wallpaper.maximized(wallpaper, client.screen, true)
    end

    screen.connect_signal("tag::history::update", function(s)
        set_wallpaper(#s.clients)
    end)

    client.connect_signal("tagged", function(c)
        set_wallpaper(#c.screen.clients)
    end)

    client.connect_signal("untagged", function(c)
        set_wallpaper(#c.screen.clients)
    end)

    client.connect_signal("property::minimized", function(c)
        set_wallpaper(#c.screen.clients)
    end)
end
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    set_wallpaper(#s.clients)
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function() awful.util._mainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- Select tag by direction in a grid (taggrid feature)
local select_tag_in_grid
do
    local columns = awful.util.tagcolumns or #awful.util.tagnames
    local index_by_direction = {
        l = function(index) return (math.ceil((index) / columns) - 1) * columns + ((index - 2) % columns) + 1 end,
        r = function(index) return (math.ceil((index) / columns) - 1) * columns + ((index) % columns) + 1 end,
        u = function(index, rows) return (index - 1 - columns) % (rows * columns) + 1 end,
        d = function(index, rows) return (index - 1 + columns) % (rows * columns) + 1 end
    }
    select_tag_in_grid = function(direction, current_index)
        local rows = math.ceil(#awful.screen.focused().tags / columns)
        local index = current_index or awful.screen.focused().selected_tag.index
        local new_index = index_by_direction[direction](index, rows)

        local new_tag = awful.screen.focused().tags[new_index]
        if new_tag then
            new_tag:view_only()
            return new_tag
        end
        select_tag_in_grid(direction, new_index)
    end
end

local function move_client_in_grid(direction)
    if client.focus then
        local current_client = client.focus
        local new_tag = select_tag_in_grid(direction)
        current_client:move_to_tag(new_tag)
        current_client:raise()
    end
end

local function easy_async_with_unfocus(cmd, callback)
    callback = callback or function() end
    local c = client.focus
    client.focus = nil
    awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
        callback(stdout, stderr, reason, exit_code)
        client.focus = c
    end)
end

local function client_floats(c)
    if awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating then
        return true
    end
    return false
end

local RESIZE_STEP = dpi(30)
local RESIZE_FACTOR = 0.05

local function get_move_function(direction, resize_step)
    if not resize_step then resize_step = RESIZE_STEP end

    return function ()
        local c = client.focus
        if client_floats(c) then
            if direction == "l" then
                awful.client.moveresize(-resize_step, 0, 0, 0)
            elseif direction == "d" then
                awful.client.moveresize(0, resize_step, 0, 0)
            elseif direction == "u" then
                awful.client.moveresize(0, -resize_step, 0, 0)
            elseif direction == "r" then
                awful.client.moveresize(resize_step, 0, 0, 0)
            end
        else
            awful.client.swap.global_bydirection(direction)
            if client.swap then client.swap:raise() end
        end
    end
end

local function get_resize_function(direction, resize_step, resize_factor)
    if not resize_step then resize_step = RESIZE_STEP end
    if not resize_factor then resize_factor = RESIZE_FACTOR end

    return function ()
        local c = client.focus
        if client_floats(c) then
            if direction == "l" then
                awful.client.moveresize(0, 0, -resize_step, 0)
            elseif direction == "d" then
                awful.client.moveresize(0, 0, 0, resize_step)
            elseif direction == "u" then
                awful.client.moveresize(0, 0, 0, -resize_step)
            elseif direction == "r" then
                awful.client.moveresize(0, 0, resize_step, 0)
            end
        else
            if direction == "l" then
                awful.tag.incmwfact(-resize_factor)
            elseif direction == "d" then
                awful.client.incwfact(-resize_factor)
            elseif direction == "u" then
                awful.client.incwfact(resize_factor)
            elseif direction == "r" then
                awful.tag.incmwfact(resize_factor)
            end
        end
    end
end

-- {{{ Key bindings

-- global keybindings and modes
local globalkeys = {}
local modekeys = {}

local escapekey = awful.key({}, "Escape", function ()
    local atextbox = awful.screen.focused()._promptbox
    atextbox.fg = beautiful.prompt_fg
    atextbox.widget.markup = ""
    root.keys(globalkeys)
end, {description = "exit mode", group = "awesome"})

local function switch_keys_mode(mode, text)
    local atextbox = awful.screen.focused()._promptbox
    atextbox.fg = beautiful.fg_focus
    atextbox.widget.markup = "<b>" .. text .. "</b>"
    root.keys(modekeys[mode])
end

globalkeys = awful.util.table.join(
    -- Awesome Hotkeys
    awful.key({ modkey, ctrlkey           }, "s", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({ modkey, ctrlkey           }, "w", function () awful.util._mainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ modkey, ctrlkey           }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, ctrlkey           }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, ctrlkey           }, "z", function () awful.spawn("sync"); awful.spawn("xautolock -locknow") end,
              {description = "lock screen", group = "awesome"}),

    -- Hotkeys
    awful.key({ modkey                    }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, ctrlkey           }, "Return", function () awful.spawn(terminal, { floating = true, placement = awful.placement.centered }) end,
              {description = "open a floating terminal", group = "launcher"}),
    awful.key({ modkey                    }, "b", function () awful.spawn(browser) end,
              {description = "open browser", group = "launcher"}),
    awful.key({ modkey                    }, "e", function () awful.spawn("thunderbird") end,
              {description = "open email client", group = "launcher"}),
    awful.key({ modkey                    }, "w", function () awful.spawn("Whatsapp") end,
              {description = "open whatsapp", group = "launcher"}),

    -- Scteenshot
    awful.key({                           }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/make-screenshot")
    end,
              {description = "take screenshot", group = "screenshot"}),
    awful.key({ shiftkey                  }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/make-screenshot -s")
    end,
              {description = "take screenshot, select area", group = "screenshot"}),
    awful.key({ ctrlkey                   }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/make-screenshot -h")
    end,
              {description = "take screenshot, hide mouse", group = "screenshot"}),
    awful.key({ ctrlkey, shiftkey         }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/make-screenshot -h -s")
    end,
              {description = "take screenshot, hide mouse, select area", group = "screenshot"}),
    awful.key({ modkey                    }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/make-screenshot -w")
    end,
              {description = "wait 5s, take screenshot", group = "screenshot"}),
    awful.key({ modkey, ctrlkey           }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/make-screenshot -w -h")
    end,
              {description = "wait 5s, take screenshot, hide mouse", group = "screenshot"}),
    awful.key({ altkey                    }, "Print", function()
        awful.spawn(awful.util.scripts_dir .. "/upload-to-imgur")
    end,
              {description = "upload last screenshot to Imgur", group = "screenshot"}),

    -- -- Copy primary to clipboard (terminals to gtk)
    -- awful.key({ modkey }, "c", function () awful.spawn("xsel | xsel -i -b") end),
    -- -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ modkey }, "v", function () awful.spawn("xsel -b | xsel") end),

    -- Prompt
    awful.key({ modkey                    }, "r", function () awful.screen.focused()._promptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey                    }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey                    }, "-", function ()
        easy_async_with_unfocus("rofi -show drun")
        -- awful.spawn("dmenu_run")
        -- awful.spawn(string.format("dmenu_run -i -t -dim 0.5 -p 'Run: ' -h 21 -fn 'Meslo LG S for Powerline-10' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        -- beautiful.tasklist_bg_normal, beautiful.fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
    end,
              {description = "show application menu (rofi)", group = "launcher"}),
    awful.key({ modkey                    }, ".", function ()
        easy_async_with_unfocus("rofi -show run")
    end,
              {description = "show commands menu (rofi)", group = "launcher"}),
    awful.key({ modkey                    }, "$", function ()
        easy_async_with_unfocus(awful.util.scripts_dir .. "/rofi-session")
    end,
              {description = "show session menu (rofi)", group = "launcher"}),
    -- awful.key({ altkey            }, "space", function ()
    --     -- awful.spawn(string.format("dmenu_run -i -fn 'Meslo LG S for Powerline' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
    --     awful.spawn(string.format("rofi -show run -width 100 -location 1 -lines 5 -bw 2 -yoffset -2",
    --     beautiful.tasklist_bg_normal, beautiful.tasklist_fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
    -- end),
    awful.key({ modkey                    }, "x", function ()
                  awful.prompt.run {
                      prompt       = "Run Lua code: ",
                      textbox      = awful.screen.focused()._promptbox.widget,
                      exe_callback = awful.util.eval,
                      history_path = awful.util.get_cache_dir() .. "/history_eval",
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    -- Dropdown application
    awful.key({ modkey                    }, "y", function () awful.screen.focused().quake:toggle() end,
              {description = "open quake application", group = "screen"}),

    -- Screen browsing
    awful.key({ ctrlkey, altkey           }, leftkey, function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ ctrlkey, altkey           }, rightkey, function () awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),

    -- -- Tag browsing
    -- awful.key({ ctrlkey, altkey           }, leftkey, awful.tag.viewprev,
    --           {description = "view previous", group = "tag"}),
    -- awful.key({ ctrlkey, altkey           }, rightkey, awful.tag.viewnext,
    --           {description = "view next", group = "tag"}),
    -- awful.key({ ctrlkey, altkey           }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, altkey, shiftkey  }, leftkey, function () lain.util.move_tag(-1) end,
              {description = "move tag backward", group = "tag"}),
    awful.key({ modkey, altkey, shiftkey  }, rightkey, function () lain.util.move_tag(1) end,
              {description = "move tag forward", group = "tag"}),
    awful.key({ modkey, altkey            }, "n", function () lain.util.add_tag() end,
              {description = "new tag", group = "tag"}),
    awful.key({ modkey, altkey            }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, altkey            }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),
    awful.key({ modkey, altkey            }, "a", function()
            for i = 1, 9 do
                awful.tag.add(tostring(i), {
                    screen = awful.screen.focused(),
                    layout = layout or awful.layout.suit.tile,
                })
            end
        end,
              {description = "add row of tags", group = "tag"}),
    awful.key({ modkey, altkey            }, "BackSpace", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ modkey, ctrlkey           }, leftkey, function () lain.util.tag_view_nonempty(-1) end,
              {description = "view previous nonempty", group = "tag"}),
    awful.key({ modkey, ctrlkey           }, rightkey, function () lain.util.tag_view_nonempty(1) end,
              {description = "view next nonempty", group = "tag"}),

    -- Select tag in grid
    awful.key({ modkey                    }, leftkey, function() select_tag_in_grid("l") end,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey                    }, rightkey, function() select_tag_in_grid("r") end,
              {description = "view next", group = "tag"}),
    awful.key({ modkey, ctrlkey           }, upkey, function() select_tag_in_grid("u") end,
              {description = "view above", group = "tag"}),
    awful.key({ modkey, ctrlkey           }, downkey, function() select_tag_in_grid("d") end,
              {description = "view below", group = "tag"}),

    -- Move client to tag in grid
    awful.key({ modkey, ctrlkey, shiftkey }, leftkey, function() move_client_in_grid("l") end,
              {description = "move to previous tag", group = "client"}),
    awful.key({ modkey, ctrlkey, shiftkey }, rightkey, function() move_client_in_grid("r") end,
              {description = "move to next tag", group = "client"}),
    awful.key({ modkey, ctrlkey, shiftkey }, upkey, function() move_client_in_grid("u") end,
              {description = "move to tag above", group = "client"}),
    awful.key({ modkey, ctrlkey, shiftkey }, downkey, function() move_client_in_grid("d") end,
              {description = "move to tag below", group = "client"}),

    -- Client manipulation
    awful.key({ modkey                    }, upkey, function () awful.client.focus.byidx(-1) end,
              {description = "focus previous client by index", group = "client"}),
    awful.key({ modkey                    }, downkey, function () awful.client.focus.byidx(1) end,
              {description = "focus next client by index", group = "client"}),
    awful.key({ modkey, shiftkey          }, upkey, function () awful.client.swap.byidx(-1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, shiftkey          }, downkey, function () awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey                    }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,                   }, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end,
              {description = "go back", group = "client"}),

    awful.key({ modkey, ctrlkey           }, "n", function ()
        local c = awful.client.restore()
        if c then
            client.focus = c
            c:raise()
        end
    end,
              {description = "restore minimized", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, shiftkey          }, rightkey, function () awful.tag.incmwfact(0.01) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, shiftkey          }, leftkey, function () awful.tag.incmwfact(-0.01) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, altkey            }, rightkey, function () awful.tag.incnmaster(1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey            }, leftkey, function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, altkey            }, upkey, function () awful.tag.incncol(1, nil, true) end,
              {description = "increase the number of slave columns", group = "layout"}),
    awful.key({ modkey, altkey            }, downkey, function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of slave columns", group = "layout"}),
    awful.key({ modkey,                   }, "space", function () awful.layout.inc(1) end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, shiftkey          }, "space", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),

    -- Show/Hide Wibox
    awful.key({ modkey, ctrlkey           }, "b", function ()
        for s in screen do
            s._wibox.visible = not s._wibox.visible
            if s._bottomwibox then
                s._bottomwibox.visible = not s._bottomwibox.visible
            end
        end
    end),

    -- On the fly useless gaps change
    awful.key({ modkey, altkey, shiftkey  }, downkey, function () lain.util.useless_gaps_resize(beautiful.useless_gap/2) end,
              {description = "increase useless gap", group = "layout"}),
    awful.key({ modkey, altkey, shiftkey  }, upkey, function () lain.util.useless_gaps_resize(-beautiful.useless_gap/2) end,
              {description = "decrease useless gap", group = "layout"}),
    awful.key({ modkey, altkey, shiftkey, ctrlkey }, downkey, function () lain.util.useless_gaps_resize(1) end),
    awful.key({ modkey, altkey, shiftkey, ctrlkey }, upkey, function () lain.util.useless_gaps_resize(-1) end),

    -- ALSA volume control
    awful.key({                           }, "XF86AudioRaiseVolume", function ()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%+", beautiful.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            beautiful.volume.manual = true
            beautiful.volume.update()
        end)
    end),
    awful.key({                           }, "XF86AudioLowerVolume", function ()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%-", beautiful.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            beautiful.volume.manual = true
            beautiful.volume.update()
        end)
    end),
    awful.key({                           }, "XF86AudioMute", function ()
        awful.spawn.easy_async(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            beautiful.volume.manual = true
            beautiful.volume.update()
        end)
    end),
    awful.key({ ctrlkey                   }, "XF86AudioRaiseVolume", function ()
        awful.spawn.easy_async(string.format("amixer -q set %s 100%%", beautiful.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            beautiful.volume.manual = true
            beautiful.volume.update()
        end)
    end),
    awful.key({ ctrlkey                   }, "XF86AudioLowerVolume", function ()
        awful.spawn.easy_async(string.format("amixer -q set %s 0%%", beautiful.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            beautiful.volume.manual = true
            beautiful.volume.update()
        end)
    end),
    awful.key({ ctrlkey                   }, "XF86AudioMute", function ()
        awful.spawn.easy_async(string.format("amixer -q set %s mute", beautiful.volume.togglechannel or beautiful.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            beautiful.volume.manual = true
            beautiful.volume.update()
        end)
    end),

    -- Backlight / Brightness
    awful.key({                           }, "XF86MonBrightnessUp", function()
        awful.spawn("light -A 2")
    end),
    awful.key({                           }, "XF86MonBrightnessDown", function()
        awful.spawn.easy_async_with_shell("light -G",
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            if tonumber(stdout) > 2 then
                awful.spawn("light -U 2")
            end
        end)
    end),
    awful.key({ ctrlkey                   }, "XF86MonBrightnessUp", function()
        awful.spawn("light -S 100")
    end),
    awful.key({ ctrlkey                   }, "XF86MonBrightnessDown", function()
        awful.spawn("light -S 1")
    end),

    -- -- Backlight / Brightness (using xbacklight)
    -- awful.key({   }, "XF86MonBrightnessUp",
    --     function()
    --         awful.spawn("xbacklight -inc 2 -time 1 -steps 1")
    --     end),
    -- awful.key({   }, "XF86MonBrightnessDown",
    --     function()
    --         awful.spawn.easy_async_with_shell("xbacklight -get | sed 's/\\..*//'",
    --         function(stdout, stderr, reason, exit_code)
    --             if tonumber(stdout) > 2 then
    --                 awful.spawn("xbacklight -dec 2 -time 1 -steps 1")
    --             end
    --         end)
    --     end),
    -- awful.key({ ctrlkey }, "XF86MonBrightnessUp",
    --     function()
    --         awful.spawn("xbacklight -set 100 -time 1 -steps 1")
    --     end),
    -- awful.key({ ctrlkey }, "XF86MonBrightnessDown",
    --     function()
    --         awful.spawn("xbacklight -set 1 -time 1 -steps 1")
    --     end),

    -- MPD control
    awful.key({                           }, "XF86AudioPlay", function ()
        awful.spawn.with_shell("mpc toggle")
        beautiful.mpd.update()
    end),
    awful.key({ ctrlkey                   }, "XF86AudioPlay", function ()
        awful.spawn.with_shell("mpc stop")
        beautiful.mpd.update()
    end),
    awful.key({                           }, "XF86AudioPrev", function ()
        awful.spawn.with_shell("mpc prev")
        beautiful.mpd.update()
    end),
    awful.key({                           }, "XF86AudioNext", function ()
        awful.spawn.with_shell("mpc next")
        beautiful.mpd.update()
    end),
    awful.key({ altkey                    }, "0", function ()
        local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
        if beautiful.mpd.timer.started then
            beautiful.mpd.timer:stop()
            common.text = common.text .. lain.util.markup.bold("OFF")
        else
            beautiful.mpd.timer:start()
            common.text = common.text .. lain.util.markup.bold("ON")
        end
        naughty.notify(common)
    end),

    -- modes
    awful.key({ modkey                    }, "g", function ()
        switch_keys_mode("command", "Command Mode")
    end, {description = "resize mode", group = "awesome"})
)

modekeys.command = awful.util.table.join(
    globalkeys,

    -- resize
    awful.key({                           }, "h", get_resize_function("l")),
    awful.key({                           }, "j", get_resize_function("d")),
    awful.key({                           }, "k", get_resize_function("u")),
    awful.key({                           }, "l", get_resize_function("r")),

    -- resize (precise)
    awful.key({ ctrlkey                   }, "h", get_resize_function("l", dpi(5), 0.005)),
    awful.key({ ctrlkey                   }, "j", get_resize_function("d", dpi(5), 0.005)),
    awful.key({ ctrlkey                   }, "k", get_resize_function("u", dpi(5), 0.005)),
    awful.key({ ctrlkey                   }, "l", get_resize_function("r", dpi(5), 0.005)),

    -- move
    awful.key({ shiftkey                  }, "h", get_move_function("l")),
    awful.key({ shiftkey                  }, "j", get_move_function("d")),
    awful.key({ shiftkey                  }, "k", get_move_function("u")),
    awful.key({ shiftkey                  }, "l", get_move_function("r")),

    -- move (precise)
    awful.key({ shiftkey, ctrlkey         }, "h", get_move_function("l", dpi(5))),
    awful.key({ shiftkey, ctrlkey         }, "j", get_move_function("d", dpi(5))),
    awful.key({ shiftkey, ctrlkey         }, "k", get_move_function("u", dpi(5))),
    awful.key({ shiftkey, ctrlkey         }, "l", get_move_function("r", dpi(5))),

    -- client manipulation
    awful.key({                           }, "z", function () client.focus:kill() end),
    awful.key({                           }, "space", awful.client.floating.toggle),
    awful.key({                           }, "o", function () client.focus:move_to_screen() end),
    awful.key({                           }, "t", function () client.focus.ontop = not client.focus.ontop end),
    awful.key({                           }, "s", function () client.focus.sticky = not client.focus.sticky end),
    awful.key({                           }, "n", function () client.focus.minimized = true end),
    awful.key({ shiftkey                  }, "n", function ()
        local c = awful.client.restore()
        if c then
            client.focus = c
            c:raise()
        end
    end),
    awful.key({                           }, "m", function ()
        if not client.focus.maximized then
            awful.titlebar.hide(client.focus)
        elseif client.focus.maximized and client.focus.floating then
            awful.titlebar.show(client.focus)
        end
        client.focus.maximized = not client.focus.maximized
        client.focus:raise()
    end),

    escapekey
)

local clientkeys = awful.util.table.join(
    awful.key({ modkey, altkey            }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "swap with master", group = "client"}),
    awful.key({ modkey, ctrlkey           }, "m", lain.util.magnify_client,
              {description = "magnify", group = "client"}),
    awful.key({ modkey                    }, "f", function (c)
        if not c.fullscreen then
            awful.titlebar.hide(c)
        elseif c.fullscreen and c.floating then
            awful.titlebar.show(c)
        end
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey                    }, "z", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ modkey, ctrlkey           }, "space", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey                    }, "o", function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey                    }, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey                    }, "s", function (c) c.sticky = not c.sticky end,
              {description = "toggle sticky", group = "client"}),
    awful.key({ modkey                    }, "i", function (c) awful.titlebar.toggle(c) end,
              {description = "toggle titlebar", group = "client"}),
    awful.key({ modkey, ctrlkey           }, "i", function () set_wallpaper(0) end,
              {description = "toggle titlebar", group = "client"}),
    awful.key({ modkey                    }, "n", function (c) c.minimized = true end,
              {description = "minimize", group = "client"}),
    awful.key({ modkey                    }, "m", function (c)
        if not c.maximized then
            awful.titlebar.hide(c)
        elseif c.maximized and c.floating then
            awful.titlebar.show(c)
        end
        c.maximized = not c.maximized
        c:raise()
    end,
              {description = "maximize", group = "client"}),
    awful.key({ modkey                    }, "v", function (c) --luacheck: no unused args
        awful.spawn(terminal .. " zsh -lic '" .. awful.util.scripts_dir .. "/edit-in-vim'", {
            floating = true,
            ontop = true,
            placement = awful.placement.centered,
        })
    end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function ()
            local _screen = awful.screen.focused()
            local _tag = _screen.tags[i]
            if _tag then
                _tag:view_only()
            end
        end,
        {description = "view tag #"..i, group = "tag-direct"}),
        -- Toggle tag display.
        awful.key({ modkey, ctrlkey }, "#" .. i + 9, function ()
            local _screen = awful.screen.focused()
            local _tag = _screen.tags[i]
            if _tag then
                awful.tag.viewtoggle(_tag)
            end
        end,
        {description = "toggle tag #" .. i, group = "tag-direct"}),
        -- Move client to tag.
        awful.key({ modkey, shiftkey }, "#" .. i + 9, function ()
            if client.focus then
                local _tag = client.focus.screen.tags[i]
                if _tag then
                    client.focus:move_to_tag(_tag)
                end
            end
        end,
        {description = "move focused client to tag #"..i, group = "tag-direct"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, altkey }, "#" .. i + 9, function ()
            if client.focus then
                local _tag = client.focus.screen.tags[i]
                if _tag then
                    client.focus:toggle_tag(_tag)
                end
            end
        end,
        {description = "toggle focused client on tag #" .. i, group = "tag-direct"})
    )
end

local clientbuttons = awful.util.table.join(
    awful.button({                  }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey           }, 1, awful.mouse.client.move),
    awful.button({ modkey, shiftkey }, 1, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

    -- all clients will match this rule
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_offscreen+awful.placement.no_overlap,
            size_hints_honor = false,
            titlebars_enabled = true,
        },
    },

    -- enable titlebars
    {
        rule_any = {
            type = {
                "normal",
                "dialog",
            },
        },
        properties = {
            titlebars_enabled = true,
        },
    },

    -- no borders if maximized
    {
        rule = {
            maximized = true,
        },
        properties = {
            border_width = 0,
        },
    },

    {
        rule = {
            class = "Thunderbird",
        },
        properties = {
            screen = 1,
            tag = awful.util.tagnames[6],
        },
    },

    {
        rule = {
            class = "Gimp-2.10",
        },
        properties = {
            screen = 1,
            tag = awful.util.tagnames[7],
        },
    },

    {
        rule = {
            class = "VirtualBox",
        },
        properties = {
            screen = 1,
            tag = awful.util.tagnames[8],
        },
    },

    {
        rule = {
            class = "Firefox",
            role = "toolbox",
        },
        properties = {
            floating = true,
        },
    },

    {
        rule = {
            class = "Chromium",
            role = "pop-up",
        },
        properties = {
            floating = true,
        },
    },

    {
        rule = {
            class = "Chrome",
            role = "pop-up",
        },
        properties = {
            floating = true,
        },
    },

    -- clients that should float
    {
        rule_any = {
            class = {
                "Git-gui",
                "feh",
                "Lxappearance",
                "Lxsession-edit",
                "Lxsession-default-apps",
                "Oomox",
                "Gpick",
                "System-config-printer.py",
                "Pinentry",
                "Event Tester",
                "alsamixer",
            },
            name = {
                "Event Tester",
            },
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        },
    },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
        not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c, true)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 20}):setup {
        layout = wibox.layout.align.horizontal,
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(awful.titlebar.widget.iconwidget(c), 0, 5),
            buttons = buttons,
        },
        { -- Middle
            layout = wibox.layout.flex.horizontal,
            { -- Title
                align = "left",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
        },
    }

    -- Hide the titlebar if floating
    if not client_floats(c) then
        awful.titlebar.hide(c)
    end

    -- Hide the titlebar if maximized
    if c.maximized or c.fullscreen then
        awful.titlebar.hide(c)
    end
end)

client.connect_signal("property::size", function(c)
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c, false)
    end
end)

-- -- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--         and awful.client.focus.filter(c) then
--         client.focus = c
--     end
-- end)

local last_focus

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    last_focus = nil
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
    last_focus = c
end)

client.connect_signal("unmanage", function(c)
    if last_focus == c and c.transient_for then
        client.focus = c.transient_for
        c.transient_for:raise()
    end
end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.border_width = 0
        awful.titlebar.hide(c)
        c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end
    else
        c.border_width = beautiful.border_width
        c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0) end
    end
end)

client.connect_signal("property::maximized", function(c)
    if c.maximized then
        c.border_width = 0
        awful.titlebar.hide(c)
        c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end
    else
        c.border_width = beautiful.border_width
        c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0) end
    end
end)

client.connect_signal("property::floating", function(c)
    if c.floating and not c.maximized and not c.fullscreen then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

awful.tag.attached_connect_signal(s, "property::layout", function(t)
    for _,c in pairs(t:clients()) do
        c.floating = t.layout == awful.layout.suit.floating
    end
end)

-- Rounded corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0)
    end
end)

-- }}}
