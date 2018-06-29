
--[[

     Blackout
     by alfunx (Alphonse Mariya)

     Powerarrow Awesome WM theme: github.com/copycat-killer
     Gruvbox: github.com/morhetz/gruvbox/

--]]

local gears            = require("gears")
local lain             = require("lain")
local widgets          = require("widgets")
local awful            = require("awful")
local wibox            = require("wibox")
local naughty          = require("naughty")
local xresources       = require("beautiful.xresources")
local context          = require("config").context
local dpi              = xresources.apply_dpi
local os, math, string = os, math, string

local colors = { }

colors.black_1          = "#282828"
colors.black_2          = "#928374"
colors.red_1            = "#cc241d"
colors.red_2            = "#fb4934"
colors.green_1          = "#98971a"
colors.green_2          = "#b8bb26"
colors.yellow_1         = "#d79921"
colors.yellow_2         = "#fabd2f"
colors.blue_1           = "#458588"
colors.blue_2           = "#83a598"
colors.purple_1         = "#b16286"
colors.purple_2         = "#d3869b"
colors.aqua_1           = "#689d6a"
colors.aqua_2           = "#8ec07c"
colors.white_1          = "#a89984"
colors.white_2          = "#ebdbb2"
colors.orange_1         = "#d65d0e"
colors.orange_2         = "#fe8019"

colors.bw_0_h           = "#1d2021"
colors.bw_0             = "#282828"
colors.bw_0_s           = "#32302f"
colors.bw_1             = "#3c3836"
colors.bw_2             = "#504945"
colors.bw_3             = "#665c54"
colors.bw_4             = "#7c6f64"
colors.bw_5             = "#928374"
colors.bw_6             = "#a89984"
colors.bw_7             = "#bdae93"
colors.bw_8             = "#d5c4a1"
colors.bw_9             = "#ebdbb2"
colors.bw_10            = "#fbf1c7"

context.util.set_colors(colors)
colors = context.colors

local bar_fg            = colors.bw_5
local bar_bg            = colors.bw_0

local theme = { }
theme.name = "blackout"
theme.alternative = "whiteout"
theme.dir = string.format("%s/.config/awesome/themes/%s", os.getenv("HOME"), theme.name)

theme.wallpaper                                 = theme.dir .. "/wallpapers/wall.png"
-- theme.wallpaper                                 = theme.dir .. "/wallpapers/escheresque.png"
-- theme.wallpaper_offset                          = 5

-- theme.wallpaper_original                        = theme.dir .. "/wallpapers/matterhorn.jpg"
-- theme.wallpaper                                 = theme.dir .. "/wallpapers/matterhorn_base.jpg"
-- theme.wallpaper_blur                            = theme.dir .. "/wallpapers/matterhorn_blur.jpg"
-- theme.wallpaper_offset                          = 0

local font_name                                 = "Iosevka Custom"
local font_size                                 = "11"
theme.font                                      = font_name .. " " ..                         font_size
theme.font_bold                                 = font_name .. " " .. "Bold"        .. " " .. font_size
theme.font_italic                               = font_name .. " " .. "Italic"      .. " " .. font_size
theme.font_bold_italic                          = font_name .. " " .. "Bold Italic" .. " " .. font_size
theme.font_big                                  = font_name .. " " .. "Bold"        .. " 16"

theme.accent                                    = colors.red_2
theme.border_normal                             = colors.bw_2
theme.border_focus                              = colors.bw_5
theme.border_marked                             = colors.bw_5

theme.fg_normal                                 = colors.bw_9
theme.fg_focus                                  = colors.bw_9
theme.fg_urgent                                 = theme.accent
theme.bg_normal                                 = colors.bw_0
theme.bg_focus                                  = theme.border_normal
theme.bg_urgent                                 = theme.border_normal

theme.taglist_font                              = theme.font_bold
theme.taglist_fg_normal                         = colors.bw_5
theme.taglist_fg_occupied                       = colors.bw_5
theme.taglist_fg_empty                          = colors.bw_1
theme.taglist_fg_volatile                       = colors.aqua_2
theme.taglist_fg_focus                          = colors.bw_9
theme.taglist_fg_urgent                         = theme.accent
theme.taglist_bg_normal                         = colors.bw_0
theme.taglist_bg_occupied                       = colors.bw_0
theme.taglist_bg_empty                          = colors.bw_0
theme.taglist_bg_volatile                       = colors.bw_0
theme.taglist_bg_focus                          = theme.border_normal
theme.taglist_bg_urgent                         = colors.bw_1

theme.tasklist_font_normal                      = theme.font
theme.tasklist_font_focus                       = theme.font_bold
theme.tasklist_font_urgent                      = theme.font_bold
theme.tasklist_fg_normal                        = colors.bw_5
theme.tasklist_fg_focus                         = colors.bw_8
theme.tasklist_fg_minimize                      = colors.bw_2
theme.tasklist_fg_urgent                        = theme.accent
theme.tasklist_bg_normal                        = colors.bw_0
theme.tasklist_bg_focus                         = colors.bw_0
theme.tasklist_bg_urgent                        = colors.bw_0

theme.titlebar_fg_normal                        = colors.bw_5
theme.titlebar_fg_focus                         = colors.bw_8
theme.titlebar_fg_marked                        = colors.bw_8
theme.titlebar_bg_normal                        = theme.border_normal
theme.titlebar_bg_focus                         = theme.border_focus
theme.titlebar_bg_marked                        = theme.border_marked

theme.hotkeys_border_width                      = dpi(30)
theme.hotkeys_border_color                      = colors.bw_0
theme.hotkeys_group_margin                      = dpi(30)
theme.hotkeys_shape                             = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, dpi(20))
                                                  end

theme.prompt_bg                                 = colors.bw_0
theme.prompt_fg                                 = theme.fg_normal
theme.bg_systray                                = theme.tasklist_bg_normal

theme.border_width                              = dpi(4)
-- theme.border_radius                             = dpi(8)
theme.border_radius                             = dpi(0)
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(250)
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_spacing                          = dpi(3)
theme.useless_gap                               = dpi(14)
theme.systray_icon_spacing                      = dpi(4)

theme.snap_bg                                   = theme.border_focus
theme.snap_shape                                = function(cr, w, h)
                                                      gears.shape.rounded_rect(cr, w, h, theme.border_radius or 0)
                                                  end

theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
-- theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
-- theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
-- theme.taglist_squares_sel_empty                 = theme.dir .. "/icons/square_sel_empty.png"
-- theme.taglist_squares_unsel_empty               = theme.dir .. "/icons/square_unsel_empty.png"

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
theme.titlebar_minimize_button_focus_active     = theme.dir .. "/icons/titlebar/minimized_focus_active.png"
theme.titlebar_minimize_button_normal_active    = theme.dir .. "/icons/titlebar/minimized_normal_active.png"
theme.titlebar_minimize_button_focus_inactive   = theme.dir .. "/icons/titlebar/minimized_focus_inactive.png"
theme.titlebar_minimize_button_normal_inactive  = theme.dir .. "/icons/titlebar/minimized_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.tooltip_fg                                = theme.titlebar_fg_focus
theme.tooltip_bg                                = theme.titlebar_bg_normal
theme.tooltip_border_color                      = theme.border_normal
theme.tooltip_border_width                      = theme.border_width

theme.notification_fg                           = theme.fg_normal
theme.notification_bg                           = theme.bg_normal
theme.notification_border_color                 = theme.border_normal
theme.notification_border_width                 = theme.border_width
theme.notification_icon_size                    = dpi(80)
theme.notification_opacity                      = 1
theme.notification_max_width                    = dpi(600)
theme.notification_max_height                   = dpi(400)
theme.notification_margin                       = dpi(20)
theme.notification_shape                        = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, theme.border_radius or 0)
                                                  end

naughty.config.padding                          = dpi(15)
naughty.config.spacing                          = dpi(10)
naughty.config.defaults.timeout                 = 5
naughty.config.defaults.margin                  = theme.notification_margin
naughty.config.defaults.border_width            = theme.notification_border_width

naughty.config.presets.normal                   = {
                                                      font         = theme.font,
                                                      fg           = theme.notification_fg,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                  }

naughty.config.presets.low                      = naughty.config.presets.normal
naughty.config.presets.ok                       = naughty.config.presets.normal
naughty.config.presets.info                     = naughty.config.presets.normal
naughty.config.presets.warn                     = naughty.config.presets.normal

naughty.config.presets.critical                 = {
                                                      font         = theme.font,
                                                      fg           = colors.red_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

local markup = lain.util.markup
-- local separators = lain.util.separators

-- Textclock
-- local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    -- "date +'%a %d %b %R'", 60,
    "date +'%R'", 5,
    function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font_bold, colors.bw_8, stdout))
    end
)

local clock_widget = wibox.widget {
    clock,
    layout = wibox.layout.align.horizontal,
}

-- Calendar
theme.cal = lain.widget.calendar {
    cal = "cal --color=always --monday",
    attach_to = { clock_widget },
    icons = "",
    notification_preset = naughty.config.presets.normal,
}

-- -- Mail IMAP check
-- local mailicon = wibox.widget.imagebox(theme.widget_mail)
-- --[[ commented because it needs to be set before use
-- mailicon:buttons(gears.table.join(awful.button({ }, 1, function() awful.spawn(mail) end)))
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
--     end,
-- })
-- --]]

-- MPD
--luacheck: push ignore widget mpd_now artist title
-- local musicplr = context.vars.terminal .. " -title Music -g 130x34-320+16 ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)

-- mpdicon:buttons(gears.table.join(
--     awful.button({ context.keys.modkey }, 1, function()
--         awful.spawn.with_shell(musicplr)
--     end),
--     awful.button({ }, 1, function()
--         awful.spawn.with_shell("mpc prev")
--         theme.mpd.update()
--     end),
--     awful.button({ }, 2, function()
--         awful.spawn.with_shell("mpc toggle")
--         theme.mpd.update()
--     end),
--     awful.button({ }, 3, function()
--         awful.spawn.with_shell("mpc next")
--         theme.mpd.update()
--     end)))

theme.mpd = lain.widget.mpd {
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
    end,
}
--luacheck: pop

-- MEM
--luacheck: push ignore widget mem_now
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem {
    timeout = 5,
    settings = function()
        local _color = bar_fg
        local _font = theme.font

        if tonumber(mem_now.perc) >= 90 then
            _color = colors.red_2
            _font = theme.font
        elseif tonumber(mem_now.perc) >= 80 then
            _color = colors.orange_2
            _font = theme.font
        elseif tonumber(mem_now.perc) >= 70 then
            _color = colors.yellow_2
            _font = theme.font
        end

        widget:set_markup(markup.fontfg(_font, _color, mem_now.perc))

        widget.used  = mem_now.used
        widget.total = mem_now.total
        widget.free  = mem_now.free
        widget.buf   = mem_now.buf
        widget.cache = mem_now.cache
        widget.swap  = mem_now.swap
        widget.swapf = mem_now.swapf
        widget.srec  = mem_now.srec
    end,
}

local mem_widget = wibox.widget {
    memicon, mem.widget,
    layout = wibox.layout.align.horizontal,
}

mem_widget:buttons(awful.button({ }, 1, function()
    if mem_widget.notification then
        naughty.destroy(mem_widget.notification)
    end
    mem.update()
    mem_widget.notification = naughty.notify {
        title = "Memory",
        text = string.format("Total:  %.2fGB\n", tonumber(mem.widget.total) / 1024 + 0.5)
            .. string.format("Used:   %.2fGB\n", tonumber(mem.widget.used ) / 1024 + 0.5)
            .. string.format("Free:   %.2fGB\n", tonumber(mem.widget.free ) / 1024 + 0.5)
            .. string.format("Buffer: %.2fGB\n", tonumber(mem.widget.buf  ) / 1024 + 0.5)
            .. string.format("Cache:  %.2fGB\n", tonumber(mem.widget.cache) / 1024 + 0.5)
            .. string.format("Swap:   %.2fGB\n", tonumber(mem.widget.swap ) / 1024 + 0.5)
            .. string.format("Swapf:  %.2fGB\n", tonumber(mem.widget.swapf) / 1024 + 0.5)
            .. string.format("Srec:   %.2fGB"  , tonumber(mem.widget.srec ) / 1024 + 0.5),
        timeout = 10,
    }
end))
--luacheck: pop

-- CPU
--luacheck: push ignore widget cpu_now
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu {
    timeout = 5,
    settings = function()
        local _color = bar_fg
        local _font = theme.font

        if tonumber(cpu_now.usage) >= 90 then
            _color = colors.red_2
            _font = theme.font
        elseif tonumber(cpu_now.usage) >= 80 then
            _color = colors.orange_2
            _font = theme.font
        elseif tonumber(cpu_now.usage) >= 70 then
            _color = colors.yellow_2
            _font = theme.font
        end

        widget:set_markup(markup.fontfg(_font, _color, cpu_now.usage))

        widget.core  = cpu_now
    end,
}

local cpu_widget = wibox.widget {
    cpuicon, cpu.widget,
    layout = wibox.layout.align.horizontal,
}

cpu_widget:buttons(awful.button({ }, 1, function()
    if cpu_widget.notification then
        naughty.destroy(cpu_widget.notification)
    end
    cpu.update()
    cpu_widget.notification = naughty.notify {
        title = "CPU",
        text = string.format("Core 1: %d%%\n", cpu.widget.core[0].usage)
            .. string.format("Core 2: %d%%\n", cpu.widget.core[1].usage)
            .. string.format("Core 3: %d%%\n", cpu.widget.core[2].usage)
            .. string.format("Core 4: %d%%"  , cpu.widget.core[3].usage),
        timeout = 10,
    }
end))
--luacheck: pop

-- SYSLOAD
--luacheck: push ignore widget load_1 load_5 load_15
local sysloadicon = wibox.widget.imagebox(theme.widget_hdd)
local sysload = lain.widget.sysload {
    timeout = 5,
    settings = function()
        local _color = bar_fg
        local _font = theme.font

        -- check with: grep 'model name' /proc/cpuinfo | wc -l
        local number_of_cores = 4

        if tonumber(load_5) / number_of_cores >= 1.5 then
            _color = colors.red_2
            _font = theme.font
        elseif tonumber(load_5) / number_of_cores >= 1.0 then
            _color = colors.orange_2
            _font = theme.font
        elseif tonumber(load_5) / number_of_cores >= 0.7 then
            _color = colors.yellow_2
            _font = theme.font
        end
        widget:set_markup(markup.fontfg(_font, _color, load_5))

        widget.load_1  = load_1
        widget.load_5  = load_5
        widget.load_15 = load_15
    end,
}

local sysload_widget = wibox.widget {
    sysloadicon, sysload.widget,
    layout = wibox.layout.align.horizontal,
}

sysload_widget:buttons(awful.button({ }, 1, function()
    if sysload_widget.notification then
        naughty.destroy(sysload_widget.notification)
    end
    sysload.update()
    sysload_widget.notification = naughty.notify {
        title = "Load Average",
        text = string.format(" 1min: %.2f\n", sysload.widget.load_1 )
            .. string.format(" 5min: %.2f\n", sysload.widget.load_5 )
            .. string.format("15min: %.2f"  , sysload.widget.load_15),
        timeout = 10,
    }
end))
--luacheck: pop

-- PACMAN
--luacheck: push ignore widget available
local pacmanicon = wibox.widget.imagebox(theme.widget_pacman)
theme.pacman = widgets.pacman {
    command = context.vars.checkupdate,
    notify = "on",
    notification_preset = naughty.config.presets.normal,
    settings = function()
        local _color = bar_fg
        local _font = theme.font
        widget:set_markup(markup.fontfg(_font, _color, available))
    end,
}

local pacman_widget = wibox.widget {
    pacmanicon, theme.pacman.widget,
    layout = wibox.layout.align.horizontal,
}

pacman_widget:buttons(awful.button({ }, 1, function()
    theme.pacman.manual_update()
end))
--luacheck: pop

-- USERS
--luacheck: push ignore widget logged_in
local usersicon = wibox.widget.imagebox(theme.widget_users)
local users = widgets.users {
    settings = function()
        local _color = bar_fg
        local _font = theme.font

        if tonumber(logged_in) > 1 then
            _color = colors.red_2
            _font = theme.font
        end
        widget:set_markup(markup.fontfg(_font, _color, logged_in))
    end,
}

local users_widget = wibox.widget {
    usersicon, users.widget,
    layout = wibox.layout.align.horizontal,
}

users_widget:buttons(awful.button({ }, 1, function()
    awful.spawn.easy_async("users", function(stdout, stderr, reason, exit_code)
        if users_widget.notification then
            naughty.destroy(users_widget.notification)
        end
        users.update()
        users_widget.notification = naughty.notify {
            title = "Users",
            text = string.gsub(string.gsub(stdout, '\n*$', ''), ' ', '\n'),
            timeout = 10,
        }
    end)
end))
--luacheck: pop

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
--         local _color = bar_fg
--         local _font = theme.font
--
--         if tonumber(coretemp_now) >= 90 then
--             _color = colors.red_2
--             _font = theme.font
--         elseif tonumber(coretemp_now) >= 80 then
--             _color = colors.orange_2
--             _font = theme.font
--         elseif tonumber(coretemp_now) >= 70 then
--             _color = colors.yellow_2
--             _font = theme.font
--         end
--         widget:set_markup(markup.fontfg(_font, _color, coretemp_now))
--     end,
-- })

-- local temp_widget = wibox.widget {
--     tempicon, temp.widget,
--     layout = wibox.layout.align.horizontal,
-- }

-- -- FS
-- local fsicon = wibox.widget.imagebox(theme.widget_hdd)
-- theme.fs = lain.widget.fs({
--     options  = "--exclude-type=tmpfs",
--     notification_preset = { fg = bar_fg, bg = theme.border_normal, font = "xos4 Terminus 10" },
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, bar_fg, " " .. fs_now.available_gb .. "GB "))
--     end,
-- })

-- local fs_widget = wibox.widget {
--     fsicon, theme.fs.widget,
--     layout = wibox.layout.align.horizontal,
-- }

-- ALSA volume
--luacheck: push ignore widget volume_now vol_text volume_before
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa {
    -- togglechannel = "IEC958,3",
    settings = function()
        if volume_now.status == "off" then
            volicon:set_image(theme.widget_vol_mute)
        elseif tonumber(volume_now.level) == 0 then
            volicon:set_image(theme.widget_vol_no)
        elseif tonumber(volume_now.level) < 50 then
            volicon:set_image(theme.widget_vol_low)
        else
            volicon:set_image(theme.widget_vol)
        end

        widget:set_markup(markup.fontfg(theme.font, bar_fg, volume_now.level))

        if theme.volume.manual then
            if theme.volume.notification then
                naughty.destroy(theme.volume.notification)
            end

            if volume_now.status == "off" then
                vol_text = "Muted"
            else
                vol_text = " " .. volume_now.level .. "%"
            end

            if client.focus and client.focus.fullscreen or volume_now.status ~= volume_before then
                theme.volume.notification = naughty.notify {
                    title = "Audio",
                    text = vol_text,
                }
            end

            theme.volume.manual = false
        end
        volume_before = volume_now.status
    end,
}

-- Initial notification
theme.volume.manual = true
theme.volume.update()

local vol_widget = wibox.widget {
    volicon, theme.volume.widget,
    layout = wibox.layout.align.horizontal,
}

vol_widget:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async(string.format("amixer -q set %s toggle", theme.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            theme.volume.manual = true
            theme.volume.update()
        end)
    end),
    awful.button({ }, 4, function()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%-", theme.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            theme.volume.update()
        end)
    end),
    awful.button({ }, 5, function()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%+", theme.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused args
            theme.volume.update()
        end)
    end)
))
--luacheck: pop

-- BAT
--luacheck: push ignore widget bat_now

-- local battery_palette = widgets.widget_palette {
--     [10] = {
--         color = colors.red_2,
--         icon = theme.widget_battery_empty,
--     },
--     [20] = {
--         color = colors.orange_2,
--         icon = theme.widget_battery_low,
--     },
--     [30] = {
--         color = colors.yellow_2,
--         icon = theme.widget_battery_low,
--     },
--     [50] = {
--         color = bar_fg,
--         icon = theme.widget_battery_low,
--     },
--     [100] = {
--         color = bar_fg,
--         icon = theme.widget_battery,
--     }
-- }

local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat {
    notify = "off",
    batteries = context.vars.batteries,
    ac = context.vars.ac,
    settings = function()
        local _color = bar_fg
        local _font = theme.font

        if tonumber(bat_now.perc) <= 10 then
            baticon:set_image(theme.widget_battery_empty)
            _color = colors.red_2
            _font = theme.font
        elseif tonumber(bat_now.perc) <= 20 then
            baticon:set_image(theme.widget_battery_low)
            _color = colors.orange_2
            _font = theme.font
        elseif tonumber(bat_now.perc) <= 30 then
            baticon:set_image(theme.widget_battery_low)
            _color = colors.yellow_2
            _font = theme.font
        elseif tonumber(bat_now.perc) <= 50 then
            baticon:set_image(theme.widget_battery_low)
        else
            baticon:set_image(theme.widget_battery)
        end

        if tonumber(bat_now.perc) <= 3 and not bat_now.ac_status == 1 then
            if not bat_now.notification then
                bat_now.notification = naughty.notify {
                    title = "Battery",
                    text = "Your battery is running low.\n"
                        .. "You should plug in your PC.",
                    preset = naughty.config.presets.critical,
                    timeout = 0,
                }
            end
        end

        if bat_now.ac_status == 1 then
            baticon:set_image(theme.widget_ac)
            if tonumber(bat_now.perc) >= 95 then
                _color = colors.green_2
                _font = theme.font
            end
        end

        widget:set_markup(markup.fontfg(_font, _color, bat_now.perc))
    end,
}

local bat_widget = wibox.widget {
    baticon, bat.widget,
    layout = wibox.layout.align.horizontal,
}

bat_widget:buttons(awful.button({ }, 1, function()
    awful.spawn.easy_async(context.vars.scripts_dir .. "/show-battery-status", function(stdout, stderr, reason, exit_code)
        if bat_widget.notification then
            naughty.destroy(bat_widget.notification)
        end
        bat.update()
        bat_widget.notification = naughty.notify {
            title = "Battery",
            text = string.gsub(stdout, '\n*$', ''),
            timeout = 10,
        }
    end)
end))
--luacheck: pop

-- -- WEATHER
-- local weather = lain.widget.weather({
--     city_id = 2661604,
--     settings = function()
--         units = math.floor(weather_now["main"]["temp"])
--         widget:set_markup(markup.fontfg(theme.font, bar_fg, " " .. units .. "°C "))
--     end,
-- })

-- weather_widget = wibox.widget {
--     weather.icon, weather.widget,
--     layout = wibox.layout.align.horizontal,
-- }

-- NET
--luacheck: push ignore widget net_now
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net {
    wifi_state = "on",
    iface = context.vars.net_iface,
    notify = "off",
    units = 1048576, -- in MB/s (1024^2)
    -- units = 131072, -- in Mbit/s / Mbps (1024^2/8)
    settings = function()
        local _color = bar_fg
        local _font = theme.font

        if not net_now.state or net_now.state == "down" then
            _color = colors.red_2
            _font = theme.font
            widget:set_markup(markup.fontfg(_font, _color, " N/A "))
        else
            widget:set_markup(markup.fontfg(_font, _color, net_now.received .. " ↓↑ " .. net_now.sent))
        end
    end,
}

local net_widget = wibox.widget {
    net.widget,
    layout = wibox.layout.align.horizontal,
}

net_widget:buttons(awful.button({ }, 1, function()
    awful.spawn.easy_async(context.vars.scripts_dir .. "/show-ip-address", function(stdout, stderr, reason, exit_code)
        if net_widget.notification then
            naughty.destroy(net_widget.notification)
        end
        net.update()
        net_widget.notification = naughty.notify {
            title = "Network",
            text = string.gsub(stdout, '\n*$', ''),
            timeout = 10,
        }

        awful.spawn.easy_async(context.vars.scripts_dir .. "/show-ip-address -f", function(stdout, stderr, reason, exit_code)
            if net_widget.notification then
                naughty.destroy(net_widget.notification)
            end
            net.update()
            net_widget.notification = naughty.notify {
                title = "Network",
                text = string.gsub(stdout, '\n*$', ''),
                timeout = 10,
            }
        end)
    end)
end))
--luacheck: pop

-- Separators
local vert_sep = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "vertical",
    forced_width = 2,
    thickness = 2,
    color = theme.border_normal,
}

-- NOTE: This will be called after fully initializing the context-object, so
--       context.util etc. can be used here.
function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake {
        app = context.vars.terminal,
    }

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    -- gears.wallpaper.maximized(wallpaper, s, true)
    gears.wallpaper.tiled(wallpaper, s)

    -- Add tags if there are none
    if #s.tags == 0 then
        awful.tag(awful.util.tagnames, s, awful.util.layouts)
    end

    -- Create a promptbox for each screen
    s._promptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s._layoutbox = awful.widget.layoutbox(s)
    s._layoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function() awful.layout.inc( 1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc( 1) end),
        awful.button({ }, 5, function() awful.layout.inc(-1) end))
    )

    -- Create a taglist widget
    s._taglist = awful.widget.taglist(s, context.util.rowfilter, awful.util.taglist_buttons)

    local gen_tasklist = function()
        -- Create a tasklist widget
        s._tasklist = awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = awful.util.tasklist_buttons,
            bg_focus = theme.tasklist_bg_focus,
            style = {
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, theme.border_radius or 0)
                end,
                shape_border_width = dpi(0),
                shape_border_color = theme.tasklist_bg_normal,
            },
            widget_template = {
                {
                    {
                        {
                            layout = wibox.layout.fixed.horizontal,
                            {
                                id     = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                        },
                        halign = 'center',
                        valign = 'center',
                        widget = wibox.container.place,
                    },
                    left = 5,
                    right = 5,
                    widget = wibox.container.margin,
                },
                create_callback = function(self, c, index, objects) --luacheck: no unused args
                    local tooltip = awful.tooltip { --luacheck: no unused
                        objects = { self },
                        delay_show = 1,
                        timer_function = function()
                            return c.name
                        end,
                        align = "bottom",
                        mode = "outside",
                        preferred_positions = { "bottom" },
                    }
                end,
                id = 'background_role',
                widget = wibox.container.background,
            },
            layout = {
                layout = wibox.layout.flex.horizontal,
                spacing = 10,
                spacing_widget = {
                    vert_sep,
                    valign = 'center',
                    halign = 'center',
                    widget = wibox.container.place,
                },
            },
        }
    end

    -- For old version (Awesome v4.2)
    if not pcall(gen_tasklist) then
        -- Create a tasklist widget
        s._tasklist = awful.widget.tasklist(s,
        awful.widget.tasklist.filter.currenttags,
        awful.util.tasklist_buttons, {
            bg_focus = theme.tasklist_bg_focus,
            shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, theme.border_radius or 0)
                    end,
            shape_border_width = dpi(0),
            shape_border_color = theme.tasklist_bg_normal,
            align = "center" })
    end

    -- Create the wibox
    s._wibox = awful.wibar {
        position = "top",
        screen = s,
        height = dpi(25) + theme.border_width,
        fg = bar_fg,
        bg = bar_bg,
    }

    local systray_widget = wibox.widget {
        layout = wibox.layout.align.horizontal,
        vert_sep,
        {
            {
                layout = wibox.layout.align.horizontal,
                wibox.widget.systray(),
            },
            left = dpi(8),
            right = dpi(0),
            top = dpi(4),
            bottom = dpi(4),
            widget = wibox.container.margin,
        },
        visible = false,
    }
    context.util.show_on_mouse(s._wibox, systray_widget)

    -- Add widgets to the wibox
    s._wibox:setup {
        {
            layout = wibox.layout.flex.vertical,
            {
                layout = wibox.layout.align.horizontal,
                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,

                    { -- Layout box
                        {
                            {
                                layout = wibox.layout.align.horizontal,
                                s._layoutbox,
                            },
                            left = dpi(8),
                            right = dpi(3),
                            top = dpi(5),
                            bottom = dpi(5),
                            widget = wibox.container.margin,
                        },
                        bg = bar_bg,
                        widget = wibox.container.background,
                    },

                    { -- Taglist
                        {
                            {
                                layout = wibox.layout.align.horizontal,
                                s._taglist,
                            },
                            left = dpi(3),
                            right = dpi(8),
                            widget = wibox.container.margin,
                        },
                        bg = bar_bg,
                        widget = wibox.container.background,
                    },

                    vert_sep,

                    { -- Prompt box
                        {
                            {
                                layout = wibox.layout.align.horizontal,
                                s._promptbox,
                            },
                            left = dpi(6),
                            right = dpi(6),
                            widget = wibox.container.margin,
                        },
                        bg = theme.prompt_bg,
                        widget = wibox.container.background,
                    },

                    vert_sep,
                },

                -- Middle widget
                { -- Tasklist
                    {
                        {
                            layout = wibox.layout.flex.horizontal,
                            s._tasklist,
                        },
                        left = dpi(8),
                        right = dpi(0),
                        widget = wibox.container.margin,
                    },
                    bg = bar_bg,
                    widget = wibox.container.background,
                },

                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,

                    wibox.container.background(wibox.container.margin(systray_widget, dpi(0), dpi(8)), bar_bg),

                    vert_sep,
                    -- wibox.container.background(wibox.container.margin(fs_widget,      dpi(2), dpi(6)), bar_bg),
                    -- wibox.container.background(wibox.container.margin(temp_widget,    dpi(2), dpi(6)), bar_bg),
                    wibox.container.background(wibox.container.margin(pacman_widget,  dpi(2), dpi(6)),  bar_bg),
                    wibox.container.background(wibox.container.margin(users_widget,   dpi(2), dpi(6)),  bar_bg),
                    wibox.container.background(wibox.container.margin(sysload_widget, dpi(2), dpi(6)),  bar_bg),
                    wibox.container.background(wibox.container.margin(cpu_widget,     dpi(2), dpi(6)),  bar_bg),
                    wibox.container.background(wibox.container.margin(mem_widget,     dpi(2), dpi(6)),  bar_bg),
                    wibox.container.background(wibox.container.margin(vol_widget,     dpi(2), dpi(6)),  bar_bg),
                    wibox.container.background(wibox.container.margin(bat_widget,     dpi(2), dpi(10)), bar_bg),

                    vert_sep,
                    wibox.container.background(wibox.container.margin(net_widget,     dpi(8), dpi(10)), bar_bg),

                    vert_sep,
                    wibox.container.background(wibox.container.margin(clock_widget,   dpi(8), dpi(8)),  bar_bg),
                },
            },
        },
        bottom = theme.border_width,
        color = theme.border_normal,
        widget = wibox.container.margin,
    }
end

return theme
