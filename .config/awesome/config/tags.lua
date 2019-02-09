
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")
local lain = require("lain")

local _config = { }

function _config.init()

    -- _config.names = { "α", "β", "γ", "δ", "ϵ", "λ", "μ", "σ", "ω" }
    _config.names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    _config.columns = #_config.names

    awful.layout.layouts = {
        awful.layout.suit.max,
        --awful.layout.suit.max.fullscreen,
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        --awful.layout.suit.spiral,
        --awful.layout.suit.spiral.dwindle,
        awful.layout.suit.magnifier,
        --awful.layout.suit.corner.nw,
        --awful.layout.suit.corner.ne,
        --awful.layout.suit.corner.sw,
        --awful.layout.suit.corner.se,
        -- lain.layout.cascade,
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
