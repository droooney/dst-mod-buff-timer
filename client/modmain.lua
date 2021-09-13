local Root = require("BuffTimer/widgets/Root")

local Constants = require("BuffTimer/Constants")
local Util = require("BuffTimer/Util")

require("constants")

AddClassPostConstruct("components/inventory_replica", function (inventory)
    local UseItemFromInvTile = inventory.UseItemFromInvTile

    inventory.UseItemFromInvTile = function (self, item)
        UseItemFromInvTile(self, item)

        if not item then
            return
        end

        local buffType = Util:EndsWith(item.prefab, "_spice_chili")
            and Constants.BuffType.SPICE_CHILI
            or Util:EndsWith(item.prefab, "_spice_sugar")
                and Constants.BuffType.SPICE_HONEY
                or Util:EndsWith(item.prefab, "_spice_garlic")
                    and Constants.BuffType.SPICE_GARLIC
                    or Constants.BuffByFoodPrefab[item.prefab]

        if not buffType then
            return
        end

        local buffTimer = GLOBAL.ThePlayer.HUD.controls.buffTimer
        local duration = Constants.BuffDuration[buffType]

        self.inst:DoTaskInTime(duration, function ()
            buffTimer:RemoveBuff(buffType)
        end)

        buffTimer:AddBuff({
            type = buffType,
            duration = duration,
        })
    end
end)

AddClassPostConstruct("widgets/controls", function (controls)
    controls.inst:DoTaskInTime(0, function ()
        controls.buffTimer = controls.top_root:AddChild(Root())
    end)

    controls.inst:ListenForEvent("death", function ()
        controls.buffTimer:ClearBuffs()
    end, GLOBAL.ThePlayer)
end)
