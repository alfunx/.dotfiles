
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local awful = require("awful")
local wibox = require("wibox")

local context = require("config.context")
local brokers = require("config.brokers")
local util = require("config.util")
local t_util = require("config.util_theme")

local _config = { }

function _config.init()

    -- Create popups for each screen
    awful.screen.connect_for_each_screen(_config.setup)

end

function _config.setup(s)
    local fg_text = context.colors.bw_8
    local fg_sym = context.colors.bw_5
    local size = 20

    local symbol = t_util.symbol_markup_function(size, fg_sym)
    local text = t_util.text_markup_function(size, fg_text)

    -- {{{ AUDIO
    local audio = wibox.widget {
        {
            id               = "icon",
            align            = "center",
            forced_width     = 20,
            widget           = wibox.widget.textbox,
        },
        {
            id               = "text",
            text             = "0%",
            align            = "center",
            forced_width     = 100,
            widget           = wibox.widget.textbox,
        },
        layout = wibox.layout.ratio.horizontal,
    }

    local audio_popup = util.default_popup {
        screen = s,
        widget = audio,
        width = 200,
        height = 72,
    }

    local audio_callback = brokers.audio:add_manual_callback(function(x)
        local icon

        if x.muted then
            icon = ""
        elseif x.percent <= 20 then
            icon = ""
        elseif x.percent < 50 then
            icon = ""
        else
            icon = ""
        end

        symbol(audio.icon, icon)
        text(audio.text, x.percent)

        audio_popup:show()
    end)

    audio_popup:buttons(brokers.audio.buttons)

    s:connect_signal("removed", function()
        brokers.audio:remove_manual_callback(audio_callback)
    end)
    -- }}}

    -- {{{ BRIGHTNESS
    local brightness = wibox.widget {
        {
            id               = "icon",
            align            = "center",
            forced_width     = 20,
            widget           = wibox.widget.textbox,
        },
        {
            id               = "text",
            text             = "0",
            align            = "center",
            forced_width     = 100,
            widget           = wibox.widget.textbox,
        },
        layout = wibox.layout.ratio.horizontal,
    }
    symbol(brightness.icon, "")

    local brightness_popup = util.default_popup {
        screen = s,
        widget = brightness,
        width = 200,
        height = 72,
    }

    local brightness_callback = brokers.brightness:add_manual_callback(function(x)
        text(brightness.text, x.percent)

        brightness_popup:show()
    end)

    brightness_popup:buttons(brokers.brightness.buttons)

    s:connect_signal("removed", function()
        brokers.brightness:remove_manual_callback(brightness_callback)
    end)
    -- }}}
end

return _config
