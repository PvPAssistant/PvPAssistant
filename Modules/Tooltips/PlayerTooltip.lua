---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.PLAYER_TOOLTIP : Frame
PvPAssistant.PLAYER_TOOLTIP = {}

function PvPAssistant.PLAYER_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local tooltipEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end

        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            local tooltipUpdates = { self:UpdatePlayerTooltipByPvPData(unit), self
                :UpdatePlayerTooltipByRecommendationData(unit) }
            if GUTIL:Some(tooltipUpdates, function(tU) return tU end) then
                GameTooltip:Show()
            end
        end
    end)
end

---@param unit UnitId
---@return boolean updated
function PvPAssistant.PLAYER_TOOLTIP:UpdatePlayerTooltipByPvPData(unit)
    if not unit then return false end

    local playerPvPData = PvPAssistant.DB.PVP_DATA:GetByUnit(unit)

    if not playerPvPData then return false end

    local headerTitle = "PvPAssistant - Rating"

    local alreadyUpdated = GUTIL:TooltipContains({
        textLeft = "PvPAssistant",
    })

    if alreadyUpdated then
        return false
    end

    if PvPAssistant.DB.DEBUG_IDS:Get("PLAYER_TOOLTIP") then
        headerTitle = headerTitle .. " " .. f.r("(DEBUG)")
    end

    GameTooltip:AddLine(f.l(headerTitle))

    for mode, rating in GUTIL:OrderedPairs(playerPvPData.ratings, function(a, b) return a < b end) do
        local isEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)

        if isEnabled then
            GameTooltip:AddDoubleLine(f.white(tostring(PvPAssistant.CONST.PVP_MODES_NAMES[mode])),
                PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    if PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE) then
        for specID, rating in pairs(playerPvPData.shuffleSpecRatings) do
            local icon = select(4, GetSpecializationInfoByID(specID))
            local iconText = GUTIL:IconToText(icon, 15, 15)
            GameTooltip:AddDoubleLine(
                f.white(PvPAssistant.CONST.PVP_MODES_NAMES[PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE]) .. " " ..
                iconText,
                PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    return true
end

---@param unit UnitId
---@return boolean updated
function PvPAssistant.PLAYER_TOOLTIP:UpdatePlayerTooltipByRecommendationData(unit)
    -- TODO: Add player tooltip option
    local unitGUID = UnitGUID(unit)
    local recommendationData = PvPAssistant.DB.RECOMMENDATION_DATA:Get(unitGUID)

    if not recommendationData then return false end

    GameTooltip:AddDoubleLine(f.white("Your Rating"),
        string.format("|A:Professions-ChatIcon-Quality-Tier%d:16:16|a", recommendationData.rating))
    GameTooltip:AddDoubleLine(f.white("Note"), f.white(recommendationData.note))

    return true
end
