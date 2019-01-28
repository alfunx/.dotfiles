
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local config = { }

function config.init(context)

    local last_focus

    -- Signal function to execute when a new client appears
    client.connect_signal("manage", function(c)
        -- Set the windows at the slave
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and
            not c.size_hints.user_position
            and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes
            awful.placement.no_offscreen(c)
        end

        -- Rounded corners
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0)
        end
    end)

    client.connect_signal("unmanage", function(c)
        if last_focus == c and c.transient_for then
            client.focus = c.transient_for
            c.transient_for:raise()
        end
    end)

    client.connect_signal("focus", function(c)
        c.border_color = beautiful.border_focus
        last_focus = nil
    end)

    client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal
        last_focus = c
    end)

    -- Add a titlebar if titlebars_enabled is set to true in the rules
    client.connect_signal("request::titlebars", function(c)
        -- Set custom titlebar or fallback
        if beautiful.titlebar_fun then
            beautiful.titlebar_fun(c)
        else
            -- Default
            -- buttons for the titlebar
            local buttons = gears.table.join(
                awful.button({ }, 1, function()
                    if c.focusable then client.focus = c end
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    if c.focusable then client.focus = c end
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
        end

        -- Hide the titlebar if not floating
        if not context.util.client_floats(c) then
            context.util.hide_titlebar(c)
        end

        -- Hide the titlebar if maximized or fullscreen
        if c.maximized or c.fullscreen then
            context.util.hide_titlebar(c)
        end
    end)

    client.connect_signal("property::size", function(c)
        if beautiful.titlebar_fun_after then
            beautiful.titlebar_fun_after(c)
        end
    end)

    client.connect_signal("property::fullscreen", function(c)
        if c.fullscreen then
            context.util.hide_titlebar(c)
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end
        else
            c.border_width = beautiful.border_width
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0) end
        end
    end)

    client.connect_signal("property::maximized", function(c)
        if c.maximized then
            context.util.hide_titlebar(c)
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end
        else
            c.border_width = beautiful.border_width
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0) end
        end
    end)

    client.connect_signal("property::floating", function(c)
        if c.floating and not c.maximized and not c.fullscreen then
            context.util.show_titlebar(c)
        else
            context.util.hide_titlebar(c)
        end
    end)

    awful.tag.attached_connect_signal(nil, "property::layout", function(t)
        for _,c in pairs(t:clients()) do
            c.floating = t.layout == awful.layout.suit.floating
        end
    end)

    tag.connect_signal("request::screen", function(t)
        local fallback_tag

        -- Find tag with same name on any other screen
        for s in screen do
            if s ~= t.screen then
                fallback_tag = awful.tag.find_by_name(s, t.name)
                if fallback_tag then break end
            end
        end

        -- No tag with same name exists, chose random one
        if not fallback_tag then
            fallback_tag = awful.tag.find_fallback()
        end

        -- Delete the tag and move it to other screen
        t:delete(fallback_tag, true)
    end)

    -- Enable sloppy focus, so that focus follows mouse
    if context.vars.sloppy_focus then
        client.connect_signal("mouse::enter", function(c)
            if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                and awful.client.focus.filter(c) then
                if c.focusable then client.focus = c end
            end
        end)
    end

end
return config
