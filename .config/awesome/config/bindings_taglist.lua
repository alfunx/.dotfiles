
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")

local _config = { }

function _config.init()

    local k = require("config.keys") --luacheck: no unused

    -- {{{ Buttons

    _config.buttons = gears.table.join(
        awful.button({                    }, 1, function(t) t:view_only() end),
        awful.button({ k.m                }, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end),
        awful.button({                    }, 3, awful.tag.viewtoggle),
        awful.button({ k.m                }, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end),
        awful.button({                    }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({                    }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    -- }}}

end

return _config
