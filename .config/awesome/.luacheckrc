-- Only allow symbols available in all Lua versions
std = "min"

-- Get rid of "unused argument self"-warnings
self = false

----function f()
--    --a, b, c = call() ; return a, b  -- unused "c"
----end
--unused_secondaries = false

-- The unit tests can use busted
--files["spec"].std = "+busted"

--
ignore = {
    "212/_.*",
}

-- The .luacheck config may set global variables
files[".luacheckrc"] = {
    allow_defined_top = true,
    ignore = { "131", "112" },
}

-- Global objects defined by the C code
read_globals = {
    "awesome",
    "button",
    "dbus",
    "drawable",
    "drawin",
    "key",
    "keygrabber",
    "mousegrabber",
    "root",
    "selection",
    "tag",
    "window",
    "table.unpack",
    "unpack",
    "math.atan2",
    "jit",
    "pack",
    "unpack"
}

-- May not be read-only due to client.focus
globals = {
    "screen",
    "mouse",
    "client",
    "nlog",
    "log",
    "context",
}

exclude_files = {
    "third_party/*",
    "actionless/menubar/*",
    "misc/*",
    "**/*lcars*", -- @TODO
}

codes = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
