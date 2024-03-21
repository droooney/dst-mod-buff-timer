local inspect = require("inspect")

local Constants = require("BuffTimerServer/Constants")

require("constants")
require("strings")
require("stringutil")

return {
    Inspect = function (self, value)
        return inspect(value)
    end,

    Log = function (self, ...)
        print("[Buff Timer]:", ...)
    end,

    FindIndex = function (self, array, cb)
        for i, v in ipairs(array) do
            if cb(v, i, array) then
                return i
            end
        end

        return 0
    end,

    ForEach = function (self, array, cb)
        for i, v in ipairs(array) do
            cb(v, i)
        end
    end,

    Reduce = function (self, array, cb, initialValue)
        local value = initialValue

        self:ForEach(array, function (v, i)
            value = cb(value, v, i)
        end)

        return value
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

    GetPlayerClassified = function (self, target)
        return target and (target.player_classified or target.classified or (target._playerlink and target._playerlink.player_classified))
    end,

    GetBuffCallbacks = function (self, buffType)
        local onAttachBuff = function (inst, target)
            inst:DoTaskInTime(0, function ()
                local player_classified = self:GetPlayerClassified(target)

                if not player_classified then
                    return
                end

                local timeLeft = inst.components.spell
                    and inst.components.spell.duration - inst.components.spell.lifetime
                    or inst.components.timer
                        and inst.components.timer:GetTimeLeft(Constants.BuffTimerName[buffType])
                        or GetTaskRemaining(inst.task or inst.bufftask or (inst.components.temperature and inst.components.temperature.bellytask))

                if not timeLeft then
                    return
                end

                player_classified.components.BuffManagerServer:AddBuff({
                    type = buffType,
                    duration = timeLeft,
                })
            end)
        end

        local onDetachBuff = function (inst, target)
            inst:DoTaskInTime(0, function ()
                local player_classified = self:GetPlayerClassified(target)

                if not player_classified then
                    return
                end

                player_classified.components.BuffManagerServer:RemoveBuff(buffType)
            end)
        end

        return onAttachBuff, onDetachBuff
    end,
}
