
--[[

     Licensed under GNU General Public License v2
      * (c) 2017, Alphonse Mariyagnanaseelan

      ------------------
      --  DEPRECATED  --
      ------------------

--]]

local helpers      = require("lain.helpers")
local markup       = require("lain.util.markup")
local awful        = require("awful")
local beautiful    = require("beautiful")
naughty            = require("naughty")
local mouse        = mouse
local os           = { date   = os.date }
local string       = { format = string.format,
                       gsub   = string.gsub }
local ipairs       = ipairs
local tonumber     = tonumber
local setmetatable = setmetatable

-- Eventhandler notification
-- lain.widget.eventhandler
eventhandler = {}

function eventhandler.attach_click(widget)
    -- widget:connect_signal("mouse::enter", eventhandler.hover_on)
    -- widget:connect_signal("mouse::leave", eventhandler.hover_off)
    -- widget:buttons(awful.util.table.join(
                -- awful.button({}, 1, eventhandler.execute)))
    widget:buttons(awful.button({}, 1, eventhandler.execute))
end

function eventhandler.attach_hover(widget)
    widget:connect_signal("mouse::enter", eventhandler.execute)
    widget:connect_signal("mouse::leave", function()
        if not widget.notification then return end
        naughty.destroy(widget.notification)
        widget.notifications = nil
    end)
end

function eventhandler.notify(args)
    if eventhandler.notification then
        naughty.destroy(eventhandler.notification)
    end
    eventhandler.notification = naughty.notify(args)
end

local function factory(args)
    local args                = args or {}
    eventhandler.attach_to    = args.attach_to or {}
    eventhandler.execute      = args.execute or function() end
    eventhandler.attach       = args.attach or eventhandler.attach_click
    eventhandler.notification = nil

    for i, widget in ipairs(eventhandler.attach_to) do
        eventhandler.attach(widget)
    end
end

return setmetatable(eventhandler, { __call = function(_, ...) return factory(...) end })
