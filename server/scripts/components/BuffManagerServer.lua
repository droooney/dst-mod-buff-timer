local Util = require("BuffTimerServer/Util")

local BuffManagerServer = Class(function (self, inst)
    self.inst = inst
    self.buffs = {}
    self.netBuffs = net_string(inst.GUID, "buffs", "buffsChanged")
    self.onBuffsChanged = nil

    if TheNet:GetIsServer() then
        inst:ListenForEvent("death", function ()
            self:ClearBuffs()
        end, inst)

        self:SetOnBuffsChanged(function ()
            self.netBuffs:set(json.encode(self.buffs))
        end)
    else
        inst:DoTaskInTime(0, function (inst)
            if ThePlayer.player_classified == inst then
                SendModRPCToServer(GetModRPC("BuffManagerServer", "getBuffs"), inst)

                inst:ListenForEvent("buffsChanged", function ()
                    self:SetBuffsFromNet()
                end, inst)
            end
        end)
    end
end)

function BuffManagerServer:AddBuff(buff)
    local index = self:FindBuffIndex(buff.type)
    local buffObject = {
        type = buff.type,
        duration = buff.duration,
        startedAt = GetTime(),
    }

    if index == 0 then
        table.insert(self.buffs, buffObject)
    else
        self.buffs[index] = buffObject
    end

    self:BuffsChanged()
end

function BuffManagerServer:BuffsChanged()
    if self.onBuffsChanged then
        self.onBuffsChanged(self.buffs)
    end
end

function BuffManagerServer:ClearBuffs()
    self.buffs = {}
    self:BuffsChanged()
end

function BuffManagerServer:FindBuffIndex(buffType)
    return Util:FindIndex(self.buffs, function (buff) return buff.type == buffType end)
end

function BuffManagerServer:GetBuffs()
    return self.buffs
end

function BuffManagerServer:RemoveBuff(buffType)
    local index = self:FindBuffIndex(buffType)

    if index ~= 0 then
        table.remove(self.buffs, index)

        self:BuffsChanged()
    end
end

function BuffManagerServer:SetBuffsFromNet()
    self.buffs = json.decode(self.netBuffs:value())
    self:BuffsChanged()
end

function BuffManagerServer:SetOnBuffsChanged(onBuffsChanged)
    self.onBuffsChanged = onBuffsChanged
end

return BuffManagerServer
