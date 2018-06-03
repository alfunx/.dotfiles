local awful = require("awful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local config = {}

function config.init(context)

    local modkey      = context.keys.modkey
    local altkey      = context.keys.altkey
    local ctrlkey     = context.keys.ctrlkey
    local shiftkey    = context.keys.shiftkey
    local leftkey     = context.keys.leftkey
    local rightkey    = context.keys.rightkey
    local upkey       = context.keys.upkey
    local downkey     = context.keys.downkey

    local terminal    = context.terminal
    local browser     = context.browser

    context.keys.global = awful.util.table.join(
        context.keys.global,
        awful.key({ modkey                    }, "g", function()
            context.switch_keys_mode("command", "Command Mode")
        end, {description = "command mode", group = "awesome"})
    )

    context.keys.command = awful.util.table.join(
        context.keys.global,

        -- move
        awful.key({                           }, "h", context.get_move_function("l")),
        awful.key({                           }, "j", context.get_move_function("d")),
        awful.key({                           }, "k", context.get_move_function("u")),
        awful.key({                           }, "l", context.get_move_function("r")),

        -- move (precise)
        awful.key({ ctrlkey                   }, "h", context.get_move_function("l", dpi(5))),
        awful.key({ ctrlkey                   }, "j", context.get_move_function("d", dpi(5))),
        awful.key({ ctrlkey                   }, "k", context.get_move_function("u", dpi(5))),
        awful.key({ ctrlkey                   }, "l", context.get_move_function("r", dpi(5))),

        -- resize
        awful.key({ shiftkey                  }, "h", context.get_resize_function("l")),
        awful.key({ shiftkey                  }, "j", context.get_resize_function("d")),
        awful.key({ shiftkey                  }, "k", context.get_resize_function("u")),
        awful.key({ shiftkey                  }, "l", context.get_resize_function("r")),

        -- resize (precise)
        awful.key({ shiftkey, ctrlkey         }, "h", context.get_resize_function("l", dpi(5), 0.005)),
        awful.key({ shiftkey, ctrlkey         }, "j", context.get_resize_function("d", dpi(5), 0.005)),
        awful.key({ shiftkey, ctrlkey         }, "k", context.get_resize_function("u", dpi(5), 0.005)),
        awful.key({ shiftkey, ctrlkey         }, "l", context.get_resize_function("r", dpi(5), 0.005)),

        -- client manipulation
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
