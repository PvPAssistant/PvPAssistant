---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local GGUI = PvPAssistant.GGUI
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.PLAYER_TOOLTIP : Frame
PvPAssistant.PLAYER_TOOLTIP = GUTIL:CreateRegistreeForEvents({ "INSPECT_HONOR_UPDATE" })
---@type PlayerUID
PvPAssistant.PLAYER_TOOLTIP.inspectPlayerUID = nil

PvPAssistant.PLAYER_TOOLTIP.cached = false
function PvPAssistant.PLAYER_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local tooltipEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            PvPAssistant.PLAYER_TOOLTIP.inspectPlayerUID = PvPAssistant.UTIL:GetPlayerUIDByUnit(unit)
            INSPECTED_UNIT = unit;
            NotifyInspect(unit)
        end
    end)
end

---@param unit UnitId
---@return table<PvPAssistant.Const.PVPModes, InspectArenaData>?
function PvPAssistant.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    if not unit then return nil end
    ---@type table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>
    local bracketPvPData = {}

    for mode, bracketID in pairs(PvPAssistant.CONST.PVP_MODES_BRACKET_IDS) do
        bracketPvPData[mode] = PvPAssistant.UTIL:ConvertInspectArenaData(
            mode, { GetInspectArenaData(bracketID) })
    end

    -- cache
    PvPAssistant.DB.PLAYER_DATA:Save(PvPAssistant.UTIL:GetPlayerUIDByUnit(unit), bracketPvPData)

    return bracketPvPData
end

---@class InspectArenaData
---@field pvpMode PvPAssistant.Const.PVPModes
---@field rating number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number

---@param unit UnitId
---@param pvpData? table<PvPAssistant.Const.PVPModes, InspectArenaData>
function PvPAssistant.PLAYER_TOOLTIP:UpdatePlayerTooltipByInspectData(unit, pvpData)
    if not unit then return end
    --- fetches the data and updates cache
    ---@type table<PvPAssistant.Const.PVPModes, InspectArenaData>
    local bracketPvPData = pvpData or PvPAssistant.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    local headerTitle = "PvPAssistant.gg - Score"

    GameTooltip:AddLine(f.l(headerTitle))

    for mode, bracketData in GUTIL:OrderedPairs(bracketPvPData, function(a, b) return a > b end) do
        local seasonWon = bracketData.seasonWon or 0
        local seasonLost = (bracketData.seasonPlayed or 0) - seasonWon
        local weeklyWon = bracketData.weeklyWon or 0
        local weeklyLost = (bracketData.weeklyPlayed or 0) - weeklyWon
        local rating = bracketData.rating or 0

        local isEnabled = PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
        if isEnabled then
            GameTooltip:AddDoubleLine(f.white(tostring(PvPAssistant.CONST.PVP_MODES_NAMES[mode])),
                PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    GameTooltip:Show()
end

function PvPAssistant.PLAYER_TOOLTIP:INSPECT_HONOR_UPDATE()
    debug("INSPECT_HONOR_UPDATE")

    if not PvPAssistant.PLAYER_TOOLTIP.inspectPlayerUID then return end

    if GameTooltip:IsVisible() then
        local _, gameTooltipUnit = GameTooltip:GetUnit()
        if gameTooltipUnit then
            if UnitIsPlayer(gameTooltipUnit) and CanInspect(gameTooltipUnit) and PvPAssistant.UTIL:GetPlayerUIDByUnit(gameTooltipUnit) == PvPAssistant.PLAYER_TOOLTIP.inspectPlayerUID then
                debug(f.g("PvPAssistant: Update Player Tooltip"))
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

    PvPAssistant.PLAYER_TOOLTIP.inspectPlayerUID = nil
    ClearInspectPlayer()
end
