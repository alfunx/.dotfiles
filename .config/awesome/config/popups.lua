
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local lain = require("lain")

local markup = lain.util.markup

local config = { }

function config.init(context)

    context.popups = context.popups or { }

    local fg_text = context.colors.bw_8
    local fg_sym = context.colors.bw_5
    local size = 20

    local symbol = context.util.symbol_markup_function(size, fg_sym, markup)
    local text = context.util.text_markup_function(size, fg_text, markup)

    -- {{{ VOL
    local vol = wibox.widget {
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
        update = function(self)
            awful.spawn.easy_async({
                "amixer", "get", "Master",
            }, function(stdout)
                local level, muted = string.match(stdout, "([%d]+)%%.*%[([%l]*)]")
                local level = tonumber(level)
                local muted = muted == "off"
                local symbol_text

                if muted then
                    symbol_text = ""
                elseif level == 0 then
                    symbol_text = ""
                elseif level < 50 then
                    symbol_text = ""
                else
                    symbol_text = ""
                end

                symbol(self.icon, symbol_text)
                text(self.text, level)
            end)
        end,
    }

    context.popups.vol = context.util.popup {
        widget = vol,
        width = 200,
        height = 72,
    }
    -- }}}

    -- {{{ LIGHT
    local light = wibox.widget {
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
        update = function(self)
            awful.spawn.easy_async({
                "light", "-G",
            }, function(stdout)
                local level = math.floor(tonumber(stdout))

                symbol(self.icon, "")
                text(self.text, level)
            end)
        end,
    }

    context.popups.light = context.util.popup {
        widget = light,
        width = 200,
        height = 72,
    }
    -- }}}

end

return config
