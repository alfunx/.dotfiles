
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local beautiful = require("beautiful")
local wibox = require("wibox")
local lain = require("lain")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local markup = lain.util.markup

local config = { }

function config.init(context)

    context.popups = context.popups or { }

    local fg_text = context.colors.bw_8
    local fg_sym = context.colors.bw_5
    local size = 20

    local symbol = context.util.symbol_markup_function(size, fg_sym, markup)
    local text = context.util.text_markup_function(size, fg_text, markup)

    local function vol()
        local vol_icon = wibox.widget.textbox()
        local vol_text = lain.widget.alsa {
            -- togglechannel = "IEC958,3",
            timeout = 0,
            settings = function()
                if volume_now.status == "off" then
                    symbol(vol_icon, "")
                elseif tonumber(volume_now.level) == 0 then
                    symbol(vol_icon, "")
                elseif tonumber(volume_now.level) < 50 then
                    symbol(vol_icon, "")
                else
                    symbol(vol_icon, "")
                end

                text(widget, volume_now.level)
            end,
        }

        local vol_widget = wibox.widget {
            {
                vol_icon,
                margins = dpi(10),
                widget = wibox.container.margin,
            },
            {
                vol_text.widget,
                margins = dpi(4),
                widget = wibox.container.margin,
            },
            layout = wibox.layout.align.horizontal,
        }

        return vol_widget
    end

    context.popups.vol = context.util.popup {
        widget = vol(),
        width = 128,
        height = 72,
    }

end

return config
