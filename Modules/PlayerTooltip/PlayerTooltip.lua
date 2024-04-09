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
            local bracketPvPData = self:GetPlayerPVPData(unit)
            if bracketPvPData then
                self:UpdatePlayerTooltipByPvPData(unit, bracketPvPData)
            end
        end
    end)
end

---@param unit UnitId
---@return table?
function PvPAssistant.PLAYER_TOOLTIP:GetPlayerPVPData(unit)
    if not unit then return nil end

    local unitName, unitRealm = UnitNameUnmodified(unit)
    unitRealm = unitRealm or GetNormalizedRealmName()
    unitRealm = PvPAssistant.UTIL:CamelCaseToDashSeparated(unitRealm) -- temporary adaption to pvp data format

    local pvpDataKey = unitName .. unitRealm

    print("Fetching data for: " .. tostring(pvpDataKey))

    ---@diagnostic disable-next-line: undefined-field
    local unitPvPData = PvPAssistant.PVP_DATA[pvpDataKey]

    if not unitPvPData then
        return
    end

    local bracketPvPData = {}

    for index, mode in ipairs(PvPAssistant.CONST.PVP_DATA_BRACKET_ORDER) do
        local rating = unitPvPData[index]
        bracketPvPData[mode] = rating
    end

    DevTool:AddData(bracketPvPData, "datatest")

    -- cache
    --PvPAssistant.DB.PLAYER_DATA:Save(PvPAssistant.UTIL:GetPlayerUIDByUnit(unit), bracketPvPData)

    return bracketPvPData
end

---@param unit UnitId
---@param bracketPvPData? table<PvPAssistant.Const.PVPModes, number>
function PvPAssistant.PLAYER_TOOLTIP:UpdatePlayerTooltipByPvPData(unit, bracketPvPData)
    if not unit then return end

    local headerTitle = "PvPAssistant - Rating"

    GameTooltip:AddLine(f.l(headerTitle))

    for mode, rating in GUTIL:OrderedPairs(bracketPvPData, function(a, b) return a > b end) do
        local isEnabled = false
        if string.find(mode, PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE) then
            isEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE)
        end

        if isEnabled then
            GameTooltip:AddDoubleLine(f.white(tostring(PvPAssistant.CONST.PVP_MODES_NAMES[mode])),
                PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    GameTooltip:Show()
end
