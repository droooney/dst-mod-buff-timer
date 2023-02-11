local Root = require("BuffTimerServer/widgets/Root")

local Constants = require("BuffTimerServer/Constants")

require("constants")
require("json")

AddClassPostConstruct("widgets/controls", function (controls)
    controls.inst:DoTaskInTime(0, function ()
        controls.buffTimer = controls.top_root:AddChild(Root(
            GLOBAL.ThePlayer.player_classified.components.BuffManagerServer,
            GLOBAL.ThePlayer.player_classified.components.TimeDifferenceManager
        ))
    end)
end)

for prefab, buffType in pairs(Constants.BuffByPrefab) do
    local onAttachBuff = function (inst, target)
        local player_classified = target and target.player_classified

        if not player_classified then
            return
        end

        local timeLeft = inst.components.spell
            and inst.components.spell.duration - inst.components.spell.lifetime
            or inst.components.timer
                and inst.components.timer:GetTimeLeft(Constants.BuffTimerName[buffType])
                or GLOBAL.GetTaskRemaining(inst.task)

        if not timeLeft then
            return
        end

        player_classified.components.BuffManagerServer:AddBuff({
            type = buffType,
            duration = timeLeft,
        })
    end

    local onDetachBuff = function (inst, target)
        local player_classified = target and target.player_classified

        if not player_classified then
            return
        end

        player_classified.components.BuffManagerServer:RemoveBuff(buffType)
    end

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
    end)
end

AddModRPCHandler("BuffManagerServer", "getBuffs", function (player, inst)
    if inst.components.BuffManagerServer then
        local BuffManagerServer = inst.components.BuffManagerServer

        -- " " because json could already be the same and nothing would be updated
        BuffManagerServer.netBuffs:set(GLOBAL.json.encode(BuffManagerServer.buffs) .. " ")
    end
end)

AddPrefabPostInit("player_classified", function (inst)
    inst:AddComponent("BuffManagerServer")
    inst:AddComponent("TimeDifferenceManager")
end)
