
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local config = { }

function config.init(context)

    context.keys = context.keys or { }

    local k           = context.keys.short
    local terminal    = context.vars.terminal
    local browser     = context.vars.browser

    context.keys.global = gears.table.join(
        context.keys.global,
        awful.key({ k.m                }, "g", function() context.util.switch_keys_mode("command", "Command Mode") end,
                  { description = "<b><span color=\"#ff0000\">command mode</span></b>", group = "awesome" })
    )

    -- Set keys
    root.keys(context.keys.global)

    -- Command mode
    context.keys.command = gears.table.join(
        context.keys.global,

        -- Move
        awful.key({                    }, k.l, context.util.get_move_function("l"),
                  { description = "move window left", group = "command mode" }),
        awful.key({                    }, k.d, context.util.get_move_function("d"),
                  { description = "move window down", group = "command mode" }),
        awful.key({                    }, k.u, context.util.get_move_function("u"),
                  { description = "move window up", group = "command mode" }),
        awful.key({                    }, k.r, context.util.get_move_function("r"),
                  { description = "move window right", group = "command mode" }),

        -- Move (precise)
        awful.key({ k.c                }, k.l, context.util.get_move_function("l", dpi(1))),
        awful.key({ k.c                }, k.d, context.util.get_move_function("d", dpi(1))),
        awful.key({ k.c                }, k.u, context.util.get_move_function("u", dpi(1))),
        awful.key({ k.c                }, k.r, context.util.get_move_function("r", dpi(1))),

        -- Resize
        awful.key({ k.s                }, k.l, context.util.get_resize_function("l"),
                  { description = "resize window left/right", group = "command mode" }),
        awful.key({ k.s                }, k.d, context.util.get_resize_function("d"),
                  { description = "resize window up/down", group = "command mode" }),
        awful.key({ k.s                }, k.u, context.util.get_resize_function("u"),
                  { description = "resize window up/down", group = "command mode" }),
        awful.key({ k.s                }, k.r, context.util.get_resize_function("r"),
                  { description = "resize window left/right", group = "command mode" }),

        -- Resize (precise)
        awful.key({ k.s, k.c           }, k.l, context.util.get_resize_function("l", dpi(1), 0.005)),
        awful.key({ k.s, k.c           }, k.d, context.util.get_resize_function("d", dpi(1), 0.005)),
        awful.key({ k.s, k.c           }, k.u, context.util.get_resize_function("u", dpi(1), 0.005)),
        awful.key({ k.s, k.c           }, k.r, context.util.get_resize_function("r", dpi(1), 0.005)),

        -- Gaps
        awful.key({ k.a                }, k.d, function() lain.util.useless_gaps_resize(beautiful.useless_gap/2) end,
                  { description = " increase useless gap", group = "command mode" }),
        awful.key({ k.a                }, k.u, function() lain.util.useless_gaps_resize(-beautiful.useless_gap/2) end,
                  { description = " decrease useless gap", group = "command mode" }),
        awful.key({ k.a, k.c           }, k.d, function() lain.util.useless_gaps_resize(1) end),
        awful.key({ k.a, k.c           }, k.u, function() lain.util.useless_gaps_resize(-1) end),

        -- Client manipulation
        awful.key({                    }, "z", function()
            if client.focus then client.focus:kill() end
        end),
        awful.key({                    }, "space",
            awful.client.floating.toggle
        ),
        awful.key({                    }, "o", function()
            if client.focus then client.focus:move_to_screen() end
        end),
        awful.key({                    }, "t", function()
            if client.focus then client.focus.ontop = not client.focus.ontop end
        end),
        awful.key({                    }, "s", function()
            if client.focus then client.focus.sticky = not client.focus.sticky end
        end),
        awful.key({                    }, "n", function()
            if client.focus then client.focus.minimized = true end
        end),
        awful.key({ k.s                }, "n", function()
            local c = awful.client.restore()
            if c then
                client.focus = c
                c:raise()
            end
        end),
        awful.key({                    }, "m", function()
            if client.focus then context.util.toggle_maximized(client.focus) end
        end),
        awful.key({                    }, "f", function()
            if client.focus then context.util.toggle_fullscreen(client.focus) end
        end),

        context.keys.escape
    )

    for i = 1, 9 do
        context.keys.command = gears.table.join(
            context.keys.command,
            awful.key({                    }, "#" .. i + 9, function()
                awful.screen.focused().selected_tag.master_width_factor = (i / 2 + 2.5) / 10
            end)
        )
    end

end

return config
