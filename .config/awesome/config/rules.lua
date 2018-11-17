
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")
local beautiful = require("beautiful")

local config = { }

function config.init(context)

    -- Rules to apply to new clients (through the "manage" signal).
    awful.rules.rules = {

        -- All clients will match this rule
        {
            rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = context.keys.client,
                buttons = context.mouse.client,
                screen = awful.screen.preferred,
                placement = awful.placement.no_offscreen+awful.placement.no_overlap,
                size_hints_honor = false,
                titlebars_enabled = true,
            },
        },

        -- Enable titlebars
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

        {
            rule = {
                class = "Arandr",
            },
            properties = {
                width = 500,
                height = 400,
            },
        },

        -- Clients that should float
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
                    "Arandr",
                },
                name = {
                    "Event Tester",
                    "Page Unresponsive",
                },
            },
            properties = {
                floating = true,
                delayed_placement = awful.placement.centered,
            },
        },

    }

    -- placement, that should be applied after setting x/y/width/height/geometry
    function awful.rules.delayed_properties.delayed_placement(c, value, props)
        if props.delayed_placement then
            awful.rules.extra_properties.placement(c, props.delayed_placement, props)
        end
    end

end

return config
