---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL
local GGUI = PvPLookup.GGUI
local f = GUTIL:GetFormatter()

---@class PvPLookup.PLAYER_TOOLTIP : Frame
PvPLookup.PLAYER_TOOLTIP = GUTIL:CreateRegistreeForEvents({ "INSPECT_HONOR_UPDATE" })
PvPLookup.PLAYER_TOOLTIP.tooltipFrame = nil
---@type PlayerUID
PvPLookup.PLAYER_TOOLTIP.inspectPlayerUID = nil
function PvPLookup.PLAYER_TOOLTIP:Init()
    PvPLookup.PLAYER_TOOLTIP:InitTooltipFrame()

    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(_, data)
        local unit = select(2, GameTooltip:GetUnit())
        if unit and UnitIsPlayer(unit) then
            if GameTooltip.insertedFrames and tContains(GameTooltip.insertedFrames, PvPLookup.PLAYER_TOOLTIP.tooltipFrame) then
                return
            end

            -- check if data is cached

            local cachedData = PvPLookup.DB.PLAYER_DATA:Get(PvPLookup.UTIL:GetPlayerUIDByUnit(unit))

            if cachedData then
                self:UpdatePlayerTooltipByInspectData(unit, cachedData)
            else
                local ratingList = PvPLookup.PLAYER_TOOLTIP.tooltipFrame.content.ratingList --[[@as GGUI.FrameList]]
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

                GameTooltip_InsertFrame(GameTooltip, PvPLookup.PLAYER_TOOLTIP.tooltipFrame)

                GameTooltip:Show()
            end

            PvPLookup.PLAYER_TOOLTIP.inspectPlayerUID = PvPLookup.UTIL:GetPlayerUIDByUnit(unit)
            INSPECTED_UNIT = unit;
            NotifyInspect(unit)
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
        disableScrolling = true,
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
                GUTIL:ColorizeText(tostring(PvPLookup.CONST.PVP_MODES_NAMES[mode]), GUTIL.COLORS.WHITE))

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

---@param unit UnitId
---@return table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>?
function PvPLookup.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)
    if not unit then return nil end
    ---@type table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>
    local bracketPvPData = {}

    bracketPvPData[PvPLookup.CONST.PVP_MODES.SOLO_SHUFFLE] = PvPLookup.UTIL:ConvertInspectArenaData(
        PvPLookup.CONST.PVP_MODES.SOLO_SHUFFLE, C_PaperDollInfo.GetInspectRatedSoloShuffleData())
    -- https://warcraft.wiki.gg/wiki/API_GetInspectArenaData
    bracketPvPData[PvPLookup.CONST.PVP_MODES.TWOS] = PvPLookup.UTIL:ConvertInspectArenaData(
        PvPLookup.CONST.PVP_MODES.TWOS, { GetInspectArenaData(1) })
    bracketPvPData[PvPLookup.CONST.PVP_MODES.THREES] = PvPLookup.UTIL:ConvertInspectArenaData(
        PvPLookup.CONST.PVP_MODES.THREES, { GetInspectArenaData(2) })
    --bracketPvPData["5v5"] = GetInspectArenaData(4) -- ??? legacy?
    bracketPvPData[PvPLookup.CONST.PVP_MODES.BATTLEGROUND] = PvPLookup.UTIL:ConvertInspectArenaData(
        PvPLookup.CONST.PVP_MODES.BATTLEGROUND, { GetInspectArenaData(4) })

    -- cache
    PvPLookup.DB.PLAYER_DATA:Save(PvPLookup.UTIL:GetPlayerUIDByUnit(unit), bracketPvPData)

    return bracketPvPData
end

---@class InspectArenaData
---@field pvpMode PvPLookup.Const.PVPModes
---@field rating number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number

---@param unit UnitId
---@param pvpData? table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>
function PvPLookup.PLAYER_TOOLTIP:UpdatePlayerTooltipByInspectData(unit, pvpData)
    if not unit then return end
    --- fetches the data and updates cache
    ---@type table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>
    local bracketPvPData = pvpData or PvPLookup.PLAYER_TOOLTIP:GetPlayerPVPDataFromInspect(unit)

    -- only update if frame was already added as loading...
    if not (GameTooltip.insertedFrames and tContains(GameTooltip.insertedFrames, PvPLookup.PLAYER_TOOLTIP.tooltipFrame)) then
        GameTooltip_InsertFrame(GameTooltip, PvPLookup.PLAYER_TOOLTIP.tooltipFrame)
    end
    local ratingList = PvPLookup.PLAYER_TOOLTIP.tooltipFrame.content.ratingList --[[@as GGUI.FrameList]]
    ratingList:Remove()

    for mode, bracketData in GUTIL:OrderedPairs(bracketPvPData, function(a, b) return a > b end) do
        ratingList:Add(function(row)
            local columns = row.columns
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local scoreColumn = columns[3]
            local expColumn = columns[4]

            typeColumn.text:SetText(CreateAtlasMarkup(PvPLookup.CONST.ATLAS.TOOLTIP_SWORD) .. "  " ..
                GUTIL:ColorizeText(tostring(PvPLookup.CONST.PVP_MODES_NAMES[mode]), GUTIL.COLORS.WHITE))

            local seasonWon = 0
            local seasonLost = 0
            local rating = 0
            if mode ~= PvPLookup.CONST.PVP_MODES.SOLO_SHUFFLE then
                ---@type InspectArenaData
                local arenaData = bracketData
                seasonWon = arenaData.seasonWon or 0
                seasonLost = seasonWon - (arenaData.seasonWon or 0)
                rating = arenaData.rating or 0
            else
                ---@type InspectPVPData
                local soloShuffleData = bracketData
                seasonWon = soloShuffleData.gamesWon or 0
                seasonLost = seasonWon - (soloShuffleData.gamesPlayed or 0)
                rating = soloShuffleData.rating or 0
            end

            ratingColumn.text:SetText(GUTIL:ColorizeText(tostring(rating), GUTIL.COLORS.LEGENDARY))
            scoreColumn.text:SetText(GUTIL:ColorizeText(tostring(seasonWon), GUTIL.COLORS.GREEN) ..
                "-" .. GUTIL:ColorizeText(tostring(seasonLost), GUTIL.COLORS.RED))
            expColumn.text:SetText(GUTIL:ColorizeText("EXP(" .. "???" .. ")", GUTIL.COLORS.EPIC))
        end)
    end
    ratingList:UpdateDisplay()

    GameTooltip:Show()
end

---@param unit UnitId
---@return PvPLookup.PlayerTooltipData?
function PvPLookup.PLAYER_TOOLTIP:GetUnitTooltipData(unit)
    local playerUID = PvPLookup.UTIL:GetPlayerUIDByUnit(unit)

    return PvPLookup.DB.PLAYER_DATA:Get(playerUID)
end

function PvPLookup.PLAYER_TOOLTIP:INSPECT_HONOR_UPDATE()
    -- print("INSPECT_HONOR_UPDATE")

    if not PvPLookup.PLAYER_TOOLTIP.inspectPlayerUID then return end

    if GameTooltip:IsVisible() then
        local _, gameTooltipUnit = GameTooltip:GetUnit()
        if gameTooltipUnit then
            if UnitIsPlayer(gameTooltipUnit) and CanInspect(gameTooltipUnit) and PvPLookup.UTIL:GetPlayerUIDByUnit(gameTooltipUnit) == PvPLookup.PLAYER_TOOLTIP.inspectPlayerUID then
                -- print(f.g("PvPLookup: Update Player Tooltip"))
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

    PvPLookup.PLAYER_TOOLTIP.inspectPlayerUID = nil
    ClearInspectPlayer()
end
