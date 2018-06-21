
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local lain = require("lain")

local config = { }

function config.init(context)

    awful.util.tagcolumns = 9
    awful.util.tagnames = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    -- awful.util.tagnames = { "α", "β", "γ", "δ", "ϵ", "λ", "μ", "σ", "ω" }

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

    awful.util.layouts = {
        awful.layout.suit.max,
        awful.layout.suit.max,
        awful.layout.suit.tile,
        awful.layout.suit.tile,
        awful.layout.suit.tile,
        awful.layout.suit.tile,
        awful.layout.suit.max,
        awful.layout.suit.max,
        awful.layout.suit.floating,
    }

    awful.util.taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ context.keys.modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ context.keys.modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    local _tasklist_menu
    awful.util.tasklist_buttons = gears.table.join(
        awful.button({ }, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end),
        awful.button({ }, 3, function()
            if _tasklist_menu and _tasklist_menu.wibox.visible then
                _tasklist_menu:hide()
                _tasklist_menu = nil
            else
                _tasklist_menu = awful.menu.clients({ }, { }, function(c)
                    return c.minimized
                end)
            end
        end),
        awful.button({ }, 4, function()
            awful.client.focus.byidx(1)
        end),
        awful.button({ }, 5, function()
            awful.client.focus.byidx(-1)
        end)
    )

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

return config
