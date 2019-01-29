--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Alphonse Mariyagnanaseelan

--]]

local gears        = require("gears")
local wibox        = require("wibox")
local lines, floor = io.lines, math.floor
local string       = { format = string.format,
                       gsub   = string.gsub }

local function factory(args)

    args.ratio = args.ratio or { 2, 0.20, 0.60, 0.20 }

    local widget = wibox.widget {
        {
            id               = "icon",
            align            = "center",
            widget           = wibox.widget.textbox,
        },
        {
            id               = "bar",
            min_value        = 0,
            max_value        = 100,
            value            = 0,
            forced_height    = args.height,
            forced_width     = args.width,
            paddings         = args.border,
            color            = args.inner_color,
            background_color = args.outer_color,
            widget           = wibox.widget.progressbar,
        },
        {
            id               = "text",
            text             = "0%",
            align            = "center",
            widget           = wibox.widget.textbox,
        },
        forced_width = args.total_width,
        layout       = wibox.layout.ratio.horizontal,
    }

    widget:ajust_ratio(table.unpack(args.ratio))

    return widget

end

return factory
