local gears = require("gears")
local beautiful = require("beautiful")

local config = {}

function config.init(context)

    context.util = context.util or {}

    context.util.set_colors = function(colors)
        -- Override colors with context.colors per default
        -- (Allows a theme to be based on another)
        context.colors = gears.table.join(colors, context.colors)
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
    end

end

return config
