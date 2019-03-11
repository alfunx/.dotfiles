
--[[

     Awesome WM configuration
     by alfunx (Alphonse Mariya)

--]]

local awful = require("awful")

local _config = { }

function _config.init()

    local blacklisted_snid = setmetatable({}, {__mode = "v" })

    --- Make startup notification work for some clients like XTerm. This is ugly
    -- but works often enough to be useful.
    local function fix_startup_id(c)
        -- Prevent "broken" sub processes created by <code>c</code> to inherit its SNID
        if c.startup_id then
            blacklisted_snid[c.startup_id] = blacklisted_snid[c.startup_id] or c
            return
        end

        if not c.pid then return end

        -- Read the process environment variables
        local f = io.open("/proc/"..c.pid.."/environ", "rb")

        -- It will only work on Linux, that's already 99% of the userbase.
        if not f then return end

        local value = _VERSION <= "Lua 5.1" and "([^\z]*)\0" or "([^\0]*)\0"
        local snid = f:read("*all"):match("STARTUP_ID=" .. value)
        f:close()

        -- If there is already a client using this SNID, it means it's either a
        -- subprocess or another window for the same process. While it makes sense
        -- in some case to apply the same rules, it is not always the case, so
        -- better doing nothing rather than something stupid.
        if blacklisted_snid[snid] then return end

        c.startup_id = snid

        blacklisted_snid[snid] = c
    end

    awful.rules.add_rule_source(
        "snid", fix_startup_id, { }, { "awful.spawn", "awful.rules" }
    )

end

return _config
