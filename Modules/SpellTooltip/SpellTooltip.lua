---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local GGUI = PvPAssistant.GGUI
local f = GUTIL:GetFormatter()

---@class PvPAssistant.SPELL_TOOLTIP : Frame
PvPAssistant.SPELL_TOOLTIP = {}
PvPAssistant.SPELL_TOOLTIP.tooltipFrame = nil
---@type PlayerUID
PvPAssistant.SPELL_TOOLTIP.inspectPlayerUID = nil
function PvPAssistant.SPELL_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function()
        local tooltipEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        local _, spellID = GameTooltip:GetSpell()
        if spellID then
            local abilityData = PvPAssistant.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(_, data)
        local tooltipEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        -- get spellID from tooltip data instead of GetSpell method
        local spellID = nil
        if data.lines[1].type == 19 and data.lines[1].tooltipType == 1 then
            spellID = data.lines[1].tooltipID
        end
        if spellID then
            local abilityData = PvPAssistant.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
end

---@param abilityData PvPAssistant.AbilityData
function PvPAssistant.SPELL_TOOLTIP:UpdateSpellTooltipByAbilityData(abilityData)
    GameTooltip:AddLine(f.bb("PvPAssistant"))

    if abilityData.abilityType and PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE) then
        GameTooltip:AddDoubleLine(f.white("Type: "), f.l(abilityData.abilityType))
    end
    if abilityData.subType and PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE) then
        GameTooltip:AddDoubleLine(f.white("Subtype: "), f.whisper(abilityData.subType))
    end

    if abilityData.severity and PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY) then
        if abilityData.severity == PvPAssistant.CONST.PVP_SEVERITY.HIGH then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.r(abilityData.severity))
        elseif abilityData.severity == PvPAssistant.CONST.PVP_SEVERITY.MEDIUM then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.l(abilityData.severity))
        elseif abilityData.severity == PvPAssistant.CONST.PVP_SEVERITY.LOW then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.g(abilityData.severity))
        end
    end

    if abilityData.duration and PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION) then
        GameTooltip:AddDoubleLine(f.white("PvP Duration: "), f.white(abilityData.duration .. " Seconds"))
    end

    if abilityData.additionalData and PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA) then
        for description, value in pairs(abilityData.additionalData) do
            GameTooltip:AddDoubleLine(f.white(description .. ": "), value)
        end
    end

    GameTooltip:Show()
end
