local inspect = require("inspect")

require("constants")
require("strings")
require("stringutil")

local DEBUG_MODE = true

-- DEBUG_MODE = false

return {
    IsDST = TheSim:GetGameID() == "DST",

    GetWorld = function (self)
        return self.IsDST and TheWorld or GetWorld()
    end,

    GetPlayer = function (self)
        return self.IsDST and ThePlayer or GetPlayer()
    end,

    Inspect = function (self, value)
        return inspect(value)
    end,

    Log = function (self, ...)
        if DEBUG_MODE then
            print("[Spice Timer]:", ...)
        end
    end,

    EndsWith = function (self, str, ending)
        return ending == "" or str:sub(-#ending) == ending
    end,
}
