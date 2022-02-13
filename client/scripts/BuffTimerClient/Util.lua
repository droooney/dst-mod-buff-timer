local inspect = require("inspect")

require("constants")
require("strings")
require("stringutil")

local DEBUG_MODE = false

DEBUG_MODE = true

local SERVER_MOD_NAMES = {"workshop-2630628898", "dst-mod-buff-timer-server"}

return {
    Inspect = function (self, value)
        return inspect(value)
    end,

    Log = function (self, ...)
        if DEBUG_MODE then
            print("[Buff Timer (server)]:", ...)
        end
    end,

    EndsWith = function (self, str, ending)
        return ending == "" or str:sub(-#ending) == ending
    end,

    StartsWith = function (self, str, start)
        return str:sub(1, #start) == start
    end,

    FindInObject = function (self, object, cb)
        for k, v in pairs(object) do
            if cb(v, k, object) then
                return v
            end
        end

        return nil
    end,

    FindIndex = function (self, array, cb)
        for i, v in ipairs(array) do
            if cb(v, i, array) then
                return i
            end
        end

        return 0
    end,

    IndexOf = function (self, array, value)
        return self:FindIndex(array, function (arrayValue)
            return arrayValue == value
        end)
    end,

    Includes = function (self, array, value)
        return self:IndexOf(array, value) ~= 0
    end,

    ForEach = function (self, array, cb)
        for i, v in ipairs(array) do
            cb(v, i)
        end
    end,

    Some = function (self, array, cb)
        for i, v in ipairs(array) do
            if cb(v, i) then
                return true
            end
        end

        return false
    end,

    KillAllWidgets = function (self, widgets)
        self:ForEach(widgets, function (widget) widget:Kill() end)
    end,

    GetInventoryItemAtlas = function (self, itemTex)
        return GetInventoryItemAtlas(itemTex)
    end,

    GetHUDAtlas = function ()
        return resolvefilepath("images/hud.xml")
    end,

    HasServerMod = function (self)
        local serverMods = ModManager:GetServerModsNames()

        return self:Some(serverMods, function (serverMod)
            return self:Includes(SERVER_MOD_NAMES, serverMod)
        end)
    end,
}
