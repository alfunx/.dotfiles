local awful = require("awful")
local lain = require("lain")

local config = {}

function config.init(context)

    local modkey      = context.keys.modkey
    local altkey      = context.keys.altkey
    local ctrlkey     = context.keys.ctrlkey
    local shiftkey    = context.keys.shiftkey
    local leftkey     = context.keys.leftkey
    local rightkey    = context.keys.rightkey
    local upkey       = context.keys.upkey
    local downkey     = context.keys.downkey

    local terminal    = context.terminal
    local browser     = context.browser

    context.keys.client = awful.util.table.join(
        awful.key({ modkey, altkey            }, "Return", function(c) c:swap(awful.client.getmaster()) end,
                  {description = "swap with master", group = "client"}),
        awful.key({ modkey, ctrlkey           }, "m", lain.util.magnify_client,
                  {description = "magnify", group = "client"}),

        awful.key({ modkey                    }, "z", function(c) c:kill() end,
                  {description = "close", group = "client"}),
        awful.key({ modkey, ctrlkey           }, "space", awful.client.floating.toggle,
                  {description = "toggle floating", group = "client"}),
        awful.key({ modkey                    }, "o", function(c) c:move_to_screen() end,
                  {description = "move to screen", group = "client"}),
        awful.key({ modkey                    }, "t", function(c) c.ontop = not c.ontop end,
                  {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey                    }, "s", function(c) c.sticky = not c.sticky end,
                  {description = "toggle sticky", group = "client"}),
        awful.key({ modkey                    }, "i", function(c) awful.titlebar.toggle(c) end,
                  {description = "toggle titlebar", group = "client"}),
        awful.key({ modkey                    }, "n", function(c) c.minimized = true end,
                  {description = "minimize", group = "client"}),
        awful.key({ modkey                    }, "m", context.toggle_maximized,
                  {description = "maximize", group = "client"}),
        awful.key({ modkey                    }, "f", context.toggle_fullscreen,
                  {description = "fullscreen", group = "client"}),

        awful.key({ modkey                    }, "v", function(c) --luacheck: no unused args
            awful.spawn(terminal .. " zsh -lic '" .. awful.util.scripts_dir .. "/edit-in-vim'", {
                floating = true,
                ontop = true,
                placement = awful.placement.centered,
            })
        end)
    )

    if context.set_wallpaper then
        context.keys.client = awful.util.table.join(
            context.keys.client,
            awful.key({ modkey, ctrlkey           }, "i", function() context.set_wallpaper(0) end,
                      {description = "unblur wallpaper", group = "client"})
        )
    end

    context.clientbuttons = awful.util.table.join(
        awful.button({                  }, 1, function(c) client.focus = c; c:raise() end),
        awful.button({ modkey           }, 1, awful.mouse.client.move),
        awful.button({ modkey, shiftkey }, 1, awful.mouse.client.resize)
    )

end

return config
