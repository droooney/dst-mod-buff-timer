local Widget = require("widgets/widget")
local Image = require("widgets/image")
local Text = require("widgets/text")

local Constants = require("BuffTimer/Constants")
local Util = require("BuffTimer/Util")

require("constants")
require("fonts")

local LEFT_OFFSET = 20
local TOP_OFFSET = 70
local IMAGE_SIZE = 50
local MARGIN = 10
local FONT_SIZE = 30
local FONT = NUMBERFONT

local Root = Class(Widget, function (self, buffManager, timeDifferenceManager)
    Widget._ctor(self, "Root")

    self.TimeDifferenceManager = timeDifferenceManager
    self.buffs = buffManager:GetBuffs()
    self.listUpdated = true

    self.root = self:AddChild(Widget("root"))
    self.root:SetVAnchor(ANCHOR_TOP)
    self.root:SetHAnchor(ANCHOR_LEFT)

    self.root.buffs = self.root:AddChild(Widget("buffs"))
    self.root.buffs:SetVAnchor(ANCHOR_TOP)
    self.root.buffs:SetHAnchor(ANCHOR_LEFT)
    self.root.buffs.items = {}

    buffManager:SetOnBuffsChanged(function (buffs)
        self.buffs = buffs
        self.listUpdated = true
    end)

    self:StartUpdating()
end)

function Root:ClearBuffs()
    self.buffs = {}
    self.listUpdated = true
end

function Root:OnUpdate()
    if self.listUpdated then
        Util:KillAllWidgets(self.root.buffs.items)

        self.root.buffs.items = {}

        Util:ForEach(self.buffs, function (buff, i)
            local buffWidget = self.root.buffs:AddChild(Widget("buff_" .. buff.type))

            buffWidget:SetVAnchor(ANCHOR_TOP)
            buffWidget:SetHAnchor(ANCHOR_LEFT)

            local imageTex = Constants.BuffImagePrefab[buff.type] .. ".tex"

            buffWidget.bg = buffWidget:AddChild(Image(Util:GetHUDAtlas(), "inv_slot.tex"))
            buffWidget.bg:SetSize(IMAGE_SIZE, IMAGE_SIZE)

            buffWidget.image = buffWidget:AddChild(Image(Util:GetInventoryItemAtlas(imageTex), imageTex))
            buffWidget.image:SetSize(IMAGE_SIZE, IMAGE_SIZE)

            buffWidget.timeLeft = buffWidget:AddChild(Text(FONT, FONT_SIZE))
            buffWidget.timeLeft:SetPosition(0, -IMAGE_SIZE)
            buffWidget.timeLeft:SetHAlign(ANCHOR_MIDDLE)

            buffWidget:SetPosition(LEFT_OFFSET + i * (IMAGE_SIZE + MARGIN), -TOP_OFFSET)

            table.insert(self.root.buffs.items, buffWidget)
        end)
    end

    Util:ForEach(self.buffs, function (buff, i)
        local buffWidget = self.root.buffs.items[i]

        if not buffWidget then
            return
        end

        local timePassed = GetTime() - buff.startedAt - self.TimeDifferenceManager.timeDiff
        local timeLeft = math.max(0, math.floor(buff.duration - timePassed))
        local minutes = math.floor(timeLeft / 60)
        local seconds = timeLeft % 60

        if minutes < 10 then
            minutes = "0" .. minutes
        end

        if seconds < 10 then
            seconds = "0" .. seconds
        end

        buffWidget.timeLeft:SetString(minutes .. ":" .. seconds)
    end)

    self.listUpdated = false
end

return Root
