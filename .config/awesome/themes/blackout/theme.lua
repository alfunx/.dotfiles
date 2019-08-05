
--[[

     Blackout
     by alfunx (Alphonse Mariya)

--]]

local awful            = require("awful")
local cairo            = require("lgi").cairo
local gears            = require("gears")
local lain             = require("lain")
local naughty          = require("naughty")
local theme_assets     = require("beautiful.theme_assets")
local wibox            = require("wibox")
local os, math, string = os, math, string

local context          = require("config.context")
local brokers          = require("config.brokers")
local util             = require("config.util")
local t_util           = require("config.util_theme")
local taglist_binds    = require("config.bindings_taglist")
local tasklist_binds   = require("config.bindings_tasklist")

local unit             = require("yaawl.util.unit")

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

colors = t_util.set_colors(colors)

local bar_fg            = colors.bw_5
local bar_bg            = colors.bw_0

local theme = { }
theme.name = "blackout"
theme.alternative = "whiteout"
theme.dir = string.format("%s/.config/awesome/themes/%s", os.getenv("HOME"), theme.name)

-- theme.wallpaper                                 = theme.dir .. "/wallpapers/wall.png"
theme.wallpaper                                 = theme.dir .. "/wallpapers/escheresque.png"
theme.wallpaper_fn                              = gears.wallpaper.tiled

-- theme.wallpaper_original                        = theme.dir .. "/wallpapers/matterhorn.jpg"
-- theme.wallpaper                                 = theme.dir .. "/wallpapers/matterhorn_base.jpg"
-- theme.wallpaper_blur                            = theme.dir .. "/wallpapers/matterhorn_blur.jpg"

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

theme.titlebar_fg_normal                        = colors.bw_5
theme.titlebar_fg_focus                         = colors.bw_8
theme.titlebar_fg_marked                        = colors.bw_8
theme.titlebar_fg_urgent                        = colors.red_2
theme.titlebar_bg_normal                        = colors.bw_2
theme.titlebar_bg_focus                         = colors.bw_5
theme.titlebar_bg_marked                        = colors.bw_5
theme.titlebar_bg_marked                        = colors.bw_5

theme.fg_normal                                 = colors.bw_9
theme.fg_focus                                  = colors.bw_9
theme.fg_urgent                                 = colors.red_2
theme.bg_normal                                 = colors.bw_0
theme.bg_focus                                  = colors.bw_2
theme.bg_urgent                                 = colors.bw_2

theme.taglist_font                              = theme.font_bold
theme.taglist_fg_normal                         = colors.bw_5
theme.taglist_fg_occupied                       = colors.bw_5
theme.taglist_fg_empty                          = colors.bw_1
theme.taglist_fg_volatile                       = colors.aqua_2
theme.taglist_fg_focus                          = colors.bw_9
theme.taglist_fg_urgent                         = colors.red_2
theme.taglist_bg_normal                         = colors.bw_0
theme.taglist_bg_occupied                       = colors.bw_0
theme.taglist_bg_empty                          = colors.bw_0
theme.taglist_bg_volatile                       = colors.bw_0
theme.taglist_bg_focus                          = colors.bw_2
theme.taglist_bg_urgent                         = colors.bw_1

theme.tasklist_font_normal                      = theme.font
theme.tasklist_font_focus                       = theme.font_bold
theme.tasklist_font_minimized                   = theme.font
theme.tasklist_font_urgent                      = theme.font_bold

theme.tasklist_fg_normal                        = colors.bw_5
theme.tasklist_fg_focus                         = colors.bw_8
theme.tasklist_fg_minimize                      = colors.bw_2
theme.tasklist_fg_urgent                        = colors.red_2
theme.tasklist_bg_normal                        = colors.bw_0
theme.tasklist_bg_focus                         = colors.bw_0
theme.tasklist_bg_minimize                      = colors.bw_0
theme.tasklist_bg_urgent                        = colors.bw_0

theme.tasklist_shape_border_color               = colors.purple_2
theme.tasklist_shape_border_color_focus         = colors.green_2
theme.tasklist_shape_border_color_minimized     = colors.blue_2
theme.tasklist_shape_border_color_urgent        = colors.red_2

theme.hotkeys_border_width                      = theme.border
theme.hotkeys_border_color                      = colors.bw_5
theme.hotkeys_group_margin                      = 50

theme.prompt_bg                                 = colors.bw_0
theme.prompt_fg                                 = theme.fg_normal
theme.bg_systray                                = colors.bw_0

theme.border                                    = 4
theme.border_width                              = 4
theme.border_radius                             = 0
theme.fullscreen_hide_border                    = true
theme.maximized_hide_border                     = true
theme.menu_height                               = 20
theme.menu_width                                = 250
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_spacing                          = 3
theme.useless_gap                               = 14
theme.systray_icon_spacing                      = 4

theme.snap_bg                                   = colors.bw_5
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
theme.layout_treetile                           = theme.dir .. "/layouts/treetile.png"

theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_load                               = theme.dir .. "/icons/load.png"
theme.widget_lock                               = theme.dir .. "/icons/lock.png"
theme.widget_unlock                             = theme.dir .. "/icons/unlock.png"
theme.widget_pacman                             = theme.dir .. "/icons/pacman.png"
theme.widget_users                              = theme.dir .. "/icons/user.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_net_0                              = theme.dir .. "/icons/net_0.png"
theme.widget_net_1                              = theme.dir .. "/icons/net_1.png"
theme.widget_net_2                              = theme.dir .. "/icons/net_2.png"
theme.widget_net_3                              = theme.dir .. "/icons/net_3.png"
theme.widget_net_4                              = theme.dir .. "/icons/net_4.png"
theme.widget_net_5                              = theme.dir .. "/icons/net_5.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_light                              = theme.dir .. "/icons/light.png"
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
theme.titlebar_minimize_button_focus            = theme.dir .. "/icons/titlebar/minimized_focus.png"
theme.titlebar_minimize_button_normal           = theme.dir .. "/icons/titlebar/minimized_normal.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

theme.tooltip_fg                                = colors.bw_8
theme.tooltip_bg                                = colors.bw_2
theme.tooltip_border_color                      = colors.bw_2
theme.tooltip_border_width                      = theme.border

theme.notification_fg                           = theme.fg_normal
theme.notification_bg                           = theme.bg_normal
theme.notification_border_color                 = colors.bw_2
theme.notification_border_width                 = theme.border
theme.notification_icon_size                    = 80
theme.notification_opacity                      = 1
theme.notification_max_width                    = 600
theme.notification_max_height                   = 400
theme.notification_margin                       = 20
theme.notification_shape                        = function(cr, w, h)
                                                      gears.shape.rounded_rect(cr, w, h, theme.border_radius or 0)
                                                  end

naughty.config.padding                          = 15
naughty.config.spacing                          = 10
naughty.config.defaults.timeout                 = 5
naughty.config.defaults.font                    = theme.font
naughty.config.defaults.fg                      = theme.notification_fg
naughty.config.defaults.bg                      = theme.notification_bg
naughty.config.defaults.border_width            = theme.notification_border_width
naughty.config.defaults.margin                  = theme.notification_margin

naughty.config.presets.normal                   = {
                                                      font         = theme.font,
                                                      fg           = theme.notification_fg,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                  }

naughty.config.presets.low                      = {
                                                      font         = theme.font,
                                                      fg           = theme.notification_fg,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                  }

naughty.config.presets.ok                       = {
                                                      font         = theme.font,
                                                      fg           = colors.aqua_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

naughty.config.presets.info                     = {
                                                      font         = theme.font,
                                                      fg           = colors.blue_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

naughty.config.presets.warn                     = {
                                                      font         = theme.font,
                                                      fg           = colors.yellow_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

naughty.config.presets.critical                 = {
                                                      font         = theme.font,
                                                      fg           = colors.red_2,
                                                      bg           = theme.notification_bg,
                                                      border_width = theme.notification_border_width,
                                                      margin       = theme.notification_margin,
                                                      timeout      = 0,
                                                  }

-- Spacing
local space = wibox.widget.separator {
    orientation = "vertical",
    forced_width = 3,
    thickness = 3,
    color = "#00000000",
}

-- Separator
local vert_sep = wibox.widget.separator {
    orientation = "vertical",
    forced_width = theme.border / 2,
    thickness = theme.border / 2,
    color = colors.bw_2,
}

-- Markup
local markup = lain.util.markup
local m_symbol = t_util.symbol_markup_function(8, bar_fg, markup)
local m_text = t_util.text_markup_function(font_size, bar_fg, markup)
local m_boldtext = t_util.markup_function({bold=true, size=font_size}, bar_fg, markup)

-- {{{ TIME
local clock = awful.widget.watch(
    -- "date +'%a %d %b %R'", 60,
    "date +'%R'", 5,
    function(widget, stdout)
        m_boldtext(widget, stdout, colors.bw_8)
    end
)

local clock_widget = wibox.widget {
    {
        clock,
        left = 4,
        right = 4,
        widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.horizontal,
}
-- }}}

-- {{{ CALENDAR
lain.widget.cal {
    cal = "cal --color=always --monday",
    attach_to = { clock_widget },
    icons = "",
    notification_preset = naughty.config.presets.normal,
}
-- }}}

-- -- {{{ CALENDAR
-- local styles = {}
-- local function rounded_shape(size, partial)
--     if partial then
--         return function(cr, width, height)
--                    gears.shape.partially_rounded_rect(cr, width, height,
--                         false, true, false, true, 5)
--                end
--     else
--         return function(cr, width, height)
--                    gears.shape.rounded_rect(cr, width, height, size)
--                end
--     end
-- end
-- styles.month   = { padding      = 5,
--                    bg_color     = '#555555',
--                    border_width = 2,
--                    shape        = rounded_shape(10)
-- }
-- styles.normal  = { shape    = rounded_shape(5) }
-- styles.focus   = { fg_color = '#000000',
--                    bg_color = '#ff9800',
--                    markup   = function(t) return table.concat { '<b>', t, '</b>' } end,
--                    shape    = rounded_shape(5, true)
-- }
-- styles.header  = { fg_color = '#de5e1e',
--                    markup   = function(t) return table.concat { '<b>', t, '</b>' } end,
--                    shape    = rounded_shape(10)
-- }
-- styles.weekday = { fg_color = '#7788af',
--                    markup   = function(t) return table.concat { '<b>', t, '</b>' } end,
--                    shape    = rounded_shape(5)
-- }
-- local function decorate_cell(widget, flag, date)
--     if flag=='monthheader' and not styles.monthheader then
--         flag = 'header'
--     end
--     local props = styles[flag] or {}
--     if props.markup and widget.get_text and widget.set_markup then
--         widget:set_markup(props.markup(widget:get_text()))
--     end
--     -- Change bg color for weekends
--     local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
--     local weekday = tonumber(os.date('%w', os.time(d)))
--     local default_bg = (weekday==0 or weekday==6) and '#232323' or '#383838'
--     local ret = wibox.widget {
--         {
--             widget,
--             margins = (props.padding or 2) + (props.border_width or 0),
--             widget  = wibox.container.margin
--         },
--         shape              = props.shape,
--         shape_border_color = props.border_color or '#b9214f',
--         shape_border_width = props.border_width or 0,
--         fg                 = props.fg_color or '#999999',
--         bg                 = props.bg_color or default_bg,
--         widget             = wibox.container.background
--     }
--     return ret
-- end
--
-- local cal_popup = awful.popup {
--     widget       = {
--         id       = "cal",
--         date     = os.date('*t'),
--         fn_embed = decorate_cell,
--         widget   = wibox.widget.calendar.month,
--     },
--     border_color        = theme.border_normal,
--     border_width        = theme.border_width,
--     preferred_positions = 'bottom',
--     preferred_anchors   = 'back',
--     placement           = awful.placement.top_right,
--     offset              = { y = 10 },
--     -- placement    = awful.placement.next_to(client.focus, {
--     --     preferred_positions = "bottom",
--     --     preferred_anchors   = { "back", "mid", "front" },
--     --     -- bounding_rect       = s:get_bounding_geometry(),
--     -- }),
--     -- placement    = awful.placement.next_to(clock_widget, {
--     --     bounding_rect       = s:get_bounding_geometry(),
--     -- }),
--     shape               = gears.shape.rounded_rect,
--     ontop               = true,
--     visible             = false,
-- }
--
-- clock_widget:connect_signal("mouse::enter", function()
--     cal_popup:move_next_to(client.focus)
--     cal_popup.visible = true
-- end)
-- clock_widget:connect_signal("mouse::leave", function()
--     cal_popup.visible = false
-- end)
-- -- }}}

-- -- {{{ Mail IMAP check
-- local mail_icon = wibox.widget.imagebox(theme.widget_mail)
-- --[[ commented because it needs to be set before use
-- mail_icon:buttons(gears.table.join(awful.button({ }, 1, function() awful.spawn(mail) end)))
-- local mail = lain.widget.imap({
--     timeout  = 180,
--     server   = "server",
--     mail     = "mail",
--     password = "keyring get mail",
--     settings = function()
--         if mailcount > 0 then
--             widget:set_text(table.concat { " ", mailcount, " " })
--             mail_icon:set_image(theme.widget_mail_on)
--         else
--             widget:set_text("")
--             mail_icon:set_image(theme.widget_mail)
--         end
--     end,
-- })
-- -- }}}

-- {{{ MPD
--luacheck: push ignore widget mpd_now artist title
-- local musicplr = context.vars.terminal .. " -title Music -g 130x34-320+16 ncmpcpp"
-- local mpd_icon = wibox.widget.imagebox(theme.widget_music)
--
-- mpd_icon:buttons(gears.table.join(
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

brokers.mpd = lain.widget.mpd {
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title = mpd_now.title .. " "
            -- mpd_icon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            -- mpd_icon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            -- mpd_icon:set_image(theme.widget_music)
        end
    end,
}
--luacheck: pop
-- }}}

-- {{{ MEMORY
local memory_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_mem,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.memory:add_callback(function(x)
    local color = bar_fg

    if x.percent >= 90 then
        color = colors.red_2
    elseif x.percent >= 80 then
        color = colors.orange_2
    elseif x.percent >= 70 then
        color = colors.yellow_2
    end

    m_text(memory_widget.text, x.percent, color)
end)

memory_widget:buttons(brokers.memory.buttons)
-- }}}

-- {{{ CPU
local cpu_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_cpu,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.cpu:add_callback(function(x)
    local color = bar_fg

    if x.percent >= 90 then
        color = colors.red_2
    elseif x.percent >= 80 then
        color = colors.orange_2
    elseif x.percent >= 70 then
        color = colors.yellow_2
    end

    m_text(cpu_widget.text, x.percent, color)
end)

cpu_widget:buttons(brokers.cpu.buttons)
-- }}}

-- {{{ LOADAVG
local loadavg_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_load,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

-- check with: grep 'model name' /proc/cpuinfo | wc -l
local _cores = context.vars.cores or 4

brokers.loadavg:add_callback(function(x)
    local color = bar_fg

    if x.load_5 / _cores >= 1.5 then
        color = colors.red_2
    elseif x.load_5 / _cores >= 1.0 then
        color = x.load_1 > x.load_5 and colors.red_2 or colors.orange_2
    elseif x.load_5 / _cores >= 0.8 then
        color = colors.orange_2
    elseif x.load_5 / _cores >= 0.6 then
        color = colors.yellow_2
    end

    m_text(loadavg_widget.text, string.format("%.1f", x.load_5), color)
end)

loadavg_widget:buttons(brokers.loadavg.buttons)
-- }}}

-- {{{ PACMAN
local pacman_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_pacman,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.pacman:add_callback(function(x)
    m_text(pacman_widget.text, x.count)
end)
pacman_widget:buttons(brokers.pacman.buttons)
-- }}}

-- {{{ USERS
local users_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_users,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    visible = false,
    layout = wibox.layout.fixed.horizontal,
}

brokers.users:add_callback(function(x)
    users_widget.visible = x.count > 1

    local color = bar_fg

    if tonumber(x.count) > 1 then
        color = colors.red_2
    end

    m_text(users_widget.text, x.count, color)
end)
users_widget:buttons(brokers.users.buttons)
-- }}}

-- {{{ BRIGHTNESS
local brightness_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_light,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.brightness:add_callback(function(x)
    m_text(brightness_widget.text, x.percent)
end)
brightness_widget:buttons(brokers.brightness.buttons)
-- }}}

-- {{{ TEMPERATURE
local temp_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_temp,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.temperature:add_callback(function(x)
    local color = bar_fg

    if x.temp >= 80 then
        color = colors.red_2
    elseif x.temp >= 70 then
        color = colors.orange_2
    elseif x.temp >= 60 then
        color = colors.yellow_2
    end

    m_text(temp_widget.text, gears.math.round(x.temp), color)
end)

temp_widget:buttons(brokers.temperature.buttons)
-- }}}

-- {{{ DRIVE
local drive_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_hdd,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.drive:add_callback(function(x)
    local color = bar_fg

    if x.percent >= 90 then
        color = colors.red_2
    elseif x.percent >= 80 then
        color = colors.orange_2
    elseif x.percent >= 70 then
        color = colors.yellow_2
    end

    m_text(drive_widget.text, x.percent, color)
end)

drive_widget:buttons(brokers.drive.buttons)
-- }}}

-- {{{ LOCK
local lock_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_lock,
        widget = wibox.widget.imagebox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.lock:add_callback(function(x)
    if x.enabled then
        lock_widget.icon:set_image(theme.widget_lock)
    else
        lock_widget.icon:set_image(theme.widget_unlock)
    end
end)

lock_widget:buttons(brokers.lock.buttons)
-- }}}

-- {{{ AUDIO
local audio_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_vol,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.audio:add_callback(function(x)
    local color
    local icon

    if x.muted then
        icon = theme.widget_vol_mute
    elseif x.percent <= 20 then
        icon = theme.widget_vol_no
    elseif x.percent <= 40 then
        icon = theme.widget_vol_low
    else
        icon = theme.widget_vol
    end

    if x.percent >= 100 then
        color = colors.red_2
    elseif x.percent >= 90 then
        color = colors.orange_2
    elseif x.percent >= 80 then
        color = colors.yellow_2
    else
        color = bar_fg
    end

    audio_widget.icon:set_image(icon)
    m_text(audio_widget.text, x.percent, color)
end)

audio_widget:buttons(brokers.audio.buttons)
-- }}}

-- {{{ BATTERY
local battery_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_battery,
        widget = wibox.widget.imagebox,
    },
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.battery:add_callback(function(x)
    local color = bar_fg
    local icon

    if x.percent <= 10 then
        icon = theme.widget_battery_empty
        color = colors.red_2
    elseif x.percent <= 20 then
        icon = theme.widget_battery_low
        color = colors.orange_2
    elseif x.percent <= 30 then
        icon = theme.widget_battery_low
        color = colors.yellow_2
    elseif x.percent <= 50 then
        icon = theme.widget_battery_low
    else
        icon = theme.widget_battery
    end

    if x.charging or x.full or x.ac then
        icon = theme.widget_ac
        if x.percent >= 95 then
            color = colors.green_2
        end
    end

    battery_widget.icon:set_image(icon)
    m_text(battery_widget.text, x.percent, color)
end)

battery_widget:buttons(brokers.battery.buttons)
-- }}}

-- {{{ WEATHER
local weather_widget = wibox.widget {
    space, space,
    {
        id = "icon",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space, space,
    {
        id = "text",
        align = "center",
        widget = wibox.widget.textbox,
    },
    space, space,
    layout = wibox.layout.fixed.horizontal,
}

brokers.weather:add_callback(function(x)
    m_symbol(weather_widget.icon, t_util.get_icon(x.data.weather[1].icon))
    m_text(weather_widget.text, x.data.main.temp)
end)

weather_widget:buttons(brokers.weather.buttons)
-- }}}

-- {{{ NET
local net_widget = wibox.widget {
    space,
    {
        id = "icon",
        image = theme.widget_net_0,
        widget = wibox.widget.imagebox,
    },
    {
        id = "load_text",
        widget = wibox.widget.textbox,
    },
    {
        id = "ping_text",
        widget = wibox.widget.textbox,
    },
    {
        id = "load",
        space,
        vert_sep,
        space, space,
        {
            id = "text",
            align = "center",
            widget = wibox.widget.textbox,
        },
        visible = false,
        layout = wibox.layout.fixed.horizontal,
    },
    space,
    layout = wibox.layout.fixed.horizontal,
}

local net_tooltip = awful.tooltip { --luacheck: no unused
    objects = { net_widget },
    delay_show = 0.5,
    align = "bottom",
    mode = "outside",
    bg = colors.bw_2,
    preferred_positions = { "bottom" },
}

brokers.net:add_callback(function(x)
    local icon

    if x.wifi and x.signal then
        if x.signal >= -35 then
            icon = theme.widget_net_5
        elseif x.signal >= -60 then
            icon = theme.widget_net_4
        elseif x.signal >= -70 then
            icon = theme.widget_net_3
        elseif x.signal >= -80 then
            icon = theme.widget_net_2
        else
            icon = theme.widget_net_1
        end
    else
        icon = theme.widget_net_0
    end

    local r, s = unit.to_mb(x.received), unit.to_mb(x.sent)
    if not x.state or x.state ~= "up" then
        m_text(net_tooltip, " N/A ", colors.red_2)
        m_text(net_widget.load.text, " N/A ", colors.red_2)
        m_symbol(net_widget.load_text, "")
    else
        m_text(net_tooltip, string.format("%.1f ↓↑ %.1f", r, s))
        m_text(net_widget.load.text, string.format("%.1f ↓↑ %.1f", r, s))
        m_symbol(net_widget.load_text, (r>0.5 or s>0.2) and "" or "", colors.red_2)
    end

    net_widget.icon:set_image(icon)
end)

brokers.ping:add_callback(function(x)
    m_symbol(net_widget.ping_text, x.connected and "" or "", colors.red_2)
end)

net_widget:buttons(gears.table.join(
    brokers.net.buttons,
    awful.button({ context.keys.ctrlkey }, 1, function()
        net_widget.load.visible = not net_widget.load.visible
    end)
))
-- }}}

-- {{{ 2BWM - style
-- theme.titlebar_fn = require("config.titlebars.double").init(theme, {
--     outer_width = 16,
--     outer_color = colors.bw_0,
-- })
-- TODO: Disable hiding titlebar when client is floating.
--       See: config/signals.lua - "property::floating"
-- }}}

-- Format title text
local function title_markup(class, name, color, bold)
    return table.concat {
        "<span color='", color, "'>",

        "<small><small><i>",
        class and gears.string.xml_escape(class .. ":") or "",
        "</i></small></small> ",

        (bold and "<b>" or ""),
        gears.string.xml_escape(name or awful.titlebar.fallback_name or "N/A"),
        (bold and "</b>" or ""),

        "</span>",
    }
end

-- Recolor client icon
local function icon_recolor(icon, color)
    local img = gears.surface.duplicate_surface(icon)
    local cr = cairo.Context(img)

    -- cr:mask_surface(img, 0, 0)
    -- cr:mask(cairo.Pattern.create_for_surface(img))

    cr:set_source_rgb(gears.color.parse_color(color))
    -- cr:set_source_rgb(gears.color.parse_color("#ff0"))
    cr:set_operator(cairo.Operator.HSL_COLOR)

    cr:paint()
    return img
end

-- {{{ TITLEBAR
theme_assets.recolor_titlebar(theme, theme.titlebar_fg_normal, "normal")
theme_assets.recolor_titlebar(theme, colors.bw_7, "normal", nil, "active")
theme_assets.recolor_titlebar(theme, theme.titlebar_fg_focus, "focus")
theme_assets.recolor_titlebar(theme, colors.bw_10, "focus", nil, "active")

-- Markup client title (class: name)
local function titlewidget(c)
    local ret = wibox.widget.textbox()
    local function update()
        if c == client.focus then
            ret:set_markup(title_markup(c.class, c.name, theme.titlebar_fg_focus, true))
        elseif c.urgent then
            ret:set_markup(title_markup(c.class, c.name, theme.titlebar_fg_urgent, true))
        else
            ret:set_markup(title_markup(c.class, c.name, theme.titlebar_fg_normal))
        end
    end

    c:connect_signal("property::name", update)
    c:connect_signal("property::urgent", update)
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)
    update()

    return ret
end

-- Black/White client icon
local function iconwidget(c)
    local ret = wibox.widget.imagebox()
    local function update()
        ret:set_image(icon_recolor(c.icon, client.focus == c
                and theme.titlebar_bg_focus or theme.titlebar_bg_normal))
        -- ret:set_image(icon_recolor(c.icon, theme.titlebar_fg_urgent))
        -- ret:set_image(c.icon)
    end

    c:connect_signal("property::icon", update)
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)
    update()

    return ret
end

theme.titlebar_fn = function(c)
    -- Default buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            if c.focusable then client.focus = c end
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            if c.focusable then client.focus = c end
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    local t = awful.titlebar(c, { size = 20, position = "top" })
    t:setup {
        {
            {
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                {
                    iconwidget(c),
                    buttons = buttons,
                    margins = 2,
                    widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            {
                {
                    {
                        {
                            align = "center",
                            widget = titlewidget(c),
                        },
                        id = "_scroll",
                        step_function = wibox.container.scroll.step_functions.linear_increase,
                        speed = 80,
                        extra_space = 50,
                        widget = wibox.container.scroll.horizontal,
                    },
                    widget = wibox.container.place,
                },
                left = 6,
                right = 6,
                buttons = buttons,
                widget = wibox.container.margin,
            },
            {
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal,
        },
        bottom = theme.border_width / 2,
        widget = wibox.container.margin,
    }

    local scroll = t:get_children_by_id("_scroll")[1]
    scroll:connect_signal("mouse::enter", function()
        scroll:continue()
    end)
    scroll:connect_signal("mouse::leave", function()
        scroll:pause()
        scroll:reset_scrolling()
    end)
    scroll:pause()
    scroll:reset_scrolling()

    util.hide_unneeded_titlebars(c)
end

util.hide_all_unneeded_titlebars()
-- }}}

-- {{{ TASKLIST
local function tasklist_update_callback(self, c, index, objects) --luacheck: no unused
    local t = self:get_children_by_id("_text")[1]
    -- local i = self:get_children_by_id("_icon")[1]
    local b = self:get_children_by_id("_color_bar")[1]

    if c == client.focus then
        t:set_markup(title_markup(c.class, c.name, theme.tasklist_fg_focus, true))
        -- i:set_image(icon_recolor(c.icon, theme.tasklist_bg_focus))
        b.color = theme.tasklist_fg_normal
    elseif c.urgent then
        t:set_markup(title_markup(c.class, c.name, theme.tasklist_fg_urgent, true))
        -- i:set_image(icon_recolor(c.icon, theme.tasklist_bg_urgent))
        b.color = theme.tasklist_fg_urgent
    elseif c.minimized then
        t:set_markup(title_markup(c.class, c.name, theme.tasklist_fg_minimize))
        -- i:set_image(icon_recolor(c.icon, theme.tasklist_bg_minimize))
        b.color = theme.tasklist_bg_minimize
    elseif c == awful.client.focus.history.get(c.screen, 0) then
        t:set_markup(title_markup(c.class, c.name, theme.tasklist_fg_normal, true))
        -- i:set_image(icon_recolor(c.icon, theme.tasklist_bg_normal))
        b.color = theme.tasklist_fg_minimize
    else
        t:set_markup(title_markup(c.class, c.name, theme.tasklist_fg_normal))
        -- i:set_image(icon_recolor(c.icon, theme.tasklist_bg_normal))
        b.color = theme.tasklist_bg_normal
    end
end
-- }}}

function theme.at_screen_connect(s)
    -- Create the wibox
    s._wibox = awful.wibar {
        position = "top",
        screen = s,
        height = 25 + theme.border,
        fg = bar_fg,
        bg = bar_bg,
    }

    -- -- Create the side wibox
    -- s._wibox_side = awful.wibar {
    --     position = "left",
    --     screen = s,
    --     width = 25 + theme.border,
    --     fg = bar_fg,
    --     bg = bar_bg,
    -- }
    --
    -- s._wibox_side:setup {
    --     wibox.widget.textbox(),
    --     right = theme.border,
    --     color = colors.bw_2,
    --     widget = wibox.container.margin,
    -- }

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
    s._taglist = awful.widget.taglist {
        screen = s,
        filter = util.rowfilter,
        buttons = taglist_binds.buttons,
    }

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
            -- shape_border_width = 2,
            -- shape_border_color = theme.tasklist_bg_normal,
        },
        widget_template = {
            {
                {
                    {
                        {
                            layout = wibox.layout.flex.vertical,
                        },
                        id = "_color_bar",
                        top = s._wibox.position == "top" and theme.border / 2 or 0,
                        bottom = s._wibox.position == "bottom" and theme.border / 2 or 0,
                        widget = wibox.container.margin,
                    },
                    {
                        {
                            {
                                -- id = "text_role",
                                id = "_text",
                                widget = wibox.widget.textbox,
                            },
                            id = "_scroll",
                            step_function = wibox.container.scroll.step_functions.linear_increase,
                            speed = 80,
                            extra_space = 50,
                            widget = wibox.container.scroll.horizontal,
                        },
                        widget = wibox.container.place,
                    },
                    -- {
                    --     {
                    --         {
                    --             -- id = "icon_role",
                    --             id = "_icon",
                    --             widget = wibox.widget.imagebox,
                    --         },
                    --         margins = 6,
                    --         widget = wibox.container.margin,
                    --     },
                    --     {
                    --         {
                    --             {
                    --                 -- id = "text_role",
                    --                 id = "_text",
                    --                 widget = wibox.widget.textbox,
                    --             },
                    --             id = "_scroll",
                    --             step_function = wibox.container.scroll.step_functions.linear_increase,
                    --             speed = 80,
                    --             extra_space = 50,
                    --             widget = wibox.container.scroll.horizontal,
                    --         },
                    --         widget = wibox.container.place,
                    --     },
                    --     layout = wibox.layout.align.horizontal,
                    -- },
                    -- {
                    --     widgets.fade {
                    --         width = 30,
                    --         color = theme.tasklist_bg_normal,
                    --     },
                    --     id = "_fade",
                    --     visible = false,
                    --     layout = wibox.layout.flex.horizontal,
                    -- },
                    layout = wibox.layout.stack,
                },
                left = 3,
                right = 3,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = function(self, c, index, objects)
                local scroll = self:get_children_by_id("_scroll")[1]
                -- local fade = self:get_children_by_id("_fade")[1]
                self:connect_signal("mouse::enter", function()
                    -- fade.visible = true
                    scroll:continue()
                end)
                self:connect_signal("mouse::leave", function()
                    -- fade.visible = false
                    scroll:pause()
                    scroll:reset_scrolling()
                end)
                scroll:pause()
                scroll:reset_scrolling()
                tasklist_update_callback(self, c, index, objects)
            end,
            update_callback = tasklist_update_callback,
        },
        layout = {
            layout = wibox.layout.flex.horizontal,
            spacing = 8,
            spacing_widget = {
                vert_sep,
                widget = wibox.container.place,
            },
        },
    }

    -- {{{ HIDDEN WIDGET
    s._hidden_widget = wibox.widget {
        space, vert_sep, vert_sep, vert_sep, vert_sep,

        drive_widget,
        weather_widget,

        vert_sep,
        space,
        {
            wibox.widget.systray(),
            left = 8,
            right = 8,
            top = 4,
            bottom = 4,
            widget = wibox.container.margin,
        },
        space,
        vert_sep,

        visible = false,
        layout = wibox.layout.fixed.horizontal,
    }

    local hidden_widget_activator = wibox.widget {
        space, space,
        layout = wibox.layout.fixed.horizontal,
        buttons = gears.table.join(
            awful.button({ }, 1, function()
                s._hidden_widget.visible = not s._hidden_widget.visible
            end)
        )
    }
    -- }}}

    -- Add widgets to the wibox
    s._wibox:setup {
        {
            {
                {
                    -- Left
                    space,
                    space,

                    {
                        -- Layoutbox
                        {
                            s._layoutbox,
                            left = 4,
                            top = 5,
                            bottom = 5,
                            widget = wibox.container.margin,
                        },
                        bg = bar_bg,
                        widget = wibox.container.background,
                    },

                    space,
                    space,
                    space,
                    vert_sep,
                    space,

                    {
                        -- Taglist
                        {
                            s._taglist,
                            left = 2,
                            right = 2,
                            widget = wibox.container.margin,
                        },
                        bg = bar_bg,
                        widget = wibox.container.background,
                    },

                    space,
                    vert_sep,

                    {
                        -- Prompt box
                        {
                            s._promptbox,
                            left = 6,
                            right = 6,
                            widget = wibox.container.margin,
                        },
                        bg = theme.prompt_bg,
                        widget = wibox.container.background,
                    },

                    vert_sep,

                    layout = wibox.layout.fixed.horizontal,
                },

                {
                    -- Middle
                    {
                        s._tasklist,
                        left = 2,
                        right = 2,
                        widget = wibox.container.margin,
                    },
                    bg = bar_bg,
                    widget = wibox.container.background,
                },

                {
                    -- Right
                    vert_sep,

                    lock_widget,

                    vert_sep,

                    pacman_widget,
                    users_widget,
                    loadavg_widget,
                    cpu_widget,
                    memory_widget,
                    temp_widget,
                    brightness_widget,
                    audio_widget,
                    battery_widget,

                    space, vert_sep,

                    net_widget,

                    space, vert_sep, space,

                    clock_widget,

                    s._hidden_widget,
                    hidden_widget_activator,

                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.layout.align.horizontal,
            },
            layout = wibox.layout.flex.vertical,
        },
        id = "border",
        bottom = s._wibox.position == "top" and theme.border or 0,
        top = s._wibox.position == "bottom" and theme.border or 0,
        color = colors.bw_2,
        widget = wibox.container.margin,
    }

    -- Popups
    do
        local popup_font = t_util.font { size = 20 , bold = true }

        -- Layoutbox popup
        s._layout_popup = util.default_popup {
            screen = s,
            widget = awful.widget.layoutbox(s),
        }

        -- Taglist popup
        s._taglist_popup = util.default_popup {
            screen = s,
            widget = awful.widget.taglist {
                screen = s,
                filter = util.rowfilter,
                buttons = taglist_binds.buttons,
                style = {
                    font = popup_font,
                    bg_focus = theme.taglist_bg_normal,
                    bg_urgent = theme.taglist_bg_normal,
                },
                layout = {
                    spacing = 8,
                    layout = wibox.layout.fixed.horizontal
                },
            },
            width = 330,
            height = 72,
        }
    end
end

return theme
