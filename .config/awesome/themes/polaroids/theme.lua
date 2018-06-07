
--[[

     Polaroids
     by Alphonse Mariyagnanaseelan

     Polaroids Openbox theme: github.com/eti0/dots
     Gruvbox: github.com/morhetz/gruvbox/

--]]

-- Gruvbox colors

local black_1          = "#282828"
local black_2          = "#928374"
local red_1            = "#cc241d"
local red_2            = "#fb4934"
local green_1          = "#98971a"
local green_2          = "#b8bb26"
local yellow_1         = "#d79921"
local yellow_2         = "#fabd2f"
local blue_1           = "#458588"
local blue_2           = "#83a598"
local purple_1         = "#b16286"
local purple_2         = "#d3869b"
local aqua_1           = "#689d6a"
local aqua_2           = "#8ec07c"
local white_1          = "#a89984"
local white_2          = "#ebdbb2"
local orange_1         = "#d65d0e"
local orange_2         = "#fe8019"

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

local bar_fg_normal    = bw5
local bar_bg_normal    = bw0 .. "00"

local gears            = require("gears")
local lain             = require("lain")
local widgets          = require("widgets")
local awful            = require("awful")
local wibox            = require("wibox")
local naughty          = require("naughty")
local xresources       = require("beautiful.xresources")
local dpi              = xresources.apply_dpi
local os, math, string = os, math, string

local theme                                     = { }
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/polaroids"

theme.wallpaper                                 = theme.dir .. "/wallpapers/wall.png"

-- theme.wallpaper                                 = theme.dir .. "/wallpapers/escheresque.png"
-- theme.wallpaper_offset                          = 5

-- theme.wallpaper_original                        = theme.dir .. "/wallpapers/matterhorn.jpg"
-- theme.wallpaper                                 = theme.dir .. "/wallpapers/matterhorn_base.jpg"
-- theme.wallpaper_blur                            = theme.dir .. "/wallpapers/matterhorn_blur.jpg"
-- theme.wallpaper_offset                          = 0

local font_name                                 = "blackjack"
local font_size                                 = "14"
theme.font                                      = font_name .. " " ..                         font_size
theme.font_bold                                 = font_name .. " " .. "Bold"        .. " " .. font_size
theme.font_italic                               = font_name .. " " .. "Italic"      .. " " .. font_size
theme.font_bold_italic                          = font_name .. " " .. "Bold Italic" .. " " .. font_size
theme.font_big                                  = font_name .. " " .. "Bold"        .. " 16"

theme.border_normal                             = bw8
theme.border_focus                              = bw10
theme.border_marked                             = bw10

theme.fg_normal                                 = bw9
theme.fg_focus                                  = red_2
theme.fg_urgent                                 = bw0
theme.bg_normal                                 = bw0
theme.bg_focus                                  = bw2
theme.bg_urgent                                 = red_2

theme.taglist_font                              = theme.font_bold
theme.taglist_fg_normal                         = bw5
theme.taglist_fg_occupied                       = bw5
theme.taglist_fg_empty                          = bw1
theme.taglist_fg_volatile                       = aqua_2
theme.taglist_fg_focus                          = bw9
theme.taglist_fg_urgent                         = red_2
theme.taglist_bg_normal                         = bw0 .. "00"
theme.taglist_bg_occupied                       = bw0 .. "00"
theme.taglist_bg_empty                          = bw0 .. "00"
theme.taglist_bg_volatile                       = bw0 .. "00"
theme.taglist_bg_focus                          = bw2 .. "00"
theme.taglist_bg_urgent                         = bw1 .. "00"

theme.tasklist_font_normal                      = theme.font
theme.tasklist_font_focus                       = theme.font_bold
theme.tasklist_font_urgent                      = theme.font_bold
theme.tasklist_fg_normal                        = bw5
theme.tasklist_fg_focus                         = bw8
theme.tasklist_fg_minimize                      = bw2
theme.tasklist_fg_urgent                        = red_2
theme.tasklist_bg_normal                        = bw0 .. "00"
theme.tasklist_bg_focus                         = bw0 .. "00"
theme.tasklist_bg_urgent                        = bw0 .. "00"

theme.titlebar_positions                        = { "bottom" }
theme.titlebar_fg_normal                        = bw0
theme.titlebar_fg_focus                         = bw0
theme.titlebar_fg_marked                        = bw0
theme.titlebar_bg_normal                        = theme.border_normal
theme.titlebar_bg_focus                         = theme.border_focus
theme.titlebar_bg_marked                        = theme.border_marked

theme.hotkeys_border_width                      = dpi(30)
theme.hotkeys_border_color                      = bw0
theme.hotkeys_group_margin                      = dpi(30)
theme.hotkeys_shape                             = function(cr, width, height)
                                                      gears.shape.rounded_rect(cr, width, height, dpi(20))
                                                  end

theme.prompt_bg                                 = bw0 .. "00"
theme.prompt_fg                                 = theme.fg_normal
theme.bg_systray                                = theme.tasklist_bg_normal

theme.border_width                              = dpi(10)
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

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar_light/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar_light/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar_light/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar_light/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar_light/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar_light/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar_light/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar_light/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar_light/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar_light/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar_light/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar_light/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar_light/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar_light/floating_normal_inactive.png"
theme.titlebar_minimize_button_focus_active     = theme.dir .. "/icons/titlebar_light/minimized_focus_active.png"
theme.titlebar_minimize_button_normal_active    = theme.dir .. "/icons/titlebar_light/minimized_normal_active.png"
theme.titlebar_minimize_button_focus_inactive   = theme.dir .. "/icons/titlebar_light/minimized_focus_inactive.png"
theme.titlebar_minimize_button_normal_inactive  = theme.dir .. "/icons/titlebar_light/minimized_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar_light/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar_light/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar_light/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar_light/maximized_normal_inactive.png"

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
                                                      fg           = red_2,
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
        widget:set_markup(markup.fontfg(theme.font_bold, bw8, stdout))
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

-- NET
--luacheck: push ignore widget net_now
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net {
    wifi_state = "on",
    iface = "wlp58s0",
    notify = "off",
    units = 1048576, -- in MB/s (1024^2)
    -- units = 131072, -- in Mbit/s / Mbps (1024^2/8)
    settings = function()
        local _color = bar_fg_normal
        local _font = theme.font

        if not net_now.state or net_now.state == "down" then
            _color = red_2
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
    awful.spawn.easy_async(awful.util.scripts_dir .. "/show-ip-address", function(stdout, stderr, reason, exit_code)
        if net_widget.notification then
            naughty.destroy(net_widget.notification)
        end
        net.update()
        net_widget.notification = naughty.notify {
            title = "Network",
            text = string.gsub(stdout, '\n*$', ''),
            timeout = 10,
        }

        awful.spawn.easy_async(awful.util.scripts_dir .. "/show-ip-address -f", function(stdout, stderr, reason, exit_code)
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

theme.titlebar_fun = function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {
        size = 40,
        position = "bottom",
    }):setup {
        {
            layout = wibox.layout.align.horizontal,
            { -- Left
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                layout = wibox.layout.flex.horizontal,
                { -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                buttons = buttons,
            },
            { -- Right
                layout = wibox.layout.fixed.horizontal,
            },
        },
        widget = wibox.container.margin,
        left = 5,
        right = 5,
        top = 8,
    }

    awful.titlebar(c, { }):setup {
        layout = wibox.layout.align.horizontal,
    }
    awful.titlebar.hide(c)
end

-- Separators
local vert_sep = wibox.widget {
    widget = wibox.widget.separator,
    orientation = "vertical",
    forced_width = 20,
    color = theme.border_normal .. "00",
}

-- Show only tags of current row (taggrid feature)
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
    s.quake = lain.util.quake {
        app = awful.util.terminal,
    }

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    -- gears.wallpaper.maximized(wallpaper, s, true)
    gears.wallpaper.tiled(wallpaper, s)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.util.layouts)

    -- Create a promptbox for each screen
    s._promptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s._layoutbox = awful.widget.layoutbox(s)
    s._layoutbox:buttons(awful.util.table.join(
        awful.button({ }, 1, function() awful.layout.inc( 1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc( 1) end),
        awful.button({ }, 5, function() awful.layout.inc(-1) end))
    )

    -- Create a taglist widget
    s._taglist = awful.widget.taglist(s, rowfilter, awful.util.taglist_buttons)

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

    -- Create the wibox
    s._wibox = awful.wibar {
        position = "top",
        screen = s,
        height = dpi(30),
        fg = bar_fg_normal,
        bg = bar_bg_normal .. "00",
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
    }

    systray_widget:set_visible(false)

    local systray_widget_timer = gears.timer {
        timeout = 5,
        callback = function()
            systray_widget:set_visible(false)
        end,
    }

    s._wibox:connect_signal("mouse::enter", function()
        systray_widget:set_visible(true)
        systray_widget_timer:stop()
    end)

    s._wibox:connect_signal("mouse::leave", function()
        systray_widget_timer:start()
    end)

    -- Add widgets to the wibox
    s._wibox:setup {
        layout = wibox.layout.fixed.vertical,
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
                        top = dpi(8),
                        bottom = dpi(8),
                        widget = wibox.container.margin,
                    },
                    bg = bar_bg_normal,
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
                    bg = bar_bg_normal,
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

            {
                layout = wibox.layout.flex.horizontal,
            },

            -- -- Middle widget
            -- { -- Tasklist
            --     {
            --         {
            --             layout = wibox.layout.flex.horizontal,
            --             s._tasklist,
            --         },
            --         left = dpi(8),
            --         right = dpi(0),
            --         widget = wibox.container.margin,
            --     },
            --     bg = bar_bg_normal,
            --     widget = wibox.container.background,
            -- },

            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,

                wibox.container.background(wibox.container.margin(systray_widget, dpi(0), dpi(8)), bar_bg_normal),

                vert_sep,
                wibox.container.background(wibox.container.margin(net_widget,     dpi(8), dpi(10)), bar_bg_normal),

                vert_sep,
                wibox.container.background(wibox.container.margin(clock_widget,   dpi(8), dpi(8)),  bar_bg_normal),
            },
        },
    }
end

return theme
