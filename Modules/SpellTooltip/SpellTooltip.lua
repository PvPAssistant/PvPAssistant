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
        local _, spellID = GameTooltip:GetSpell()
        if spellID then
            local abilityData = Arenalogs.ABILITIES:GetSpellByID(spellID)
            if abilityData then
                self:UpdateSpellTooltipByAbilityData(abilityData)
            end
        end
    end)
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Macro, function(_, data)
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
    if abilityData.abilityType then
        GameTooltip:AddDoubleLine(f.white("Type: "), f.l(abilityData.abilityType))
    end
    if abilityData.subType then
        GameTooltip:AddDoubleLine(f.white("Subtype: "), f.whisper(abilityData.subType))
    end

    if abilityData.severity then
        if abilityData.severity == Arenalogs.CONST.PVP_SEVERITY.HIGH then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.r(abilityData.severity))
        elseif abilityData.severity == Arenalogs.CONST.PVP_SEVERITY.MEDIUM then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.l(abilityData.severity))
        elseif abilityData.severity == Arenalogs.CONST.PVP_SEVERITY.LOW then
            GameTooltip:AddDoubleLine(f.white("PvP Severity: "), f.g(abilityData.severity))
        end
    end

    if abilityData.duration then
        GameTooltip:AddDoubleLine(f.white("PvP Duration: "), f.white(abilityData.duration .. " Seconds"))
    end

    GameTooltip:Show()
end
