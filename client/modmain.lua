local Constants = require("BuffTimerClient/Constants")
local Util = require("BuffTimerClient/Util")

local Root = require("BuffTimerClient/widgets/Root")

local serverModEnabled

function runIfNeeded(cb)
    if serverModEnabled == nil then
        serverModEnabled = Util:HasServerMod()
    end

    if not serverModEnabled then
        cb()
    end
end

AddClassPostConstruct("widgets/controls", function (controls)
    runIfNeeded(function ()
        controls.inst:DoTaskInTime(0, function ()
            controls.buffTimer = controls.top_root:AddChild(Root(
                GLOBAL.ThePlayer.player_classified.components.BuffManagerClient
            ))
        end)
    end)
end)

AddClassPostConstruct("components/playercontroller", function (playerController)
    runIfNeeded(function ()
        local RemoteUseItemFromInvTile = playerController.RemoteUseItemFromInvTile

        playerController.RemoteUseItemFromInvTile = function (self, action, item, ...)
            RemoteUseItemFromInvTile(self, action, item, ...)

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
            elseif action.action.id == "HEAL" then
                buffs = {
                    Util:FindInObject(Constants.BuffByHealingPrefab, function (_, prefab)
                        return item.prefab == prefab
                    end),
                }
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
    end)
end)

AddPrefabPostInit("player_classified", function (inst)
    runIfNeeded(function ()
        inst:AddComponent("BuffManagerClient")
    end)
end)
