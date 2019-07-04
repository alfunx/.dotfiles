
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local treetile = require("treetile")
local markup = require("lain.util.markup")

local tags = require("config.tags")

local _config = { }

function _config.init()

    -- Check if client floats
    _config.client_floats = function(c)
        return c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating
    end

    -- Check if client floats and is not maximized of fullscreen
    _config.if_client_floats = function(fn)
        return function(c)
            if (c.floating or awful.layout.get(c.screen) == awful.layout.suit.floating)
                    and not (c.maximized or c.fullscreen) then
                fn(c)
            end
        end
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

    -- Non-empty tag browsing
    -- direction in {-1, 1} <-> {previous, next} non-empty tag
    function _config.tag_view_nonempty(direction, s)
       s = s or awful.screen.focused()

       local idx = s.selected_tag.index
       for i = 1, #s.tags do
           local t = s.tags[(idx + i * direction) % #s.tags]
           if t and #t:clients() > 0 then
               t:view_only()
               return
           end
       end
    end

    -- {{{ Dynamic tagging

    -- Add a new tag
    function _config.add_tag(layout)
        awful.prompt.run {
            prompt       = "New tag name: ",
            textbox      = awful.screen.focused()._promptbox.widget,
            exe_callback = function(name)
                if not name or #name == 0 then return end
                awful.tag.add(name, {
                    screen = awful.screen.focused(),
                    layout = layout or awful.layout.suit.tile
                }):view_only()
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
                if t then t.name = new_name end
            end
        }
    end

    -- Move current tag
    -- pos in {-1, 1} <-> {previous, next} tag position
    function _config.move_tag(pos)
        local t = awful.screen.focused().selected_tag
        if tonumber(pos) <= -1 then
            t.index = t.index - 1
        else
            t.index = t.index + 1
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

    -- {{{ Titlebars
    do
        -- Set titlebar visibility
        local set_titlebar = function(c, f)
            if beautiful.titlebar_positions then
                for _, p in pairs(beautiful.titlebar_positions) do
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
    end

    _config.hide_unneeded_titlebars = function(c)
        if not _config.client_floats(c) then
            _config.hide_titlebar(c)
        end
        if c.maximized or c.fullscreen then
            _config.hide_titlebar(c)
        end
    end

    _config.hide_all_unneeded_titlebars = function()
        client.connect_signal("property::floating", function(c)
            if c.floating and not c.maximized and not c.fullscreen then
                _config.show_titlebar(c)
            else
                _config.hide_titlebar(c)
            end
        end)

        client.connect_signal("property::fullscreen", function(c)
            if c.fullscreen then
                _config.hide_titlebar(c)
            end
        end)

        client.connect_signal("property::maximized", function(c)
            if c.maximized then
                _config.hide_titlebar(c)
            end
        end)
    end
    -- }}}

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

    -- Get resize functions (horizontal / vertical)
    do
        local resize_horizontal_by_layout = {
            tile       = function(r) return awful.tag.incmwfact( r) end,
            tileleft   = function(r) return awful.tag.incmwfact(-r) end,
            tiletop    = function(r) return awful.client.incwfact(r) end,
            tilebottom = function(r) return awful.client.incwfact(r) end,
            treetile   = function(r) return treetile.resize_horizontal(r) end,
        }

        local resize_vertical_by_layout = {
            tile       = function(r) return awful.client.incwfact(r) end,
            tileleft   = function(r) return awful.client.incwfact(r) end,
            tiletop    = function(r) return awful.tag.incmwfact( r) end,
            tilebottom = function(r) return awful.tag.incmwfact(-r) end,
            treetile   = function(r) return treetile.resize_vertical(-r) end,
        }

        _config.resize_horizontal = function(r)
            local l = awful.layout.getname(awful.layout.get(awful.screen.focused()))
            local fn = resize_horizontal_by_layout[l] or resize_horizontal_by_layout.tile
            fn(r)
        end

        _config.resize_vertical = function(r)
            local l = awful.layout.getname(awful.layout.get(awful.screen.focused()))
            local fn = resize_vertical_by_layout[l] or resize_horizontal_by_layout.tile
            fn(r)
        end
    end

    do
        -- Resize/Move constants
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
                l = function(r, c) return c:relative_move(-r,  0, 0, 0) end,
                d = function(r, c) return c:relative_move( 0,  r, 0, 0) end,
                u = function(r, c) return c:relative_move( 0, -r, 0, 0) end,
                r = function(r, c) return c:relative_move( r,  0, 0, 0) end,
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
                l = function(r, c) return c:relative_move(0, 0, -r,  0) end,
                d = function(r, c) return c:relative_move(0, 0,  0,  r) end,
                u = function(r, c) return c:relative_move(0, 0,  0, -r) end,
                r = function(r, c) return c:relative_move(0, 0,  r,  0) end,
            }
            local resize_tiled_by_direction = {
                l = function(r) return _config.resize_horizontal(-r) end,
                d = function(r) return _config.resize_vertical(-r) end,
                u = function(r) return _config.resize_vertical( r) end,
                r = function(r) return _config.resize_horizontal( r) end,
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
            t.widget:set_markup(markup.bold(text))
        else
            t.fg = beautiful.prompt_fg
            t.widget:set_markup("")
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
            bg                = "#00ff0033",
            ontop             = true,
            input_passthrough = true,
        }
        function c._shade_update()
            local geo       = c:geometry()
            c._shade.x      = geo.x - c.border_width
            c._shade.y      = geo.y - c.border_width
            c._shade.width  = geo.width  + 4*c.border_width
            c._shade.height = geo.height + 4*c.border_width
            c._shade.bg     = c == client.focus and "#ff000033" or "#00ff0033"
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
    _config.default_popup = function(args)
        args.width   = args.width   or 96
        args.height  = args.height  or 96
        args.timeout = args.timeout or 1
        args.screen  = args.screen  or screen[1]

        local popup = awful.popup {
            screen = args.screen,
            widget = {
                {
                    {
                        args.widget,
                        widget = wibox.container.place
                    },
                    margins = 16,
                    widget  = wibox.container.margin,
                },
                forced_width  = args.width,
                forced_height = args.height,
                widget        = wibox.container.background,
            },
            border_color = beautiful.border_normal,
            border_width = beautiful.border_width,
            ontop        = true,
            visible      = false,
            placement    = awful.placement.centered,
        }

        local mouse_enter = false
        local t = gears.timer {
            timeout     = args.timeout,
            single_shot = true,
            callback    = function()
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
        if type(release) == 'table' then
            data=release
            release=nil
        end

        -- append custom userdata (like description) to a hotkey
        data = data and gears.table.clone(data) or { }
        gears.table.crush(data, {
            mod     = mod,
            key     = _key,
            press   = press,
            release = release,
            execute = function(_) awful.key.execute(mod, _key) end,
        })
        table.insert(awful.key.hotkeys, data)

        return { }
    end

    _config.global_history_get = function(s, idx, filter)
        -- When this counter is equal to idx, we return the client
        local counter = 0
        for _, c in ipairs(awful.client.focus.history.list) do
            if c.screen == s then
                if not filter or filter(c) then
                    for _, vcc in ipairs(s.all_clients) do
                        if vcc == c then
                            if counter == idx then
                                return c
                            end
                            -- We found one, increment the counter only.
                            counter = counter + 1
                            break
                        end
                    end
                end
            end
        end
        -- Argh nobody found in history, give the first one visible if there is one
        -- that passes the filter.
        filter = filter or awful.client.focus.filter
        if counter == 0 then
            for _, v in ipairs(s.all_clients) do
                if filter(v) then
                    return v
                end
            end
        end
    end

end

return _config
