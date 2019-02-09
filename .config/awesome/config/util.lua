
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local markup = require("lain.util.markup")

local tags = require("config.tags")

local _config = { }

function _config.init()

    -- Check if client floats
    _config.client_floats = function(c)
        return awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating
    end

    -- Spawn process and adjust border color current client until process exits
    -- (useful for e.g. rofi or dmenu)
    _config.easy_async_with_unfocus = function(cmd, callback)
        local c = client.focus
        callback = callback or function() end
        if c then c:emit_signal("unfocus") end
        awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
            callback(stdout, stderr, reason, exit_code)
            if c then c:emit_signal("focus") end
        end)
    end

    -- Select tag by direction in a grid (taggrid feature)
    _config.select_tag_in_grid = nil
    do
        local columns = tags.columns or #tags.names
        local index_by_direction = {
            l = function(i) return (math.ceil((i) / columns) - 1) * columns + ((i - 2) % columns) + 1 end,
            r = function(i) return (math.ceil((i) / columns) - 1) * columns + ((i) % columns) + 1 end,
            u = function(i, rows) return (i - 1 - columns) % (rows * columns) + 1 end,
            d = function(i, rows) return (i - 1 + columns) % (rows * columns) + 1 end
        }
        _config.select_tag_in_grid = function(direction, current_index)
            local rows = math.ceil(#awful.screen.focused().tags / columns)
            local index = current_index or awful.screen.focused().selected_tag.index
            local new_index = index_by_direction[direction](index, rows)

            local new_tag = awful.screen.focused().tags[new_index]
            if new_tag then
                new_tag:view_only()
                return new_tag
            end
            _config.select_tag_in_grid(direction, new_index)
        end
    end

    -- Move client to tag by direction in a grid (taggrid feature)
    _config.move_client_in_grid = function(c, direction)
        local new_tag = _config.select_tag_in_grid(direction)
        c:move_to_tag(new_tag)
        c:raise()
    end

    -- Show only tags of current row (taggrid feature)
    _config.rowfilter = function(t)
        local index = t.index
        local selected = awful.screen.focused().selected_tag.index
        if not index or not selected then return false end
        local columns = tags.columns or #tags.names
        return math.floor((index - 1) / columns) == math.floor((selected - 1) / columns)
    end

    -- {{{ Dynamic tagging

    -- Add a new tag
    function _config.add_tag(layout)
        awful.prompt.run {
            prompt       = "New tag name: ",
            textbox      = awful.screen.focused()._promptbox.widget,
            exe_callback = function(name)
                if not name or #name == 0 then return end
                awful.tag.add(name, { screen = awful.screen.focused(), layout = layout or awful.layout.suit.tile }):view_only()
            end
        }
    end

    -- Rename current tag
    function _config.rename_tag()
        awful.prompt.run {
            prompt       = "Rename tag: ",
            textbox      = awful.screen.focused()._promptbox.widget,
            exe_callback = function(new_name)
                if not new_name or #new_name == 0 then return end
                local t = awful.screen.focused().selected_tag
                if t then
                    t.name = new_name
                end
            end
        }
    end

    -- Move current tag
    -- pos in {-1, 1} <-> {previous, next} tag position
    function _config.move_tag(pos)
        local tag = awful.screen.focused().selected_tag
        if tonumber(pos) <= -1 then
            awful.tag.move(tag.index - 1, tag)
        else
            awful.tag.move(tag.index + 1, tag)
        end
    end

    -- Delete current tag
    -- Any rule set on the tag shall be broken
    function _config.delete_tag()
        local t = awful.screen.focused().selected_tag
        if not t then return end
        t:delete()
    end

    -- }}}

    -- Set titlebar visibility
    local set_titlebar = function(c, f)
        if beautiful.titlebar_positions then
            for _, p in ipairs(beautiful.titlebar_positions) do
                f(c, p)
            end
        else
            f(c)
        end
    end

    _config.hide_titlebar = function(c)
        set_titlebar(c, awful.titlebar.hide)
    end

    _config.show_titlebar = function(c)
        set_titlebar(c, awful.titlebar.show)
    end

    _config.toggle_titlebar = function(c)
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
                _config.hide_titlebar(c)
            elseif c[toggle] and c.floating then
                _config.show_titlebar(c)
            end
            c[toggle] = not c[toggle]
            c:raise()
        end

        -- Toggle fullscreen (check maximized)
        _config.toggle_fullscreen = function(c)
            toggle_client_property(c, "fullscreen", "maximized")
        end

        -- Toggle maximized (check fullscreen)
        _config.toggle_maximized = function(c)
            toggle_client_property(c, "maximized", "fullscreen")
        end
    end

    -- Resize/Move constants
    do
        local RESIZE_STEP = 30
        local RESIZE_FACTOR = 0.05

        local expand_direction = {
            l = "left",
            d = "down",
            u = "up",
            r = "right",
        }

        -- Get move function
        _config.get_move_function = nil
        do
            local move_by_direction = {
                l = function(r, c) return c:relative_move(-r, 0, 0, 0) end,
                d = function(r, c) return c:relative_move(0, r, 0, 0) end,
                u = function(r, c) return c:relative_move(0, -r, 0, 0) end,
                r = function(r, c) return c:relative_move(r, 0, 0, 0) end,
            }
            _config.get_move_function = function(direction, resize_step)
                resize_step = resize_step or RESIZE_STEP
                return function()
                    local c = client.focus
                    if c and _config.client_floats(c) then
                        move_by_direction[direction](resize_step, c)
                    else
                        awful.client.swap.global_bydirection(expand_direction[direction])
                        if client.swap then client.swap:raise() end
                    end
                end
            end
        end

        -- Get resize function
        _config.get_resize_function = nil
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
            _config.get_resize_function = function(direction, resize_step, resize_factor)
                resize_step = resize_step or RESIZE_STEP
                resize_factor = resize_factor or RESIZE_FACTOR
                return function()
                    local c = client.focus
                    if c and _config.client_floats(c) then
                        resize_floating_by_direction[direction](resize_step, c)
                    else
                        resize_tiled_by_direction[direction](resize_factor)
                    end
                end
            end
        end
    end

    -- Set mode
    _config.set_mode = function(text)
        local t = awful.screen.focused()._promptbox
        if not t then return end

        if text then
            t.fg = beautiful.tasklist_fg_urgent or beautiful.fg_focus
            t.widget.markup = markup.bold(text)
        else
            t.fg = beautiful.prompt_fg
            t.widget.markup = ""
        end
    end

    -- Show shade
    _config.show_shade = function(c)
        if c._shade then
            c._shade_update()
            c._shade.visible = true
            return
        end

        c._shade = wibox {
            bg = "#00ff0033",
            ontop = true,
            input_passthrough = true,
        }
        function c._shade_update()
            local geo = c:geometry()
            c._shade.x = geo.x - c.border_width
            c._shade.y = geo.y - c.border_width
            c._shade.width = geo.width + 4*c.border_width
            c._shade.height = geo.height + 4*c.border_width
            c._shade.bg = c == client.focus and "#ff000033" or "#00ff0033"
        end

        c:connect_signal("property::geometry", c._shade_update)
        c:connect_signal("property::shape_client_bounding", function()
            gears.timer.delayed_call(c._shade_update)
        end)
        c:connect_signal("unmanage", function()
            c._shade.visible = false
        end)
        c:connect_signal("focus", c._shade_update)
        c:connect_signal("unfocus", c._shade_update)

        c._shade_update()
        c._shade.visible = true
    end

    -- Hide shade
    _config.hide_shade = function(c)
        if c._shade then
            c._shade.visible = false
        end
    end

    -- Blur wallpaper (only set if theme has blurred wallpaper)
    if beautiful.wallpaper_blur or beautiful.wallpaper_offset then
        _config.set_wallpaper = function(clients)
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

            local offset = - (tonumber(awful.screen.focused().selected_tag.index) - 1)
                           * (beautiful.wallpaper_offset or 0)
            gears.wallpaper.tiled(w, client.screen, {x = offset})
        end

        screen.connect_signal("tag::history::update", function(s)
            _config.set_wallpaper(#s.clients)
        end)

        client.connect_signal("tagged", function(c)
            _config.set_wallpaper(#c.screen.clients)
        end)

        client.connect_signal("untagged", function(c)
            _config.set_wallpaper(#c.screen.clients)
        end)

        client.connect_signal("property::minimized", function(c)
            _config.set_wallpaper(#c.screen.clients)
        end)
    end

    -- Show widget on mouse::enter on parent, hide after mouse::leave + timeout
    _config.show_on_mouse = function(parent, widget, timeout)
        local t = gears.timer {
            timeout = timeout or 5,
            single_shot = true,
            callback = function()
                widget.visible = false
            end,
        }

        parent:connect_signal("mouse::enter", function()
            widget.visible = true
            if t.started then t:stop() end
        end)

        parent:connect_signal("mouse::leave", function()
            t:again()
        end)
    end

    -- Create default popup
    _config.popup = function(args)
        args.width = args.width or 96
        args.height = args.height or 96
        args.timeout = args.timeout or 1

        local popup = awful.popup {
            widget = {
                {
                    {
                        args.widget,
                        widget = wibox.container.place
                    },
                    margins = 16,
                    widget = wibox.container.margin,
                },
                forced_width = args.width,
                forced_height = args.height,
                widget = wibox.container.background,
            },
            border_color = beautiful.border_normal,
            border_width = beautiful.border_width,
            ontop = true,
            visible = false,
            placement = awful.placement.centered,
        }

        local mouse_enter = false
        local t = gears.timer {
            timeout = args.timeout,
            single_shot = true,
            callback = function()
                if mouse_enter then return end
                popup.visible = false
            end,
        }

        -- Show popup
        function popup:show()
            self.visible = true
            t:again()
        end

        popup:connect_signal("mouse::enter", function()
            mouse_enter = true
            if t.started then t:stop() end
        end)

        popup:connect_signal("mouse::leave", function()
            mouse_enter = false
            t:again()
        end)

        return popup
    end

    _config.show_tasklist = function()
        local s = awful.screen.focused()
        if not s._tasklist_wibox then return end
        if s.selected_tag.layout == awful.layout.suit.max then
            s._tasklist_wibox:show()
        end
    end

    -- Add fake bindings (based on awful.key)
    _config.fake_key = function(mod, _key, press, release, data)
        if type(release)=='table' then
            data=release
            release=nil
        end

        -- append custom userdata (like description) to a hotkey
        data = data and gears.table.clone(data) or { }
        data.mod = mod
        data.key = _key
        data.press = press
        data.release = release
        table.insert(awful.key.hotkeys, data)
        data.execute = function(_) awful.key.execute(mod, _key) end

        return { }
    end

end

return _config
