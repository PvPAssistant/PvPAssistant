---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL
local GGUI = Arenalogs.GGUI
local f = GUTIL:GetFormatter()

---@class Arenalogs.SPELL_TOOLTIP : Frame
Arenalogs.SPELL_TOOLTIP = {}
Arenalogs.SPELL_TOOLTIP.tooltipFrame = nil
---@type PlayerUID
Arenalogs.SPELL_TOOLTIP.inspectPlayerUID = nil
function Arenalogs.SPELL_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function()
        local tooltipEnabled = Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        local _, spellID = GameTooltip:GetSpell()
        if spellID then
            local abilityData = Arenalogs.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(_, data)
        local tooltipEnabled = Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        -- get spellID from tooltip data instead of GetSpell method
        local spellID = nil
        if data.lines[1].type == 19 and data.lines[1].tooltipType == 1 then
            spellID = data.lines[1].tooltipID
        end
        if spellID then
            local abilityData = Arenalogs.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
end

---@param abilityData Arenalogs.AbilityData
function Arenalogs.SPELL_TOOLTIP:UpdateSpellTooltipByAbilityData(abilityData)
    GameTooltip:AddLine(Arenalogs.MEDIA:GetAsTextIcon(Arenalogs.MEDIA.IMAGES.LOGO_1024, 0.028 * 0.5) ..
        f.l(" Arenalogs"))

    if abilityData.abilityType and Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.TYPE) then
        GameTooltip:AddDoubleLine(f.white("Type: "), f.l(abilityData.abilityType))
    end
    if abilityData.subType and Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE) then
        GameTooltip:AddDoubleLine(f.white("Subtype: "), f.whisper(abilityData.subType))
    end

    if abilityData.severity and Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY) then
        if abilityData.severity == Arenalogs.CONST.PVP_SEVERITY.HIGH then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.r(abilityData.severity))
        elseif abilityData.severity == Arenalogs.CONST.PVP_SEVERITY.MEDIUM then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.l(abilityData.severity))
        elseif abilityData.severity == Arenalogs.CONST.PVP_SEVERITY.LOW then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.g(abilityData.severity))
        end
    end

    if abilityData.duration and Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION) then
        GameTooltip:AddDoubleLine(f.white("PvP Duration: "), f.white(abilityData.duration .. " Seconds"))
    end

    if abilityData.additionalData and Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA) then
        for description, value in pairs(abilityData.additionalData) do
            GameTooltip:AddDoubleLine(f.white(description .. ": "), value)
        end
    end

    GameTooltip:Show()
end
