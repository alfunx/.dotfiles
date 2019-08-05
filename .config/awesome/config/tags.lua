
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local awful = require("awful")
local lain = require("lain")

local _config = { }

function _config.init()

    -- _config.names = { "α", "β", "γ", "δ", "ϵ", "λ", "μ", "σ", "ω" }
    _config.names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    _config.columns = #_config.names

    -- local manual = awful.layout.dynamic.suit.manual
    -- local tile = awful.layout.dynamic.suit.tile
    -- local fair = awful.layout.dynamic.suit.fair
    -- local corner = awful.layout.dynamic.suit.corner
    -- local cond = require("wibox.container.conditional")
    -- local wibox = require("wibox")
    --
    -- local mycustomtilelayout = manual {
    --     {
    --         max_elements = 3,
    --         {
    --             {
    --                 priority     = 2,
    --                 max_elements = 1,
    --                 ratio        = 0.33,
    --                 layout       = tile.vertical,
    --             },
    --             {
    --                 priority     = 1,
    --                 max_elements = 1,
    --                 ratio        = 0.33,
    --                 layout       = tile.vertical,
    --             },
    --             {
    --                 priority     = 3,
    --                 max_elements = 1,
    --                 ratio        = 0.33,
    --                 layout       = tile.vertical,
    --             },
    --             reflow              = true,
    --             inner_fill_strategy = 'spacing',
    --             layout              = tile.horizontal,
    --         },
    --         margins = 3,
    --         widget  = wibox.container.margin,
    --     },
    --     {
    --         reflow       = true,
    --         max_elements = 4,
    --         min_elements = 4,
    --         layout       = fair,
    --     },
    --     {
    --         reflow       = true,
    --         min_elements = 5,
    --         layout       = corner,
    --     },
    --     reflow = true,
    --     layout = cond,
    -- }

    awful.layout.layouts = {
        awful.layout.suit.max,
        --awful.layout.suit.max.fullscreen,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        --awful.layout.suit.tile.bottom,
        --awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        --awful.layout.suit.fair.horizontal,
        --awful.layout.suit.spiral,
        --awful.layout.suit.spiral.dwindle,
        awful.layout.suit.magnifier,
        --awful.layout.suit.corner.nw,
        --awful.layout.suit.corner.ne,
        --awful.layout.suit.corner.sw,
        --awful.layout.suit.corner.se,
        --lain.layout.cascade,
        lain.layout.cascade.tile,
        lain.layout.centerwork,
        --lain.layout.centerwork.horizontal,
        --lain.layout.termfair,
        --lain.layout.termfair.center,
        awful.layout.suit.floating,
    }

    _config.layouts = {
        awful.layout.suit.max,
        awful.layout.suit.max,
        awful.layout.suit.max,
        awful.layout.suit.tile,
        awful.layout.suit.tile,
        awful.layout.suit.tile,
        awful.layout.suit.max,
        awful.layout.suit.max,
        awful.layout.suit.floating,
    }

    _config.main_layout = awful.layout.suit.tile

    lain.layout.termfair.nmaster           = 3
    lain.layout.termfair.ncol              = 1
    lain.layout.termfair.center.nmaster    = 3
    lain.layout.termfair.center.ncol       = 1
    lain.layout.cascade.tile.offset_x      = 2
    lain.layout.cascade.tile.offset_y      = 32
    lain.layout.cascade.tile.extra_padding = 5
    lain.layout.cascade.tile.nmaster       = 3
    lain.layout.cascade.tile.ncol          = 2

end

return _config
