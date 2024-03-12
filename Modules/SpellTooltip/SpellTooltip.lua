---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GUTIL = PvpAssistant.GUTIL
local GGUI = PvpAssistant.GGUI
local f = GUTIL:GetFormatter()

---@class PvpAssistant.SPELL_TOOLTIP : Frame
PvpAssistant.SPELL_TOOLTIP = {}
PvpAssistant.SPELL_TOOLTIP.tooltipFrame = nil
---@type PlayerUID
PvpAssistant.SPELL_TOOLTIP.inspectPlayerUID = nil
function PvpAssistant.SPELL_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function()
        local tooltipEnabled = PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        local _, spellID = GameTooltip:GetSpell()
        if spellID then
            local abilityData = PvpAssistant.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(_, data)
        local tooltipEnabled = PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        -- get spellID from tooltip data instead of GetSpell method
        local spellID = nil
        if data.lines[1].type == 19 and data.lines[1].tooltipType == 1 then
            spellID = data.lines[1].tooltipID
        end
        if spellID then
            local abilityData = PvpAssistant.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
end

---@param abilityData PvpAssistant.AbilityData
function PvpAssistant.SPELL_TOOLTIP:UpdateSpellTooltipByAbilityData(abilityData)
    GameTooltip:AddLine(PvpAssistant.MEDIA:GetAsTextIcon(PvpAssistant.MEDIA.IMAGES.LOGO_1024, 0.028 * 0.5) ..
        f.l(" PvpAssistant"))

    if abilityData.abilityType and PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE) then
        GameTooltip:AddDoubleLine(f.white("Type: "), f.l(abilityData.abilityType))
    end
    if abilityData.subType and PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE) then
        GameTooltip:AddDoubleLine(f.white("Subtype: "), f.whisper(abilityData.subType))
    end

    if abilityData.severity and PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY) then
        if abilityData.severity == PvpAssistant.CONST.PVP_SEVERITY.HIGH then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.r(abilityData.severity))
        elseif abilityData.severity == PvpAssistant.CONST.PVP_SEVERITY.MEDIUM then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.l(abilityData.severity))
        elseif abilityData.severity == PvpAssistant.CONST.PVP_SEVERITY.LOW then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.g(abilityData.severity))
        end
    end

    if abilityData.duration and PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION) then
        GameTooltip:AddDoubleLine(f.white("PvP Duration: "), f.white(abilityData.duration .. " Seconds"))
    end

    if abilityData.additionalData and PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA) then
        for description, value in pairs(abilityData.additionalData) do
            GameTooltip:AddDoubleLine(f.white(description .. ": "), value)
        end
    end

    GameTooltip:Show()
end
