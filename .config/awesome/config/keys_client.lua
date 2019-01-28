
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local lain = require("lain")

local config = { }

function config.init(context)

    context.keys = context.keys or { }
    context.mouse = context.mouse or { }

    local k        = context.keys.short
    local terminal = context.vars.terminal
    local browser  = context.vars.browser

    context.keys.client = gears.table.join(

        -- Client manipulation
        awful.key({ k.m                }, "z", function(c) c:kill() end,
                  { description = "close", group = "client" }),
        awful.key({ k.m                }, "m", context.util.toggle_maximized,
                  { description = "maximize", group = "client" }),
        awful.key({ k.m                }, "n", function(c) c.minimized = true end,
                  { description = "minimize", group = "client" }),
        awful.key({ k.m                }, "t", function(c) c.ontop = not c.ontop end,
                  { description = "toggle keep on top", group = "client" }),
        awful.key({ k.m                }, "s", function(c) c.sticky = not c.sticky end,
                  { description = "toggle sticky", group = "client" }),

        -- Client manipulation (Keyboard only)
        awful.key({ k.m                }, "f", context.util.toggle_fullscreen,
                  { description = "fullscreen", group = "client" }),
        awful.key({ k.m, k.c           }, "m", lain.util.magnify_client,
                  { description = "magnify", group = "client" }),
        awful.key({ k.m, k.c           }, "space", awful.client.floating.toggle,
                  { description = "toggle floating", group = "client" }),
        awful.key({ k.m                }, "i", context.util.toggle_titlebar,
                  { description = "toggle titlebar", group = "client" }),
        awful.key({ k.m                }, "BackSpace", function(c) c:swap(awful.client.getmaster()) end,
                  { description = "swap with master", group = "client" }),

        -- Move client to tag in grid
        awful.key({ k.m, k.c, k.s      }, k.l, function(c)
            context.util.move_client_in_grid(c, "l")
            c.screen._taglist_popup:show()
        end,
                  { description = "move to previous tag", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.r, function(c)
            context.util.move_client_in_grid(c, "r")
            c.screen._taglist_popup:show()
        end,
                  { description = "move to next tag", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.u, function(c)
            context.util.move_client_in_grid(c, "u")
            c.screen._taglist_popup:show()
        end,
                  { description = "move to tag above", group = "client" }),
        awful.key({ k.m, k.c, k.s      }, k.d, function(c)
            context.util.move_client_in_grid(c, "d")
            c.screen._taglist_popup:show()
        end,
                  { description = "move to tag below", group = "client" }),

        -- Move client to screen
        awful.key({ k.m                }, "o", function(c)
            c:move_to_screen()
            c.screen._taglist_popup:show()
        end,
                  { description = "move to screen", group = "client" }),
        awful.key({ k.c, k.a, k.s      }, k.l, function(c)
            c:move_to_screen(c.screen.index+1)
            c.screen._taglist_popup:show()
        end,
                  { description = "move to previous screen", group = "client" }),
        awful.key({ k.c, k.a, k.s      }, k.r, function(c)
            c:move_to_screen(c.screen.index-1)
            c.screen._taglist_popup:show()
        end,
                  { description = "move to next screen", group = "client" }),

        -- Edit in Vim
        awful.key({ k.m                }, "v", function(c) --luacheck: no unused args
            awful.spawn(terminal .. " zsh -lic '" .. context.vars.scripts_dir .. "/edit-in-vim'", {
                floating = true,
                ontop = true,
                placement = awful.placement.centered,
            })
        end)
    )

    if context.util.set_wallpaper then
        context.keys.client = gears.table.join(
            context.keys.client,

            awful.key({ k.m, k.c           }, "i", function() context.util.set_wallpaper(0) end,
                      { description = "unblur wallpaper", group = "client" })
        )
    end

    -- Bind number keys
    -- NOTE: Using keycodes to make it works on any keyboard layout
    for i = 1, 10 do
        context.keys.client = gears.table.join(
            context.keys.client,

            -- Move client to tag
            awful.key({ k.m, k.s           }, "#" .. i + 9, function(c)
                local _tag = c.screen.tags[i]
                if _tag then
                    c:move_to_tag(_tag)
                end
                c.screen._taglist_popup:show()
            end),

            -- Move client to tag and view it
            awful.key({ k.m, k.c, k.s      }, "#" .. i + 9, function(c)
                local _tag = c.screen.tags[i]
                if _tag then
                    c:move_to_tag(_tag)
                    _tag:view_only()
                end
                c.screen._taglist_popup:show()
            end),

            -- Toggle tag on focused client
            awful.key({ k.m, k.a           }, "#" .. i + 9, function(c)
                local _tag = c.screen.tags[i]
                if _tag then
                    c:toggle_tag(_tag)
                end
                c.screen._taglist_popup:show()
            end)
        )
    end

    context.mouse.client = gears.table.join(
        awful.button({                    }, 1, function(c) if c.focusable then client.focus = c end; c:raise() end),
        awful.button({ k.m                }, 1, awful.mouse.client.move),
        awful.button({ k.m, k.s           }, 1, awful.mouse.client.resize)
    )

end

return config
