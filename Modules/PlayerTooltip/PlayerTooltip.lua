---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL
local GGUI = Arenalogs.GGUI
local f = GUTIL:GetFormatter()

---@class Arenalogs.PLAYER_TOOLTIP : Frame
Arenalogs.PLAYER_TOOLTIP = GUTIL:CreateRegistreeForEvents({ "INSPECT_HONOR_UPDATE" })
Arenalogs.PLAYER_TOOLTIP.tooltipFrame = nil
---@type PlayerUID
Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID = nil
function Arenalogs.PLAYER_TOOLTIP:Init()
    Arenalogs.PLAYER_TOOLTIP:InitTooltipFrame()

    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            if GameTooltip.insertedFrames and tContains(GameTooltip.insertedFrames, Arenalogs.PLAYER_TOOLTIP.tooltipFrame) then
                return
            end

            -- check if data is cached

            local cachedData = Arenalogs.DB.PLAYER_DATA:Get(Arenalogs.UTIL:GetPlayerUIDByUnit(unit))

            if cachedData then
                self:UpdatePlayerTooltipByInspectData(unit, cachedData)
            else
                local ratingList = Arenalogs.PLAYER_TOOLTIP.tooltipFrame.content.ratingList --[[@as GGUI.FrameList]]
                ratingList:Remove()
                -- add blank lines for height adjustment?
                for i = 1, 4 do
                    ratingList:Add(function(row, columns)
                        local typeColumn = columns[1]
                        local ratingColumn = columns[2]
                        local scoreColumn = columns[3]
                        local expColumn = columns[4]
                        typeColumn.text:SetText(f.l("Loading.."))
                        ratingColumn.text:SetText("")
                        scoreColumn.text:SetText("")
                        expColumn.text:SetText("")
                    end)
                end

                ratingList:UpdateDisplay()

                GameTooltip_InsertFrame(GameTooltip, Arenalogs.PLAYER_TOOLTIP.tooltipFrame)

                GameTooltip:Show()
            end

            Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID = Arenalogs.UTIL:GetPlayerUIDByUnit(unit)
            INSPECTED_UNIT = unit;
            NotifyInspect(unit)
        end
    end)
end

function Arenalogs.PLAYER_TOOLTIP:InitTooltipFrame()
    local tooltipFrameX = 265
    local tooltipFrameY = 50
    Arenalogs.PLAYER_TOOLTIP.tooltipFrame = CreateFrame("Frame", nil, nil, "BackdropTemplate")
    Arenalogs.PLAYER_TOOLTIP.tooltipFrame:SetSize(tooltipFrameX, tooltipFrameY)
    Arenalogs.PLAYER_TOOLTIP.tooltipFrame.contentFrame = GGUI.Frame {
        parent = Arenalogs.PLAYER_TOOLTIP.tooltipFrame, anchorParent = Arenalogs.PLAYER_TOOLTIP.tooltipFrame,
        anchorA = "TOP", anchorB = "TOP", sizeX = tooltipFrameX, sizeY = tooltipFrameY,
        --backdropOptions = Arenalogs.CONST.TOOLTIP_FRAME_BACKDROP
    }
    Arenalogs.PLAYER_TOOLTIP.tooltipFrame.content = Arenalogs.PLAYER_TOOLTIP.tooltipFrame.contentFrame.content
    local content = Arenalogs.PLAYER_TOOLTIP.tooltipFrame.content
    content.title = GGUI.Text {
        parent = content, anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -12, offsetX = 0,
        text = Arenalogs.MEDIA:GetAsTextIcon(Arenalogs.MEDIA.IMAGES.LOGO_1024, 0.017) .. " " ..
            GUTIL:ColorizeText("PVPLookup", GUTIL.COLORS.LEGENDARY)
    }
    local frameListOffsetY = -50
    content.ratingList = GGUI.FrameList {
        columnOptions = {
            {
                label = f.grey("Mode"), -- type
                width = 80,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                label = f.grey("Rating"), --rating
                width = 60,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                label = f.grey("Season"),
                width = 60,
                justifyOptions = { type = "H", align = "CENTER" },
            },
            {
                label = f.grey("Week"),
                width = 60,
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
        disableScrolling = true,
        parent = content, anchorParent = content,
        hideScrollbar = true, autoAdjustHeight = true, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetY = frameListOffsetY, offsetX = -7,
        autoAdjustHeightCallback = function(newHeight)
            Arenalogs.PLAYER_TOOLTIP.tooltipFrame:SetSize(tooltipFrameX, newHeight + -frameListOffsetY + 0)
            Arenalogs.PLAYER_TOOLTIP.tooltipFrame.contentFrame:SetSize(tooltipFrameX, newHeight + -frameListOffsetY + 0)
        end,
        rowBackdrops = { Arenalogs.CONST.TOOLTIP_FRAME_ROW_BACKDROP_A, {} }
    }

    Arenalogs.PLAYER_TOOLTIP.tooltipFrame:Hide()
end

---@param playerTooltipData Arenalogs.PlayerTooltipData
function Arenalogs.PLAYER_TOOLTIP:UpdatePlayerTooltipByData(playerTooltipData)
    if not playerTooltipData then return end

    if not playerTooltipData.ratingData then return end

    if GUTIL:Count(playerTooltipData.ratingData) == 0 then return end

    local ratingList = Arenalogs.PLAYER_TOOLTIP.tooltipFrame.content.ratingList --[[@as GGUI.FrameList]]
    ratingList:Remove()

    for mode, data in GUTIL:OrderedPairs(playerTooltipData.ratingData, function(a, b) return a > b end) do
        ratingList:Add(function(row)
            local columns = row.columns
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local scoreColumn = columns[3]
            local expColumn = columns[4]

            typeColumn.text:SetText(CreateAtlasMarkup(Arenalogs.CONST.ATLAS.TOOLTIP_SWORD) .. "  " ..
                GUTIL:ColorizeText(tostring(Arenalogs.CONST.PVP_MODES_NAMES[mode]), GUTIL.COLORS.WHITE))

            ratingColumn.text:SetText(GUTIL:ColorizeText(tostring(data.rating), GUTIL.COLORS.LEGENDARY))
            scoreColumn.text:SetText(GUTIL:ColorizeText(tostring(data.win), GUTIL.COLORS.GREEN) ..
                "-" .. GUTIL:ColorizeText(tostring(data.loss), GUTIL.COLORS.RED))
            expColumn.text:SetText(GUTIL:ColorizeText("EXP(" .. tostring(data.exp) .. ")", GUTIL.COLORS.EPIC))
        end)
    end
    ratingList:UpdateDisplay()

    GameTooltip_InsertFrame(GameTooltip, Arenalogs.PLAYER_TOOLTIP.tooltipFrame)

    GameTooltip:Show()
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

    -- only update if frame was already added as loading...
    if not (GameTooltip.insertedFrames and tContains(GameTooltip.insertedFrames, Arenalogs.PLAYER_TOOLTIP.tooltipFrame)) then
        GameTooltip_InsertFrame(GameTooltip, Arenalogs.PLAYER_TOOLTIP.tooltipFrame)
    end
    local ratingList = Arenalogs.PLAYER_TOOLTIP.tooltipFrame.content.ratingList --[[@as GGUI.FrameList]]
    ratingList:Remove()

    for mode, bracketData in GUTIL:OrderedPairs(bracketPvPData, function(a, b) return a > b end) do
        ratingList:Add(function(row)
            local columns = row.columns
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local seasonColumn = columns[3]
            local weeklyColumn = columns[4]

            typeColumn.text:SetText(CreateAtlasMarkup(Arenalogs.CONST.ATLAS.TOOLTIP_SWORD) .. "  " ..
                GUTIL:ColorizeText(tostring(Arenalogs.CONST.PVP_MODES_NAMES[mode]), GUTIL.COLORS.WHITE))

            local seasonWon = bracketData.seasonWon or 0
            local seasonLost = (bracketData.seasonPlayed or 0) - seasonWon
            local weeklyWon = bracketData.weeklyWon or 0
            local weeklyLost = (bracketData.weeklyPlayed or 0) - weeklyWon
            local rating = bracketData.rating or 0

            ratingColumn.text:SetText(GUTIL:ColorizeText(tostring(rating), GUTIL.COLORS.LEGENDARY))
            seasonColumn.text:SetText(GUTIL:ColorizeText(tostring(seasonWon), GUTIL.COLORS.GREEN) ..
                "-" .. GUTIL:ColorizeText(tostring(seasonLost), GUTIL.COLORS.RED))
            weeklyColumn.text:SetText(GUTIL:ColorizeText(tostring(weeklyWon), GUTIL.COLORS.GREEN) ..
                "-" .. GUTIL:ColorizeText(tostring(weeklyLost), GUTIL.COLORS.RED))
        end)
    end
    ratingList:UpdateDisplay()

    GameTooltip:Show()
end

function Arenalogs.PLAYER_TOOLTIP:INSPECT_HONOR_UPDATE()
    -- print("INSPECT_HONOR_UPDATE")

    if not Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID then return end

    if GameTooltip:IsVisible() then
        local _, gameTooltipUnit = GameTooltip:GetUnit()
        if gameTooltipUnit then
            if UnitIsPlayer(gameTooltipUnit) and CanInspect(gameTooltipUnit) and Arenalogs.UTIL:GetPlayerUIDByUnit(gameTooltipUnit) == Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID then
                -- print(f.g("Arenalogs: Update Player Tooltip"))
                self:UpdatePlayerTooltipByInspectData(gameTooltipUnit)
            else
                -- print(f.r("not updating, no other problem"))
            end
        else
            -- print(f.r("not updating, no tooltip unit"))
        end
    else
        -- print(f.r("not updating, tooltip not visible"))
    end

    Arenalogs.PLAYER_TOOLTIP.inspectPlayerUID = nil
    ClearInspectPlayer()
end
