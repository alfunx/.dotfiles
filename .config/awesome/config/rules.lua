local awful = require("awful")
local beautiful = require("beautiful")

local config = {}

function config.init(context)

    -- Rules to apply to new clients (through the "manage" signal).
    awful.rules.rules = {

        -- all clients will match this rule
        {
            rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = context.keys.client,
                buttons = context.clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_offscreen+awful.placement.no_overlap,
                size_hints_honor = false,
                titlebars_enabled = true,
            },
        },

        -- enable titlebars
        {
            rule_any = {
                type = {
                    "normal",
                    "dialog",
                },
            },
            properties = {
                titlebars_enabled = true,
            },
        },

        -- no borders if maximized
        {
            rule = {
                maximized = true,
            },
            properties = {
                border_width = 0,
            },
        },

        {
            rule = {
                class = "Thunderbird",
            },
            properties = {
                screen = 1,
                tag = awful.util.tagnames[6],
            },
        },

        {
            rule = {
                class = "Gimp-2.10",
            },
            properties = {
                screen = 1,
                tag = awful.util.tagnames[7],
            },
        },

        {
            rule = {
                class = "VirtualBox",
            },
            properties = {
                screen = 1,
                tag = awful.util.tagnames[8],
            },
        },

        {
            rule = {
                class = "Firefox",
                role = "toolbox",
            },
            properties = {
                floating = true,
            },
        },

        {
            rule = {
                class = "Chromium",
                role = "pop-up",
            },
            properties = {
                floating = true,
            },
        },

        {
            rule = {
                class = "Chrome",
                role = "pop-up",
            },
            properties = {
                floating = true,
            },
        },

        -- clients that should float
        {
            rule_any = {
                class = {
                    "Git-gui",
                    "feh",
                    "Lxappearance",
                    "Lxsession-edit",
                    "Lxsession-default-apps",
                    "Oomox",
                    "Gpick",
                    "System-config-printer.py",
                    "Pinentry",
                    "Event Tester",
                    "alsamixer",
                },
                name = {
                    "Event Tester",
                },
            },
            properties = {
                floating = true,
                placement = awful.placement.centered,
            },
        },

    }

end

return config
