
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

--luacheck: push ignore
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local pairs, ipairs, string, os, table, math, tostring, tonumber, type = pairs, ipairs, string, os, table, math, tostring, tonumber, type
--luacheck: pop

local context = require("config.context")

local _config = { }

function _config.init()

    _config.m = context.keys.modkey
    _config.c = context.keys.ctrlkey
    _config.a = context.keys.altkey
    _config.s = context.keys.shiftkey
    _config.l = context.keys.leftkey
    _config.r = context.keys.rightkey
    _config.u = context.keys.upkey
    _config.d = context.keys.downkey
    _config.l_a = context.keys.leftkey_alt
    _config.r_a = context.keys.rightkey_alt
    _config.u_a = context.keys.upkey_alt
    _config.d_a = context.keys.downkey_alt

end

return _config
