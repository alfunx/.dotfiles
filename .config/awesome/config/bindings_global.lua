
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local markup = require("lain.util.markup")

local context = require("config.context")
local brokers = require("config.brokers")
local sidebar = require("config.sidebar")
local menu = require("config.menu")
local util = require("config.util")
local tags = require("config.tags")

local _config = { }

function _config.init()

    local k = require("config.keys") --luacheck: no unused

    -- {{{ Keys

    _config.keys = gears.table.join(

        -- Awesome Hotkeys
        awful.key({ k.m, k.c           }, "s", hotkeys_popup.show_help,
                  { description = "show help", group = "awesome" }),
        awful.key({ k.m, k.c           }, "o", function() menu.main:show() end,
                  { description = "show main menu", group = "awesome" }),
        awful.key({ k.m, k.c           }, "r", awesome.restart,
                  { description = "reload awesome", group = "awesome" }),
        awful.key({ k.m, k.c           }, "q", awesome.quit,
                  { description = "quit awesome", group = "awesome" }),
        awful.key({ k.m, k.c           }, "z", function() awful.spawn("sync"); awful.spawn("lock") end,
                  { description = "lock screen", group = "awesome" }),
        awful.key({ k.m                }, "Escape", naughty.destroy_all_notifications,
                  { description = "dismiss all notifications", group = "awesome" }),

        -- Switch to alternative theme
        awful.key({ k.m, k.a           }, "z", util.alternate_theme,
                  { description = "switch to alternative theme", group = "awesome" }),

        -- Hotkeys
        awful.key({ k.m                }, "Return", function() awful.spawn(context.vars.terminal) end,
                  { description = "open a terminal", group = "launcher" }),
        awful.key({ k.m, k.c           }, "Return", function() awful.spawn(context.vars.terminal,
                  { floating = true, placement = awful.placement.centered }) end,
                  { description = "open a floating terminal", group = "launcher" }),
        awful.key({ k.m                }, "b", function() awful.spawn(context.vars.browser) end,
                  { description = "open browser", group = "launcher" }),
        awful.key({ k.m                }, "d", function() awful.spawn("discord") end,
                  { description = "open discord", group = "launcher" }),
        awful.key({ k.m                }, "e", function() awful.spawn("spotify") end,
                  { description = "open spotify", group = "launcher" }),
        awful.key({ k.m,               }, "w", function() awful.spawn("kitty -e sudo wifi-menu",
                  { floating = true, placement = awful.placement.centered }) end,
                  { description = "open wifi-menu", group = "launcher" }),

        -- Screenshot
        awful.key({                    }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/make-screenshot" })
        end,
                  { description = "take screenshot", group = "screenshot" }),
        awful.key({ k.s                }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/make-screenshot -s" })
        end,
                  { description = "take screenshot, select area", group = "screenshot" }),
        awful.key({ k.c                }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/make-screenshot -C" })
        end,
                  { description = "take screenshot, hide mouse", group = "screenshot" }),
        awful.key({ k.c, k.s           }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/make-screenshot -sC" })
        end,
                  { description = "take screenshot, hide mouse, select area", group = "screenshot" }),
        awful.key({ k.m                }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/make-screenshot -t" })
        end,
                  { description = "wait 5s, take screenshot", group = "screenshot" }),
        awful.key({ k.m, k.c           }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/make-screenshot -tH" })
        end,
                  { description = "wait 5s, take screenshot, hide mouse", group = "screenshot" }),
        awful.key({ k.a                }, "Print", function()
            awful.spawn(table.concat { context.vars.scripts_dir, "/upload-to-imgur" })
        end,
                  { description = "upload last screenshot to Imgur", group = "screenshot" }),

        -- -- Copy primary to clipboard (terminals to gtk)
        -- awful.key({ k.m                }, "c", function() awful.spawn("xsel | xsel -i -b") end),
        -- -- Copy clipboard to primary (gtk to terminals)
        -- awful.key({ k.m                }, "v", function() awful.spawn("xsel -b | xsel") end),

        -- Sidebar
        awful.key({ k.m, k.c           }, "/", function() sidebar.widget:toggle() end,
                  { description = "toggle sidebar", group = "awesome" }),

        -- Prompt
        awful.key({ k.m                }, "r", function() awful.screen.focused()._promptbox:run() end,
                  { description = "run prompt", group = "launcher" }),
        awful.key({ k.m, k.a           }, "p", function() menubar.show() end,
                  { description = "show the menubar", group = "launcher" }),
        awful.key({ k.m                }, ",", function()
            awful.spawn.easy_async("rofi -show drun", function() end)
        end,
                  { description = "show application menu (rofi)", group = "launcher" }),
        awful.key({ k.m                }, ".", function()
            awful.spawn.easy_async("rofi -show run", function() end)
        end,
                  { description = "show commands menu (rofi)", group = "launcher" }),
        awful.key({ k.m                }, "/", function()
            awful.spawn.easy_async(table.concat { context.vars.scripts_dir, "/rofi-session" }, function() end)
        end,
                  { description = "show session menu (rofi)", group = "launcher" }),
        awful.key({ k.m                }, "x", function()
            awful.prompt.run {
                prompt       = "Run (Lua): ",
                textbox      = awful.screen.focused()._promptbox.widget,
                exe_callback = awful.util.eval,
                history_path = table.concat { gears.filesystem.get_cache_dir(), "/history_eval" },
            }
        end,
                  { description = "lua execute prompt", group = "awesome" }),

        -- Dropdown application
        awful.key({ k.m                }, "y", function() awful.screen.focused().quake:toggle() end,
                  { description = "open quake application", group = "screen" }),

        -- Screen browsing
        awful.key({ k.c, k.a           }, k.l, function() awful.screen.focus_relative(-1) end,
                  { description = "focus the previous screen", group = "screen" }),
        awful.key({ k.c, k.a           }, k.r, function() awful.screen.focus_relative(1) end,
                  { description = "focus the next screen", group = "screen" }),

        -- -- Tag browsing
        -- awful.key({ k.c, k.a           }, k.l, awful.tag.viewprev,
        --           { description = "view previous", group = "tag" }),
        -- awful.key({ k.c, k.a           }, k.r, awful.tag.viewnext,
        --           { description = "view next", group = "tag" }),
        -- awful.key({ k.c, k.a           }, "Escape", awful.tag.history.restore,
        --           { description = "go back", group = "tag" }),

        -- Dynamic tagging
        awful.key({ k.m, k.a           }, k.l, function()
            util.move_tag(-1)
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "move tag backward", group = "tag" }),
        awful.key({ k.m, k.a           }, k.r, function()
            util.move_tag(1)
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "move tag forward", group = "tag" }),
        awful.key({ k.m, k.a           }, "n", function()
            util.add_tag()
        end,
                  { description = "new tag", group = "tag" }),
        awful.key({ k.m, k.a           }, "r", function()
            util.rename_tag()
        end,
                  { description = "rename tag", group = "tag" }),
        awful.key({ k.m, k.a           }, "d", function()
            util.delete_tag()
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "delete tag", group = "tag" }),
        awful.key({ k.m, k.a           }, "a", function()
            for i = 1, tags.columns or #tags.names do
                awful.tag.add(tostring(i), {
                    screen = awful.screen.focused(),
                    layout = awful.layout.suit.tile,
                })
            end
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "add row of tags", group = "tag" }),
        awful.key({ k.m, k.a           }, "BackSpace", function()
            awful.tag.history.restore()
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "go back", group = "tag" }),

        -- Non-empty tag browsing
        awful.key({ k.m, k.c           }, k.l, function()
            util.tag_view_nonempty(-1)
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "view previous nonempty", group = "tag" }),
        awful.key({ k.m, k.c           }, k.r, function()
            util.tag_view_nonempty(1)
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "view next nonempty", group = "tag" }),

        -- Select tag in grid
        awful.key({ k.m                }, k.l, function()
            util.select_tag_in_grid("l")
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "view previous", group = "tag" }),
        awful.key({ k.m                }, k.r, function()
            util.select_tag_in_grid("r")
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "view next", group = "tag" }),
        awful.key({ k.m, k.c           }, k.u, function()
            util.select_tag_in_grid("u")
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "view above", group = "tag" }),
        awful.key({ k.m, k.c           }, k.d, function()
            util.select_tag_in_grid("d")
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "view below", group = "tag" }),

        -- Client manipulation
        awful.key({ k.m                }, k.u, function()
            awful.client.focus.byidx(-1)
            util.show_tasklist()
        end,
                  { description = "focus previous client by index", group = "client" }),
        awful.key({ k.m                }, k.d, function()
            awful.client.focus.byidx(1)
            util.show_tasklist()
        end,
                  { description = "focus next client by index", group = "client" }),
        awful.key({ k.m, k.s           }, k.u, function()
            awful.client.swap.byidx(-1)
            util.show_tasklist()
        end,
                  { description = "swap with previous client by index", group = "client" }),
        awful.key({ k.m, k.s           }, k.d, function()
            awful.client.swap.byidx(1)
            util.show_tasklist()
        end,
                  { description = "swap with next client by index", group = "client" }),
        awful.key({ k.m                }, "u", function()
            awful.client.urgent.jumpto()
            -- awful.screen.focused()._taglist_popup:show()
        end,
                  { description = "jump to urgent client", group = "client" }),

        -- Cycle clients
        awful.key({ k.m, k.a           }, k.u, function()
            awful.client.cycle(false)
            awful.client.focus.byidx(1)
        end,
                  { description = "counter-clockwise cycle", group = "client" }),
        awful.key({ k.m, k.a           }, k.d, function()
            awful.client.cycle(true)
            awful.client.focus.byidx(-1)
        end,
                  { description = "clockwise cycle", group = "client" }),

        -- Toggle between clients
        awful.key({ k.m                }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
                  { description = "toggle client", group = "client" }),
        awful.key({ k.m, k.c           }, "Tab", function()
            local c = util.global_history_get(awful.screen.focused(), 1)
            if c then
                c.first_tag:view_only()
                c:emit_signal("request::activate", "ewmh", {raise=true})
            end
        end,
                  { description = "toggle client (global)", group = "client" }),

        -- Restore minimized client
        awful.key({ k.m, k.c           }, "n", function()
            local c = awful.client.restore()
            if c then
                client.focus = c
                c:raise()
            end
        end,
                  { description = "restore minimized", group = "client" }),

        -- Toggle all titlebars
        awful.key({ k.m, k.c           }, "i", function()
            for _, c in pairs(awful.screen.focused().clients) do
                if not c.floating then util.toggle_titlebar(c) end
            end
        end,
                  { description = "toggle all titlebars", group = "client" }),

        -- Hide all titlebars
        awful.key({ k.m, k.c, k.s      }, "i", function()
            for _, c in pairs(awful.screen.focused().clients) do
                if not c.floating then util.hide_titlebar(c) end
            end
        end,
                  { description = "hide all titlebars", group = "client" }),

        -- Keyboard layout
        awful.key({ k.m                }, "c", function()
                    awful.spawn("keymap_toggle") end,
                  { description = "Switch keyboard layout", group = "client" }),

        -- Layout manipulation
        awful.key({ k.m, k.s           }, k.r, function() util.resize_horizontal(0.01) end,
                  { description = "increase master width factor", group = "layout" }),
        awful.key({ k.m, k.s           }, k.l, function() util.resize_horizontal(-0.01) end,
                  { description = "decrease master width factor", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.u, function() awful.tag.incnmaster(1, nil, true) end,
                  { description = "increase the number of master clients", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.d, function() awful.tag.incnmaster(-1, nil, true) end,
                  { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.r, function() awful.tag.incncol(1, nil, true) end,
                  { description = "increase the number of slave columns", group = "layout" }),
        awful.key({ k.m, k.a, k.s      }, k.l, function() awful.tag.incncol(-1, nil, true) end,
                  { description = "decrease the number of slave columns", group = "layout" }),
        awful.key({ k.m                }, "space", function()
            awful.layout.inc(1)
            awful.screen.focused()._layout_popup:show()
        end,
                  { description = "select next layout", group = "layout" }),
        awful.key({ k.m, k.s           }, "space", function()
            awful.layout.inc(-1)
            awful.screen.focused()._layout_popup:show()
        end,
                  { description = "select previous layout", group = "layout" }),

        -- Show/hide wibox
        awful.key({ k.m, k.c           }, "b", function()
            for s in screen do
                s._wibox.visible = not s._wibox.visible
                if s._bottomwibox then
                    s._bottomwibox.visible = not s._bottomwibox.visible
                end
            end
        end),

        -- Update widgets
        awful.key({ k.m, k.c           }, "u", function()
            brokers:show()
            if brokers.mpd then
                brokers.mpd.update()
            end
        end,
                  { description = "update widgets", group = "widget" }),

        -- Toggle hidden widget
        awful.key({ k.m, k.a           }, "i", function()
            local s = awful.screen.focused()
            if not s._hidden_widget then return end
            s._hidden_widget.visible = not s._hidden_widget.visible
        end,
                  { description = "toggle hidden widget", group = "widget" }),

        -- Show weather notification
        awful.key({ k.m, k.c           }, "w", function()
            brokers.weather:show()
        end,
                  { description = "show weather notification", group = "widget" }),

        -- ALSA volume control
        awful.key({                    }, "XF86AudioRaiseVolume", function()
            brokers.audio:increase()
        end),
        awful.key({                    }, "XF86AudioLowerVolume", function()
            brokers.audio:decrease()
        end),
        awful.key({                    }, "XF86AudioMute", function()
            brokers.audio:toggle()
        end),
        awful.key({ k.c                }, "XF86AudioRaiseVolume", function()
            brokers.audio:set_max()
        end),
        awful.key({ k.c                }, "XF86AudioLowerVolume", function()
            brokers.audio:set_min()
        end),
        awful.key({ k.c                }, "XF86AudioMute", function()
            brokers.audio:off()
        end),

        -- Backlight / Brightness
        awful.key({                    }, "XF86MonBrightnessUp", function()
            brokers.brightness:increase()
        end),
        awful.key({                    }, "XF86MonBrightnessDown", function()
            brokers.brightness:decrease()
        end),
        awful.key({ k.c                }, "XF86MonBrightnessUp", function()
            brokers.brightness:set_max()
        end),
        awful.key({ k.c                }, "XF86MonBrightnessDown", function()
            brokers.brightness:set_min()
        end)

        -- -- MPD control
        -- awful.key({                    }, "XF86AudioPlay", function()
        --     awful.spawn.with_shell("mpc toggle")
        --     brokers.mpd.update()
        -- end),
        -- awful.key({ k.c                }, "XF86AudioPlay", function()
        --     awful.spawn.with_shell("mpc stop")
        --     brokers.mpd.update()
        -- end),
        -- awful.key({                    }, "XF86AudioPrev", function()
        --     awful.spawn.with_shell("mpc prev")
        --     brokers.mpd.update()
        -- end),
        -- awful.key({                    }, "XF86AudioNext", function()
        --     awful.spawn.with_shell("mpc next")
        --     brokers.mpd.update()
        -- end),
        -- awful.key({ k.a                }, "0", function()
        --     local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
        --     if brokers.mpd.timer.started then
        --         brokers.mpd.timer:stop()
        --         common.text = table.concat { common.text, markup.bold("OFF") }
        --     else
        --         brokers.mpd.timer:start()
        --         common.text = table.concat { common.text, markup.bold("ON") }
        --     end
        --     naughty.notify(common)
        -- end)
    )

    -- Bind number keys
    -- NOTE: Using keycodes to make it works on any keyboard layout
    for i = 1, 10 do
        _config.keys = gears.table.join(
            _config.keys,

            -- View tag only
            awful.key({ k.m                }, "#" .. i + 9, function()
                local s = awful.screen.focused()
                local t = s.tags[i]
                if not t then return end
                if t == s.selected_tag then
                    awful.tag.history.restore()
                else
                    t:view_only()
                end
                -- s._taglist_popup:show()
            end),

            -- Toggle tag display
            awful.key({ k.m, k.c           }, "#" .. i + 9, function()
                local s = awful.screen.focused()
                local t = s.tags[i]
                if t then
                    awful.tag.viewtoggle(t)
                end
                -- s._taglist_popup:show()
            end)
        )
    end

    -- }}}

    -- {{{ Fake bindings for description

    -- View tag only
    util.fake_key({ k.m                }, "1..9", nil,
                  { description = "view tag", group = "numeric keys" })

    -- Toggle tag display
    util.fake_key({ k.m, k.c           }, "1..9", nil,
                  { description = "toggle tag", group = "numeric keys" })

    -- }}}

    -- {{{ Buttons

    _config.buttons = gears.table.join(
        awful.button({                    }, 3, function() menu.main:toggle() end),
        awful.button({                    }, 4, function() end),
        awful.button({                    }, 5, function() end)
        -- awful.button({                    }, 4, awful.tag.viewnext),
        -- awful.button({                    }, 5, awful.tag.viewprev)
    )

    -- }}}

    -- Set keys
    root.keys(_config.keys)

    -- Set buttons
    root.buttons(_config.buttons)

    -- -- Layout
    -- awful.keygrabber {
    --     start_callback = function() awful.screen.focused()._layout_popup.visible = true end,
    --     stop_callback  = function() awful.screen.focused()._layout_popup.visible = false end,
    --     export_keybindings = true,
    --     stop_event = "release",
    --     stop_key = { k.m },
    --     allowed_keys   = { "Shift_L", "Shift_R", " " },
    --     keybindings = {
    --         {{ k.m                } , " " , function()
    --             awful.layout.inc(1)
    --             -- awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, 1), nil)
    --         end,
    --          { description = "select next", group = "layout" }},
    --         {{ k.m, k.s           } , " " , function()
    --             -- awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, -1), nil)
    --             awful.layout.inc(-1)
    --         end,
    --          { description = "select previous", group = "layout" }},
    --     }
    -- }

end

return _config
