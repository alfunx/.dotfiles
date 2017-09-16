
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

-- local fs_bg_normal    = bw7
-- local temp_bg_normal  = bw6
local cpu_bg_normal   = bw5
local mem_bg_normal   = bw4
local vol_bg_normal   = bw3
local bat_bg_normal   = bw2
local net_bg_normal   = bw1
local clock_bg_normal = bw0

local gears            = require("gears")
local lain             = require("lain")
local custom_widget    = require("themes.powerarrow-gruvbox.widgets")
local awful            = require("awful")
local wibox            = require("wibox")
local os, math, string = os, math, string

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-gruvbox"
theme.wallpaper                                 = theme.dir .. "/wallpapers/wall.png"

local font_name                                 = "Meslo LG S for Powerline"
-- local font_name                                 = "Source Code Pro for Powerline"
local font_size                                 = "11"
theme.font                                      = font_name .. " " ..                         font_size
theme.font_bold                                 = font_name .. " " .. "Bold"        .. " " .. font_size
theme.font_italic                               = font_name .. " " .. "Italic"      .. " " .. font_size
theme.font_bold_italic                          = font_name .. " " .. "Bold Italic" .. " " .. font_size

theme.border_normal                             = bw0
theme.border_focus                              = bw10
theme.border_marked                             = red_light

theme.fg_normal                                 = bw9
theme.fg_focus                                  = red_light
theme.fg_urgent                                 = bw0
theme.bg_normal                                 = bw5
theme.bg_normal                                 = bw0
theme.bg_focus                                  = bw3
theme.bg_urgent                                 = red_light

theme.notification_margin                       = 100
theme.notification_opacity                      = 70

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
theme.tasklist_font_minimized                   = theme.font_italic
theme.tasklist_font_urgent                      = theme.font_italic
theme.tasklist_fg_normal                        = textcolor_dark
theme.tasklist_fg_focus                         = textcolor_dark
theme.tasklist_fg_urgent                        = textcolor_dark
theme.tasklist_bg_normal                        = bw6
theme.tasklist_bg_focus                         = bw8
theme.tasklist_bg_urgent                        = red_light

theme.titlebar_bg_normal                        = theme.border_normal
theme.titlebar_bg_focus                         = theme.border_focus
theme.titlebar_bg_marked                        = theme.border_marked

theme.prompt_bg                                 = bw3
theme.prompt_fg                                 = textcolor_light
theme.bg_systray                                = theme.tasklist_bg_normal

theme.border_width                              = 2
theme.menu_height                               = 20
theme.menu_width                                = 250
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 3
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
    "date +'%R'", 60,
    function(widget, stdout)
        widget:set_markup(markup.fontfg(theme.font_bold, textcolor_light, " " .. stdout))
    end
)

-- -- Binary clock
-- local binclock = require("themes.powerarrow.binclock"){
--     height = 21,
--     show_seconds = false,
--     color_active = theme.fg_normal,
--     color_inactive = theme.bg_focus
-- }

-- Calendar
theme.cal = lain.widget.calendar({
    cal = "cal --color=always --monday",
    -- attach_to = { binclock.widget },
    attach_to = { clock },
    icons = "",
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- -- Taskwarrior
-- local task = wibox.widget.imagebox(theme.widget_task)
-- lain.widget.contrib.task.attach(task, {
--     -- do not colorize output
--     show_cmd = "task | sed -r 's/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g'"
-- })
-- task:buttons(awful.util.table.join(awful.button({}, 1, lain.widget.contrib.task.prompt)))

-- -- Scissors (xsel copy and paste)
-- local scissors = wibox.widget.imagebox(theme.widget_scissors)
-- scissors:buttons(awful.util.table.join(awful.button({}, 1, function() awful.spawn("xsel | xsel -i -b") end)))

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

-- -- MPD
-- local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
-- local mpdicon = wibox.widget.imagebox(theme.widget_music)
-- mpdicon:buttons(awful.util.table.join(
--     awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
--     awful.button({ }, 1, function ()
--         awful.spawn.with_shell("mpc prev")
--         theme.mpd.update()
--     end),
--     awful.button({ }, 2, function ()
--         awful.spawn.with_shell("mpc toggle")
--         theme.mpd.update()
--     end),
--     awful.button({ }, 3, function ()
--         awful.spawn.with_shell("mpc next")
--         theme.mpd.update()
--     end)))
-- theme.mpd = lain.widget.mpd({
--     settings = function()
--         if mpd_now.state == "play" then
--             artist = " " .. mpd_now.artist .. " "
--             title  = mpd_now.title  .. " "
--             mpdicon:set_image(theme.widget_music_on)
--             widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
--         elseif mpd_now.state == "pause" then
--             widget:set_markup(markup.font(theme.font, " mpd paused "))
--             mpdicon:set_image(theme.widget_music_pause)
--         else
--             widget:set_text("")
--             mpdicon:set_image(theme.widget_music)
--         end
--     end
-- })

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        local mem_bg_normal_text = textcolor_light
        local mem_bg_normal_font = theme.font

        if tonumber(mem_now.perc) >= 90 then
            mem_bg_normal_text = red_light
            mem_bg_normal_font = theme.font_bold
        elseif tonumber(mem_now.perc) >= 80 then
            mem_bg_normal_text = orange_light
            mem_bg_normal_font = theme.font_bold
        elseif tonumber(mem_now.perc) >= 70 then
            mem_bg_normal_text = yellow_light
            mem_bg_normal_font = theme.font_bold
        end

        widget:set_markup(markup.fontfg(mem_bg_normal_font, mem_bg_normal_text, " " .. mem_now.used .. "MB "))
    end
})

-- mem:buttons(awful.util.table.join(
--     awful.button({   }, 1, awful.tag.viewnext),
-- ))

-- mem:buttons(awful.util.table.join(
--             awful.button({}, 1, os.execute("ranger")),
--             awful.button({}, 3, os.execute("glances"))))

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        local cpu_bg_normal_text = textcolor_light
        local cpu_bg_normal_font = theme.font

        if tonumber(cpu_now.usage) >= 90 then
            cpu_bg_normal_text = red_light
            cpu_bg_normal_font = theme.font_bold
        elseif tonumber(cpu_now.usage) >= 80 then
            cpu_bg_normal_text = orange_light
            cpu_bg_normal_font = theme.font_bold
        elseif tonumber(cpu_now.usage) >= 70 then
            cpu_bg_normal_text = yellow_light
            cpu_bg_normal_font = theme.font_bold
        end

        widget:set_markup(markup.fontfg(cpu_bg_normal_font, cpu_bg_normal_text, " " .. cpu_now.usage .. "% "))
    end
})

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
-- local temp = lain.widget.temp({
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, textcolor_light, " " .. coretemp_now .. "°C "))
--     end
-- })
-- --]]
-- local tempicon = wibox.widget.imagebox(theme.widget_temp)

-- -- FS
-- local fsicon = wibox.widget.imagebox(theme.widget_hdd)
-- theme.fs = lain.widget.fs({
--     options  = "--exclude-type=tmpfs",
--     notification_preset = { fg = theme.fg_normal, bg = theme.border_normal, font = "xos4 Terminus 10" },
--     settings = function()
--         widget:set_markup(markup.fontfg(theme.font, textcolor_light, " " .. fs_now.available_gb .. "GB "))
--     end
-- })

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    -- togglechannel = "IEC958,3",
    -- notification_preset = { font = "xos4 Terminus 10", fg = theme.fg_normal },
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

        widget:set_markup(markup.fontfg(theme.font, textcolor_light, " " .. volume_now.level .. "% "))
    end,
})

theme.volume_click = custom_widget.eventhandler({
    attach_to = { theme.volume.widget },
    execute = function() awful.spawn("termite -e \"alsamixer\"") end,
})

-- BAT
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    settings = function()
        local bat_bg_normal_text = textcolor_light
        local bat_bg_normal_font = theme.font

        if bat_now.ac_status == 1 then
            baticon:set_image(theme.widget_ac)
        elseif tonumber(bat_now.perc) <= 10 then
            baticon:set_image(theme.widget_battery_empty)
            bat_bg_normal_text = red_light
            bat_bg_normal_font = theme.font_bold
        elseif tonumber(bat_now.perc) <= 20 then
            baticon:set_image(theme.widget_battery_low)
            bat_bg_normal_text = orange_light
            bat_bg_normal_font = theme.font_bold
        elseif tonumber(bat_now.perc) <= 30 then
            baticon:set_image(theme.widget_battery_low)
            bat_bg_normal_text = yellow_light
            bat_bg_normal_font = theme.font_bold
        elseif tonumber(bat_now.perc) <= 50 then
            baticon:set_image(theme.widget_battery_low)
        else
            baticon:set_image(theme.widget_battery)
        end

        widget:set_markup(markup.fontfg(bat_bg_normal_font, bat_bg_normal_text, " " .. bat_now.perc .. "% "))
    end,
    notify = "off",
    batteries = {"BAT0"},
    ac = "AC"
})

-- theme.bat_hover = awful.tooltip({
--     objects = { bat.widget },
--     margin_leftright = 10,
--     margin_topbottom = 20,
--     shape = gears.shape.infobubble,
--     -- timer_function = function() return "hello" end
--     -- timer_function = awful.spawn.easy_async("/home/amariya/scripts/battery.sh", function(stdout, stderr, reason, exit_code)
--     --     text = stdout, height = 31, timeout = 0
--     -- end)
-- })

theme.bat_hover = custom_widget.eventhandler({
    attach_to = { bat.widget },
    attach = eventhandler.attach_hover,
    execute = function()
        awful.spawn.easy_async("/home/amariya/scripts/battery.sh", function(stdout, stderr, reason, exit_code)
            eventhandler.notify {
                text = stdout, height = 31, timeout = 0
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

-- NET
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        local net_bg_normal_text = textcolor_light
        local net_bg_normal_font = theme.font

        if net_now.state == nil or (net_now.state ~= nil and net_now.state == "down") then
            net_bg_normal_text = red_light
            net_bg_normal_font = theme.font_bold
            widget:set_markup(markup.fontfg(net_bg_normal_font, net_bg_normal_text, " N/A "))
        else
            widget:set_markup(markup.fontfg(net_bg_normal_font, net_bg_normal_text, " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
        end
    end,
    notify = "off",
    units = 1048576, -- in MB (1024^2)
    -- units = 131072, -- in mbps (1024^2/8)
})

-- net.widget:buttons(awful.table.join(
--     awful.button({}, 1, awful.spawn("termite"))
-- ))

theme.net_click = custom_widget.eventhandler({
    attach_to = { net.widget },
    execute = function() awful.spawn("termite -e \"sudo wifi-menu\"") end,
})

theme.net_hover = custom_widget.eventhandler({
    attach_to = { net.widget },
    attach = eventhandler.attach_hover,
    execute = function()
        awful.spawn.easy_async("/home/amariya/scripts/ip_address.sh", function(stdout, stderr, reason, exit_code)
            eventhandler.notify {
                text = stdout, timeout = 0
            }
        end)
    end
})

-- net.buttons = awful.util.table.join(
--                     awful.button({ }, 1, os.execute("ranger")),
--                     awful.button({ modkey }, 1, awful.client.movetotag),
--                     awful.button({ }, 3, awful.tag.viewtoggle),
--                     awful.button({ modkey }, 3, awful.client.toggletag),
--                     awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
--                     awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
--                     )

-- SEPARATORS
local arrow = separators.arrow_left
local arrow_r = separators.arrow_right

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
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
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s,
    awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, {
      bg_focus = theme.tasklist_bg_focus, shape = gears.shape.octogon,
      shape_border_width = 0, shape_border_color = theme.tasklist_bg_normal,
      align = "center" })

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 21, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,

        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            wibox.container.background(wibox.container.margin(wibox.widget { s.mylayoutbox, layout = wibox.layout.align.horizontal }, 7, 3, 3, 3), clock_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { s.mytaglist, layout = wibox.layout.align.horizontal }, 3, 8), theme.taglist_bg_normal),
            arrow_r(theme.taglist_bg_normal, theme.prompt_bg),
            wibox.container.background(wibox.container.margin(wibox.widget { s.mypromptbox, layout = wibox.layout.align.horizontal }, 8, 4), theme.prompt_bg),
            arrow_r(theme.prompt_bg, theme.tasklist_bg_normal),
            spr,
        },

        -- s.mytasklist, -- Middle widget
        wibox.container.background(wibox.container.margin(s.mytasklist, 8, 0), theme.tasklist_bg_normal),

        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(wibox.container.margin(wibox.widget { nil, wibox.widget.systray(), layout = wibox.layout.align.horizontal }, 4, 8, 3, 3), theme.tasklist_bg_normal),
            -- wibox.container.margin(scissors, 4, 8),

            --[[ using shapes
            pl(wibox.widget { mpdicon, theme.mpd.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(task, "#343434"),
            --pl(wibox.widget { mailicon, mail and mail.widget, layout = wibox.layout.align.horizontal }, "#343434"),
            pl(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, "#777E76"),
            pl(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, "#4B696D"),
            pl(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, "#4B3B51"),
            pl(wibox.widget { fsicon, theme.fs.widget, layout = wibox.layout.align.horizontal }, "#CB755B"),
            pl(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, "#8DAA9A"),
            pl(wibox.widget { neticon, net.widget, layout = wibox.layout.align.horizontal }, "#C0C0A2"),
            pl(binclock.widget, "#777E76"),
            --]]

            -- wibox.container.background(wibox.container.margin(wibox.widget { weather.icon, weather.widget, layout = wibox.layout.align.horizontal }, 4, 2), cpu_bg_normal),

            -- using separators
            -- arrow(theme.bg_normal, fs_bg_normal),
            -- wibox.container.background(wibox.container.margin(wibox.widget { fsicon, theme.fs.widget, layout = wibox.layout.align.horizontal }, 4, 2), fs_bg_normal),
            -- arrow(fs_bg_normal, temp_bg_normal),
            -- wibox.container.background(wibox.container.margin(wibox.widget { tempicon, temp.widget, layout = wibox.layout.align.horizontal }, 4, 2), temp_bg_normal),
            -- arrow(temp_bg_normal, cpu_bg_normal),
            arrow(theme.tasklist_bg_normal, cpu_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { cpuicon, cpu.widget, layout = wibox.layout.align.horizontal }, 4, 2), cpu_bg_normal),
            arrow(cpu_bg_normal, mem_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 4, 2), mem_bg_normal),
            arrow(mem_bg_normal, vol_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { volicon, theme.volume.widget, layout = wibox.layout.align.horizontal }, 4, 2), vol_bg_normal),
            arrow(vol_bg_normal, bat_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, 4, 2), bat_bg_normal),
            arrow(bat_bg_normal, net_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }, 4, 2), net_bg_normal),
            arrow(net_bg_normal, clock_bg_normal),
            -- wibox.container.background(wibox.container.margin(binclock.widget, 4, 8), clock_bg_normal),
            wibox.container.background(wibox.container.margin(wibox.widget { clock, layout = wibox.layout.align.horizontal }, 0, 8), clock_bg_normal),
            --]]
        },
    }
end

return theme
