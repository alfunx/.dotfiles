
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local context = require("config.context")
local util = require("config.util")

local _config = { }

function _config.init()

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
        if beautiful.titlebar_fn then
            beautiful.titlebar_fn(c)
            return
        end

        -- Default buttons for the titlebar
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

        awful.titlebar(c, { size = 20, position = "top" }):setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                { -- Title
                    {
                        align  = "left",
                        widget = awful.titlebar.widget.titlewidget(c),
                    },
                    left   = 5,
                    right  = 5,
                    widget = wibox.container.margin,
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal,
            },
            { -- Right
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        }

        util.hide_unneeded_titlebars(c)
    end)

    if not beautiful.titlebar_fn then
        util.hide_all_unneeded_titlebars()
    end

    client.connect_signal("property::fullscreen", function(c)
        if c.fullscreen then
            c.border_width = 0
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end
        else
            c.border_width = beautiful.border_width
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0) end
        end
    end)

    client.connect_signal("property::maximized", function(c)
        if c.maximized then
            c.border_width = 0
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 0) end
        else
            c.border_width = beautiful.border_width
            c.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, beautiful.border_radius or 0) end
        end
    end)

    client.connect_signal("request::activate", function(c, ...)
        if awesome.startup then return end
        if c.minimized then c.minimized = false end
        awful.ewmh.activate(c, ...)
    end)

    awful.tag.attached_connect_signal(nil, "property::layout", function(t)
        for _, c in pairs(t:clients()) do
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

return _config
