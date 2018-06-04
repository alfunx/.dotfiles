local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local config = {}

function config.init(context)

    -- Check if client floats
    context.client_floats = function(c)
        if awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating then
            return true
        end
        return false
    end

    -- Spawn a process
    context.run_once = function(cmd_arr)
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
    context.spawn_once = function(command, class, tag)
        -- create move callback
        local callback
        callback = function(c)
            if c.class == class then
                c:move_to_tag(tag)
                client.disconnect_signal("manage", callback)
            end
        end
        client.connect_signal("manage", callback)

        -- now check if not already running!
        local findme = command
        local firstspace = findme:find(" ")
        if firstspace then
            findme = findme:sub(0, firstspace-1)
        end

        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, command))
    end

    -- Spawn process and unfocus current client until process exits (useful for
    -- e.g. rofi or dmenu)
    context.easy_async_with_unfocus = function(cmd, callback)
        callback = callback or function() end
        local c = client.focus
        client.focus = nil
        awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
            callback(stdout, stderr, reason, exit_code)
            client.focus = c
        end)
    end

    -- Select tag by direction in a grid (taggrid feature)
    context.select_tag_in_grid = function() end
    do
        local columns = awful.util.tagcolumns or #awful.util.tagnames
        local index_by_direction = {
            l = function(i) return (math.ceil((i) / columns) - 1) * columns + ((i - 2) % columns) + 1 end,
            r = function(i) return (math.ceil((i) / columns) - 1) * columns + ((i) % columns) + 1 end,
            u = function(i, rows) return (i - 1 - columns) % (rows * columns) + 1 end,
            d = function(i, rows) return (i - 1 + columns) % (rows * columns) + 1 end
        }
        context.select_tag_in_grid = function(direction, current_index)
            local rows = math.ceil(#awful.screen.focused().tags / columns)
            local index = current_index or awful.screen.focused().selected_tag.index
            local new_index = index_by_direction[direction](index, rows)

            local new_tag = awful.screen.focused().tags[new_index]
            if new_tag then
                new_tag:view_only()
                return new_tag
            end
            context.select_tag_in_grid(direction, new_index)
        end
    end

    -- Move client to tag by direction in a grid (taggrid feature)
    context.move_client_in_grid = function(direction)
        if client.focus then
            local current_client = client.focus
            local new_tag = context.select_tag_in_grid(direction)
            current_client:move_to_tag(new_tag)
            current_client:raise()
        end
    end

    -- Toggle client property
    local toggle_client_property
    toggle_client_property = function(c, toggle, check)
        if c[check] then
            toggle_client_property(c, check, toggle)
        end
        if not c[toggle] then
            awful.titlebar.hide(c)
        elseif c[toggle] and c.floating then
            awful.titlebar.show(c)
        end
        c[toggle] = not c[toggle]
        c:raise()
    end

    -- Toggle fullscreen (check maximized)
    context.toggle_fullscreen = function(c)
        toggle_client_property(c, "fullscreen", "maximized")
    end

    -- Toggle maximized (check fullscreen)
    context.toggle_maximized = function(c)
        toggle_client_property(c, "maximized", "fullscreen")
    end

    -- Resize/Move constants
    local RESIZE_STEP = dpi(30)
    local RESIZE_FACTOR = 0.05

    local expand_direction = {
        l = "left",
        d = "down",
        u = "up",
        r = "right",
    }

    -- Get move function
    context.get_move_function = function() end
    do
        local move_by_direction = {
            l = function(r, c) return c:relative_move(-r, 0, 0, 0) end,
            d = function(r, c) return c:relative_move(0, r, 0, 0) end,
            u = function(r, c) return c:relative_move(0, -r, 0, 0) end,
            r = function(r, c) return c:relative_move(r, 0, 0, 0) end,
        }
        context.get_move_function = function(direction, resize_step)
            if not resize_step then resize_step = RESIZE_STEP end
            return function()
                if not client.focus then return end
                local c = client.focus
                if context.client_floats(c) then
                    move_by_direction[direction](resize_step, c)
                else
                    awful.client.swap.global_bydirection(expand_direction[direction])
                    if client.swap then client.swap:raise() end
                end
            end
        end
    end

    -- Get resize function
    context.get_resize_function = function() end
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
        context.get_resize_function = function(direction, resize_step, resize_factor)
            if not resize_step then resize_step = RESIZE_STEP end
            if not resize_factor then resize_factor = RESIZE_FACTOR end
            return function()
                if not client.focus then return end
                local c = client.focus
                if context.client_floats(c) then
                    resize_floating_by_direction[direction](resize_step, c)
                else
                    resize_tiled_by_direction[direction](resize_factor)
                end
            end
        end
    end

    -- Switch mode
    context.switch_keys_mode = function(mode, text)
        local _textbox = awful.screen.focused()._promptbox
        if not _textbox then return end
        _textbox.fg = beautiful.fg_focus
        _textbox.widget.markup = "<b>" .. text .. "</b>"
        root.keys(context.keys[mode])
    end

    -- Exit mode
    context.exit_keys_mode = function()
        local _textbox = awful.screen.focused()._promptbox
        if not _textbox then return end
        _textbox.fg = beautiful.prompt_fg
        _textbox.widget.markup = ""
        root.keys(context.keys.global)
    end

    -- Blur Wallpaper (only set if theme has blurred wallpaper)
    if beautiful.wallpaper_blur or beautiful.wallpaper_offset then
        context.set_wallpaper = function(clients)
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
            context.set_wallpaper(#s.clients)
        end)

        client.connect_signal("tagged", function(c)
            context.set_wallpaper(#c.screen.clients)
        end)

        client.connect_signal("untagged", function(c)
            context.set_wallpaper(#c.screen.clients)
        end)

        client.connect_signal("property::minimized", function(c)
            context.set_wallpaper(#c.screen.clients)
        end)
    end

end

return config
