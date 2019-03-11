
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")
local wibox = require("wibox")

local util = require("config.util")

local _titlebar = { }

function _titlebar.init(theme, args)

    args = args or { }

    theme.titlebar_positions = { "top", "left", "right", "bottom" }
    theme.border_width       = args.outer_width or theme.border_width
    theme.border_normal      = args.outer_normal or args.outer_color or theme.border_normal
    theme.border_focus       = args.outer_focus or args.outer_color or theme.border_focus
    theme.border_marked      = args.outer_marker or args.outer_color or theme.border_marked

    local function titlebar_fn(c)
        c.titlebars = c.titlebars or { }

        local function gen_titlebar(pos)
            local t = awful.titlebar(c, { size = 4, position = pos })

            t:setup {
                id     = "color",
                bg     = theme.titlebar_bg_normal,
                widget = wibox.container.background,
            }

            table.insert(c.titlebars, t)
        end

        for _, p in pairs(theme.titlebar_positions) do
            gen_titlebar(p)
        end
    end

    client.connect_signal("focus", function(c)
        for _, t in pairs(c.titlebars) do
            t.color.bg = theme.titlebar_bg_focus
        end
    end)

    client.connect_signal("unfocus", function(c)
        for _, t in pairs(c.titlebars) do
            t.color.bg = theme.titlebar_bg_normal
        end
    end)

    client.connect_signal("property::floating", function(c)
        if c.maximized or c.fullscreen then
            util.hide_titlebar(c)
        else
            util.show_titlebar(c)
        end
    end)

    client.connect_signal("property::fullscreen", function(c)
        if c.fullscreen then
            util.hide_titlebar(c)
        end
    end)

    client.connect_signal("property::maximized", function(c)
        if c.maximized then
            util.hide_titlebar(c)
        end
    end)

    return titlebar_fn

end

return _titlebar
