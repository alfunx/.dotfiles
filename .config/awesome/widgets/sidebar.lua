--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Alphonse Mariyagnanaseelan

--]]

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local wibox = require("wibox")
local bar = require("widgets.bar")

-- local debug = false

local function factory(context, args)

    local args = args or { }
    args.x = args.x or beautiful.sidebar_x or 0
    args.y = args.y or beautiful.sidebar_y or 0
    args.bg = args.bg or beautiful.sidebar_bg or beautiful.tasklist_bg_normal or "#000000"
    args.fg = args.fg or beautiful.sidebar_fg or beautiful.tasklist_fg_normal or "#FFFFFF"
    args.opacity = args.opacity or beautiful.sidebar_opacity or 1
    args.height = args.height or beautiful.sidebar_height or awful.screen.focused().geometry.height
    args.width = args.width or beautiful.sidebar_width or 400
    args.radius = args.radius or beautiful.border_radius or 0
    args.mouse_toggle = args.mouse_toggle or beautiful.sidebar_mouse_toggle
    args.position = args.position or "left"

    local sidebar = wibox {
        x = args.x,
        y = args.y,
        bg = args.bg,
        fg = args.fg,
        opacity = args.opacity,
        height = args.height,
        width = args.width,
        visible = false,
        ontop = true,
        type = "dock",
    }

    if args.position == "right" then
        sidebar.x = awful.screen.focused().geometry.width - sidebar.width
        sidebar.shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, args.radius)
        end
    else
        sidebar.x = 0
        sidebar.shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, args.radius)
        end
    end

    sidebar:buttons(gears.table.join(
        awful.button({ }, 2, function ()
            sidebar.hide()
        end)
    ))

    -- Hide sidebar when mouse leaves
    if args.mouse_toggle then
        sidebar:connect_signal("mouse::leave", function ()
            sidebar.hide()
        end)
    end

    -- Activate sidebar by moving the mouse at the edge of the screen
    if args.mouse_toggle then
        local sidebar_activator = wibox {
            y = 0,
            width = 1,
            height = awful.screen.focused().geometry.height,
            visible = true,
            ontop = true,
            opacity = 0,
            below = true,
        }

        sidebar_activator:connect_signal("mouse::enter", function ()
            sidebar.show()
        end)

        if args.position == "right" then
            sidebar_activator.x = awful.screen.focused().geometry.width - sidebar_activator.width
        else
            sidebar_activator.x = 0
        end

        sidebar_activator:buttons(gears.table.join(
            awful.button({ }, 2, function ()
                sidebar.toggle()
            end),
            awful.button({ }, 4, function ()
                awful.tag.viewprev()
            end),
            awful.button({ }, 5, function ()
                awful.tag.viewnext()
            end)
        ))
    end

    -- {{{ SHOW / HIDE
    -- Store timers
    local timers = { }

    function sidebar.hide()
        sidebar.visible = false
        for _, t in pairs(timers) do
            t:stop()
        end
    end

    function sidebar.show()
        sidebar.visible = true
        for _, t in pairs(timers) do
            t:start()
        end
    end

    function sidebar.toggle()
        if sidebar.visible then
            sidebar.hide()
        else
            sidebar.show()
        end
    end
    -- }}}

    -- {{{ VARS
    -- Bar sizes
    bar_args = { }
    bar_args.height = 24
    bar_args.width = 200
    bar_args.total_width = args.width
    bar_args.border = beautiful.border_width
    bar_args.inner_color = beautiful.border_focus
    bar_args.outer_color = beautiful.border_normal

    -- Font colors
    local text_fg = context.colors.bw_5
    local symbol_fg = context.colors.bw_5

    -- Markup
    local symbol = context.util.symbol_markup_function(14, symbol_fg)
    local text = context.util.text_markup_function(14, symbol_fg)
    local time_text = context.util.markup_function({bold=true, size=30}, text_fg)
    local date_text = context.util.markup_function({bold=true, size=18}, text_fg)
    -- }}}

    -- {{{ TIME
    local time
    time, timers.time = awful.widget.watch(
        -- "date +'%a %d %b %R'", 60,
        "date +'%R'", 10,
        function(widget, stdout)
            if debug then naughty.notify { text = "TIME" } end
            time_text(widget, stdout)
        end
    )
    -- }}}

    -- {{{ DATE
    local date
    date, timers.date = awful.widget.watch(
        -- "date +'%a %d %b %R'", 60,
        "date +'%A, %d. %B'", 60,
        function(widget, stdout)
            if debug then naughty.notify { text = "DATE" } end
            date_text(widget, stdout)
        end
    )
    -- }}}

    -- {{{ VOL
    local vol = bar(bar_args)
    context.vol = vol
    vol.update = function(self)
        if debug then naughty.notify { text = "VOL" } end

        awful.spawn.easy_async({
            "amixer", "get", "Master",
        }, function(stdout)
            local level, muted = string.match(stdout, "([%d]+)%%.*%[([%l]*)]")
            local level = tonumber(level)
            local muted = muted == "off"

            local symbol_text

            if volume_now.status == "off" then
                symbol_text = ""
            elseif tonumber(volume_now.level) == 0 then
                symbol_text = ""
            elseif tonumber(volume_now.level) < 50 then
                symbol_text = ""
            else
                symbol_text = ""
            end

            self.bar.value = level
            symbol(self.icon, symbol_text)
            text(self.text, level .. "%")
        end)
    end

    timers.vol = gears.timer {
        timeout  = 30,
        call_now = true,
        callback = function() vol:update() end,
    }
    -- }}}

    -- {{{ BAT
    local bat = bar(bar_args)
    bat.update = function(self)
        if debug then naughty.notify { text = "BAT" } end

        awful.spawn.easy_async({
            "cat", "/sys/class/power_supply/BAT0/capacity", "&&",
            "cat", "/sys/class/power_supply/AC/online",
        }, function(stdout)
            local level, ac = string.match(stdout, "([%d]+)\n([%d]+)")

            local level = tonumber(level)
            local ac = tonumber(ac) == 1

            local color = text_fg
            local symbol_text

            if level <= 10 then
                symbol_text = ""
                color = context.colors.red_2
            elseif level <= 20 then
                symbol_text = ""
                color = context.colors.orange_2
            elseif level <= 30 then
                symbol_text = ""
                color = context.colors.yellow_2
            elseif level <= 50 then
                symbol_text = ""
            elseif level <= 75 then
                symbol_text = ""
            else
                symbol_text = ""
            end

            if ac then
                symbol_text = ""
                if level >= 95 then
                    color = context.colors.green_2
                end
            end

            self.bar.value = level
            symbol(self.icon, symbol_text)
            text(self.text, level .. "%", color)
        end)
    end

    timers.bat = gears.timer {
        timeout  = 30,
        call_now = true,
        callback = function() bat:update() end,
    }
    -- }}}

    -- {{{ Item placement
    sidebar:setup {
        {
            {
                {
                    {
                        time,
                        widget = wibox.container.place,
                    },
                    {
                        date,
                        widget = wibox.container.place,
                    },
                    layout = wibox.layout.flex.vertical,
                },
                widget = wibox.container.place,
            },
            {
                {
                    {
                        {
                            vol,
                            bat,
                            bat,
                            bat,
                            bat,
                            bat,
                            spacing = 20,
                            layout = wibox.layout.flex.vertical,
                        },
                        margins = 20,
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.flex.vertical,
                },
                widget = wibox.container.place,
            },
            layout = wibox.layout.flex.vertical,
        },
        right = beautiful.border_width,
        color = beautiful.border_focus,
        widget = wibox.container.margin,
    }
    -- }}}

    return sidebar

end

return factory
