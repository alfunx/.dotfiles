local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local config = {}

function config.init(context)

    -- Signal function to execute when a new client appears.
    client.connect_signal("manage", function(c)
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
        if not context.client_floats(c) then
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

    awful.tag.attached_connect_signal(nil, "property::layout", function(t)
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

end
return config
