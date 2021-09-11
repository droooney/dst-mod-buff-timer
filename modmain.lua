local InventoryReplica = require("components/inventory_replica")

require("constants")

--local Root = require("SpiceTimer/widgets/Root")
local Util = require("SpiceTimer/Util")

local UseItemFromInvTile = InventoryReplica.UseItemFromInvTile

function InventoryReplica:UseItemFromInvTile(item)
    UseItemFromInvTile(self, item)

    if not item then
        return
    end

    local isChili = Util:EndsWith(item.prefab, "_spice_chili")
    local isHoney = Util:EndsWith(item.prefab, "_spice_sugar")

    if not isChili and not isHoney then
        return
    end

    self.inst:DoTaskInTime(isChili and TUNING.BUFF_ATTACK_DURATION or TUNING.BUFF_WORKEFFECTIVENESS_DURATION, function ()
        Util:Log(isChili and "chili" or "honey", "over")
    end)

    Util:Log(isChili and "chili" or "honey", "start")
end
