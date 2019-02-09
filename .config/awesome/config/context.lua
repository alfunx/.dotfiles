
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local gears = require("gears")

local _config = { }

function _config.init(context)

    gears.table.crush(_config, context)

end

return _config
