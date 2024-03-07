---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL
local GGUI = Arenalogs.GGUI
local f = GUTIL:GetFormatter()
local debug = Arenalogs.DEBUG:GetDebugPrint()

---@class Arenalogs.PLAYER_TOOLTIP : Frame
Arenalogs.PLAYER_TOOLTIP = GUTIL:CreateRegistreeForEvents({ "INSPECT_HONOR_UPDATE" })
---@type PlayerUID
Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID = nil

Arenalogs.PLAYER_TOOLTIP.cached = false
function Arenalogs.PLAYER_TOOLTIP:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local tooltipEnabled = Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
        if not tooltipEnabled then return end
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID = Arenalogs.UTIL:GetPlayerUIDByUnit(unit)
            INSPECTED_UNIT = unit;
            NotifyInspect(unit)
        end
    end)
end

---@param unit UnitId
---@return table<Arenalogs.Const.PVPModes, InspectArenaData>?
function Arenalogs.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    if not unit then return nil end
    ---@type table<Arenalogs.Const.PVPModes, InspectArenaData | InspectPVPData>
    local bracketPvPData = {}

    for mode, bracketID in pairs(Arenalogs.CONST.PVP_MODES_BRACKET_IDS) do
        bracketPvPData[mode] = Arenalogs.UTIL:ConvertInspectArenaData(
            mode, { GetInspectArenaData(bracketID) })
    end

    -- cache
    Arenalogs.DB.PLAYER_DATA:Save(Arenalogs.UTIL:GetPlayerUIDByUnit(unit), bracketPvPData)

    return bracketPvPData
end

---@class InspectArenaData
---@field pvpMode Arenalogs.Const.PVPModes
---@field rating number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number

---@param unit UnitId
---@param pvpData? table<Arenalogs.Const.PVPModes, InspectArenaData>
function Arenalogs.PLAYER_TOOLTIP:UpdatePlayerTooltipByInspectData(unit, pvpData)
    if not unit then return end
    --- fetches the data and updates cache
    ---@type table<Arenalogs.Const.PVPModes, InspectArenaData>
    local bracketPvPData = pvpData or Arenalogs.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    local headerTitle = "Arenalogs.gg - Score"

    GameTooltip:AddLine(f.l(headerTitle))

    for mode, bracketData in GUTIL:OrderedPairs(bracketPvPData, function(a, b) return a > b end) do
        local seasonWon = bracketData.seasonWon or 0
        local seasonLost = (bracketData.seasonPlayed or 0) - seasonWon
        local weeklyWon = bracketData.weeklyWon or 0
        local weeklyLost = (bracketData.weeklyPlayed or 0) - weeklyWon
        local rating = bracketData.rating or 0

        local isEnabled = Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
        if isEnabled then
            GameTooltip:AddDoubleLine(f.white(tostring(Arenalogs.CONST.PVP_MODES_NAMES[mode])),
                Arenalogs.UTIL:ColorByRating(tostring(rating), rating))
        end
    end

    GameTooltip:Show()
end

function Arenalogs.PLAYER_TOOLTIP:INSPECT_HONOR_UPDATE()
    debug("INSPECT_HONOR_UPDATE")

    if not Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID then return end

    if GameTooltip:IsVisible() then
        local _, gameTooltipUnit = GameTooltip:GetUnit()
        if gameTooltipUnit then
            if UnitIsPlayer(gameTooltipUnit) and CanInspect(gameTooltipUnit) and Arenalogs.UTIL:GetPlayerUIDByUnit(gameTooltipUnit) == Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID then
                debug(f.g("Arenalogs: Update Player Tooltip"))
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

    Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID = nil
    ClearInspectPlayer()
end
