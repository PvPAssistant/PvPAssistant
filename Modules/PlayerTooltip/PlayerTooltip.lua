---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL
local GGUI = PvPLookup.GGUI

---@class PvPLookup.PLAYER_TOOLTIP
PvPLookup.PLAYER_TOOLTIP = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@type table<PlayerUID, PvPLookup.PlayerTooltipData>
PvPLookupPlayerDB = PvPLookupPlayerDB or {}

function PvPLookup.PLAYER_TOOLTIP:Init()
    function PvPLookup.PLAYER_TOOLTIP:Init()
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
            local unit = select(2, GameTooltip:GetUnit())
            if unit and UnitIsPlayer(unit) then
                self:UpdatePlayerTooltipByData(self:GetUnitTooltipData(unit))
            end
        end)
    end
end

---@param playerTooltipData PvPLookup.PlayerTooltipData
function PvPLookup.PLAYER_TOOLTIP:UpdatePlayerTooltipByData(playerTooltipData)
    if not playerTooltipData then return end

    if #playerTooltipData.ratingData == 0 then return end

    GameTooltip:AddLine(PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.1) ..
        GUTIL:ColorizeText("PvPLookup", GUTIL.COLORS.LEGENDARY))

    for mode, data in pairs(playerTooltipData.ratingData) do
        GameTooltip:AddLine(CreateAtlasMarkup(PvPLookup.CONST.ATLAS.TOOLTIP_SWORD) ..
            PvPLookup.CONST.PVP_MODES_NAMES[mode] ..
            GUTIL:ColorizeText(tostring(data.rating), GUTIL.COLORS.LEGENDARY) .. " | " ..
            GUTIL:ColorizeText(tostring(data.win), GUTIL.COLORS.GREEN) ..
            "-" .. GUTIL:ColorizeText(tostring(data.loss), GUTIL.COLORS.RED) .. " | " ..
            GUTIL:ColorizeText("EXP(" .. tostring(data.exp) .. ")", GUTIL.COLORS.EPIC)
        )
    end
end

---@class PvPLookup.PlayerTooltipData.ModeData
---@field rating number
---@field win number
---@field loss number
---@field exp number


---@class PvPLookup.PlayerTooltipData
---@field ratingData table<PvPLookup.Const.PVPModes, PvPLookup.PlayerTooltipData.ModeData>

---@param unit UnitId
---@return PvPLookup.PlayerTooltipData?
function PvPLookup.PLAYER_TOOLTIP:GetUnitTooltipData(unit)
    local playerUID = PvPLookup.UTIL:GetPlayerUIDByUnit(unit)

    PvPLookupPlayerDB[playerUID] = PvPLookupPlayerDB[playerUID] or {}
    PvPLookupPlayerDB[playerUID].ratingData = PvPLookupPlayerDB[playerUID].ratingData or {}

    return PvPLookupPlayerDB[playerUID]
end
