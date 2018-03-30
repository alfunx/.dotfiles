
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

local cairo            = require("lgi").cairo
local gears            = require("gears")
local lain             = require("lain")
local widgets          = require("widgets")
local awful            = require("awful")
local wibox            = require("wibox")
local os, math, string = os, math, string

local theme = require("themes.powerarrow-gruvbox.theme")

theme.wallpaper_original                        = theme.dir .. "/wallpapers/matterhorn.jpg"
theme.wallpaper                                 = theme.dir .. "/wallpapers/matterhorn_base.jpg"
theme.wallpaper_blur                            = theme.dir .. "/wallpapers/matterhorn_blur.jpg"

theme.border_normal                             = bw4
theme.border_focus                              = bw7
theme.border_marked                             = bw7

theme.titlebar_fg_normal                        = bw0
theme.titlebar_fg_focus                         = bw0
theme.titlebar_fg_marked                        = bw0
theme.titlebar_bg_normal                        = theme.border_normal
theme.titlebar_bg_focus                         = theme.border_focus
theme.titlebar_bg_marked                        = theme.border_marked

theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar_dark/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar_dark/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar_dark/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar_dark/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar_dark/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar_dark/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar_dark/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar_dark/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar_dark/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar_dark/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar_dark/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar_dark/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar_dark/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar_dark/floating_normal_inactive.png"
theme.titlebar_minimize_button_focus_active     = theme.dir .. "/icons/titlebar_dark/minimized_focus_active.png"
theme.titlebar_minimize_button_normal_active    = theme.dir .. "/icons/titlebar_dark/minimized_normal_active.png"
theme.titlebar_minimize_button_focus_inactive   = theme.dir .. "/icons/titlebar_dark/minimized_focus_inactive.png"
theme.titlebar_minimize_button_normal_inactive  = theme.dir .. "/icons/titlebar_dark/minimized_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar_dark/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar_dark/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar_dark/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar_dark/maximized_normal_inactive.png"

return theme
