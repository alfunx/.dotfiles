
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local widgets = require("widgets")

local context = require("config.context")

local _config = { }

function _config.init()

    _config.widget = widgets.sidebar {
        mouse_toggle = true,
        colors = context.colors,
        vars = context.vars,
    }

end

return _config
