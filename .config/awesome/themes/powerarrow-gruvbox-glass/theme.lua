local cairo            = require("lgi").cairo
local gears            = require("gears")
local awful            = require("awful")
local wibox            = require("wibox")
local os, math, string = os, math, string

local theme = require("themes.powerarrow-gruvbox.theme")

theme.border_width                              = 0
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_spacing                          = 3
theme.useless_gap                               = 8
theme.systray_icon_spacing                      = 4

-- {{{ Glass borders (experimental)
function theme.titlebar_fn(c)
    -- if c.floating then return end

    local b_string_color = gears.color(theme.border_focus .. "55")
    local b_arrow_color = gears.color(theme.border_focus .. "ff")
    local b_weight = 12
    local b_string_weight = 4
    local b_gutter = 12
    local b_arrow = 120

    local side = b_weight + b_gutter
    local total_width = c.width
    local total_height = c.height

    -- for some reasons, the client height/width are not the same at first
    -- render (when called by request title bar) and when resizing
    total_width = total_width + 2 * (b_weight + b_gutter)

    local imgTop = cairo.ImageSurface.create(cairo.Format.ARGB32, total_width, side)
    local crTop  = cairo.Context(imgTop)

    crTop:set_source(b_string_color)
    crTop:rectangle(0, b_weight / 2 - b_string_weight / 2, total_width, b_string_weight)
    crTop:fill()

    crTop:set_source(b_arrow_color)
    crTop:rectangle(0, 0, b_arrow, b_weight)
    crTop:rectangle(0, 0, b_weight, side)
    crTop:rectangle(total_width - b_arrow, 0, b_arrow, b_weight)
    crTop:rectangle(total_width - b_weight, 0, b_weight, side)
    crTop:fill()

    local imgBot = cairo.ImageSurface.create(cairo.Format.ARGB32, total_width, side)
    local crBot  = cairo.Context(imgBot)

    crBot:set_source(b_string_color)
    crBot:rectangle(0, side - b_weight / 2 - b_string_weight / 2, total_width, b_string_weight)
    crBot:fill()

    crBot:set_source(b_arrow_color)
    crBot:rectangle(0, b_gutter, b_arrow, b_weight)
    crBot:rectangle(0, 0, b_weight, side)
    crBot:rectangle(total_width - b_weight, 0, b_weight, side)
    crBot:rectangle(total_width - b_arrow, b_gutter, b_arrow, b_weight)
    crBot:fill()

    local imgLeft = cairo.ImageSurface.create(cairo.Format.ARGB32, side, total_height)
    local crLeft  = cairo.Context(imgLeft)

    crLeft:set_source(b_string_color)
    crLeft:rectangle(b_weight / 2 - b_string_weight / 2, 0, b_string_weight, total_height)
    crLeft:fill()

    crLeft:set_source(b_arrow_color)
    crLeft:rectangle(0, 0, b_weight, b_arrow - side)
    crLeft:rectangle(0, total_height - b_arrow + side, b_weight, b_arrow - side)
    crLeft:fill()

    local imgRight = cairo.ImageSurface.create(cairo.Format.ARGB32, side, total_height)
    local crRight  = cairo.Context(imgRight)

    crRight:set_source(b_string_color)
    crRight:rectangle(b_gutter + b_weight / 2 - b_string_weight / 2, 0, b_string_weight, total_height)
    crRight:fill()

    crRight:set_source(b_arrow_color)
    crRight:rectangle(b_gutter, 0, b_weight, b_arrow - side)
    crRight:rectangle(b_gutter, total_height - b_arrow + side, b_weight, b_arrow - side)
    crRight:fill()

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "top",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgTop,
    }) : setup { layout = wibox.layout.align.horizontal, }

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "left",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgLeft,
    }) : setup { layout = wibox.layout.align.horizontal, }

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "right",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgRight,
    }) : setup { layout = wibox.layout.align.horizontal, }

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "bottom",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgBot,
    }) : setup { layout = wibox.layout.align.horizontal, }
end

local function titlebar_after(c)
    -- if c.floating then return end

    local b_string_color = gears.color(theme.border_focus .. "55")
    local b_arrow_color = gears.color(theme.border_focus .. "ff")
    local b_weight = 12
    local b_string_weight = 4
    local b_gutter = 12
    local b_arrow = 120

    local side = b_weight + b_gutter
    local total_width = c.width
    local total_height = c.height

    -- for some reasons, the client height/width are not the same at first
    -- render (when called by request title bar) and when resizing
    total_height = total_height - 2 * (b_weight + b_gutter)

    local imgTop = cairo.ImageSurface.create(cairo.Format.ARGB32, total_width, side)
    local crTop  = cairo.Context(imgTop)

    crTop:set_source(b_string_color)
    crTop:rectangle(0, b_weight / 2 - b_string_weight / 2, total_width, b_string_weight)
    crTop:fill()

    crTop:set_source(b_arrow_color)
    crTop:rectangle(0, 0, b_arrow, b_weight)
    crTop:rectangle(0, 0, b_weight, side)
    crTop:rectangle(total_width - b_arrow, 0, b_arrow, b_weight)
    crTop:rectangle(total_width - b_weight, 0, b_weight, side)
    crTop:fill()

    local imgBot = cairo.ImageSurface.create(cairo.Format.ARGB32, total_width, side)
    local crBot  = cairo.Context(imgBot)

    crBot:set_source(b_string_color)
    crBot:rectangle(0, side - b_weight / 2 - b_string_weight / 2, total_width, b_string_weight)
    crBot:fill()

    crBot:set_source(b_arrow_color)
    crBot:rectangle(0, b_gutter, b_arrow, b_weight)
    crBot:rectangle(0, 0, b_weight, side)
    crBot:rectangle(total_width - b_weight, 0, b_weight, side)
    crBot:rectangle(total_width - b_arrow, b_gutter, b_arrow, b_weight)
    crBot:fill()

    local imgLeft = cairo.ImageSurface.create(cairo.Format.ARGB32, side, total_height)
    local crLeft  = cairo.Context(imgLeft)

    crLeft:set_source(b_string_color)
    crLeft:rectangle(b_weight / 2 - b_string_weight / 2, 0, b_string_weight, total_height)
    crLeft:fill()

    crLeft:set_source(b_arrow_color)
    crLeft:rectangle(0, 0, b_weight, b_arrow - side)
    crLeft:rectangle(0, total_height - b_arrow + side, b_weight, b_arrow - side)
    crLeft:fill()

    local imgRight = cairo.ImageSurface.create(cairo.Format.ARGB32, side, total_height)
    local crRight  = cairo.Context(imgRight)

    crRight:set_source(b_string_color)
    crRight:rectangle(b_gutter + b_weight / 2 - b_string_weight / 2, 0, b_string_weight, total_height)
    crRight:fill()

    crRight:set_source(b_arrow_color)
    crRight:rectangle(b_gutter, 0, b_weight, b_arrow - side)
    crRight:rectangle(b_gutter, total_height - b_arrow + side, b_weight, b_arrow - side)
    crRight:fill()

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "top",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgTop,
    }) : setup { layout = wibox.layout.align.horizontal, }

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "left",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgLeft,
    }) : setup { layout = wibox.layout.align.horizontal, }

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "right",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgRight,
    }) : setup { layout = wibox.layout.align.horizontal, }

    awful.titlebar(c, {
        size = b_weight + b_gutter,
        position = "bottom",
        bg_normal = "transparent",
        bg_focus = "transparent",
        bgimage_focus = imgBot,
    }) : setup { layout = wibox.layout.align.horizontal, }
end

client.connect_signal("property::size", titlebar_after)
-- }}}

return theme
