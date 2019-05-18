
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

local util = require("config.util")

local _config = { }

function _config.init()

    local k = require("config.keys") --luacheck: no unused

    local function set_width_factor(factor)
        awful.screen.focused().selected_tag.master_width_factor = factor
    end

    awful.keygrabber {
        stop_key           = 'Escape',
        start_callback     = function()
            -- for _, c in pairs(awful.screen.focused().clients) do
            --     util.show_shade(c)
            -- end
        end,
        stop_callback      = function()
            util.set_mode()
            -- for _, c in pairs(awful.screen.focused().clients) do
            --     util.hide_shade(c)
            -- end
        end,
        root_keybindings = {
            { { k.m                }, "g", function() util.set_mode("Command Mode") end,
              { description = "<b><span color=\"#ff0000\">command mode</span></b>", group = "awesome" } },
        },
        keybindings = {

            -- Focus / Move (by index)
            -- { {                    }, k.u, function() awful.client.focus.byidx(-1) end,
            --   { description = "focus previous client by index", group = "client" } },
            -- { {                    }, k.d, function() awful.client.focus.byidx(1) end,
            --   { description = "focus next client by index", group = "client" } },
            -- { { k.s                }, string.upper(k.u), function() awful.client.swap.byidx(-1) end,
            --   { description = "swap with previous client by index", group = "client" } },
            -- { { k.s                }, string.upper(k.d), function() awful.client.swap.byidx(1) end,
            --   { description = "swap with next client by index", group = "client" } },

            -- Focus (by direction)
            { {                    }, k.u, function() awful.client.focus.bydirection("up") end,
              { description = "focus client above", group = "client" } },
            { {                    }, k.d, function() awful.client.focus.bydirection("down") end,
              { description = "focus client below", group = "client" } },
            { {                    }, k.l, function() awful.client.focus.bydirection("left") end,
              { description = "focus client left", group = "client" } },
            { {                    }, k.r, function() awful.client.focus.bydirection("right") end,
              { description = "focus client right", group = "client" } },

            -- Move
            { { k.m                }, k.l, util.get_move_function("l"),
              { description = "move window left", group = "command mode" } },
            { { k.m                }, k.d, util.get_move_function("d"),
              { description = "move window down", group = "command mode" } },
            { { k.m                }, k.u, util.get_move_function("u"),
              { description = "move window up", group = "command mode" } },
            { { k.m                }, k.r, util.get_move_function("r"),
              { description = "move window right", group = "command mode" } },

            -- Move (precise)
            { { k.m, k.c           }, k.l, util.get_move_function("l", 1),
              { description = "move window left (precise)", group = "command mode" } },
            { { k.m, k.c           }, k.d, util.get_move_function("d", 1),
              { description = "move window down (precise)", group = "command mode" } },
            { { k.m, k.c           }, k.u, util.get_move_function("u", 1),
              { description = "move window up (precise)", group = "command mode" } },
            { { k.m, k.c           }, k.r, util.get_move_function("r", 1),
              { description = "move window right (precise)", group = "command mode" } },

            -- Resize
            { { k.s                }, string.upper(k.l), util.get_resize_function("l"),
              { description = "resize window left/right", group = "command mode" } },
            { { k.s                }, string.upper(k.d), util.get_resize_function("d"),
              { description = "resize window up/down", group = "command mode" } },
            { { k.s                }, string.upper(k.u), util.get_resize_function("u"),
              { description = "resize window up/down", group = "command mode" } },
            { { k.s                }, string.upper(k.r), util.get_resize_function("r"),
              { description = "resize window left/right", group = "command mode" } },

            -- Resize (precise)
            { { k.s, k.c           }, k.l, util.get_resize_function("l", 1, 0.005) ,
              { description = "resize window left/right (precise)", group = "command mode" } },
            { { k.s, k.c           }, k.d, util.get_resize_function("d", 1, 0.005) ,
              { description = "resize window up/down (precise)", group = "command mode" } },
            { { k.s, k.c           }, k.u, util.get_resize_function("u", 1, 0.005) ,
              { description = "resize window up/down (precise)", group = "command mode" } },
            { { k.s, k.c           }, k.r, util.get_resize_function("r", 1, 0.005) ,
              { description = "resize window left/right (precise)", group = "command mode" } },

            -- Layout manipulation
            { { k.m                }, " ", function()
                awful.layout.inc(1)
                awful.screen.focused()._layout_popup:show()
            end,
              { description = "select next layout", group = "layout" } },
            { { k.m, k.s           }, " ", function()
                awful.layout.inc(-1)
                awful.screen.focused()._layout_popup:show()
            end,
              { description = "select previous layout", group = "layout" } },

            -- Useless gaps
            { { k.a                }, k.d, function() awful.tag.incgap(beautiful.useless_gap/2) end,
              { description = "increase useless gap", group = "command mode" } },
            { { k.a                }, k.u, function() awful.tag.incgap(-beautiful.useless_gap/2) end,
              { description = "decrease useless gap", group = "command mode" } },

            -- Useless gaps (precise)
            { { k.a, k.c           }, k.d, function() awful.tag.incgap(1) end,
              { description = "increase useless gap (percise)", group = "command mode" } },
            { { k.a, k.c           }, k.u, function() awful.tag.incgap(-1) end,
              { description = "increase useless gap (percise)", group = "command mode" } },

            -- Client manipulation
            { {                    }, " ", function()
                if client.focus then
                    client.focus.floating = not client.focus.floating
                end
            end },
            { {                    }, "z", function()
                if client.focus then client.focus:kill() end
            end },
            { {                    }, "o", function()
                if client.focus then client.focus:move_to_screen() end
            end },
            { {                    }, "t", function()
                if client.focus then client.focus.ontop = not client.focus.ontop end
            end },
            { {                    }, "s", function()
                if client.focus then client.focus.sticky = not client.focus.sticky end
            end },
            { {                    }, "n", function()
                if client.focus then client.focus.minimized = true end
            end },
            { {                    }, "m", function()
                if client.focus then util.toggle_maximized(client.focus) end
            end },
            { {                    }, "f", function()
                if client.focus then util.toggle_fullscreen(client.focus) end
            end },
            { { k.s                }, string.upper("n"), function()
                local c = awful.client.restore()
                if c then
                    client.focus = c
                    c:raise()
                end
            end },

            -- Resize (ratio)
            { {                    }, "1", function() set_width_factor((1 / 2 + 2.5) / 10) end, },
            { {                    }, "2", function() set_width_factor((2 / 2 + 2.5) / 10) end, },
            { {                    }, "3", function() set_width_factor((3 / 2 + 2.5) / 10) end, },
            { {                    }, "4", function() set_width_factor((4 / 2 + 2.5) / 10) end, },
            { {                    }, "5", function() set_width_factor((5 / 2 + 2.5) / 10) end, },
            { {                    }, "6", function() set_width_factor((6 / 2 + 2.5) / 10) end, },
            { {                    }, "7", function() set_width_factor((7 / 2 + 2.5) / 10) end, },
            { {                    }, "8", function() set_width_factor((8 / 2 + 2.5) / 10) end, },
            { {                    }, "9", function() set_width_factor((9 / 2 + 2.5) / 10) end, },

        },
    }

end

return _config
