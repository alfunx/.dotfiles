local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local config = {}

function config.init(context)

    local modkey      = context.keys.modkey
    local altkey      = context.keys.altkey
    local ctrlkey     = context.keys.ctrlkey
    local shiftkey    = context.keys.shiftkey
    local l_key       = context.keys.l_key
    local r_key       = context.keys.r_key
    local u_key       = context.keys.u_key
    local d_key       = context.keys.d_key

    local terminal    = context.vars.terminal
    local browser     = context.vars.browser

    context.keys.global = awful.util.table.join(
        context.keys.global,
        awful.key({ modkey                    }, "g", function()
            context.switch_keys_mode("command", "Command Mode")
        end, {description = "<b><span color=\"#ff0000\">command mode</span></b>", group = "awesome"})
    )

    context.keys.command = awful.util.table.join(
        context.keys.global,

        -- Move
        awful.key({                           }, l_key, context.get_move_function("l"),
                  {description = "move window left", group = "command mode"}),
        awful.key({                           }, d_key, context.get_move_function("d"),
                  {description = "move window down", group = "command mode"}),
        awful.key({                           }, u_key, context.get_move_function("u"),
                  {description = "move window up", group = "command mode"}),
        awful.key({                           }, r_key, context.get_move_function("r"),
                  {description = "move window right", group = "command mode"}),

        -- Move (precise)
        awful.key({ ctrlkey                   }, l_key, context.get_move_function("l", dpi(5))),
        awful.key({ ctrlkey                   }, d_key, context.get_move_function("d", dpi(5))),
        awful.key({ ctrlkey                   }, u_key, context.get_move_function("u", dpi(5))),
        awful.key({ ctrlkey                   }, r_key, context.get_move_function("r", dpi(5))),

        -- Resize
        awful.key({ shiftkey                  }, l_key, context.get_resize_function("l"),
                  {description = "resize window left/right", group = "command mode"}),
        awful.key({ shiftkey                  }, d_key, context.get_resize_function("d"),
                  {description = "resize window up/down", group = "command mode"}),
        awful.key({ shiftkey                  }, u_key, context.get_resize_function("u"),
                  {description = "resize window up/down", group = "command mode"}),
        awful.key({ shiftkey                  }, r_key, context.get_resize_function("r"),
                  {description = "resize window left/right", group = "command mode"}),

        -- Resize (precise)
        awful.key({ shiftkey, ctrlkey         }, l_key, context.get_resize_function("l", dpi(5), 0.005)),
        awful.key({ shiftkey, ctrlkey         }, d_key, context.get_resize_function("d", dpi(5), 0.005)),
        awful.key({ shiftkey, ctrlkey         }, u_key, context.get_resize_function("u", dpi(5), 0.005)),
        awful.key({ shiftkey, ctrlkey         }, r_key, context.get_resize_function("r", dpi(5), 0.005)),

        -- Gaps
        awful.key({ altkey                    }, d_key, function() lain.util.useless_gaps_resize(beautiful.useless_gap/2) end,
                  {description = " increase useless gap", group = "command mode"}),
        awful.key({ altkey                    }, u_key, function() lain.util.useless_gaps_resize(-beautiful.useless_gap/2) end,
                  {description = " decrease useless gap", group = "command mode"}),
        awful.key({ altkey, ctrlkey           }, d_key, function() lain.util.useless_gaps_resize(1) end),
        awful.key({ altkey, ctrlkey           }, u_key, function() lain.util.useless_gaps_resize(-1) end),

        -- Client manipulation
        awful.key({                           }, "z", function()
            if client.focus then client.focus:kill() end
        end),
        awful.key({                           }, "space",
            awful.client.floating.toggle
        ),
        awful.key({                           }, "o", function()
            if client.focus then client.focus:move_to_screen() end
        end),
        awful.key({                           }, "t", function()
            if client.focus then client.focus.ontop = not client.focus.ontop end
        end),
        awful.key({                           }, "s", function()
            if client.focus then client.focus.sticky = not client.focus.sticky end
        end),
        awful.key({                           }, "n", function()
            if client.focus then client.focus.minimized = true end
        end),
        awful.key({ shiftkey                  }, "n", function()
            local c = awful.client.restore()
            if c then
                client.focus = c
                c:raise()
            end
        end),
        awful.key({                           }, "m", function()
            if client.focus then context.toggle_maximized(client.focus) end
        end),
        awful.key({                           }, "f", function()
            if client.focus then context.toggle_fullscreen(client.focus) end
        end),

        context.keys.escape
    )

    for i = 1, 9 do
        context.keys.command = awful.util.table.join(
            context.keys.command,
            awful.key({}, "#" .. i + 9, function()
                awful.screen.focused().selected_tag.master_width_factor = (i / 2 + 2.5) / 10
            end)
        )
    end

    -- Set keys
    root.keys(context.keys.global)

end

return config
