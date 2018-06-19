local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local config = {}

function config.init(context)

    context.util = context.util or {}

    -- Check if client floats
    context.util.client_floats = function(c)
        if awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating then
            return true
        end
        return false
    end

    -- Spawn a process
    context.util.run_once = function(cmd_arr)
        for _, cmd in ipairs(cmd_arr) do
            local findme = cmd
            local firstspace = cmd:find(" ")
            if firstspace then
                findme = cmd:sub(0, firstspace-1)
            end
            awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
        end
    end

    -- Spawn a window
    context.util.spawn_once = function(args)
        if not args and args.command then return end
        args.callback = args.callback or function() end

        -- Create move callback
        local f
        f = function(c)
            if c.class == args.class then
                c:move_to_tag(tag)
                client.disconnect_signal("manage", f)
                args.callback(c)
            end
        end
        client.connect_signal("manage", f)

        -- Now check if not already running
        local findme = args.command
        local firstspace = findme:find(" ")
        if firstspace then
            findme = findme:sub(0, firstspace-1)
        end

        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, args.command))
    end

    -- Spawn process and adjust border color current client until process exits
    -- (useful for e.g. rofi or dmenu)
    context.util.easy_async_with_unfocus = function(cmd, callback)
        local c = client.focus
        callback = callback or function() end
        if c then c:emit_signal("unfocus") end
        awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
            callback(stdout, stderr, reason, exit_code)
            if c then c:emit_signal("focus") end
        end)
    end

    -- Select tag by direction in a grid (taggrid feature)
    context.util.select_tag_in_grid = nil
    do
        local columns = awful.util.tagcolumns or #awful.util.tagnames
        local index_by_direction = {
            l = function(i) return (math.ceil((i) / columns) - 1) * columns + ((i - 2) % columns) + 1 end,
            r = function(i) return (math.ceil((i) / columns) - 1) * columns + ((i) % columns) + 1 end,
            u = function(i, rows) return (i - 1 - columns) % (rows * columns) + 1 end,
            d = function(i, rows) return (i - 1 + columns) % (rows * columns) + 1 end
        }
        context.util.select_tag_in_grid = function(direction, current_index)
            local rows = math.ceil(#awful.screen.focused().tags / columns)
            local index = current_index or awful.screen.focused().selected_tag.index
            local new_index = index_by_direction[direction](index, rows)

            local new_tag = awful.screen.focused().tags[new_index]
            if new_tag then
                new_tag:view_only()
                return new_tag
            end
            context.util.select_tag_in_grid(direction, new_index)
        end
    end

    -- Move client to tag by direction in a grid (taggrid feature)
    context.util.move_client_in_grid = function(direction)
        if client.focus then
            local current_client = client.focus
            local new_tag = context.util.select_tag_in_grid(direction)
            current_client:move_to_tag(new_tag)
            current_client:raise()
        end
    end

    -- Show only tags of current row (taggrid feature)
    context.util.rowfilter = function(t)
        local index = t.index
        local selected = awful.screen.focused().selected_tag.index
        if not index or not selected then
            return false
        end
        local columns = awful.util.tagcolumns or #awful.util.tagnames
        return math.floor((index - 1) / columns) == math.floor((selected - 1) / columns)
    end

    -- Set titlebar visibility
    local set_titlebar = function(c, f)
        if beautiful.titlebar_positions then
            for _, v in pairs(beautiful.titlebar_positions) do
                f(c, v)
            end
        else
            f(c)
        end
    end

    context.util.hide_titlebar = function(c)
        set_titlebar(c, awful.titlebar.hide)
    end

    context.util.show_titlebar = function(c)
        set_titlebar(c, awful.titlebar.show)
    end

    context.util.toggle_titlebar = function(c)
        set_titlebar(c, awful.titlebar.toggle)
    end

    -- Toggle client property
    do
        local toggle_client_property
        toggle_client_property = function(c, toggle, check)
            if c[check] then
                toggle_client_property(c, check, toggle)
            end
            if not c[toggle] then
                context.util.hide_titlebar(c)
            elseif c[toggle] and c.floating then
                context.util.show_titlebar(c)
            end
            c[toggle] = not c[toggle]
            c:raise()
        end

        -- Toggle fullscreen (check maximized)
        context.util.toggle_fullscreen = function(c)
            toggle_client_property(c, "fullscreen", "maximized")
        end

        -- Toggle maximized (check fullscreen)
        context.util.toggle_maximized = function(c)
            toggle_client_property(c, "maximized", "fullscreen")
        end
    end

    -- Resize/Move constants
    do
        local RESIZE_STEP = dpi(30)
        local RESIZE_FACTOR = 0.05

        local expand_direction = {
            l = "left",
            d = "down",
            u = "up",
            r = "right",
        }

        -- Get move function
        context.util.get_move_function = nil
        do
            local move_by_direction = {
                l = function(r, c) return c:relative_move(-r, 0, 0, 0) end,
                d = function(r, c) return c:relative_move(0, r, 0, 0) end,
                u = function(r, c) return c:relative_move(0, -r, 0, 0) end,
                r = function(r, c) return c:relative_move(r, 0, 0, 0) end,
            }
            context.util.get_move_function = function(direction, resize_step)
                resize_step = resize_step or RESIZE_STEP
                return function()
                    if not client.focus then return end
                    local c = client.focus
                    if context.util.client_floats(c) then
                        move_by_direction[direction](resize_step, c)
                    else
                        awful.client.swap.global_bydirection(expand_direction[direction])
                        if client.swap then client.swap:raise() end
                    end
                end
            end
        end

        -- Get resize function
        context.util.get_resize_function = nil
        do
            local resize_floating_by_direction = {
                l = function(r, c) return c:relative_move(0, 0, -r, 0) end,
                d = function(r, c) return c:relative_move(0, 0, 0, r) end,
                u = function(r, c) return c:relative_move(0, 0, 0, -r) end,
                r = function(r, c) return c:relative_move(0, 0, r, 0) end,
            }
            local resize_tiled_by_direction = {
                l = function(r) return awful.tag.incmwfact(-r) end,
                d = function(r) return awful.client.incwfact(-r) end,
                u = function(r) return awful.client.incwfact(r) end,
                r = function(r) return awful.tag.incmwfact(r) end,
            }
            context.util.get_resize_function = function(direction, resize_step, resize_factor)
                resize_step = resize_step or RESIZE_STEP
                resize_factor = resize_factor or RESIZE_FACTOR
                return function()
                    if not client.focus then return end
                    local c = client.focus
                    if context.util.client_floats(c) then
                        resize_floating_by_direction[direction](resize_step, c)
                    else
                        resize_tiled_by_direction[direction](resize_factor)
                    end
                end
            end
        end
    end

    -- Switch mode
    context.util.switch_keys_mode = function(mode, text)
        local _textbox = awful.screen.focused()._promptbox
        if not _textbox then return end
        _textbox.fg = beautiful.fg_focus
        _textbox.widget.markup = "<b>" .. text .. "</b>"
        root.keys(context.keys[mode])
    end

    -- Exit mode
    context.util.exit_keys_mode = function()
        local _textbox = awful.screen.focused()._promptbox
        if not _textbox then return end
        _textbox.fg = beautiful.prompt_fg
        _textbox.widget.markup = ""
        root.keys(context.keys.global)
    end

    -- Blur Wallpaper (only set if theme has blurred wallpaper)
    if beautiful.wallpaper_blur or beautiful.wallpaper_offset then
        context.util.set_wallpaper = function(clients)
            local w
            if clients > 0 and beautiful.wallpaper_blur then
                w = beautiful.wallpaper_blur
            elseif beautiful.wallpaper then
                w = beautiful.wallpaper
            end

            -- If 'w' is a function, call it with the screen
            if type(w) == "function" then
                w = w(client.screen)
            end

            local offset = -(tonumber(awful.screen.focused().selected_tag.index) - 1) * (beautiful.wallpaper_offset or 0)
            gears.wallpaper.tiled(w, client.screen, {x = offset})
        end

        screen.connect_signal("tag::history::update", function(s)
            context.util.set_wallpaper(#s.clients)
        end)

        client.connect_signal("tagged", function(c)
            context.util.set_wallpaper(#c.screen.clients)
        end)

        client.connect_signal("untagged", function(c)
            context.util.set_wallpaper(#c.screen.clients)
        end)

        client.connect_signal("property::minimized", function(c)
            context.util.set_wallpaper(#c.screen.clients)
        end)
    end

    -- Show widget on mouse::enter on parent, hide after mouse::leave + timeout
    context.util.show_on_mouse = function(parent, widget, timeout)
        local timer = gears.timer {
            timeout = timeout or 5,
            callback = function()
                widget:set_visible(false)
            end,
        }
        timer:start()

        parent:connect_signal("mouse::enter", function()
            widget:set_visible(true)
            timer:stop()
        end)

        parent:connect_signal("mouse::leave", function()
            timer:start()
        end)
    end

    -- Swap widget of two parent tables
    context.util.swap_widget_on_mouse = function(primary, secondary)
        local w = primary.widget

        local swap_widget = function()
            primary.widget = secondary.widget
            secondary.widget = w
            w = primary.widget
        end

        primary:connect_signal("mouse::enter", swap_widget)
        primary:connect_signal("mouse::leave", swap_widget)
    end

end

return config
