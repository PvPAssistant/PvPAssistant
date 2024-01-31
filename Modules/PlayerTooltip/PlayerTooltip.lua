---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL
local GGUI = PvPLookup.GGUI

---@class PvPLookup.PLAYER_TOOLTIP
PvPLookup.PLAYER_TOOLTIP = {}
PvPLookup.PLAYER_TOOLTIP.tooltipFrame = nil

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@type table<PlayerUID, PvPLookup.PlayerTooltipData>
PvPLookupPlayerDB = PvPLookupPlayerDB or {}

function PvPLookup.PLAYER_TOOLTIP:Init()
    PvPLookup.PLAYER_TOOLTIP:InitTooltipFrame()

    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            self:UpdatePlayerTooltipByData(self:GetUnitTooltipData(unit))
        end
    end)
end

function PvPLookup.PLAYER_TOOLTIP:InitTooltipFrame()
    local tooltipFrameX = 265
    local tooltipFrameY = 50
    PvPLookup.PLAYER_TOOLTIP.tooltipFrame = CreateFrame("Frame", nil, nil, "BackdropTemplate")
    PvPLookup.PLAYER_TOOLTIP.tooltipFrame:SetSize(tooltipFrameX, tooltipFrameY)
    PvPLookup.PLAYER_TOOLTIP.tooltipFrame.contentFrame = GGUI.Frame {
        parent = PvPLookup.PLAYER_TOOLTIP.tooltipFrame, anchorParent = PvPLookup.PLAYER_TOOLTIP.tooltipFrame,
        anchorA = "TOP", anchorB = "TOP", sizeX = tooltipFrameX, sizeY = tooltipFrameY,
        --backdropOptions = PvPLookup.CONST.TOOLTIP_FRAME_BACKDROP
    }
    PvPLookup.PLAYER_TOOLTIP.tooltipFrame.content = PvPLookup.PLAYER_TOOLTIP.tooltipFrame.contentFrame.content
    local content = PvPLookup.PLAYER_TOOLTIP.tooltipFrame.content
    content.title = GGUI.Text {
        parent = content, anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetY = -12, offsetX = 0,
        text = PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.017) .. " " ..
            GUTIL:ColorizeText("PVP Score", GUTIL.COLORS.LEGENDARY)
    }
    local frameListOffsetY = -30
    content.ratingList = GGUI.FrameList {
        columnOptions = {
            {
                label = "", -- type
                width = 80,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                label = "", --rating
                width = 60,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                label = "", --win/loss
                width = 40,
                justifyOptions = { type = "H", align = "CENTER" },
            },
            {
                label = "", -- exp
                width = 90,
                justifyOptions = { type = "H", align = "CENTER" },
            }
        },
        rowConstructor = function(columns)
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local scoreColumn = columns[3]
            local expColumn = columns[4]

            typeColumn.text = GGUI.Text {
                parent = typeColumn, anchorParent = typeColumn,
                text = "", anchorA = "LEFT", anchorB = "LEFT", offsetX = 5,
                justifyOptions = { type = "H", align = "LEFT" },
            }
            ratingColumn.text = GGUI.Text {
                parent = ratingColumn, anchorParent = ratingColumn,
                anchorA = "LEFT", anchorB = "LEFT",
                text = "", justifyOptions = { type = "H", align = "LEFT" },
            }
            scoreColumn.text = GGUI.Text {
                parent = scoreColumn, anchorParent = scoreColumn,
                text = "",
            }
            expColumn.text = GGUI.Text {
                parent = expColumn, anchorParent = expColumn, offsetX = 5,
                text = "", justifyOptions = { type = "H", align = "CENTER" },
            }
        end,
        parent = content, anchorParent = content,
        hideScrollbar = true, autoAdjustHeight = true, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetY = frameListOffsetY, offsetX = -7,
        autoAdjustHeightCallback = function(newHeight)
            PvPLookup.PLAYER_TOOLTIP.tooltipFrame:SetSize(tooltipFrameX, newHeight + -frameListOffsetY + 0)
            PvPLookup.PLAYER_TOOLTIP.tooltipFrame.contentFrame:SetSize(tooltipFrameX, newHeight + -frameListOffsetY + 0)
        end,
        rowBackdrops = { PvPLookup.CONST.TOOLTIP_FRAME_ROW_BACKDROP_A, {} }
    }

    PvPLookup.PLAYER_TOOLTIP.tooltipFrame:Hide()
end

---@param playerTooltipData PvPLookup.PlayerTooltipData
function PvPLookup.PLAYER_TOOLTIP:UpdatePlayerTooltipByData(playerTooltipData)
    if not playerTooltipData then return end

    if not playerTooltipData.ratingData then return end

    if GUTIL:Count(playerTooltipData.ratingData) == 0 then return end

    local ratingList = PvPLookup.PLAYER_TOOLTIP.tooltipFrame.content.ratingList --[[@as GGUI.FrameList]]
    ratingList:Remove()

    for mode, data in GUTIL:OrderedPairs(playerTooltipData.ratingData, function(a, b) return a > b end) do
        ratingList:Add(function(row)
            local columns = row.columns
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local scoreColumn = columns[3]
            local expColumn = columns[4]

            typeColumn.text:SetText(CreateAtlasMarkup(PvPLookup.CONST.ATLAS.TOOLTIP_SWORD) .. "  " ..
                GUTIL:ColorizeText(PvPLookup.CONST.PVP_MODES_NAMES[mode], GUTIL.COLORS.WHITE))

            ratingColumn.text:SetText(GUTIL:ColorizeText(tostring(data.rating), GUTIL.COLORS.LEGENDARY))
            scoreColumn.text:SetText(GUTIL:ColorizeText(tostring(data.win), GUTIL.COLORS.GREEN) ..
                "-" .. GUTIL:ColorizeText(tostring(data.loss), GUTIL.COLORS.RED))
            expColumn.text:SetText(GUTIL:ColorizeText("EXP(" .. tostring(data.exp) .. ")", GUTIL.COLORS.EPIC))
        end)
    end
    ratingList:UpdateDisplay()

    GameTooltip_InsertFrame(GameTooltip, PvPLookup.PLAYER_TOOLTIP.tooltipFrame)

    GameTooltip:Show()
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
