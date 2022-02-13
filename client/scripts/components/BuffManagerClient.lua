local Constants = require("BuffTimerClient/Constants")
local Util = require("BuffTimerClient/Util")

local BUFF_EVENT_PREFIX = "buffOver_"

local BuffManagerClient = Class(function (self, inst)
    self.inst = inst
    self.buffs = {}
    self.onBuffsChanged = nil

    inst:AddComponent("timer")

    inst:ListenForEvent("timerdone", function (...)
        self:OnTimerDone(...)
    end)
    inst:ListenForEvent("death", function ()
        self:ClearBuffs()
    end, inst)
end)

function BuffManagerClient:AddBuff(buffType)
    local index = self:FindBuffIndex(buffType)
    local buffObject = {
        type = buffType,
        duration = Constants.BuffDuration[buffType],
        startedAt = GetTime(),
    }
    local timerName = BUFF_EVENT_PREFIX .. buffType

    if index == 0 then
        table.insert(self.buffs, buffObject)
    else
        self.buffs[index] = buffObject

        self.inst.components.timer:StopTimer(timerName)
    end

    self.inst.components.timer:StartTimer(timerName, buffObject.duration)

    self:BuffsChanged()
end

function BuffManagerClient:BuffsChanged()
    if self.onBuffsChanged then
        self.onBuffsChanged(self.buffs)
    end
end

function BuffManagerClient:ClearBuffs()
    self.buffs = {}
    self:BuffsChanged()
end

function BuffManagerClient:FindBuffIndex(buffType)
    return Util:FindIndex(self.buffs, function (buff) return buff.type == buffType end)
end

function BuffManagerClient:GetBuffs()
    return self.buffs
end

function BuffManagerClient:RemoveBuff(buffType)
    local index = self:FindBuffIndex(buffType)

    if index ~= 0 then
        table.remove(self.buffs, index)

        self:BuffsChanged()
    end
end

function BuffManagerClient:SetOnBuffsChanged(onBuffsChanged)
    self.onBuffsChanged = onBuffsChanged
end

function BuffManagerClient:OnTimerDone(inst, data)
    if not Util:StartsWith(data.name, BUFF_EVENT_PREFIX) then
        return
    end

    local buffType = data.name:sub(#BUFF_EVENT_PREFIX + 1)

    self:RemoveBuff(buffType)
end

return BuffManagerClient
