
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local markup = require("lain.util.markup")

local context = require("config.context")
local screens = require("config.screens")

local _config = { }

function _config.init()

    _config.set_colors = function(colors)
        -- Override colors with context.colors per default
        -- (Allows a theme to be based on another)
        context.colors = gears.table.join(colors, context.colors)
        return context.colors
    end

    _config.alternate_theme = function()
        if not beautiful.alternative then return end
        context.theme = beautiful.alternative

        -- Priorize theme colors for one call
        local set_colors = _config.set_colors
        _config.set_colors = function(colors)
            context.colors = gears.table.join(context.colors, colors)
            _config.set_colors = set_colors
            return context.colors
        end

        local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), context.theme)
        beautiful.init(theme_path)

        -- Reload wibox and titlebar
        screens.init()

        -- Reload border and titlebar colors
        for _, c in pairs(client.get()) do
            c:emit_signal("unfocus")
        end
        if client.focus then
            client.focus:emit_signal("focus")
        end

        if context.vars.update_applications then
            awful.spawn.easy_async(string.format("%s/alternate %s", beautiful.dir, context.theme), function()
                naughty.notify {
                    title = "Theme",
                    text = string.format("Switched to \"%s\".", context.theme),
                }
            end)
        end
    end

    -- Generate font string
    _config.font = function(args)
        local args = args or { }
        args.name = args.name or "monospace"
        args.bold = args.bold or false
        args.italic = args.italic or false
        args.size = args.size or 11

        local font_string = args.name
        if args.bold then font_string = table.concat { font_string, " Bold" } end
        if args.italic then font_string = table.concat { font_string, " Italic" } end
        font_string = table.concat { font_string, " ", args.size }

        return font_string
    end

    -- Generate markup function
    _config.markup_function = function(args, color)
        local font_string = _config.font(args)

        return function(widget, text, fg)
            widget:set_markup(markup.fontfg(font_string, fg or color, text))
        end
    end

    -- Generate text markup function
    _config.text_markup_function = function(size, color)
        return _config.markup_function({ size = size }, color)
    end

    -- Generate symbol markup function
    _config.symbol_markup_function = function(size, color)
        return _config.markup_function({ name = "Font Awesome", size = size }, color)
    end

    do
        local default = ""
        local icons = {
            ["01d"] = "",
            ["01n"] = "",
            ["02d"] = "",
            ["02n"] = "",
            ["03d"] = "",
            ["03n"] = "",
            ["04d"] = "",
            ["04n"] = "",
            ["09d"] = "",
            ["09n"] = "",
            ["10d"] = "",
            ["10n"] = "",
            ["11d"] = "",
            ["11n"] = "",
            ["13d"] = "",
            ["13n"] = "",
            ["50d"] = "",
            ["50n"] = "",
        }
        _config.get_icon = function(icon_code)
            return icons[icon_code] or default
        end
    end

end

return _config
