
--[[

     Powerarrow - Gruvbox
     by Alphonse Mariyagnanaseelan

     Powerarrow Awesome WM theme: github.com/copycat-killer
     Gruvbox: github.com/morhetz/gruvbox/

--]]

-- Gruvbox colors

local black_dark       = "#282828"
local black_light      = "#928374"
local red_dark         = "#cc241d"
local red_light        = "#fb4934"
local green_dark       = "#98971a"
local green_light      = "#b8bb26"
local yellow_dark      = "#d79921"
local yellow_light     = "#fabd2f"
local blue_dark        = "#458588"
local blue_light       = "#83a598"
local purple_dark      = "#b16286"
local purple_light     = "#d3869b"
local aqua_dark        = "#689d6a"
local aqua_light       = "#8ec07c"
local white_dark       = "#a89984"
local white_light      = "#ebdbb2"
local orange_dark      = "#d65d0e"
local orange_light     = "#fe8019"

local bw0_h            = "#1d2021"
local bw0              = "#282828"
local bw0_s            = "#32302f"
local bw1              = "#3c3836"
local bw2              = "#504945"
local bw3              = "#665c54"
local bw4              = "#7c6f64"
local bw5              = "#928374"
local bw6              = "#a89984"
local bw7              = "#bdae93"
local bw8              = "#d5c4a1"
local bw9              = "#ebdbb2"
local bw10             = "#fbf1c7"

local textcolor_dark   = bw0
local textcolor_light  = bw9

-- local fs_bg_normal      = bw2
-- local temp_bg_normal    = bw2
local pacman_bg_normal  = bw2
local users_bg_normal   = bw2
local sysload_bg_normal = bw2
local cpu_bg_normal     = bw2
local mem_bg_normal     = bw2
local vol_bg_normal     = bw2
local bat_bg_normal     = bw2
local net_bg_normal     = bw1
local clock_bg_normal   = bw0

local cairo            = require("lgi").cairo
local gears            = require("gears")
local lain             = require("lain")
local custom_widget    = require("themes.powerarrow-gruvbox.widgets")
local awful            = require("awful")
local wibox            = require("wibox")
local os, math, string = os, math, string

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-gruvbox"
theme.scripts_dir                               = os.getenv("HOME") .. "/.bin"

theme.wallpaper_original                        = theme.dir .. "/wallpapers/matterhorn.jpg"
theme.wallpaper                                 = theme.dir .. "/wallpapers/matterhorn_base.jpg"
theme.wallpaper_blur                            = theme.dir .. "/wallpapers/matterhorn_blur.jpg"

local font_name                                 = "Iosevka Custom"
local font_size                                 = "11"
theme.font                                      = font_name .. " " ..                         font_size
theme.font_bold                                 = font_name .. " " .. "Bold"        .. " " .. font_size
theme.font_italic                               = font_name .. " " .. "Italic"      .. " " .. font_size
theme.font_bold_italic                          = font_name .. " " .. "Bold Italic" .. " " .. font_size
theme.font_big                                  = font_name .. " " .. "Bold"        .. " 16"

theme.border_normal                             = bw4
theme.border_focus                              = bw7
theme.border_marked                             = bw5

theme.fg_normal                                 = bw9
theme.fg_focus                                  = red_light
theme.fg_urgent                                 = bw0
theme.bg_normal                                 = bw0
theme.bg_focus                                  = bw2
theme.bg_urgent                                 = red_light

theme.notification_fg                           = textcolor_light
theme.notification_bg                           = bw0
theme.notification_border_color                 = bw0
theme.notification_border_width                 = 4
theme.notification_icon_size                    = 80
theme.notification_opacity                      = 0.9
theme.notification_max_width                    = 600
theme.notification_margin                       = 100
theme.notification_shape                        = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, 5)
                                                  end

theme.taglist_font                              = theme.font_bold
theme.taglist_fg_normal                         = theme.fg_normal
theme.taglist_fg_focus                          = theme.fg_focus
theme.taglist_fg_urgent                         = bw0
theme.taglist_bg_normal                         = bw0
theme.taglist_bg_occupied                       = bw0
theme.taglist_bg_empty                          = bw0
theme.taglist_bg_volatile                       = bw0
theme.taglist_bg_focus                          = bw0
theme.taglist_bg_urgent                         = red_light

theme.tasklist_font_normal                      = theme.font
theme.tasklist_font_focus                       = theme.font_bold
theme.tasklist_font_urgent                      = theme.font_bold
theme.tasklist_fg_normal                        = bw7
theme.tasklist_fg_focus                         = bw9
theme.tasklist_fg_minimize                      = bw5
theme.tasklist_fg_urgent                        = red_light
theme.tasklist_bg_normal                        = bw3
theme.tasklist_bg_focus                         = bw4
theme.tasklist_bg_urgent                        = bw2

-- theme.titlebar_fg_normal                        = theme.tasklist_fg_normal
-- theme.titlebar_fg_focus                         = theme.tasklist_fg_focus
-- theme.titlebar_fg_marked                        = theme.tasklist_fg_focus
theme.titlebar_fg_normal                        = textcolor_dark
theme.titlebar_fg_focus                         = textcolor_dark
theme.titlebar_fg_marked                        = textcolor_dark
theme.titlebar_bg_normal                        = theme.border_normal
theme.titlebar_bg_focus                         = theme.border_focus
theme.titlebar_bg_marked                        = theme.border_marked

theme.hotkeys_border_width                      = 30
theme.hotkeys_border_color                      = bw0
theme.hotkeys_group_margin                      = 30
theme.hotkeys_shape                             = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, 20)
                                                  end

theme.prompt_bg                                 = bw2
theme.prompt_fg                                 = textcolor_light
theme.bg_systray                                = theme.tasklist_bg_normal

theme.border_width                              = 4
theme.border_radius                             = 8
theme.menu_height                               = 20
theme.menu_width                                = 250
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_spacing                          = 3
theme.useless_gap                               = 14
theme.systray_icon_spacing                      = 4

theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"

theme.layout_cascadetile                        = theme.dir .. "/layouts/cascadetile.png"
theme.layout_centerwork                         = theme.dir .. "/layouts/centerwork.png"
theme.layout_cornerne                           = theme.dir .. "/layouts/cornerne.png"
theme.layout_cornernw                           = theme.dir .. "/layouts/cornernw.png"
theme.layout_cornerse                           = theme.dir .. "/layouts/cornerse.png"
theme.layout_cornersw                           = theme.dir .. "/layouts/cornersw.png"
theme.layout_dwindle                            = theme.dir .. "/layouts/dwindle.png"
theme.layout_fairh                              = theme.dir .. "/layouts/fairh.png"
theme.layout_fairv                              = theme.dir .. "/layouts/fairv.png"
theme.layout_floating                           = theme.dir .. "/layouts/floating.png"
theme.layout_fullscreen                         = theme.dir .. "/layouts/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/layouts/magnifier.png"
theme.layout_max                                = theme.dir .. "/layouts/max.png"
theme.layout_spiral                             = theme.dir .. "/layouts/spiral.png"
theme.layout_tile                               = theme.dir .. "/layouts/tile.png"
theme.layout_tilebottom                         = theme.dir .. "/layouts/tilebottom.png"
theme.layout_tileleft                           = theme.dir .. "/layouts/tileleft.png"
theme.layout_tiletop                            = theme.dir .. "/layouts/tiletop.png"

theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_pacman                             = theme.dir .. "/icons/pacman.png"
theme.widget_users                              = theme.dir .. "/icons/user.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_minimize_button_focus_active    = theme.dir .. "/icons/titlebar/minimized_focus_active.png"
theme.titlebar_minimize_button_normal_active   = theme.dir .. "/icons/titlebar/minimized_normal_active.png"
theme.titlebar_minimize_button_focus_inactive  = theme.dir .. "/icons/titlebar/minimized_focus_inactive.png"
theme.titlebar_minimize_button_normal_inactive = theme.dir .. "/icons/titlebar/minimized_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    -- "date +'%a %d %b %R'", 60,
    "date +'%R'", 5,
    function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font_bold, textcolor_light, stdout))
    end
)

clock_widget = wibox.widget {
    clock,
    layout = wibox.layout.align.horizontal
}

-- Calendar
theme.cal = lain.widget.calendar({
    cal = "cal --color=always --monday",
    attach_to = { clock_widget },
    icons = "",
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- -- Mail IMAP check
-- local mailicon = wibox.widget.imagebox(theme.widget_mail)
-- --[[ commented because it needs to be set before use
-- mailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
-- local mail = lain.widget.imap({
--     timeout  = 180,
--     server   = "server",
--     mail     = "mail",
--     password = "keyring get mail",
--     settings = function()
--         if mailcount > 0 then
--             widget:set_text(" " .. mailcount .. " ")
--             mailicon:set_image(theme.widget_mail_on)
--         else
--             widget:set_text("")
--             mailicon:set_image(theme.widget_mail)
--         end
--     end
-- })
-- --]]

-- MPD
local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(awful.util.table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc next")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    timeout = 5,
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font

        if tonumber(mem_now.perc) >= 90 then
            bg_normal_color = red_light
            bg_normal_font = theme.font_bold
        elseif tonumber(mem_now.perc) >= 80 then
            bg_normal_color = orange_light
            bg_normal_font = theme.font_bold
        elseif tonumber(mem_now.perc) >= 70 then
            bg_normal_color = yellow_light
            bg_normal_font = theme.font_bold
        end

        widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, mem_now.perc))
    end
})

mem_widget = wibox.widget {
    memicon, mem.widget,
    layout = wibox.layout.align.horizontal
}

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    timeout = 5,
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font

        if tonumber(cpu_now.usage) >= 90 then
            bg_normal_color = red_light
            bg_normal_font = theme.font_bold
        elseif tonumber(cpu_now.usage) >= 80 then
            bg_normal_color = orange_light
            bg_normal_font = theme.font_bold
        elseif tonumber(cpu_now.usage) >= 70 then
            bg_normal_color = yellow_light
            bg_normal_font = theme.font_bold
        end

        widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, cpu_now.usage))
    end
})

cpu_widget = wibox.widget {
    cpuicon, cpu.widget,
    layout = wibox.layout.align.horizontal
}

-- SYSLOAD
local sysloadicon = wibox.widget.imagebox(theme.widget_hdd)
local sysload = lain.widget.sysload({
    timeout = 5,
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font

        -- check with: grep 'model name' /proc/cpuinfo | wc -l
        local number_of_cores = 4

        if tonumber(load_1) / number_of_cores >= 1.5 then
            bg_normal_color = red_light
            bg_normal_font = theme.font_bold
        elseif tonumber(load_1) / number_of_cores >= 1.0 then
            bg_normal_color = orange_light
            bg_normal_font = theme.font_bold
        elseif tonumber(load_1) / number_of_cores >= 0.7 then
            bg_normal_color = yellow_light
            bg_normal_font = theme.font_bold
        end
        widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, load_1))
    end
})

sysload_widget = wibox.widget {
    sysloadicon, sysload.widget,
    layout = wibox.layout.align.horizontal
}

-- PACMAN
local pacmanicon = wibox.widget.imagebox(theme.widget_pacman)
theme.pacman = custom_widget.pacman({
    command = "( checkupdates & pacaur -k --color never | sed 's/:: [a-zA-Z0-9]\\+ //' ) | sed 's/->/→/' | sort | column -t",
    notify = "on",
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font
        widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, available))
    end
})

pacman_widget = wibox.widget {
    pacmanicon, theme.pacman.widget,
    layout = wibox.layout.align.horizontal
}

theme.pacman_click = custom_widget.eventhandler({
    attach_to = { pacman_widget },
    execute = theme.pacman.manual_update
})

-- USERS
local usersicon = wibox.widget.imagebox(theme.widget_users)
local users = custom_widget.users({
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font

        if tonumber(logged_in) > 1 then
            bg_normal_color = red_light
            bg_normal_font = theme.font_bold
        end
        widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, logged_in))
    end
})

users_widget = wibox.widget {
    usersicon, users.widget,
    layout = wibox.layout.align.horizontal
}

--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]

-- -- CORETEMP (lain, average)
-- local tempicon = wibox.widget.imagebox(theme.widget_temp)
-- local temp = lain.widget.temp({
--     tempfile = "/sys/class/thermal/thermal_zone7/temp",
--     settings = function()
--         local bg_normal_color = textcolor_light
--         local bg_normal_font = theme.font
--
--         if tonumber(coretemp_now) >= 90 then
--             bg_normal_color = red_light
--             bg_normal_font = theme.font_bold
--         elseif tonumber(coretemp_now) >= 80 then
--             bg_normal_color = orange_light
--             bg_normal_font = theme.font_bold
--         elseif tonumber(coretemp_now) >= 70 then
--             bg_normal_color = yellow_light
--             bg_normal_font = theme.font_bold
--         end
--         widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, coretemp_now))
--     end
-- })

-- temp_widget = wibox.widget {
--     tempicon, temp.widget,
--     layout = wibox.layout.align.horizontal
-- }

-- -- FS
-- local fsicon = wibox.widget.imagebox(theme.widget_hdd)
-- theme.fs = lain.widget.fs({
--     options  = "--exclude-type=tmpfs",
--     notification_preset = { fg = theme.fg_normal, bg = theme.border_normal, font = "xos4 Terminus 10" },
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, textcolor_light, " " .. fs_now.available_gb .. "GB "))
--     end
-- })

-- fs_widget = wibox.widget {
--     fsicon, theme.fs.widget,
--     layout = wibox.layout.align.horizontal
-- }

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    -- togglechannel = "IEC958,3",
    -- notification_preset = { font = "xos4 Terminus 10", fg = theme.fg_normal },
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
            naughty.notify {
                title = "Audio",
                text = "Muted"
            }
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) < 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.fontfg(theme.font, textcolor_light, volume_now.level))
    end,
})

vol_widget = wibox.widget {
    volicon, theme.volume.widget,
    layout = wibox.layout.align.horizontal
}

theme.volume_click = custom_widget.eventhandler({
    attach_to = { vol_widget },
    execute = function() awful.spawn(awful.util.terminal .. " \"alsamixer\"") end,
})

-- BAT
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font

        if tonumber(bat_now.perc) <= 10 then
            baticon:set_image(theme.widget_battery_empty)
            bg_normal_color = red_light
            bg_normal_font = theme.font_bold
        elseif tonumber(bat_now.perc) <= 20 then
            baticon:set_image(theme.widget_battery_low)
            bg_normal_color = orange_light
            bg_normal_font = theme.font_bold
        elseif tonumber(bat_now.perc) <= 30 then
            baticon:set_image(theme.widget_battery_low)
            bg_normal_color = yellow_light
            bg_normal_font = theme.font_bold
        elseif tonumber(bat_now.perc) <= 50 then
            baticon:set_image(theme.widget_battery_low)
        else
            baticon:set_image(theme.widget_battery)
        end

        if bat_now.ac_status == 1 then
            baticon:set_image(theme.widget_ac)
            if tonumber(bat_now.perc) >= 95 then
                bg_normal_color = green_light
                bg_normal_font = theme.font_bold
            end
        end

        widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, bat_now.perc))
    end,
    notify = "off",
    batteries = {"BAT0"},
    ac = "AC"
})

bat_widget = wibox.widget {
    baticon, bat.widget,
    layout = wibox.layout.align.horizontal
}

-- theme.bat_hover = awful.tooltip({
--     objects = { bat.widget },
--     margin_leftright = 10,
--     margin_topbottom = 20,
--     shape = gears.shape.infobubble,
--     -- timer_function = awful.spawn.easy_async(theme.scripts_dir .. "/show-battery-status", function(stdout, stderr, reason, exit_code)
--     --     text = stdout, height = 31, timeout = 10
--     -- end)
-- })

-- theme.bat_hover = custom_widget.eventhandler({
--     attach_to = { bat.widget },
--     attach = eventhandler.attach_hover,
--     execute = function()
--         awful.spawn.easy_async(theme.scripts_dir .. "/show-battery-status", function(stdout, stderr, reason, exit_code)
--             eventhandler.notify {
--                 text = stdout, height = 31, timeout = 10
--             }
--         end)
--     end
-- })

theme.bat_click = custom_widget.eventhandler({
    attach_to = { bat_widget },
    execute = function()
        awful.spawn.easy_async(theme.scripts_dir .. "/show-battery-status", function(stdout, stderr, reason, exit_code)
            eventhandler.notify {
                text = string.gsub(stdout, '\n*$', ''),
                timeout = 10
            }
        end)
    end
})

-- -- WEATHER
-- local weather = lain.widget.weather({
--     city_id = 2661604,
--     settings = function()
--         units = math.floor(weather_now["main"]["temp"])
--         widget:set_markup(markup.fontfg(theme.font, textcolor_light, " " .. units .. "°C "))
--     end
-- })

-- weather_widget = wibox.widget {
--     weather.icon, weather.widget,
--     layout = wibox.layout.align.horizontal
-- }

-- NET
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        local bg_normal_color = textcolor_light
        local bg_normal_font = theme.font

        if net_now.state == nil or (net_now.state ~= nil and net_now.state == "down") then
            bg_normal_color = red_light
            bg_normal_font = theme.font_bold
            widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, " N/A "))
        else
            widget:set_markup(markup.fontfg(bg_normal_font, bg_normal_color, net_now.received .. " ↓↑ " .. net_now.sent))
        end
    end,
    notify = "off",
    units = 1048576, -- in MB (1024^2)
    -- units = 131072, -- in mbps (1024^2/8)
})

net_widget = wibox.widget {
    net.widget,
    layout = wibox.layout.align.horizontal
}

-- theme.net_click = custom_widget.eventhandler({
--     attach_to = { net.widget },
--     execute = function() awful.spawn(awful.util.terminal .. " \"sudo wifi-menu\"") end,
-- })

-- theme.net_hover = custom_widget.eventhandler({
--     attach_to = { net.widget },
--     attach = eventhandler.attach_hover,
--     execute = function()
--         awful.spawn.easy_async(theme.scripts_dir .. "/show-ip-address", function(stdout, stderr, reason, exit_code)
--             eventhandler.notify {
--                 text = stdout, timeout = 10
--             }
--         end)
--     end
-- })

theme.net_click = custom_widget.eventhandler({
    attach_to = { net_widget },
    execute = function()
        awful.spawn.easy_async(theme.scripts_dir .. "/show-ip-address", function(stdout, stderr, reason, exit_code)
            eventhandler.notify {
                title = "Network",
                text = string.gsub(stdout, '\n$', ''),
                timeout = 10
            }
        end)
    end
})

-- SEPARATORS
local arrow_l = separators.arrow_left
local arrow_r = separators.arrow_right

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to( offset + arrow_depth         , 0        )
    cr:line_to( offset + width               , 0        )
    cr:line_to( offset + width - arrow_depth , height/2 )
    cr:line_to( offset + width               , height   )
    cr:line_to( offset + arrow_depth         , height   )
    cr:line_to( offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

-- Show only tags of current row
local function rowfilter(t)
    local index = t.index
    local selected = awful.screen.focused().selected_tag.index
    if not index or not selected then
        return false
    end
    local columns = awful.util.tagcolumns or #awful.util.tagnames
    return math.floor((index - 1) / columns) == math.floor((selected - 1) / columns)
end

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.util.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                          awful.button({ }, 1, function () awful.layout.inc( 1) end),
                          awful.button({ }, 3, function () awful.layout.inc(-1) end),
                          awful.button({ }, 4, function () awful.layout.inc( 1) end),
                          awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, rowfilter, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s,
    awful.widget.tasklist.filter.currenttags,
    awful.util.tasklist_buttons, {
        bg_focus = theme.tasklist_bg_focus,
        shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 5) end,
        shape_border_width = 0,
        shape_border_color = theme.tasklist_bg_normal,
        align = "center" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 21, bg = theme.bg_normal, fg = theme.fg_normal })

    local systray_widget = wibox.container.margin(wibox.widget {
        wibox.widget.systray(),
        layout = wibox.layout.align.horizontal
    }, 8, 0, 3, 3)
    systray_widget:set_visible(false)

    local systray_widget_timer = gears.timer {
        timeout   = 5,
        callback  = function()
            systray_widget:set_visible(false)
        end
    }

    s.mywibox:connect_signal("mouse::enter", function()
        systray_widget:set_visible(true)
        systray_widget_timer:stop()
    end)

    s.mywibox:connect_signal("mouse::leave", function()
        systray_widget_timer:start()
    end)

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,

        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,

            wibox.container.background(wibox.container.margin(wibox.widget {
                s.mylayoutbox, layout = wibox.layout.align.horizontal
            }, 8, 3, 4, 4), clock_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget {
                s.mytaglist, layout = wibox.layout.align.horizontal
            }, 3, 8), theme.taglist_bg_normal),
            arrow_r(theme.taglist_bg_normal, theme.prompt_bg),

            wibox.container.background(wibox.container.margin(wibox.widget {
                s.mypromptbox, layout = wibox.layout.align.horizontal
            }, 8, 4), theme.prompt_bg),
            arrow_r(theme.prompt_bg, theme.tasklist_bg_normal),
        },

        -- s.mytasklist, -- Middle widget
        wibox.container.background(wibox.container.margin(s.mytasklist, 8, 0), theme.tasklist_bg_normal),

        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,

            wibox.container.background(wibox.container.margin(systray_widget, 0, 8), theme.tasklist_bg_normal),

            arrow_l(theme.tasklist_bg_normal, pacman_bg_normal),
            -- wibox.container.background(wibox.container.margin(fs_widget,      2, 6), fs_bg_normal),
            -- wibox.container.background(wibox.container.margin(temp_widget,    2, 6), temp_bg_normal),
            wibox.container.background(wibox.container.margin(pacman_widget,  2, 6), pacman_bg_normal),
            wibox.container.background(wibox.container.margin(users_widget,   2, 6), users_bg_normal),
            wibox.container.background(wibox.container.margin(sysload_widget, 2, 6), sysload_bg_normal),
            wibox.container.background(wibox.container.margin(cpu_widget,     2, 6), cpu_bg_normal),
            wibox.container.background(wibox.container.margin(mem_widget,     2, 6), mem_bg_normal),
            wibox.container.background(wibox.container.margin(vol_widget,     2, 6), vol_bg_normal),
            wibox.container.background(wibox.container.margin(bat_widget,     2, 10), bat_bg_normal),

            arrow_l(bat_bg_normal, net_bg_normal),
            wibox.container.background(wibox.container.margin(net_widget,     8, 10), net_bg_normal),

            arrow_l(net_bg_normal, clock_bg_normal),
            wibox.container.background(wibox.container.margin(clock_widget,   8, 8), clock_bg_normal),
        },
    }
end

return theme
