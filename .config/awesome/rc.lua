
--[[

     Awesome WM configuration
     by Alphonse Mariyagnanaseelan

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears         = require("gears")
local awful         = require("awful")
local autofocus     = require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

function spawn_once(command, class, tag)
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
-- spawn_once("termite -e tmux", "tmux", awful.tag.find_by_name(awful.screen.focused(), "2"))

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

run_once({ "redshift -c .config/redshift.conf &" })
-- }}}

-- {{{ Variable definitions
local chosen_theme = "powerarrow-gruvbox"

local mod_4        = "Mod4"
local altkey       = "Mod1"
local ctrlkey      = "Control"
local shiftkey     = "Shift"

-- local leftkey      = "Left"
-- local rightkey     = "Right"
-- local upkey        = "Up"
-- local downkey      = "Down"

local leftkey      = "h"
local rightkey     = "l"
local upkey        = "k"
local downkey      = "j"

local terminal     = "termite"
local editor       = "termite -e vim"
local guieditor    = "gvim"
local browser      = "chromium"
local filemanager  = "termite -e ranger"

awful.util.terminal = terminal
-- awful.util.tagnames = { "α", "β", "γ", "δ", "ϵ", "λ", "μ", "σ", "ω" }
awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

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
    awful.layout.suit.tile,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}

awful.util.taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ mod_4 }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ mod_4 }, 3, function(t)
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
                                                  instance = awful.menu.clients({ theme = { width = 250 } })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

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
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Awesome Hotkeys
    awful.key({ mod_4, ctrlkey            }, "s", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({ mod_4, ctrlkey            }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({ mod_4, ctrlkey            }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ mod_4, ctrlkey            }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ mod_4, ctrlkey, altkey    }, "q", function () awful.spawn("/usr/bin/custom-lockscreen") end,
              {description = "lock screen", group = "awesome"}),

    -- Hotkeys
    awful.key({ mod_4,                    }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ mod_4,                    }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ mod_4,                    }, "t", function () awful.spawn(terminal) end),
    awful.key({ mod_4                     }, "b", function () awful.spawn(browser) end,
              {description = "open browser", group = "launcher"}),
    awful.key({ mod_4                     }, "e", function () awful.spawn(editor) end,
              {description = "open editor", group = "launcher"}),
    awful.key({ mod_4                     }, "o", function () awful.spawn(filemanager) end,
              {description = "open filemanager", group = "launcher"}),
    awful.key({ mod_4                     }, "w", function () awful.spawn("Whatsapp") end,
              {description = "open whatsapp", group = "launcher"}),

    awful.key({                          }, "Print", function() os.execute("maim ~/pictures/screenshots/$(date +%s).png") end,
              {description = "take screenshot", group = "launcher"}),
    awful.key({ ctrlkey                  }, "Print", function() os.execute("maim -s -b 3 -c 0.98431372549019607843,0.28627450980392156862,0.20392156862745098039,1 ~/pictures/screenshots/$(date +%s).png") end,
              {description = "take screenshot", group = "launcher"}),
    awful.key({ shiftkey                 }, "Print", function() os.execute("maim -u ~/pictures/screenshots/$(date +%s).png") end,
              {description = "take screenshot", group = "launcher"}),
    awful.key({ ctrlkey, shiftkey        }, "Print", function() os.execute("maim -u -s -b 3 -c 0.98431372549019607843,0.28627450980392156862,0.20392156862745098039,1 ~/pictures/screenshots/$(date +%s).png") end,
              {description = "take screenshot", group = "launcher"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ mod_4             }, "c", function () awful.spawn("xsel | xsel -i -b") end),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ mod_4             }, "v", function () awful.spawn("xsel -b | xsel") end),

    -- Prompt
    awful.key({ mod_4             }, "$", function () awful.screen.focused().mypromptbox:run() end),
    awful.key({ mod_4             }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ mod_4             }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ mod_4             }, ".", function ()
        -- awful.spawn(string.format("dmenu_run -i -fn 'Meslo LG S for Powerline' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        awful.spawn(string.format("dmenu_run -i -t -dim 0.5 -p 'Run: ' -h 21 -fn 'Meslo LG S for Powerline-10' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        beautiful.tasklist_bg_normal, beautiful.fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
    end),
    -- awful.key({ altkey            }, "space", function ()
    --     -- awful.spawn(string.format("dmenu_run -i -fn 'Meslo LG S for Powerline' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
    --     awful.spawn(string.format("rofi -show run -width 100 -location 1 -lines 5 -bw 2 -yoffset -2",
    --     beautiful.tasklist_bg_normal, beautiful.tasklist_fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
    -- end),
    awful.key({ mod_4             }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),

    -- Dropdown application
    awful.key({ mod_4                     }, "y", function () awful.screen.focused().quake:toggle() end,
              {description = "open quake application", group = "screen"}),

    -- Screen browsing
    awful.key({ mod_4, altkey             }, leftkey, function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ mod_4, altkey             }, rightkey, function () awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),

    -- -- Tag browsing
    -- awful.key({ ctrlkey, altkey           }, leftkey, awful.tag.viewprev,
    --           {description = "view previous", group = "tag"}),
    -- awful.key({ ctrlkey, altkey           }, rightkey, awful.tag.viewnext,
    --           {description = "view next", group = "tag"}),
    -- awful.key({ ctrlkey, altkey           }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    -- Dynamic tagging
    awful.key({ mod_4, ctrlkey, shiftkey  }, leftkey, function () lain.util.move_tag(-1) end,
              {description = "move tag backward", group = "tag"}),
    awful.key({ mod_4, ctrlkey, shiftkey  }, rightkey, function () lain.util.move_tag(1) end,
              {description = "move tag forward", group = "tag"}),
    awful.key({ mod_4, altkey             }, "n", function () lain.util.add_tag() end,
              {description = "new tag", group = "tag"}),
    awful.key({ mod_4, altkey             }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ mod_4, altkey             }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- -- By direction client focus
    -- awful.key({ mod_4                     }, downkey, function()
    --         awful.client.focus.bydirection("down")
    --         if client.focus then client.focus:raise() end
    --     end),
    -- awful.key({ mod_4                     }, upkey, function()
    --         awful.client.focus.bydirection("up")
    --         if client.focus then client.focus:raise() end
    --     end),
    -- awful.key({ mod_4                     }, leftkey, function()
    --         awful.client.focus.bydirection("left")
    --         if client.focus then client.focus:raise() end
    --     end),
    -- awful.key({ mod_4                     }, rightkey, function()
    --         awful.client.focus.bydirection("right")
    --         if client.focus then client.focus:raise() end
    --     end),

    -- By index client focus
    awful.key({ mod_4                     }, upkey, function () awful.client.focus.byidx(-1) end,
              {description = "focus previous client by index", group = "client"}),
    awful.key({ mod_4                     }, downkey, function () awful.client.focus.byidx(1) end,
              {description = "focus next client by index", group = "client"}),
    awful.key({ mod_4                     }, leftkey, awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ mod_4                     }, rightkey, awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    -- Layout manipulation
    awful.key({ mod_4, shiftkey           }, upkey, function () awful.client.swap.byidx(-1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ mod_4, shiftkey           }, downkey, function () awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ mod_4, shiftkey           }, rightkey, function () awful.tag.incmwfact(0.01) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ mod_4, shiftkey           }, leftkey, function () awful.tag.incmwfact(-0.01) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ mod_4, ctrlkey            }, upkey, function () awful.tag.incnmaster(1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ mod_4, ctrlkey            }, downkey, function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ mod_4, ctrlkey, shiftkey  }, upkey, function () awful.tag.incncol(1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ mod_4, ctrlkey, shiftkey  }, downkey, function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ mod_4,                    }, "space", function () awful.layout.inc(1) end,
              {description = "select next", group = "layout"}),
    awful.key({ mod_4, shiftkey           }, "space", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),

    awful.key({ mod_4,                    }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    awful.key({ mod_4, ctrlkey            }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}),

    -- -- Show/Hide Wibox
    -- awful.key({ mod_4 }, "b", function ()
    --     for s in screen do
    --         s.mywibox.visible = not s.mywibox.visible
    --         if s.mybottomwibox then
    --             s.mybottomwibox.visible = not s.mybottomwibox.visible
    --         end
    --     end
    -- end),

    -- On the fly useless gaps change
    awful.key({ mod_4, altkey             }, downkey, function () lain.util.useless_gaps_resize(3) end,
              {description = "increase useless gap"}),
    awful.key({ mod_4, altkey             }, upkey, function () lain.util.useless_gaps_resize(-3) end,
              {description = "decrease useless gap"}),
    awful.key({ mod_4, altkey, shiftkey   }, downkey, function () lain.util.useless_gaps_resize(9) end),
    awful.key({ mod_4, altkey, shiftkey   }, upkey, function () lain.util.useless_gaps_resize(-9) end),

    -- Non-empty tag browsing
    awful.key({ mod_4, ctrlkey            }, leftkey, function () lain.util.tag_view_nonempty(-1) end,
              {description = "view previous nonempty", group = "tag"}),
    awful.key({ mod_4, ctrlkey            }, rightkey, function () lain.util.tag_view_nonempty(1) end,
              {description = "view previous nonempty", group = "tag"}),

    -- -- Default client focus
    -- awful.key({ altkey,           }, "j", function () awful.client.focus.byidx(1) end,
    --           {description = "focus next by index", group = "client"}),
    -- awful.key({ altkey,           }, "k", function () awful.client.focus.byidx(-1) end,
    --           {description = "focus previous by index", group = "client"}),

    -- -- Widgets popups
    -- awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end),
    -- awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end),
    -- awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end),

    -- ALSA volume control
    awful.key({   }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({   }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({   }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ ctrlkey }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ ctrlkey }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ ctrlkey }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s mute", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),

    -- Backlight / Brightness
    awful.key({   }, "XF86MonBrightnessUp",
        function()
            os.execute("xbacklight -inc 2 -time 1 -steps 1")
        end),
    awful.key({   }, "XF86MonBrightnessDown",
        function()
            local handle = io.popen("xbacklight -get")
            local current = handle:read("*n")
            handle:close()
            if current > 2 then
                os.execute("xbacklight -dec 2 -time 1 -steps 1")
            end
        end),
    awful.key({ ctrlkey }, "XF86MonBrightnessUp",
        function()
            os.execute("xbacklight -set 100 -time 1 -steps 1")
        end),
    awful.key({ ctrlkey }, "XF86MonBrightnessDown",
        function()
            os.execute("xbacklight -set 1 -time 1 -steps 1")
        end),

    -- MPD control
    awful.key({   }, "XF86AudioPlay",
        function ()
            awful.spawn.with_shell("mpc toggle")
            beautiful.mpd.update()
        end),
    awful.key({ ctrlkey }, "XF86AudioPlay",
        function ()
            awful.spawn.with_shell("mpc stop")
            beautiful.mpd.update()
        end),
    awful.key({   }, "XF86AudioPrev",
        function ()
            awful.spawn.with_shell("mpc prev")
            beautiful.mpd.update()
        end),
    awful.key({   }, "XF86AudioNext",
        function ()
            awful.spawn.with_shell("mpc next")
            beautiful.mpd.update()
        end),
    awful.key({ altkey }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end)
)

clientkeys = awful.util.table.join(
    awful.key({ mod_4, ctrlkey    }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "swap with master", group = "client"}),
    awful.key({ mod_4, ctrlkey    }, "m", lain.util.magnify_client,
              {description = "magnify", group = "client"}),
    awful.key({ mod_4             }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ mod_4             }, "-", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({ mod_4             }, "z", function (c) c:kill() end),
    awful.key({ mod_4, ctrlkey    }, "space", awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({ mod_4             }, "o", function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({ mod_4             }, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ mod_4             }, "s", function (c) c.sticky = not c.sticky end,
              {description = "toggle sticky", group = "client"}),
    awful.key({ mod_4             }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ mod_4            }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ mod_4 }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ mod_4, ctrlkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ mod_4, shiftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ mod_4, altkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({                 }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ mod_4           }, 1, awful.mouse.client.move),
    awful.button({ mod_4, shiftkey }, 1, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- Set Firefox to always map on the first tag on screen 1.
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = awful.util.tagnames[1] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
      properties = { maximized = true } },

    { rule = { class = "feh" },
      properties = { floating = true, x = 30, y = 51 } },

    { rule = { class = "Pinentry" },
      properties = { floating = true } },
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
        beautiful.titlebar_fun(c)
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

    awful.titlebar(c, {size = 16}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- -- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--         and awful.client.focus.filter(c) then
--         client.focus = c
--     end
-- end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized then
            c.border_width = 0
            c.border_color = beautiful.border_normal
        elseif awful.layout.get(c.screen) == awful.layout.suit.max
                or #awful.screen.focused().clients == 1 then
            c.border_color = beautiful.border_normal
        elseif #awful.screen.focused().clients > 1 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)

client.connect_signal("property::maximized",
    function(c)
        if c.maximized then
            c.border_width = 0
            c.border_color = beautiful.border_normal
        elseif awful.layout.get(c.screen) == awful.layout.suit.max
                or #awful.screen.focused().clients == 1 then
            c.border_color = beautiful.border_normal
        elseif #awful.screen.focused().clients > 1 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)

tag.connect_signal("property::layout",
    function(t)
        if #awful.screen.focused().clients >= 1
                and client.focus.maximized then
            client.focus.border_width = 0
            client.focus.border_color = beautiful.border_normal
        elseif (t.layout == awful.layout.suit.max
                and #awful.screen.focused().clients >= 1)
                or #awful.screen.focused().clients == 1 then
            client.focus.border_color = beautiful.border_normal
        elseif #awful.screen.focused().clients > 1 then
            client.focus.border_width = beautiful.border_width
            client.focus.border_color = beautiful.border_focus
        end
    end)

client.connect_signal("unfocus",
    function(c)
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_normal
    end)

-- -- Rounded corners
-- client.connect_signal("manage",
--     function(c)
--         c.shape = function(cr, w, h)
--             gears.shape.rounded_rect(cr, w, h, 3)
--             end
--     end)

-- }}}
