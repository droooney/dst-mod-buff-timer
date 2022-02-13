local Constants = require("BuffTimerClient/Constants")
local Util = require("BuffTimerClient/Util")

local Root = require("BuffTimerClient/widgets/Root")

local serverModEnabled

function runIfNeeded(cb)
    if serverModEnabled == nil then
        serverModEnabled = Util:HasServerMod()
    end

    Util:Log("enabled", serverModEnabled)

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

            if action.action.id ~= "EAT" then
                return
            end

            local buffs = {
                Util:FindInObject(Constants.BuffByFoodPrefab, function (_, prefab)
                    return Util:StartsWith(item.prefab, prefab)
                end),

                Util:FindInObject(Constants.BuffBySpicePrefab, function (_, prefab)
                    return Util:EndsWith(item.prefab, prefab)
                end)
            }

            for _, buffType in pairs(buffs) do
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
