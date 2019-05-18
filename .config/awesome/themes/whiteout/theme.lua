
--[[

     Whiteout
     by alfunx (Alphonse Mariya)
     based on Blackout

--]]

local gears            = require("gears")

local t_util           = require("config.util_theme")
local os, math, string = os, math, string

local colors = { }

colors.black_1          = "#fbf1c7"
colors.black_2          = "#928374"
colors.red_1            = "#cc241d"
colors.red_2            = "#9d0006"
colors.green_1          = "#98971a"
colors.green_2          = "#79740e"
colors.yellow_1         = "#d79921"
colors.yellow_2         = "#b57614"
colors.blue_1           = "#458588"
colors.blue_2           = "#076678"
colors.purple_1         = "#b16286"
colors.purple_2         = "#8f3f71"
colors.aqua_1           = "#689d6a"
colors.aqua_2           = "#427b58"
colors.white_1          = "#7c6f64"
colors.white_2          = "#3c3836"
colors.orange_1         = "#d65d0e"
colors.orange_2         = "#af3a03"

colors.bw_0_h           = "#f9f5d7"
colors.bw_0             = "#fbf1c7"
colors.bw_0_s           = "#f2e5bc"
colors.bw_1             = "#ebdbb2"
colors.bw_2             = "#d5c4a1"
colors.bw_3             = "#bdae93"
colors.bw_4             = "#a89984"
colors.bw_5             = "#928374"
colors.bw_6             = "#7c6f64"
colors.bw_7             = "#665c54"
colors.bw_8             = "#504945"
colors.bw_9             = "#3c3836"
colors.bw_10            = "#282828"

colors = t_util.set_colors(colors)

-- Use _dir to preserve parent theme.dir
local theme = require("themes.blackout.theme")
theme.name = "whiteout"
theme.alternative = "blackout"
theme._dir = string.format("%s/.config/awesome/themes/%s", os.getenv("HOME"), theme.name)

-- theme.wallpaper                                 = theme.dir .. "/wallpapers/wall.png"
theme.wallpaper                                 = theme.dir .. "/wallpapers/escheresque.png"
theme.wallpaper_fn                              = gears.wallpaper.tiled

theme.titlebar_close_button_focus               = theme._dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme._dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme._dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme._dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme._dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme._dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme._dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme._dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme._dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme._dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme._dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme._dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme._dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme._dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_minimize_button_focus            = theme._dir .. "/icons/titlebar/minimized_focus.png"
theme.titlebar_minimize_button_normal           = theme._dir .. "/icons/titlebar/minimized_normal.png"
theme.titlebar_maximized_button_focus_active    = theme._dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme._dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme._dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme._dir .. "/icons/titlebar/maximized_normal_inactive.png"

return theme
