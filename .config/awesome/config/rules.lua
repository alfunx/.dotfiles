
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local awful = require("awful")
local beautiful = require("beautiful")

local bindings = require("config.bindings_client")
local tags = require("config.tags")

local _config = { }

function _config.init()

    -- placement, that should be applied after setting x/y/width/height/geometry
    function awful.rules.delayed_properties.delayed_placement(c, value, props) --luacheck: no unused
        if props.delayed_placement then
            awful.rules.extra_properties.placement(c, props.delayed_placement, props)
        end
    end

    -- Rules to apply to new clients (through the "manage" signal)
    awful.rules.rules = {

        -- All clients will match this rule
        {
            rule = { },
            properties = {
                border_width      = beautiful.border_width,
                border_color      = beautiful.border_normal,
                focus             = awful.client.focus.filter,
                raise             = true,
                keys              = bindings.keys,
                buttons           = bindings.buttons,
                screen            = awful.screen.preferred,
                placement         = awful.placement.no_offscreen
                                  + awful.placement.no_overlap,
                delayed_placement = awful.placement.centered,
                size_hints_honor  = false,
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
                class = "chromium",
            },
            properties = {
                tag    = tags.names[2],
            },
        },

        {
            rule = {
                class = "Discord",
            },
            properties = {
                tag    = tags.names[3],
            },
        },

        {
            rule = {
                class = "discord",
            },
            properties = {
                tag    = tags.names[3],
            },
        },

        {
            rule = {
                class = "Chromium",
                role  = "pop-up",
            },
            properties = {
                floating = true,
                tag    = tags.names[2],
            },
        },

        {
            rule = {
                class = "Chrome",
                role  = "pop-up",
            },
            properties = {
                floating = true,
                tag    = tags.names[2],
            },
        },

        {
            rule = {
                class = "Arandr",
            },
            properties = {
                width  = 600,
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
                    "pulsemixer",
                    "Arandr",
                },
                name = {
                    "Event Tester",
                    "Page Unresponsive",
                },
                role = {
                    "AlarmWindow",
                    "ConfigManager",
                    "toolbox",
                    "pop-up",
                },
                instance = {
                    "DTA",
                    "copyq",
                    "pinentry",
                },
            },
            properties = {
                floating          = true,
                delayed_placement = awful.placement.centered,
            },
        },

    }

end

return _config
