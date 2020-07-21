
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local widgets = require("widgets")

local context = require("config.context")

local _config = { }

function _config.init()

    _config.widget = widgets.sidebar {
        mouse_toggle = false,
        colors       = context.colors,
        vars         = context.vars,
    }

end

return _config
