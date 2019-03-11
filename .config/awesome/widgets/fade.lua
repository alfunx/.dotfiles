
--[[

     Licensed under GNU General Public License v2
      * (c) 2019, Alphonse Mariyagnanaseelan

--]]

local wibox = require("wibox")
local gears = require("gears")

local function factory(args)

    if args.width and args.height then
        gears.debug.print_warning("widgets.fade: Ambiguous direction.")
        gears.debug.print_warning("              args.width and args.height defined - using width")
    elseif not args.width and not args.height then
        args.width = 10
        gears.debug.print_warning("widgets.fade: Undefined direction.")
        gears.debug.print_warning("              args.width and args.height undefined - using width=10")
    end

    local primary_dir = args.width and wibox.layout.align.horizontal or wibox.layout.align.vertical
    local secondary_dir = args.width and wibox.layout.flex.vertical or wibox.layout.flex.horizontal

    local widget = {
        {
            {
                layout = secondary_dir,
            },
            forced_width = args.width,
            forced_height = args.height,
            bg = {
                type = "linear",
                from = { 0, 0 },
                to = { args.width or 0, args.height or 0 },
                stops = {
                    { 0, args.color },
                    { 1, args.color .. "00" },
                },
            },
            widget = wibox.container.background,
        },
        {
            layout = secondary_dir,
        },
        {
            {
                layout = secondary_dir,
            },
            forced_width = args.width,
            forced_height = args.height,
            bg = {
                type = "linear",
                from = { 0, 0 },
                to = { args.width or 0, args.height or 0 },
                stops = {
                    { 0, args.color .. "00" },
                    { 1, args.color },
                },
            },
            widget = wibox.container.background,
        },
        layout = primary_dir,
    }

    return widget

end

return factory
