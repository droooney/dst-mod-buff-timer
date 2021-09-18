local Root = require("BuffTimer/widgets/Root")

local Constants = require("BuffTimer/Constants")
local Util = require("BuffTimer/Util")

require("constants")
require("json")

AddClassPostConstruct("widgets/controls", function (controls)
    controls.inst:DoTaskInTime(0, function ()
        controls.buffTimer = controls.top_root:AddChild(Root(
            GLOBAL.ThePlayer.player_classified.components.BuffManager,
            GLOBAL.ThePlayer.player_classified.components.TimeDifferenceManager
        ))
    end)
end)

for prefab, buffType in pairs(Constants.BuffByPrefab) do
    local onAttachBuff = function (inst, target)
        local timeLeft = inst.components.timer:GetTimeLeft("buffover")

        target.player_classified.components.BuffManager:AddBuff({
            type = buffType,
            duration = timeLeft,
        })
    end

    AddPrefabPostInit("buff_" .. prefab, function (inst)
        local onattachedfn = inst.components.debuff.onattachedfn
        local onextendedfn = inst.components.debuff.onextendedfn
        local ondetachedfn = inst.components.debuff.ondetachedfn

        inst.components.debuff:SetAttachedFn(function (inst, target, ...)
            onattachedfn(inst, target, ...)
            onAttachBuff(inst, target)
        end)

        inst.components.debuff:SetExtendedFn(function (inst, target, ...)
            onextendedfn(inst, target, ...)
            onAttachBuff(inst, target)
        end)

        inst.components.debuff:SetDetachedFn(function (inst, target, ...)
            ondetachedfn(inst, target, ...)

            target.player_classified.components.BuffManager:RemoveBuff(buffType)
        end)
    end)
end

AddModRPCHandler("BuffManager", "getBuffs", function (player, inst)
    if inst.components.BuffManager then
        local BuffManager = inst.components.BuffManager

        -- " " because json could already be the same and nothing would be updated
        BuffManager.netBuffs:set(GLOBAL.json.encode(BuffManager.buffs) .. " ")
    end
end)

AddPrefabPostInit("player_classified", function (inst)
    inst:AddComponent("BuffManager")
    inst:AddComponent("TimeDifferenceManager")
end)
