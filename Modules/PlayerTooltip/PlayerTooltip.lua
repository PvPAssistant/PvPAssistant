---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GUTIL = PvpAssistant.GUTIL
local GGUI = PvpAssistant.GGUI
local f = GUTIL:GetFormatter()
local debug = PvpAssistant.DEBUG:GetDebugPrint()

---@class PvpAssistant.PLAYER_TOOLTIP : Frame
PvpAssistant.PLAYER_TOOLTIP = GUTIL:CreateRegistreeForEvents({ "INSPECT_HONOR_UPDATE" })
---@type PlayerUID
PvpAssistant.PLAYER_TOOLTIP.inspectPlayerUID = nil

PvpAssistant.PLAYER_TOOLTIP.cached = false
function PvpAssistant.PLAYER_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local tooltipEnabled = PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            PvpAssistant.PLAYER_TOOLTIP.inspectPlayerUID = PvpAssistant.UTIL:GetPlayerUIDByUnit(unit)
            INSPECTED_UNIT = unit;
            NotifyInspect(unit)
        end
    end)
end

---@param unit UnitId
---@return table<PvpAssistant.Const.PVPModes, InspectArenaData>?
function PvpAssistant.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    if not unit then return nil end
    ---@type table<PvpAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>
    local bracketPvPData = {}

    for mode, bracketID in pairs(PvpAssistant.CONST.PVP_MODES_BRACKET_IDS) do
        bracketPvPData[mode] = PvpAssistant.UTIL:ConvertInspectArenaData(
            mode, { GetInspectArenaData(bracketID) })
    end

    -- cache
    PvpAssistant.DB.PLAYER_DATA:Save(PvpAssistant.UTIL:GetPlayerUIDByUnit(unit), bracketPvPData)

    return bracketPvPData
end

---@class InspectArenaData
---@field pvpMode PvpAssistant.Const.PVPModes
---@field rating number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number

---@param unit UnitId
---@param pvpData? table<PvpAssistant.Const.PVPModes, InspectArenaData>
function PvpAssistant.PLAYER_TOOLTIP:UpdatePlayerTooltipByInspectData(unit, pvpData)
    if not unit then return end
    --- fetches the data and updates cache
    ---@type table<PvpAssistant.Const.PVPModes, InspectArenaData>
    local bracketPvPData = pvpData or PvpAssistant.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    local headerTitle = "PvpAssistant.gg - Score"

    GameTooltip:AddLine(f.l(headerTitle))

    for mode, bracketData in GUTIL:OrderedPairs(bracketPvPData, function(a, b) return a > b end) do
        local seasonWon = bracketData.seasonWon or 0
        local seasonLost = (bracketData.seasonPlayed or 0) - seasonWon
        local weeklyWon = bracketData.weeklyWon or 0
        local weeklyLost = (bracketData.weeklyPlayed or 0) - weeklyWon
        local rating = bracketData.rating or 0

        local isEnabled = PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
        if isEnabled then
            GameTooltip:AddDoubleLine(f.white(tostring(PvpAssistant.CONST.PVP_MODES_NAMES[mode])),
                PvpAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    GameTooltip:Show()
end

function PvpAssistant.PLAYER_TOOLTIP:INSPECT_HONOR_UPDATE()
    debug("INSPECT_HONOR_UPDATE")

    if not PvpAssistant.PLAYER_TOOLTIP.inspectPlayerUID then return end

    if GameTooltip:IsVisible() then
        local _, gameTooltipUnit = GameTooltip:GetUnit()
        if gameTooltipUnit then
            if UnitIsPlayer(gameTooltipUnit) and CanInspect(gameTooltipUnit) and PvpAssistant.UTIL:GetPlayerUIDByUnit(gameTooltipUnit) == PvpAssistant.PLAYER_TOOLTIP.inspectPlayerUID then
                debug(f.g("PvpAssistant: Update Player Tooltip"))
                self:UpdatePlayerTooltipByInspectData(gameTooltipUnit)
            else
                debug(f.r("not updating, no other problem"))
            end
        else
            debug(f.r("not updating, no tooltip unit"))
        end
    else
        debug(f.r("not updating, tooltip not visible"))
    end

    PvpAssistant.PLAYER_TOOLTIP.inspectPlayerUID = nil
    ClearInspectPlayer()
end
