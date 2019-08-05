
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local yaawl = require("yaawl")
local file = require("yaawl.util.file")

local context = require("config.context")

local _config = { }

function _config.init()

    -- Updates
    _config.pacman = yaawl.updates {
        command = "checkupdates | sed -E 's/->/→/;s/\\.g[^.-]+-/-/g' | sort | column -t -c 70 -T 2,4",
        notify  = true,
    }
    _config.pacman:add_timer {
        timeout = 911,
    }

    -- Active users
    _config.users = yaawl.users {
    }
    _config.users:add_timer {
        timeout = 181,
    }

    -- Brightness
    _config.brightness = yaawl.brightness {
    }
    _config.brightness:add_timer {
        timeout = 191,
    }

    -- Audio
    _config.audio = yaawl.audio {
    }
    -- _config.audio:add_timer {
    --     timeout = 193,
    -- }
    _config.audio.buttons = gears.table.join(
        _config.audio.buttons,
        awful.button({ context.keys.modkey }, 1, function()
            awful.spawn(table.concat {
                context.vars.terminal, "zsh -lic 'pulsemixer'"
            }, {
                floating = true,
                ontop = true,
                placement = awful.placement.centered,
            })
        end),
        awful.button({ context.keys.altkey }, 1, function()
            awful.spawn(table.concat {
                context.vars.scripts_dir, "/connect-headphones"
            })
        end)
    )

    -- Battery
    _config.battery = yaawl.battery {
        battery = "BAT0",
        ac      = "AC",
    }
    -- _config.battery:add_timer {
    --     timeout = 31,
    -- }

    local htop_fn = function()
        awful.spawn(table.concat {
            context.vars.terminal, "zsh -lic 'htop'"
        }, {
            floating = true,
            ontop = true,
            placement = awful.placement.centered,
        })
    end

    -- Loadavg
    _config.loadavg = yaawl.loadavg {
    }
    _config.loadavg:add_timer {
        timeout = 13,
    }
    _config.loadavg.buttons = gears.table.join(
        _config.loadavg.buttons,
        awful.button({ context.keys.modkey }, 1, htop_fn)
    )

    -- CPU
    _config.cpu = yaawl.cpu {
    }
    _config.cpu:add_timer {
        timeout = 17,
    }
    _config.cpu.buttons = gears.table.join(
        _config.cpu.buttons,
        awful.button({ context.keys.modkey }, 1, htop_fn)
    )

    -- Memory
    _config.memory = yaawl.memory {
    }
    _config.memory:add_timer {
        timeout = 19,
    }
    _config.memory.buttons = gears.table.join(
        _config.memory.buttons,
        awful.button({ context.keys.modkey }, 1, htop_fn)
    )

    -- Temperature
    _config.temperature = yaawl.temperature {
        temp_path = "/sys/class/thermal/thermal_zone8/temp",
    }
    _config.temperature:add_timer {
        timeout = 23,
    }
    _config.temperature.buttons = gears.table.join(
        _config.temperature.buttons,
        awful.button({ context.keys.modkey }, 1, htop_fn)
    )

    -- Drive
    _config.drive = yaawl.drive {
        partition = "/",
        threshold = 95,
    }
    _config.drive:add_timer {
        timeout = 997,
    }
    _config.drive.buttons = gears.table.join(
        _config.drive.buttons,
        awful.button({ context.keys.modkey }, 1, function()
            awful.spawn(table.concat {
                context.vars.terminal, "zsh -lic 'ncdu /'"
            }, {
                floating = true,
                ontop = true,
                placement = awful.placement.centered,
            })
        end)
    )

    -- Lock
    _config.lock = yaawl.lock {
        signals = false,
    }
    _config.lock:add_timer {
        timeout = 401,
    }

    -- Weather
    _config.weather = yaawl.weather {
        APPID = file.first_line(table.concat { context.vars.secrets_dir, "/openweathermap" }),
        query = "Zurich,CH",
    }
    _config.weather:add_timer {
        timeout = 3607,
    }
    _config.weather.buttons = gears.table.join(
        _config.weather.buttons,
        awful.button({ context.keys.modkey }, 1, function()
            awful.spawn(table.concat {
                context.vars.terminal, "zsh -lic 'curl -s wttr.in | less'"
            }, {
                floating = true,
                ontop = true,
                width = 1136,
                height = 797,
                delayed_placement = awful.placement.centered,
            })
        end)
    )

    -- Ping
    _config.ping = yaawl.ping {
        command = table.concat { "ping -c1 -w5 ", context.vars.ping_ip },
    }
    _config.ping:add_timer {
        timeout = 307,
    }

    -- Net
    local net_widget_notification
    local net_dhcp_notification
    _config.net = yaawl.net {
        iface   = context.vars.net_iface,
        timeout = 2,
    }
    _config.net.buttons = gears.table.join(
        awful.button({ context.keys.modkey }, 1, function()
            awful.spawn(table.concat {
                context.vars.terminal, "zsh -lic 'sudo wifi-menu'"
            }, {
                floating = true,
                ontop = true,
                placement = awful.placement.centered,
            })
        end),
        awful.button({ context.keys.altkey }, 1, function()
            naughty.destroy(net_dhcp_notification)
            net_dhcp_notification = naughty.notify {
                title = "DHCP",
                timeout = 0,
            }
            local _text
            awful.spawn.with_line_callback(table.concat {
                "sh -c 'ping -c1 -w10 ", context.vars.ping_ip,
                " || sudo dhcpcd -1 ", context.vars.net_iface, "'"
            }, {
                stderr = function(line)
                    _text = _text and table.concat { _text, '\n', line } or line
                    net_dhcp_notification.text = _text
                end,
                exit = function(reason, args)
                    _config.net:update()
                    _config.ping:update()
                    if reason == "exit" and args == 0 then
                        naughty.destroy(net_dhcp_notification)
                    end
                end,
            })
        end),
        awful.button({ }, 1, function()
            _config.net:show()
            _config.ping:show()
            naughty.destroy(net_widget_notification)
            net_widget_notification = naughty.notify {
                title = "Network",
                timeout = 15,
            }
            local _text
            awful.spawn.with_line_callback(context.vars.scripts_dir .. "/show-ip-address -f", {
                stdout = function(line)
                    _text = _text and table.concat { _text, '\n', line } or line
                    net_widget_notification.text = _text
                end,
            })
        end)
    )

    ---------------------
    --  Notifications  --
    ---------------------

    local battery_notification
    _config.battery:add_callback(function(x)
        if x.percent > 5 or x.charging then
            naughty.destroy(battery_notification)
            return
        end
        naughty.destroy(battery_notification)
        battery_notification = naughty.notify {
            preset  = naughty.config.presets.critical,
            timeout = 0,
            title   = "Battery",
            text    = table.concat {
                "Your battery is running low.\n",
                "You should plug in your PC.",
            },
        }
    end)

--
--                      ---------------------
--                      --  PRIME NUMBERS  --
--                      ---------------------
--
--              2     3     5     7    11    13    17    19    23
--       29    31    37    41    43    47    53    59    61    67
--       71    73    79    83    89    97   101   103   107   109
--      113   127   131   137   139   149   151   157   163   167
--      173   179   181   191   193   197   199   211   223   227
--      229   233   239   241   251   257   263   269   271   277
--      281   283   293   307   311   313   317   331   337   347
--      349   353   359   367   373   379   383   389   397   401
--      409   419   421   431   433   439   443   449   457   461
--      463   467   479   487   491   499   503   509   521   523
--      541   547   557   563   569   571   577   587   593   599
--      601   607   613   617   619   631   641   643   647   653
--      659   661   673   677   683   691   701   709   719   727
--      733   739   743   751   757   761   769   773   787   797
--      809   811   821   823   827   829   839   853   857   859
--      863   877   881   883   887   907   911   919   929   937
--      941   947   953   967   971   977   983   991   997
--

end

----------------------
--  Update Brokers  --
----------------------

function _config:update()
    self.users:update()
    self.brightness:update()
    self.audio:update()
    self.battery:update()
    self.loadavg:update()
    self.cpu:update()
    self.memory:update()
    self.temperature:update()
    self.drive:update()
    self.lock:update()
    self.weather:update()
    self.ping:update()
end

--------------------
--  Show Brokers  --
--------------------

function _config:show()
    self.pacman:show()
    self:update()
end

return _config
