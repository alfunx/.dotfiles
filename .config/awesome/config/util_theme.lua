
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local markup = lain.util.markup

local config = { }

function config.init(context)

    context.util = context.util or { }

    context.util.set_colors = function(colors)
        -- Override colors with context.colors per default
        -- (Allows a theme to be based on another)
        context.colors = gears.table.join(colors, context.colors)
        return context.colors
    end

    context.util.alternate_theme = function()
        if not beautiful.alternative then return end
        context.theme = beautiful.alternative

        -- Priorize theme colors for one call
        local set_colors = context.util.set_colors
        context.util.set_colors = function(colors)
            context.colors = gears.table.join(context.colors, colors)
            context.util.set_colors = set_colors
        end

        local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), context.theme)
        beautiful.init(theme_path)

        -- Reload wibox and titlebar
        require("config").screen.init(context)

        -- Reload border and titlebar colors
        for _, c in ipairs(client.get()) do
            c:emit_signal("unfocus")
        end
        if client.focus then
            client.focus:emit_signal("focus")
        end

        if context.vars.update_applications then
            awful.spawn.easy_async(string.format("%s/alternate %s", beautiful.dir, context.theme), function(stdout, stderr, reason, exit_code)
                naughty.notify {
                    title = "Theme",
                    text = string.format("Switched to \"%s\".", context.theme),
                }
            end)
        end
    end

    -- Generate font string
    context.util.font = function(args)
        local args = args or {}
        args.name = args.name or "monospace"
        args.bold = args.bold or false
        args.italic = args.italic or false
        args.size = args.size or 11

        font_string = args.name
        if args.bold then font_string = font_string .. " Bold" end
        if args.italic then font_string = font_string .. " Italic" end
        font_string = font_string .. " " .. args.size

        return font_string
    end

    -- Generate markup function
    context.util.markup_function = function(args, color)
        local font_string = context.util.font(args)

        return function(widget, text, fg)
            fg = fg or color
            widget:set_markup(markup.fontfg(font_string, fg, text))
        end
    end

    -- Generate text markup function
    context.util.text_markup_function = function(size, color)
        return context.util.markup_function({ size = size }, color)
    end

    -- Generate symbol markup function
    context.util.symbol_markup_function = function(size, color)
        return context.util.markup_function({ name = "Font Awesome", size = size }, color)
    end

end

return config
