---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.PLAYER_TOOLTIP : Frame
PvPAssistant.PLAYER_TOOLTIP = {}

---@class PvPAssistant.PLAYER_TOOLTIP.BracketData
---@field ratings table<PvPAssistant.Const.PVPModes, number>
---@field shuffleSpecRatings table<number, number> specID -> rating

function PvPAssistant.PLAYER_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local tooltipEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end

        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            local bracketPvPData = self:GetPlayerPVPData(unit)
            if bracketPvPData then
                self:UpdatePlayerTooltipByPvPData(unit, bracketPvPData)
            end
        end
    end)
end

---@param unit UnitId
---@return PvPAssistant.PLAYER_TOOLTIP.BracketData?
function PvPAssistant.PLAYER_TOOLTIP:GetPlayerPVPData(unit)
    if not unit then return nil end

    local unitName, unitRealm = UnitNameUnmodified(unit)
    unitRealm = unitRealm or GetNormalizedRealmName()
    unitRealm = PvPAssistant.UTIL:CamelCaseToDashSeparated(unitRealm) -- temporary adaption to pvp data format

    local pvpDataKey = unitName .. unitRealm

    ---@diagnostic disable-next-line: undefined-field
    local unitPvPData = PvPAssistant.PVP_DATA[pvpDataKey]

    if not unitPvPData then
        return
    end

    ---@type PvPAssistant.PLAYER_TOOLTIP.BracketData
    local bracketPvPData = {
        ratings = {},
        shuffleSpecRatings = {},
    }

    --- 2v2,3v3,rbg,shuffle-1,shuffle-2,shuffle-3,shuffle-4
    for index, mode in ipairs(PvPAssistant.CONST.PVP_DATA_BRACKET_ORDER) do
        local rating = unitPvPData[index]
        if index < 4 then
            bracketPvPData.ratings[mode] = rating
        else
            local unitClassID = select(3, UnitClass(unit))
            local specIndex = (3 - index) * -1
            local specID = GetSpecializationInfoForClassID(unitClassID, specIndex)
            if specID then
                bracketPvPData.shuffleSpecRatings[specID] = rating
            end
        end
    end

    return bracketPvPData
end

---@param unit UnitId
---@param bracketPvPData PvPAssistant.PLAYER_TOOLTIP.BracketData
function PvPAssistant.PLAYER_TOOLTIP:UpdatePlayerTooltipByPvPData(unit, bracketPvPData)
    if not unit then return end

    local headerTitle = "PvPAssistant - Rating"

    GameTooltip:AddLine(f.l(headerTitle))

    for mode, rating in GUTIL:OrderedPairs(bracketPvPData.ratings, function(a, b) return a < b end) do
        local isEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)

        if isEnabled then
            GameTooltip:AddDoubleLine(f.white(tostring(PvPAssistant.CONST.PVP_MODES_NAMES[mode])),
                PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    if PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE) then
        for specID, rating in pairs(bracketPvPData.shuffleSpecRatings) do
            local icon = select(4, GetSpecializationInfoByID(specID))
            local iconText = GUTIL:IconToText(icon, 15, 15)
            GameTooltip:AddDoubleLine(
                f.white(PvPAssistant.CONST.PVP_MODES_NAMES[PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE]) .. " " ..
                iconText,
                PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    GameTooltip:Show()
end
