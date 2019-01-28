
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local widgets = require("widgets")

local config = { }

function config.init(context)

    context.sidebar = widgets.sidebar(context, {
        mouse_toggle = true,
        colors = context.colors,
    })
    context.sidebar.show()

end

return config
