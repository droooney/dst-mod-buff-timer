local Root = require("BuffTimerServer/widgets/Root")

local Constants = require("BuffTimerServer/Constants")
local Util = require("BuffTimerServer/Util")

require("constants")
require("json")

AddClassPostConstruct("widgets/controls", function (controls)
    controls.inst:DoTaskInTime(0, function ()
        controls.buffTimer = controls.top_root:AddChild(Root(
            controls,
            GLOBAL.ThePlayer.player_classified.components.BuffManagerServer,
            GLOBAL.ThePlayer.player_classified.components.TimeDifferenceManager
        ))
    end)
end)

for prefab, buffType in pairs(Constants.BuffByPrefab) do
    local onAttachBuff, onDetachBuff = Util:GetBuffCallbacks(buffType)

    AddPrefabPostInit(prefab, function (inst)
        if inst.components.spell then
            local spell = inst.components.spell

            local onstartfn = spell.onstartfn
            local resumefn = spell.resumefn
            local onfinishfn = spell.onfinishfn

            spell.onstartfn = function(...)
                if onstartfn then
                    onstartfn(...)
                end

                onAttachBuff(inst, spell.target)
            end

            spell.resumefn = function(...)
                if resumefn then
                    resumefn(...)
                end

                onAttachBuff(inst, spell.target)
            end

            spell.onfinishfn = function(...)
                if onfinishfn then
                    onfinishfn(...)
                end

                onDetachBuff(inst, spell.target)
            end

            return
        end

        if inst.components.debuff then
            local onattachedfn = inst.components.debuff.onattachedfn
            local onextendedfn = inst.components.debuff.onextendedfn
            local ondetachedfn = inst.components.debuff.ondetachedfn

            inst.components.debuff:SetAttachedFn(function (inst, target, ...)
                if onattachedfn then
                    onattachedfn(inst, target, ...)
                end

                onAttachBuff(inst, target)
            end)

            inst.components.debuff:SetExtendedFn(function (inst, target, ...)
                if onextendedfn then
                    onextendedfn(inst, target, ...)
                end

                onAttachBuff(inst, target)
            end)

            inst.components.debuff:SetDetachedFn(function (inst, target, ...)
                if ondetachedfn then
                    ondetachedfn(inst, target, ...)
                end

                onDetachBuff(inst, target)
            end)
        end
    end)
end

AddModRPCHandler("BuffManagerServer", "getBuffs", function (player, inst)
    local BuffManagerServer = inst.components.BuffManagerServer

    if not BuffManagerServer then
        return
    end

    -- " " because json could already be the same and nothing would be updated
    BuffManagerServer.netBuffs:set(GLOBAL.json.encode(BuffManagerServer.buffs) .. " ")
end)

AddPrefabPostInit("player_classified", function (inst)
    inst:AddComponent("BuffManagerServer")
    inst:AddComponent("TimeDifferenceManager")

    inst:DoTaskInTime(0, function ()
        local temperature = inst._parent and inst._parent.components.temperature

        if not temperature then
            return
        end

        local target = inst._parent
        local onDragonChiliSaladAttachBuff, onDragonChiliSaladDetachBuff = Util:GetBuffCallbacks(Constants.BuffType.DRAGON_CHILI_SALAD)
        local onAsparagazpachoAttachBuff, onAsparagazpachoDetachBuff = Util:GetBuffCallbacks(Constants.BuffType.ASPARAGAZPACHO)

        local tryAttachBuff = function ()
            -- if it's less than 15 seconds, even if it's the buff food it's whatever
            if not temperature.bellytask or GLOBAL.GetTaskRemaining(temperature.bellytask) < GLOBAL.TUNING.FOOD_TEMP_LONG + 1 then
                return
            end

            local onfinish = temperature.bellytask.onfinishfn

            temperature.bellytask.onfinish = function (...)
                if onfinish then
                    onfinish(...)
                end

                onDragonChiliSaladDetachBuff(target, target)
                onAsparagazpachoDetachBuff(target, target)
            end

            if temperature.bellytemperaturedelta > 0 then
                onDragonChiliSaladAttachBuff(target, target)
            else
                onAsparagazpachoAttachBuff(target, target)
            end
        end

        local oldSetTemperatureInBelly = temperature.SetTemperatureInBelly

        temperature.SetTemperatureInBelly = function ( ...)
            oldSetTemperatureInBelly(...)

            tryAttachBuff()
        end

        tryAttachBuff()
    end)
end)
