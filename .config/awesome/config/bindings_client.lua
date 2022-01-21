
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local gears = require("gears")
local awful = require("awful")
local lain = require("lain")

local context = require("config.context")
local util = require("config.util")

local _config = { }

function _config.init()

    local k = require("config.keys") --luacheck: no unused

    -- {{{ Keys

    _config.keys = gears.table.join(

        -- Client manipulation
        awful.key({ k.m                }, "z", function(c) c:kill() end,
                  { description = "close", group = "client" }),
        awful.key({ k.m                }, "m", util.toggle_maximized,
                  { description = "maximize", group = "client" }),
        awful.key({ k.m                }, "n", function(c) c.minimized = true end,
                  { description = "minimize", group = "client" }),
        awful.key({ k.m                }, "t", function(c) c.ontop = not c.ontop end,
                  { description = "toggle keep on top", group = "client" }),
        awful.key({ k.m                }, "s", function(c) c.sticky = not c.sticky end,
                  { description = "toggle sticky", group = "client" }),

        -- Client manipulation (Keyboard only)
        awful.key({ k.m                }, "f", util.toggle_fullscreen,
                  { description = "fullscreen", group = "client" }),
        awful.key({ k.m, k.c           }, "m", lain.util.magnify_client,
                  { description = "magnify", group = "client" }),
        awful.key({ k.m, k.c           }, "space", awful.client.floating.toggle,
                  { description = "toggle floating", group = "client" }),
        awful.key({ k.m                }, "i", util.toggle_titlebar,
                  { description = "toggle titlebar", group = "client" }),
        awful.key({ k.m                }, "BackSpace", function(c) c:swap(awful.client.getmaster()) end,
                  { description = "swap with master", group = "client" }),

        -- Client placement
        awful.key({ k.m, k.c, k.s      }, "c", util.if_client_floats(awful.placement.centered),
                  { description = "center floating client", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, "o", util.if_client_floats(awful.placement.no_overlap),
                  { description = "no-overlap floating client", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, "s", util.if_client_floats(awful.placement.no_offscreen),
                  { description = "no-offscreen floating client", group = "client" }),

        -- Move client to tag in grid
        awful.key({ k.m, k.c, k.s      }, k.l, function(c)
            util.move_client_in_grid(c, "l")
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to previous tag", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.r, function(c)
            util.move_client_in_grid(c, "r")
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to next tag", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.u, function(c)
            util.move_client_in_grid(c, "u")
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to tag above", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.d, function(c)
            util.move_client_in_grid(c, "d")
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to tag below", group = "client" }),

        -- Move client to screen
        awful.key({ k.m, k.s, k.c      }, "g", function(c)
            c:move_to_screen(c.screen.index-1)
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to previous screen", group = "screen" }),
        awful.key({ k.m, k.s           }, "g", function(c)
            c:move_to_screen(c.screen.index+1)
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to next screen", group = "screen" }),

        -- Move client to screen
        awful.key({ k.c, k.a, k.s      }, k.l, function(c)
            c:move_to_screen(c.screen.index-1)
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to previous screen", group = "screen" }),
        awful.key({ k.c, k.a, k.s      }, k.r, function(c)
            c:move_to_screen(c.screen.index+1)
            -- c.screen._taglist_popup:show()
        end,
                  { description = "move to next screen", group = "screen" }),

        -- Edit in Vim
        awful.key({ k.m                }, "v", function(c) --luacheck: no unused
            awful.spawn(table.concat {
                    context.vars.terminal, " zsh -lic '", context.vars.scripts_dir, "/edit-in-vim'"
                }, {
                    floating = true,
                    ontop = true,
                    placement = awful.placement.centered,
                }
            )
        end)
    )

    -- Bind number keys
    -- NOTE: Using keycodes to make it works on any keyboard layout
    for i = 1, 10 do
        _config.keys = gears.table.join(
            _config.keys,

            -- Move client to tag
            awful.key({ k.m, k.s           }, "#" .. i + 9, function(c)
                local t = c.screen.tags[i]
                if t then
                    c:move_to_tag(t)
                end
                -- c.screen._taglist_popup:show()
            end),

            -- Move client to tag and view it
            awful.key({ k.m, k.c, k.s      }, "#" .. i + 9, function(c)
                local t = c.screen.tags[i]
                if t then
                    c:move_to_tag(t)
                    t:view_only()
                end
                -- c.screen._taglist_popup:show()
            end),

            -- Toggle tag on focused client
            awful.key({ k.m, k.a           }, "#" .. i + 9, function(c)
                local t = c.screen.tags[i]
                if t then
                    c:toggle_tag(t)
                end
                -- c.screen._taglist_popup:show()
            end)
        )
    end

    -- }}}

    -- {{{ Fake bindings for description

    -- Move client to tag
    util.fake_key({ k.m, k.s           }, "1..9",
                  { description = "move client to tag", group = "numeric keys" })

    -- Move client to tag and view it
    util.fake_key({ k.m, k.c, k.s      }, "1..9",
                  { description = "move client to tag, focus", group = "numeric keys" })

    -- Toggle tag on focused client
    util.fake_key({ k.m, k.a           }, "1..9",
                  { description = "toggle client on tag", group = "numeric keys" })

    -- }}}

    -- {{{ Buttons

    _config.buttons = gears.table.join(
        awful.button({                    }, 1, function(c) if c.focusable then client.focus = c end; c:raise() end),
        awful.button({ k.m                }, 1, function(c) awful.mouse.client.move(c); c:raise() end),
        awful.button({ k.m, k.s           }, 1, function(c) awful.mouse.client.resize(c); c:raise() end)
    )

    -- }}}

end

return _config
