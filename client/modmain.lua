local Constants = require("BuffTimerClient/Constants")
local Util = require("BuffTimerClient/Util")

local Root = require("BuffTimerClient/widgets/Root")

function onAction(action)
    local item = action.invobject
    local target = action.target

    if item == nil then
        return
    end

    -- TODO: add support for wigfrid/wurt/warly not being able to eat certain foods
    -- TODO: add action delay
    -- TODO: change temp buff on other foods

    local buffs = {}

    if action.action.id == "EAT" then
        buffs = {
            Util:FindInObject(Constants.BuffByFoodPrefab, function (_, prefab)
                return item.prefab == prefab or Util:StartsWith(item.prefab, prefab .. "_spice")
            end),

            Util:FindInObject(Constants.BuffBySpicePrefab, function (_, prefab)
                return Util:EndsWith(item.prefab, prefab)
            end),
        }
    elseif action.action.id == "HEAL" or action.action.id == "FERTILIZE" then
        buffs = {Constants.BuffByHealingPrefab[item.prefab]}
    elseif action.action.id == "GIVE" and (target and target:HasTag("ghostlyelixirable")) then
        buffs = {Constants.BuffByElixirPrefab[item.prefab]}
    elseif action.action.id == "CASTAOE" and item.components.spellbook then
        buffs = {Constants.BuffBySpellPrefab[item.components.spellbook:GetSpellName()]}
    end

    for _, buffType in pairs(buffs) do
        Util:ForEach(Constants.OverlappingBuffedFoods, function (overlappingFoods)
            if not Util:Includes(overlappingFoods, buffType) then
                return
            end

            Util:ForEach(overlappingFoods, function (overlappingBuffType)
                if overlappingBuffType ~= buffType then
                    GLOBAL.ThePlayer.player_classified.components.BuffManagerClient:RemoveBuff(overlappingBuffType)
                end
            end)
        end)

        GLOBAL.ThePlayer.player_classified.components.BuffManagerClient:AddBuff(buffType)
    end
end

AddClassPostConstruct("widgets/controls", function (controls)
    if Util:HasServerMod() then
        return
    end

    controls.inst:DoTaskInTime(0, function ()
        controls.buffTimer = controls.top_root:AddChild(Root(
            controls,
            GLOBAL.ThePlayer.player_classified.components.BuffManagerClient,
            { timeDiff = 0 }
        ))
    end)
end)

AddClassPostConstruct("components/playercontroller", function (playerController)
    if Util:HasServerMod() or GLOBAL.TheNet:GetIsServer() then
        return
    end

    local oldRemoteBufferedAction = playerController.RemoteBufferedAction

    playerController.RemoteBufferedAction = function (self, action, ...)
        oldRemoteBufferedAction(self, action, ...)

        onAction(action)
    end
end)

AddPrefabPostInit("player_classified", function (inst)
    if Util:HasServerMod() then
        return
    end

    inst:AddComponent("BuffManagerClient")

    if not GLOBAL.TheNet:GetIsServer() then
        return
    end

    inst:DoTaskInTime(0, function ()
        if not inst._parent then
            return
        end

        inst._parent:ListenForEvent("performaction", function (_, data)
            local action = data and data.action

            if action then
                onAction(action)
            end
        end)
    end)
end)
