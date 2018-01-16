
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
-- spawn_once("termite", "termite", awful.tag.find_by_name(awful.screen.focused(), "2"))
-- spawn_once("termite", "termite", awful.screen.focused().tags[2])

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

menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}

-- {{{ Blur Wallpaper
local set_wallpaper = function(clients)
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
    awful.button({ }, 3, function() awful.util.mymainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

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
            return new_index
        end
        select_tag_in_grid(direction, new_index)
    end
end

local function move_client_in_grid(direction)
    if client.focus then
        local current_client = client.focus
        local new_index = select_tag_in_grid(direction)
        local new_tag = awful.screen.focused().tags[new_index]
        current_client:move_to_tag(new_tag)
        current_client:raise()
    end
end

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
    awful.key({ mod_4, ctrlkey,           }, "z", function () awful.spawn("sync"); awful.spawn("xautolock -locknow") end,
              {description = "lock screen", group = "awesome"}),

    -- Hotkeys
    awful.key({ mod_4,                    }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ mod_4,                    }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ mod_4, ctrlkey            }, "Return", function () awful.spawn(terminal, { floating = true, placement = awful.placement.centered }) end,
              {description = "open a floating terminal", group = "launcher"}),
    awful.key({ mod_4,                    }, "v", function () awful.spawn(terminal) end),
    awful.key({ mod_4                     }, "b", function () awful.spawn(browser) end,
              {description = "open browser", group = "launcher"}),
    awful.key({ mod_4                     }, "e", function () awful.spawn(editor) end,
              {description = "open editor", group = "launcher"}),
    awful.key({ mod_4                     }, "w", function () awful.spawn("Whatsapp") end,
              {description = "open whatsapp", group = "launcher"}),

    awful.key({                          }, "Print", function() os.execute("maim ~/pictures/screenshots/$(date +%Y-%m-%d_%T).png") end,
              {description = "take screenshot", group = "launcher"}),
    awful.key({ ctrlkey                  }, "Print", function() os.execute("maim -s -b 3 -c 0.98431372549019607843,0.28627450980392156862,0.20392156862745098039,1 ~/pictures/screenshots/$(date +%Y-%m-%d_%T).png") end,
              {description = "take screenshot, select area", group = "launcher"}),
    awful.key({ shiftkey                 }, "Print", function() os.execute("maim -u ~/pictures/screenshots/$(date +%Y-%m-%d_%T).png") end,
              {description = "take screenshot, hide mouse", group = "launcher"}),
    awful.key({ ctrlkey, shiftkey        }, "Print", function() os.execute("maim -u -s -b 3 -c 0.98431372549019607843,0.28627450980392156862,0.20392156862745098039,1 ~/pictures/screenshots/$(date +%Y-%m-%d_%T).png") end,
              {description = "take screenshot, hide mouse, select area", group = "launcher"}),

    -- -- Copy primary to clipboard (terminals to gtk)
    -- awful.key({ mod_4             }, "c", function () awful.spawn("xsel | xsel -i -b") end),
    -- -- Copy clipboard to primary (gtk to terminals)
    -- awful.key({ mod_4             }, "v", function () awful.spawn("xsel -b | xsel") end),

    -- Prompt
    awful.key({ mod_4             }, "$", function () awful.screen.focused().mypromptbox:run() end),
    awful.key({ mod_4             }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ mod_4             }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ mod_4             }, ".", function ()
        awful.spawn("rofi -show drun")
        -- awful.spawn(string.format("dmenu_run -i -t -dim 0.5 -p 'Run: ' -h 21 -fn 'Meslo LG S for Powerline-10' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
        -- beautiful.tasklist_bg_normal, beautiful.fg_normal, beautiful.tasklist_bg_urgent, beautiful.tasklist_fg_urgent))
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
    awful.key({ mod_4, altkey, shiftkey   }, leftkey, function () lain.util.move_tag(-1) end,
              {description = "move tag backward", group = "tag"}),
    awful.key({ mod_4, altkey, shiftkey   }, rightkey, function () lain.util.move_tag(1) end,
              {description = "move tag forward", group = "tag"}),
    awful.key({ mod_4, altkey             }, "n", function () lain.util.add_tag() end,
              {description = "new tag", group = "tag"}),
    awful.key({ mod_4, altkey             }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ mod_4, altkey             }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),
    awful.key({ mod_4, altkey             }, "a",
        function()
            for i = 1, 9 do
                awful.tag.add(tostring(i), { screen = awful.screen.focused(), layout = layout or awful.layout.suit.tile })
            end
        end,
              {description = "add row of tags", group = "tag"}),
    awful.key({ mod_4, altkey             }, "BackSpace", awful.tag.history.restore,
              {description = "go back", group = "tag"}),


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

    -- awful.key({ mod_4                     }, leftkey, awful.tag.viewprev,
    --           {description = "view previous", group = "tag"}),
    -- awful.key({ mod_4                     }, rightkey, awful.tag.viewnext,
    --           {description = "view next", group = "tag"}),
    -- awful.key({ mod_4, ctrlkey            }, upkey,
    --     function()
    --         local columns = awful.util.tagcolumns or #awful.util.tagnames
    --         awful.tag.viewidx(-columns)
    --     end,
    --           {description = "view above", group = "tag"}),
    -- awful.key({ mod_4, ctrlkey            }, downkey,
    --     function()
    --         local columns = awful.util.tagcolumns or #awful.util.tagnames
    --         awful.tag.viewidx(columns)
    --     end,
    --           {description = "view below", group = "tag"}),

    -- Non-empty tag browsing
    awful.key({ mod_4, ctrlkey            }, leftkey, function () lain.util.tag_view_nonempty(-1) end,
              {description = "view previous nonempty", group = "tag"}),
    awful.key({ mod_4, ctrlkey            }, rightkey, function () lain.util.tag_view_nonempty(1) end,
              {description = "view next nonempty", group = "tag"}),

    -- -- Default client focus
    -- awful.key({ altkey,           }, "j", function () awful.client.focus.byidx(1) end,
    --           {description = "focus next by index", group = "client"}),
    -- awful.key({ altkey,           }, "k", function () awful.client.focus.byidx(-1) end,
    --           {description = "focus previous by index", group = "client"}),

    -- awful.key({ mod_4                     }, leftkey, function() select_tag_in_grid("l") end),
    -- awful.key({ mod_4                     }, rightkey, function() select_tag_in_grid("r") end),

    awful.key({ mod_4                     }, leftkey, function() select_tag_in_grid("l") end,
              {description = "view previous", group = "tag"}),
    awful.key({ mod_4                     }, rightkey, function() select_tag_in_grid("r") end,
              {description = "view next", group = "tag"}),
    awful.key({ mod_4, ctrlkey            }, upkey, function() select_tag_in_grid("u") end,
              {description = "view above", group = "tag"}),
    awful.key({ mod_4, ctrlkey            }, downkey, function() select_tag_in_grid("d") end,
              {description = "view below", group = "tag"}),

    awful.key({ mod_4, ctrlkey, shiftkey  }, leftkey, function() move_client_in_grid("l") end,
              {description = "move to previous tag", group = "tag"}),
    awful.key({ mod_4, ctrlkey, shiftkey  }, rightkey, function() move_client_in_grid("r") end,
              {description = "move to next tag", group = "tag"}),
    awful.key({ mod_4, ctrlkey, shiftkey  }, upkey, function() move_client_in_grid("u") end,
              {description = "move to tag above", group = "tag"}),
    awful.key({ mod_4, ctrlkey, shiftkey  }, downkey, function() move_client_in_grid("d") end,
              {description = "move to tag below", group = "tag"}),

    -- -- Move client between tags
    -- awful.key({ mod_4, ctrlkey, shiftkey  }, leftkey,
    --     function ()
    --         if client.focus then
    --             local current_tag = (client.focus.screen.selected_tags[1].index - 2) % #awful.screen.focused().tags + 1
    --             local tag = client.focus.screen.tags[current_tag]
    --             if tag then
    --                 client.focus:move_to_tag(tag)
    --             end
    --         end
    --         awful.tag.viewprev()
    --     end,  {description = "move client to previous tag", group = "client"}),
    -- awful.key({ mod_4, ctrlkey, shiftkey  }, rightkey,
    --     function ()
    --         if client.focus then
    --             local current_tag = (client.focus.screen.selected_tags[1].index) % #awful.screen.focused().tags + 1
    --             local tag = client.focus.screen.tags[current_tag]
    --             if tag then
    --                 client.focus:move_to_tag(tag)
    --             end
    --         end
    --         awful.tag.viewnext()
    --     end,  {description = "move client to next tag", group = "client"}),

    -- Layout manipulation
    awful.key({ mod_4, shiftkey           }, upkey, function () awful.client.swap.byidx(-1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ mod_4, shiftkey           }, downkey, function () awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ mod_4, shiftkey           }, rightkey, function () awful.tag.incmwfact(0.01) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ mod_4, shiftkey           }, leftkey, function () awful.tag.incmwfact(-0.01) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ mod_4, altkey             }, rightkey, function () awful.tag.incnmaster(1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ mod_4, altkey             }, leftkey, function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ mod_4, altkey             }, upkey, function () awful.tag.incncol(1, nil, true) end,
              {description = "increase the number of slave columns", group = "layout"}),
    awful.key({ mod_4, altkey             }, downkey, function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of slave columns", group = "layout"}),
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

    -- Show/Hide Wibox
    awful.key({ mod_4, ctrlkey            }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end),

    -- On the fly useless gaps change
    awful.key({ mod_4, altkey, shiftkey   }, downkey, function () lain.util.useless_gaps_resize(beautiful.useless_gap/2) end,
              {description = "increase useless gap", group = "layout"}),
    awful.key({ mod_4, altkey, shiftkey   }, upkey, function () lain.util.useless_gaps_resize(-beautiful.useless_gap/2) end,
              {description = "decrease useless gap", group = "layout"}),
    awful.key({ mod_4, altkey, shiftkey, ctrlkey }, downkey, function () lain.util.useless_gaps_resize(1) end),
    awful.key({ mod_4, altkey, shiftkey, ctrlkey }, upkey, function () lain.util.useless_gaps_resize(-1) end),

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
    awful.key({ mod_4, altkey     }, "Return", function (c) c:swap(awful.client.getmaster()) end,
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
    awful.key({ mod_4            }, "i", function (c) awful.titlebar.toggle(c) end,
              {description = "toggle titlebar", group = "client"}),
    awful.key({ mod_4, ctrlkey   }, "i", function (c) set_wallpaper(0) end,
              {description = "toggle titlebar", group = "client"}),
    awful.key({ mod_4             }, "n", function (c) c.minimized = true end,
              {description = "minimize", group = "client"}),
    awful.key({ mod_4            }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
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
                  {description = "view tag #"..i, group = "tag-direct"}),
        -- Toggle tag display.
        awful.key({ mod_4, ctrlkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag-direct"}),
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
                  {description = "move focused client to tag #"..i, group = "tag-direct"}),
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
                  {description = "toggle focused client on tag #" .. i, group = "tag-direct"})
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
                       size_hints_honor = false,
                       titlebars_enabled = true }
    },

    { rule_any = { type = { "normal", "dialog" } },
      properties = { titlebars_enabled = true } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
      properties = { screen = 1, tag = awful.util.tagnames[7] } },

    { rule = { class = "VirtualBox" },
      properties = { screen = 1, tag = awful.util.tagnames[8] } },

    { rule = { class = "Git-gui" },
      properties = { floating = true, x = 30, y = 51, placement = awful.placement.centered+awful.placement.no_offscreen } },

    { rule = { class = "feh" },
      properties = { floating = true, x = 30, y = 51, placement = awful.placement.centered+awful.placement.no_offscreen } },

    { rule = { class = "Lxappearance" },
      properties = { floating = true, x = 30, y = 51, placement = awful.placement.centered+awful.placement.no_offscreen } },

    { rule = { class = "Oomox" },
      properties = { floating = true, x = 30, y = 51, placement = awful.placement.centered+awful.placement.no_offscreen } },

    { rule = { class = "Pinentry" },
      properties = { floating = true, placement = awful.placement.centered+awful.placement.no_offscreen } },

    { rule = { name = "Event Tester" },
      properties = { floating = true, placement = awful.placement.centered+awful.placement.no_offscreen } },

    { rule = { name = "alsamixer" },
      properties = { floating = true, x = 30, y = 51, placement = awful.placement.centered+awful.placement.no_offscreen } },

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

    awful.titlebar(c, {size = 20}) : setup {
        { -- Left
            wibox.container.margin(awful.titlebar.widget.iconwidget(c), 0, 5),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "left",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            -- awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
    -- awful.titlebar(c, {
    --     size = 4,
    --     position = "bottom",
    -- }) : setup { layout = wibox.layout.align.horizontal }
    -- awful.titlebar(c, {
    --     size = 4,
    --     position = "left",
    -- }) : setup { layout = wibox.layout.align.horizontal }
    -- awful.titlebar(c, {
    --     size = 4,
    --     position = "right",
    -- }) : setup { layout = wibox.layout.align.horizontal }

    -- Hide the titlebar if we are not floating
    if not (awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating) then
        awful.titlebar.hide(c)
    end
end)

client.connect_signal("property::size",
    function(c)
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

-- -- No border for maximized clients
-- client.connect_signal("focus",
--     function(c)
--         if not c.maximized and (awful.layout.get(c.screen) == awful.layout.suit.floating or
--                 c.type == "dialog" or c.floating) then
--             c.border_width = beautiful.border_width
--             c.border_color = beautiful.border_focus
--             awful.titlebar.show(c)
--         elseif c.maximized then
--             c.border_width = 0
--             c.border_color = beautiful.border_normal
--             awful.titlebar.hide(c)
--         elseif awful.layout.get(c.screen) == awful.layout.suit.max
--                 or #awful.screen.focused().clients == 1 then
--             c.border_color = beautiful.border_normal
--             awful.titlebar.hide(c)
--         elseif #awful.screen.focused().clients > 1 then
--             c.border_width = beautiful.border_width
--             c.border_color = beautiful.border_focus
--             awful.titlebar.hide(c)
--         end
--     end)
--
-- client.connect_signal("property::maximized",
--     function(c)
--         if not c.maximized and (awful.layout.get(c.screen) == awful.layout.suit.floating or
--                 c.type == "dialog" or c.floating) then
--             c.border_width = beautiful.border_width
--             c.border_color = beautiful.border_focus
--             awful.titlebar.show(c)
--         elseif c.maximized then
--             c.border_width = 0
--             c.border_color = beautiful.border_normal
--             awful.titlebar.hide(c)
--         elseif awful.layout.get(c.screen) == awful.layout.suit.max
--                 or #awful.screen.focused().clients == 1 then
--             c.border_color = beautiful.border_normal
--             awful.titlebar.hide(c)
--         elseif #awful.screen.focused().clients > 1 then
--             c.border_width = beautiful.border_width
--             c.border_color = beautiful.border_focus
--             awful.titlebar.hide(c)
--         end
--     end)
--
-- tag.connect_signal("property::layout",
--     function(t)
--         if #awful.screen.focused().clients >= 1 and
--                 not client.focus.maximized and (t.layout == awful.layout.suit.floating or
--                 client.focus.type == "dialog" or client.focus.floating) then
--             client.focus.border_width = beautiful.border_width
--             client.focus.border_color = beautiful.border_focus
--             awful.titlebar.show(client.focus)
--         elseif #awful.screen.focused().clients >= 1
--                 and client.focus.maximized then
--             client.focus.border_width = 0
--             client.focus.border_color = beautiful.border_normal
--             awful.titlebar.hide(client.focus)
--         elseif (t.layout == awful.layout.suit.floating
--                 and #awful.screen.focused().clients >= 1)
--                 or #awful.screen.focused().clients == 1 then
--             client.focus.border_color = beautiful.border_normal
--             awful.titlebar.hide(client.focus)
--         elseif #awful.screen.focused().clients > 1 then
--             client.focus.border_width = beautiful.border_width
--             client.focus.border_color = beautiful.border_focus
--             awful.titlebar.hide(client.focus)
--         end
--     end)
--
-- client.connect_signal("property::floating",
--     function(c)
--         if c.floating then
--             awful.titlebar.show(c)
--         else
--             awful.titlebar.hide(c)
--         end
--     end)
--
-- -- awful.tag.attached_connect_signal(s, "property::layout", function (t)
-- --     local float = t.layout.name == "floating"
-- --     for _,c in pairs(t:clients()) do
-- --         c.floating = float
-- --     end
-- -- end)
--
-- client.connect_signal("unfocus",
--     function(c)
--         c.border_width = beautiful.border_width
--         c.border_color = beautiful.border_normal
--     end)

screen.connect_signal("tag::history::update",
    function(s)
        set_wallpaper(#s.clients)
    end)

client.connect_signal("tagged",
    function(c)
        set_wallpaper(#c.screen.clients)
    end)

client.connect_signal("untagged",
    function(c)
        set_wallpaper(#c.screen.clients)
    end)

client.connect_signal("property::minimized",
    function(c)
        set_wallpaper(#c.screen.clients)
    end)

client.connect_signal("focus",
    function(c)
        c.border_color = beautiful.border_focus
    end)

client.connect_signal("unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end)

-- client.connect_signal("property::fullscreen",
--     function(c)
--         if c.maximized or c.fullscreen then
--             c.border_width = 0
--             awful.titlebar.hide(c, "top")
--             awful.titlebar.hide(c, "bottom")
--             awful.titlebar.hide(c, "left")
--             awful.titlebar.hide(c, "right")
--         else
--             c.border_width = beautiful.border_width
--             awful.titlebar.show(c, "top")
--             awful.titlebar.show(c, "bottom")
--             awful.titlebar.show(c, "left")
--             awful.titlebar.show(c, "right")
--         end
--         -- if beautiful.titlebar_fun then
--         --     beautiful.titlebar_fun(c)
--         -- end
--     end)
--
-- client.connect_signal("property::maximized",
--     function(c)
--         if c.maximized or c.fullscreen then
--             c.border_width = 0
--             awful.titlebar.hide(c, "top")
--             awful.titlebar.hide(c, "bottom")
--             awful.titlebar.hide(c, "left")
--             awful.titlebar.hide(c, "right")
--         else
--             c.border_width = beautiful.border_width
--             awful.titlebar.show(c, "top")
--             awful.titlebar.show(c, "bottom")
--             awful.titlebar.show(c, "left")
--             awful.titlebar.show(c, "right")
--         end
--         -- if beautiful.titlebar_fun then
--         --     beautiful.titlebar_fun(c)
--         -- end
--     end)
--
-- client.connect_signal("property::floating",
--     function(c)
--         if beautiful.titlebar_fun then
--             beautiful.titlebar_fun(c)
--         end
--         if c.maximized or c.fullscreen then
--             c.border_width = 0
--             awful.titlebar.hide(c, "top")
--             awful.titlebar.hide(c, "bottom")
--             awful.titlebar.hide(c, "left")
--             awful.titlebar.hide(c, "right")
--         else
--             c.border_width = beautiful.border_width
--             awful.titlebar.show(c, "top")
--             awful.titlebar.show(c, "bottom")
--             awful.titlebar.show(c, "left")
--             awful.titlebar.show(c, "right")
--         end
--     end)

client.connect_signal("property::fullscreen",
    function(c)
        if c.fullscreen then
            c.border_width = 0
            awful.titlebar.hide(c)
        else
            c.border_width = beautiful.border_width
        end
    end)

client.connect_signal("property::maximized",
    function(c)
        if c.maximized then
            c.border_width = 0
            awful.titlebar.hide(c)
        else
            c.border_width = beautiful.border_width
        end
    end)

client.connect_signal("property::floating",
    function(c)
        if c.floating and not c.maximized and not c.fullscreen then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end
    end)

awful.tag.attached_connect_signal(s, "property::layout",
    function(t)
        for _,c in pairs(t:clients()) do
            c.floating = t.layout == awful.layout.suit.floating
        end
    end)

-- Rounded corners
client.connect_signal("manage",
    function(c)
        c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end
    end)

-- }}}
