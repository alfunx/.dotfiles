
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local wibox = require("wibox")

local context = require("config.context")
local brokers = require("config.brokers")
local util = require("config.util")
local t_util = require("config.util_theme")

local _config = { }

function _config.init()

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

    _config.audio = util.popup {
        widget = audio,
        width = 200,
        height = 72,
    }

    brokers.audio:add_callback(function(x)
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
    end)

    brokers.audio:set_popup(function()
        _config.audio:show()
    end)

    _config.audio:buttons(brokers.audio.buttons)
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

    _config.brightness = util.popup {
        widget = brightness,
        width = 200,
        height = 72,
    }

    brokers.brightness:add_callback(function(x)
        text(brightness.text, x.percent)
    end)

    brokers.brightness:set_popup(function()
        _config.brightness:show()
    end)

    _config.brightness:buttons(brokers.brightness.buttons)
    -- }}}

end

return _config
