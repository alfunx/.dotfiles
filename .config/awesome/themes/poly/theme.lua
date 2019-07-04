
--[[

     Poly
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
local os, math, string = os, math, string

local context          = require("config.context")
local util             = require("config.util")
local tags             = require("config.tags")
local taglist_binds    = require("config.bindings_taglist")
local tasklist_binds   = require("config.bindings_tasklist")

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

colors = util.set_colors(colors)

local bar_fg            = colors.bw_5
local bar_bg            = colors.bw_0

local theme = { }
theme.name = "poly"
theme.dir = string.format("%s/.config/awesome/themes/%s", os.getenv("HOME"), theme.name)

-- theme.wallpaper                                 = theme.dir .. "/wallpapers/wall.png"
-- theme.wallpaper                                 = theme.dir .. "/wallpapers/escheresque.png"
-- theme.wallpaper_fn                              = gears.wallpaper.tiled

-- theme.wallpaper_original                        = theme.dir .. "/wallpapers/matterhorn.jpg"
-- theme.wallpaper                                 = theme.dir .. "/wallpapers/matterhorn_base.jpg"
-- theme.wallpaper_blur                            = theme.dir .. "/wallpapers/matterhorn_blur.jpg"
-- theme.wallpaper_offset                          = 0

local font_name                                 = "monospace"
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

theme.hotkeys_border_width                      = 30
theme.hotkeys_border_color                      = colors.bw_0
theme.hotkeys_group_margin                      = 30
theme.hotkeys_shape                             = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, 20)
                                                  end

theme.prompt_bg                                 = colors.bw_0
theme.prompt_fg                                 = theme.fg_normal
theme.bg_systray                                = theme.tasklist_bg_normal

theme.border_width                              = 4
-- theme.border_radius                             = 8
theme.border_radius                             = 0
theme.menu_height                               = 20
theme.menu_width                                = 250
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_spacing                          = 3
theme.useless_gap                               = 16
theme.systray_icon_spacing                      = 4

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
theme.widget_clock                              = theme.dir .. "/icons/clock.png"
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
theme.notification_icon_size                    = 80
theme.notification_opacity                      = 1
theme.notification_max_width                    = 600
theme.notification_max_height                   = 400
theme.notification_margin                       = 20
theme.notification_shape                        = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, theme.border_radius or 0)
                                                  end

naughty.config.padding                          = 15
naughty.config.spacing                          = 10
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

-- Spacing
local space = wibox.widget {
    forced_width = theme.useless_gap * 2,
    thickness = theme.useless_gap * 2,
    color = "#00000000",
    widget = wibox.widget.separator,
}

-- Separator
local vert_sep = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "vertical",
    forced_width = theme.border_width,
    thickness = theme.border_width,
    color = theme.border_normal,
}

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    -- "date +'%a %d %b %R'", 60,
    "date +'%R'", 5,
    function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font_bold, colors.bw_0, stdout))
    end
)

local clock_widget = wibox.widget {
    {
        {
            clockicon,
            bg = theme.border_normal,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                clock,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.white_1,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
    },
    top = theme.border_width,
    bottom = theme.border_width,
    left = theme.border_width,
    right = theme.border_width,
    color = theme.border_normal,
    widget = wibox.container.margin,
}

-- Calendar
theme.cal = lain.widget.cal {
    cal = "cal --color=always --monday",
    attach_to = { clock_widget },
    icons = "",
    notification_preset = naughty.config.presets.normal,
}

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

-- -- MEM
-- --luacheck: push ignore widget mem_now
-- local memicon = wibox.widget.imagebox(theme.widget_mem)
-- local mem = lain.widget.mem {
--     timeout = 5,
--     settings = function()
--         local _color = colors.bw_0
--         local _font = theme.font_bold
--         widget:set_markup(markup.fontfg(_font, _color, mem_now.perc))
--
--         widget.used  = mem_now.used
--         widget.total = mem_now.total
--         widget.free  = mem_now.free
--         widget.buf   = mem_now.buf
--         widget.cache = mem_now.cache
--         widget.swap  = mem_now.swap
--         widget.swapf = mem_now.swapf
--         widget.srec  = mem_now.srec
--     end,
-- }
--
-- local mem_widget = wibox.widget {
--     memicon, mem.widget,
--     layout = wibox.layout.align.horizontal,
-- }
--
-- mem_widget:buttons(awful.button({ }, 1, function()
--     if mem_widget.notification then
--         naughty.destroy(mem_widget.notification)
--     end
--     mem.update()
--     mem_widget.notification = naughty.notify {
--         title = "Memory",
--         text = string.format("Total:  %.2fGB\n", tonumber(mem.widget.total) / 1024 + 0.5)
--             .. string.format("Used:   %.2fGB\n", tonumber(mem.widget.used ) / 1024 + 0.5)
--             .. string.format("Free:   %.2fGB\n", tonumber(mem.widget.free ) / 1024 + 0.5)
--             .. string.format("Buffer: %.2fGB\n", tonumber(mem.widget.buf  ) / 1024 + 0.5)
--             .. string.format("Cache:  %.2fGB\n", tonumber(mem.widget.cache) / 1024 + 0.5)
--             .. string.format("Swap:   %.2fGB\n", tonumber(mem.widget.swap ) / 1024 + 0.5)
--             .. string.format("Swapf:  %.2fGB\n", tonumber(mem.widget.swapf) / 1024 + 0.5)
--             .. string.format("Srec:   %.2fGB"  , tonumber(mem.widget.srec ) / 1024 + 0.5),
--         timeout = 10,
--     }
-- end))
-- --luacheck: pop

-- -- CPU
-- --luacheck: push ignore widget cpu_now
-- local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
-- local cpu = lain.widget.cpu {
--     timeout = 5,
--     settings = function()
--         local _color = colors.bw_0
--         local _font = theme.font_bold
--         widget:set_markup(markup.fontfg(_font, _color, cpu_now.usage))
--
--         widget.core  = cpu_now
--     end,
-- }
--
-- local cpu_widget = wibox.widget {
--     cpuicon, cpu.widget,
--     layout = wibox.layout.align.horizontal,
-- }
--
-- cpu_widget:buttons(awful.button({ }, 1, function()
--     if cpu_widget.notification then
--         naughty.destroy(cpu_widget.notification)
--     end
--     cpu.update()
--     cpu_widget.notification = naughty.notify {
--         title = "CPU",
--         text = string.format("Core 1: %d%%\n", cpu.widget.core[0].usage)
--             .. string.format("Core 2: %d%%\n", cpu.widget.core[1].usage)
--             .. string.format("Core 3: %d%%\n", cpu.widget.core[2].usage)
--             .. string.format("Core 4: %d%%"  , cpu.widget.core[3].usage),
--         timeout = 10,
--     }
-- end))
-- --luacheck: pop

-- SYSLOAD
--luacheck: push ignore widget load_1 load_5 load_15
local sysloadicon = wibox.widget.imagebox(theme.widget_hdd)
local sysload = lain.widget.sysload {
    timeout = 5,
    settings = function()
        local _color = colors.bw_0
        local _font = theme.font_bold

        -- check with: grep 'model name' /proc/cpuinfo | wc -l
        local number_of_cores = 4

        widget:set_markup(markup.fontfg(_font, _color, load_5))

        widget.load_1  = load_1
        widget.load_5  = load_5
        widget.load_15 = load_15
    end,
}

local sysload_widget = wibox.widget {
    {
        {
            sysloadicon,
            bg = theme.border_normal,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                sysload.widget,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.blue_1,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
    },
    top = theme.border_width,
    bottom = theme.border_width,
    left = theme.border_width,
    right = theme.border_width,
    color = theme.border_normal,
    widget = wibox.container.margin,
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
        local _color = colors.bw_0
        local _font = theme.font_bold
        widget:set_markup(markup.fontfg(_font, _color, available))
    end,
}

local pacman_widget = wibox.widget {
    {
        {
            pacmanicon,
            bg = theme.border_normal,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                theme.pacman.widget,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.purple_1,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
    },
    top = theme.border_width,
    bottom = theme.border_width,
    left = theme.border_width,
    right = theme.border_width,
    color = theme.border_normal,
    widget = wibox.container.margin,
}

pacman_widget:buttons(awful.button({ }, 1, function()
    theme.pacman.manual_update()
end))
--luacheck: pop

-- -- USERS
-- --luacheck: push ignore widget logged_in
-- local usersicon = wibox.widget.imagebox(theme.widget_users)
-- local users = widgets.users {
--     settings = function()
--         local _color = colors.bw_0
--         local _font = theme.font_bold
--         widget:set_markup(markup.fontfg(_font, _color, logged_in))
--     end,
-- }
--
-- local users_widget = wibox.widget {
--     usersicon, users.widget,
--     layout = wibox.layout.align.horizontal,
-- }
--
-- users_widget:buttons(awful.button({ }, 1, function()
--     awful.spawn.easy_async("users", function(stdout, stderr, reason, exit_code)
--         if users_widget.notification then
--             naughty.destroy(users_widget.notification)
--         end
--         users.update()
--         users_widget.notification = naughty.notify {
--             title = "Users",
--             text = string.gsub(string.gsub(stdout, '\n*$', ''), ' ', '\n'),
--             timeout = 10,
--         }
--     end)
-- end))
-- --luacheck: pop

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

        local _color = colors.bw_0
        local _font = theme.font_bold
        widget:set_markup(markup.fontfg(_font, _color, volume_now.level))

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
    {
        {
            volicon,
            bg = theme.border_normal,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                theme.volume.widget,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.aqua_1,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
    },
    top = theme.border_width,
    bottom = theme.border_width,
    left = theme.border_width,
    right = theme.border_width,
    color = theme.border_normal,
    widget = wibox.container.margin,
}

vol_widget:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async(string.format("amixer -q set %s toggle", theme.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused
            theme.volume.manual = true
            theme.volume.update()
        end)
    end),
    awful.button({ }, 4, function()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%-", theme.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused
            theme.volume.update()
        end)
    end),
    awful.button({ }, 5, function()
        awful.spawn.easy_async(string.format("amixer -q set %s 1%%+", theme.volume.channel),
        function(stdout, stderr, reason, exit_code) --luacheck: no unused
            theme.volume.update()
        end)
    end)
))
--luacheck: pop

-- BAT
--luacheck: push ignore widget bat_now
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat {
    notify = "off",
    batteries = context.vars.batteries,
    ac = context.vars.ac,
    settings = function()
        local _color = colors.bw_0
        local _font = theme.font_bold

        if tonumber(bat_now.perc) <= 10 then
            baticon:set_image(theme.widget_battery_empty)
        elseif tonumber(bat_now.perc) <= 20 then
            baticon:set_image(theme.widget_battery_low)
        elseif tonumber(bat_now.perc) <= 30 then
            baticon:set_image(theme.widget_battery_low)
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
        end

        widget:set_markup(markup.fontfg(_font, _color, bat_now.perc))
    end,
}

local bat_widget = wibox.widget {
    {
        {
            baticon,
            bg = theme.border_normal,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                bat.widget,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.green_1,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
    },
    top = theme.border_width,
    bottom = theme.border_width,
    left = theme.border_width,
    right = theme.border_width,
    color = theme.border_normal,
    widget = wibox.container.margin,
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

-- NET
--luacheck: push ignore widget net_now
local neticon = wibox.widget.imagebox(theme.widget_net)
local net_up = lain.widget.net {
    wifi_state = "on",
    iface = context.vars.net_iface,
    notify = "off",
    units = 1048576, -- in MB/s (1024^2)
    -- units = 131072, -- in Mbit/s / Mbps (1024^2/8)
    settings = function()
        local _color = colors.bw_0
        local _font = theme.font_bold
        if not net_now.state or net_now.state == "down" then
            widget:set_markup(markup.fontfg(_font, _color, " - "))
        else
            widget:set_markup(markup.fontfg(_font, _color, net_now.sent))
        end
    end,
}
local net_down = lain.widget.net {
    wifi_state = "on",
    iface = context.vars.net_iface,
    notify = "off",
    units = 1048576, -- in MB/s (1024^2)
    -- units = 131072, -- in Mbit/s / Mbps (1024^2/8)
    settings = function()
        local _color = colors.bw_0
        local _font = theme.font_bold
        if not net_now.state or net_now.state == "down" then
            widget:set_markup(markup.fontfg(_font, _color, " - "))
        else
            widget:set_markup(markup.fontfg(_font, _color, net_now.received))
        end
    end,
}

local net_widget = wibox.widget {
    {
        {
            {
                net_down.widget,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.yellow_1,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                markup = markup.fontfg(theme.font_bold, bar_fg, "↓↑"),
                widget = wibox.widget.textbox,
            },
            bg = theme.border_normal,
            widget = wibox.container.background,
        },
        vert_sep,
        {
            {
                net_up.widget,
                top = theme.border_width,
                bottom = theme.border_width,
                left = theme.border_width + 2,
                right = theme.border_width + 2,
                widget = wibox.container.margin,
            },
            bg = colors.yellow_1,
            widget = wibox.container.background,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    top = theme.border_width,
    bottom = theme.border_width,
    left = theme.border_width,
    right = theme.border_width,
    color = theme.border_normal,
    widget = wibox.container.margin,
}

net_widget:buttons(awful.button({ }, 1, function()
    awful.spawn.easy_async(context.vars.scripts_dir .. "/show-ip-address", function(stdout, stderr, reason, exit_code)
        if net_widget.notification then
            naughty.destroy(net_widget.notification)
        end
        net_up.update()
        net_down.update()
        net_widget.notification = naughty.notify {
            title = "Network",
            text = string.gsub(stdout, '\n*$', ''),
            timeout = 10,
        }

        awful.spawn.easy_async(context.vars.scripts_dir .. "/show-ip-address -f", function(stdout, stderr, reason, exit_code)
            if net_widget.notification then
                naughty.destroy(net_widget.notification)
            end
            net_up.update()
            net_down.update()
            net_widget.notification = naughty.notify {
                title = "Network",
                text = string.gsub(stdout, '\n*$', ''),
                timeout = 10,
            }
        end)
    end)
end))
--luacheck: pop

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
        awful.tag(tags.names, s, tags.layouts)
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
    s._taglist = awful.widget.taglist(s, util.rowfilter, taglist_binds.buttons)

    local gen_tasklist = function()
        -- Create a tasklist widget
        s._tasklist = awful.widget.tasklist {
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,
            buttons = tasklist_binds.buttons,
            bg_focus = theme.tasklist_bg_focus,
            style = {
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, theme.border_radius or 0)
                end,
                shape_border_width = 0,
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
                create_callback = function(self, c, index, objects) --luacheck: no unused
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
        tasklist_binds.buttons, {
            bg_focus = theme.tasklist_bg_focus,
            shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, theme.border_radius or 0)
                    end,
            shape_border_width = 0,
            shape_border_color = theme.tasklist_bg_normal,
            align = "center" })
    end

    -- Create the wibox
    s._wibox = awful.wibar {
        position = "top",
        screen = s,
        height = 30 + theme.useless_gap * 1.5,
        fg = bar_fg,
        bg = "#00000000",
    }

    local systray_widget = wibox.widget {
        layout = wibox.layout.align.horizontal,
        {
            {
                layout = wibox.layout.align.horizontal,
                wibox.widget.systray(),
            },
            right = 12,
            top = 6,
            bottom = 6,
            widget = wibox.container.margin,
        },
        visible = false,
    }
    util.show_on_mouse(s._wibox, systray_widget)

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
                                s._layoutbox,
                                margins = 3,
                                widget = wibox.container.margin,
                            },
                            bg = colors.bw_0,
                            widget = wibox.container.background,
                        },
                        top = theme.border_width,
                        bottom = theme.border_width,
                        left = theme.border_width,
                        right = theme.border_width,
                        color = theme.border_normal,
                        widget = wibox.container.margin,
                    },

                    space,

                    { -- Taglist
                        {
                            {
                                s._taglist,
                                left = 5,
                                right = 5,
                                widget = wibox.container.margin,
                            },
                            bg = colors.bw_0,
                            widget = wibox.container.background,
                        },
                        top = theme.border_width,
                        bottom = theme.border_width,
                        left = theme.border_width,
                        right = theme.border_width,
                        color = theme.border_normal,
                        widget = wibox.container.margin,
                    },

                    space,

                    { -- Prompt box
                        {
                            s._promptbox,
                            left = 5,
                            right = 5,
                            widget = wibox.container.margin,
                        },
                        top = theme.border_width,
                        bottom = theme.border_width,
                        left = theme.border_width,
                        right = theme.border_width,
                        widget = wibox.container.margin,
                    },
                },

                -- Middle widget
                {
                    layout = wibox.layout.flex.horizontal,
                },

                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,

                    systray_widget,
                    space,
                    pacman_widget,
                    space,
                    sysload_widget,
                    space,
                    vol_widget,
                    space,
                    bat_widget,
                    space,
                    net_widget,
                    space,
                    clock_widget
                },
            },
        },
        top = theme.useless_gap * 1.5,
        left = theme.useless_gap * 2,
        right = theme.useless_gap * 2,
        widget = wibox.container.margin,
    }
end

return theme
