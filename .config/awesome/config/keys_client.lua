
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

    local k             = context.keys.short
    local terminal      = context.vars.terminal
    local browser       = context.vars.browser

    context.keys.client = gears.table.join(
        awful.key({ k.m, k.a           }, "Return", function(c) c:swap(awful.client.getmaster()) end,
                  { description = "swap with master", group = "client" }),
        awful.key({ k.m, k.c           }, "m", lain.util.magnify_client,
                  { description = "magnify", group = "client" }),

        awful.key({ k.m                }, "z", function(c) c:kill() end,
                  { description = "close", group = "client" }),
        awful.key({ k.m, k.c           }, "space", awful.client.floating.toggle,
                  { description = "toggle floating", group = "client" }),
        awful.key({ k.m                }, "o", function(c) c:move_to_screen() end,
                  { description = "move to screen", group = "client" }),
        awful.key({ k.m                }, "t", function(c) c.ontop = not c.ontop end,
                  { description = "toggle keep on top", group = "client" }),
        awful.key({ k.m                }, "s", function(c) c.sticky = not c.sticky end,
                  { description = "toggle sticky", group = "client" }),
        awful.key({ k.m                }, "i", context.util.toggle_titlebar,
                  { description = "toggle titlebar", group = "client" }),
        awful.key({ k.m                }, "n", function(c) c.minimized = true end,
                  { description = "minimize", group = "client" }),
        awful.key({ k.m                }, "m", context.util.toggle_maximized,
                  { description = "maximize", group = "client" }),
        awful.key({ k.m                }, "f", context.util.toggle_fullscreen,
                  { description = "fullscreen", group = "client" }),

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

    context.mouse.client = gears.table.join(
        awful.button({                    }, 1, function(c) if c.focusable then client.focus = c end; c:raise() end),
        awful.button({ k.m                }, 1, awful.mouse.client.move),
        awful.button({ k.m, k.s           }, 1, awful.mouse.client.resize)
    )

end

return config
