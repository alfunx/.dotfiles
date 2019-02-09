
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local _config = {

    context = require("config.context"),

    brokers = require("config.brokers"),
    tags = require("config.tags"),
    util = require("config.util"),
    util_theme = require("config.util_theme"),

    keys = require("config.keys"),
    bindings_global = require("config.bindings_global"),
    bindings_client = require("config.bindings_client"),
    bindings_command = require("config.bindings_command"),
    bindings_taglist = require("config.bindings_taglist"),
    bindings_tasklist = require("config.bindings_tasklist"),

    menu = require("config.menu"),
    popups = require("config.popups"),
    sidebar = require("config.sidebar"),

    rules = require("config.rules"),
    signals = require("config.signals"),
    screen = require("config.screen"),

}

return _config
