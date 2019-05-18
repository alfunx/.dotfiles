
--[[

     Licensed under GNU General Public License v2
      * (c) 2019, Alphonse Mariyagnanaseelan

--]]

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gears = require("gears")
local wibox = require("wibox")
local bar = require("widgets.bar")
local brokers = require("config.brokers")
local t_util = require("config.util_theme")

local debug = false

local function factory(args)

    local radius = args.radius or beautiful.border_radius or 0
    local mouse_toggle = args.mouse_toggle or beautiful.sidebar_mouse_toggle
    local position = args.position or "left"
    local colors = args.colors or { }
    local vars = args.vars or { }

    -- Reset position of a widget (sidebar)
    local function reset_position(widget)
        widget.height = screen.primary.geometry.height
        widget.y = screen.primary.geometry.y
        if position == "right" then
            widget.x = screen.primary.geometry.width - widget.width
        else
            widget.x = screen.primary.geometry.x
        end
    end

    -- Position a widget (sidebar) and connect to signals
    local function setup(widget)
        reset_position(widget)
        screen.connect_signal("primary_changed", function()
            reset_position(widget)
        end)
        screen.connect_signal("property::geometry", function()
            reset_position(widget)
        end)
    end

    local sidebar = wibox {
        bg = args.bg or beautiful.sidebar_bg or beautiful.tasklist_bg_normal or "#000000",
        fg = args.fg or beautiful.sidebar_fg or beautiful.tasklist_fg_normal or "#FFFFFF",
        opacity = args.opacity or beautiful.sidebar_opacity or 1,
        width = args.width or beautiful.sidebar_width or 400,
        visible = false,
        ontop = true,
        type = "dock",
    }
    setup(sidebar)

    if position == "right" then
        sidebar.shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, true, false, false, true, radius)
        end
    else
        sidebar.shape = function(cr, width, height)
            gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, radius)
        end
    end

    if mouse_toggle then
        local sidebar_activator = wibox {
            x = screen.primary.geometry.x,
            y = screen.primary.geometry.y,
            height = screen.primary.geometry.height,
            width = 1,
            visible = true,
            ontop = true,
            opacity = 0,
            below = true,
        }
        setup(sidebar_activator)

        -- Activate sidebar by moving the mouse at the edge of the screen
        sidebar_activator:connect_signal("mouse::enter", function ()
            sidebar:show()
        end)

        -- Hide sidebar when mouse leaves
        sidebar:connect_signal("mouse::leave", function ()
            sidebar:hide()
        end)
    end

    -- {{{ SHOW / HIDE
    -- Store timers
    local timers = { }

    function sidebar:hide()
        self.visible = false
        for _, t in pairs(timers) do
            if t.started then t:stop() end
        end
    end

    function sidebar:show()
        brokers:update()
        self.visible = true
        for _, t in pairs(timers) do
            t:again()
        end
    end

    function sidebar:toggle()
        if self.visible then
            self:hide()
        else
            self:show()
        end
    end
    -- }}}

    -- {{{ VARS
    -- Bar sizes
    local bar_args = { }
    bar_args.height = 30
    bar_args.width = 200
    bar_args.total_width = sidebar.width
    bar_args.border_width = beautiful.border
    bar_args.border_color = beautiful.border_normal
    bar_args.inner_color = beautiful.border_focus
    bar_args.outer_color = colors.bw_1

    -- Font colors
    local text_fg = colors.bw_7
    local symbol_fg = colors.bw_7

    -- Markup
    local m_symbol = t_util.symbol_markup_function(18, symbol_fg)
    local m_text = t_util.text_markup_function(14, text_fg)
    local m_time_text = t_util.markup_function({bold=true, size=48}, text_fg)
    local m_date_text = t_util.markup_function({bold=true, size=18}, text_fg)
    local m_weather_text = t_util.markup_function({size=16}, text_fg)
    -- }}}

    -- {{{ CLOCK
    local clock = wibox.widget {
            id     = "text",
            text   = "",
            align  = "center",
            widget = wibox.widget.textbox,
    }
    timers.clock = gears.timer {
        timeout = 2,
        autostart = true,
        call_now = true,
        callback = function()
            if debug then naughty.notify { text = "CLOCK" } end
            awful.spawn.easy_async("date +'%R'", function(stdout)
                m_time_text(clock, stdout)
            end)
        end,
    }
    -- }}}

    -- {{{ DATE
    local date = wibox.widget {
            id     = "text",
            text   = "",
            align  = "center",
            widget = wibox.widget.textbox,
    }
    timers.date = gears.timer {
        timeout = 19,
        autostart = true,
        call_now = true,
        callback = function()
            if debug then naughty.notify { text = "DATE" } end
            awful.spawn.easy_async("date +'%A, %d. %B'", function(stdout)
                m_date_text(date, stdout)
            end)
        end,
    }
    -- }}}

    -- {{{ WEATHER
    local weather = wibox.widget {
        {
            id     = "icon",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        {
            id     = "text",
            text   = "",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        id      = "weather",
        spacing = 20,
        layout  = wibox.layout.fixed.horizontal,
    }

    local daylight = wibox.widget {
        {
            id     = "sun_text",
            text   = "",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        {
            id     = "sun",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        {
            id     = "arrow",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        {
            id     = "moon",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        {
            id     = "moon_text",
            text   = "",
            align  = "center",
            widget = wibox.widget.textbox,
        },
        id      = "daylight",
        spacing = 20,
        layout  = wibox.layout.fixed.horizontal,
    }

    m_symbol(daylight.sun, "")
    m_symbol(daylight.moon, "")
    -- m_symbol(daylight.arrow, "")
    -- m_symbol(daylight.arrow, "")
    m_symbol(daylight.arrow, "-")

    brokers.weather:add_callback(function(x)
        m_symbol(weather.icon, t_util.get_icon(x.data.weather[1].icon))
        m_weather_text(weather.text, string.format("%s, %s°C", x.data.weather[1].description, x.data.main.temp))
        m_weather_text(daylight.sun_text, os.date("%H:%M", x.data.sys.sunrise))
        m_weather_text(daylight.moon_text, os.date("%H:%M", x.data.sys.sunset))
    end)

    weather:buttons(brokers.weather.buttons)
    daylight:buttons(brokers.weather.buttons)
    -- }}}

    -- {{{ AUDIO
    local audio = bar(bar_args)

    brokers.audio:add_callback(function(x)
        local color
        local icon

        if x.muted then
            icon = ""
        elseif x.percent <= 20 then
            icon = ""
        elseif x.percent <= 40 then
            icon = ""
        else
            icon = ""
        end

        if x.percent >= 100 then
            color = colors.red_2
        elseif x.percent >= 90 then
            color = colors.orange_2
        elseif x.percent >= 80 then
            color = colors.yellow_2
        else
            color = text_fg
        end

        audio.bar.value = x.percent
        m_symbol(audio.icon, icon)
        m_text(audio.text, x.percent .. "%", color)
    end)

    -- timers.audio = brokers.audio:add_timer {
    --     timeout = 29,
    --     autostart = false,
    -- }
    audio:buttons(brokers.audio.buttons)
    -- }}}

    -- {{{ BRIGHTNESS
    local brightness = bar(bar_args)
    m_symbol(brightness.icon, "")

    brokers.brightness:add_callback(function(x)
        brightness.bar.value = x.percent
        m_text(brightness.text, x.percent .. "%")
    end)

    timers.brightness = brokers.brightness:add_timer {
        timeout = 31,
        autostart = false,
    }
    brightness:buttons(brokers.brightness.buttons)
    -- }}}

    -- {{{ BATTERY
    local battery = bar(bar_args)

    brokers.battery:add_callback(function(x)
        local color = text_fg
        local icon

        if x.percent <= 10 then
            icon = ""
            color = colors.red_2
        elseif x.percent <= 20 then
            icon = ""
            color = colors.orange_2
        elseif x.percent <= 30 then
            icon = ""
            color = colors.yellow_2
        elseif x.percent <= 50 then
            icon = ""
        elseif x.percent <= 75 then
            icon = ""
        else
            icon = ""
        end

        if x.charging or x.full or x.ac then
            icon = ""
            if x.percent >= 95 then
                color = colors.green_2
            end
        end

        battery.bar.value = x.percent
        m_symbol(battery.icon, icon)
        m_text(battery.text, x.percent .. "%", color)
    end)

    -- timers.battery = brokers.battery:add_timer {
    --     timeout = 23,
    --     autostart = false,
    -- }
    battery:buttons(brokers.battery.buttons)
    -- }}}

    -- {{{ LOADAVG
    local loadavg = bar(bar_args)
    m_symbol(loadavg.icon, "")

    -- check with: grep 'model name' /proc/cpuinfo | wc -l
    local _cores = vars.cores or 4
    loadavg.bar.min_value = 0
    loadavg.bar.max_value = _cores

    brokers.loadavg:add_callback(function(x)
        local color = text_fg

        if x.load_5 / _cores >= 1.5 then
            color = colors.red_2
        elseif x.load_5 / _cores >= 0.8 then
            if x.load_1 > x.load_5 then
                color = colors.red_2
            else
                color = colors.orange_2
            end
        elseif x.load_5 / _cores >= 0.65 then
            color = colors.orange_2
        elseif x.load_5 / _cores >= 0.5 then
            color = colors.yellow_2
        end

        loadavg.bar.value = x.load_5
        m_text(loadavg.text, x.load_5, color)
    end)

    timers.loadavg = brokers.loadavg:add_timer {
        timeout = 3,
        autostart = false,
    }
    loadavg:buttons(brokers.loadavg.buttons)
    -- }}}

    -- {{{ CPU
    local cpu = bar(bar_args)
    m_symbol(cpu.icon, "")

    brokers.cpu:add_callback(function(x)
        local color = text_fg

        if x.percent >= 90 then
            color = colors.red_2
        elseif x.percent >= 80 then
            color = colors.orange_2
        elseif x.percent >= 70 then
            color = colors.yellow_2
        end

        cpu.bar.value = x.percent
        m_text(cpu.text, x.percent .. "%", color)
    end)

    timers.cpu = brokers.cpu:add_timer {
        timeout = 5,
        autostart = false,
    }
    cpu:buttons(brokers.cpu.buttons)
    -- }}}

    -- {{{ MEMORY
    local memory = bar(bar_args)
    m_symbol(memory.icon, "")

    brokers.memory:add_callback(function(x)
        local color = text_fg

        if x.percent >= 90 then
            color = colors.red_2
        elseif x.percent >= 80 then
            color = colors.orange_2
        elseif x.percent >= 70 then
            color = colors.yellow_2
        end

        memory.bar.value = x.percent
        m_text(memory.text, x.percent .. "%", color)
    end)

    timers.memory = brokers.memory:add_timer {
        timeout = 7,
        autostart = false,
    }
    memory:buttons(brokers.memory.buttons)
    -- }}}

    -- {{{ TEMPERATURE
    local temperature = bar(bar_args)

    brokers.temperature:add_callback(function(x)
        local color = text_fg
        local icon

        if x.temp >= 80 then
            icon = ""
            color = colors.red_2
        elseif x.temp >= 70 then
            icon = ""
            color = colors.orange_2
        elseif x.temp >= 60 then
            icon = ""
            color = colors.yellow_2
        elseif x.temp >= 30 then
            icon = ""
        else
            icon = ""
        end

        temperature.bar.value = x.temp
        m_symbol(temperature.icon, icon)
        m_text(temperature.text, x.temp, color)
    end)

    timers.temperature = brokers.temperature:add_timer {
        timeout = 11,
        autostart = false,
    }
    temperature:buttons(brokers.temperature.buttons)
    -- }}}

    -- {{{ DRIVE
    local drive = bar(bar_args)
    m_symbol(drive.icon, "")

    brokers.drive:add_callback(function(x)
        local color = text_fg

        if x.percent >= 90 then
            color = colors.red_2
        elseif x.percent >= 80 then
            color = colors.orange_2
        elseif x.percent >= 70 then
            color = colors.yellow_2
        end

        drive.bar.value = x.percent
        m_text(drive.text, x.percent .. "%", color)
    end)

    timers.drive = brokers.drive:add_timer {
        timeout = 7,
        autostart = false,
    }
    drive:buttons(brokers.drive.buttons)
    -- }}}

    -- {{{ Item placement
    sidebar:setup {
        {
            {
                {
                    {
                        {
                            clock,
                            widget = wibox.container.place,
                        },
                        {
                            date,
                            widget = wibox.container.place,
                        },
                        spacing = 20,
                        layout = wibox.layout.fixed.vertical,
                    },
                    {
                        {
                            weather,
                            widget = wibox.container.place,
                        },
                        {
                            daylight,
                            widget = wibox.container.place,
                        },
                        spacing = 20,
                        layout = wibox.layout.fixed.vertical,
                    },
                    {
                        forced_height = 30,
                        widget = wibox.container.background,
                    },
                    {
                        {
                            audio,
                            brightness,
                            battery,
                            loadavg,
                            cpu,
                            memory,
                            temperature,
                            drive,
                            spacing = 20,
                            layout = wibox.layout.flex.vertical,
                        },
                        margins = 20,
                        widget = wibox.container.margin,
                    },
                    spacing = 50,
                    layout = wibox.layout.fixed.vertical,
                },
                widget = wibox.container.place,
            },
            layout = wibox.layout.flex.vertical,
        },
        right = position == "left" and beautiful.border or nil,
        left = position == "right" and beautiful.border or nil,
        color = beautiful.border_focus,
        widget = wibox.container.margin,
    }
    -- }}}

    sidebar:hide()

    return sidebar

end

return factory
