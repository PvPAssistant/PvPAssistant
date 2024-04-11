---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.PvPInfo
PvPAssistant.PVPINFO = PvPAssistant.PVPINFO

---@class PvPAssistant.PvPInfo.Frames
PvPAssistant.PVPINFO.FRAMES = {}

function PvPAssistant.PVPINFO.FRAMES:Init()
    if not PVPUIFrame then
        error("PVPUIFrame not found")
    end
    local sizeX, sizeY = 285, 160

    ---@type GGUI.AnchorPoint[]
    local anchorPoints = { { anchorParent = PVPUIFrame, anchorA = "TOPLEFT", anchorB = "TOPRIGHT" } }

    if RaiderIO_ProfileTooltip then
        anchorPoints = { {
            anchorParent = RaiderIO_ProfileTooltip,
            anchorA = "TOPLEFT",
            anchorB = "BOTTOMLEFT"
        } }
    end
    PvPAssistant.PVPINFO.frame = GGUI.Frame {
        parent = PVPUIFrame, anchorPoints = anchorPoints, sizeX = sizeX, sizeY = sizeY,
        frameConfigTable = PvPAssistantGGUIConfig, frameID = PvPAssistant.CONST.FRAMES.PVPINFO,
        backdropOptions = PvPAssistant.CONST.PVPINFO_BACKDROP
    }

    local content = PvPAssistant.PVPINFO.frame.content


    content.titleText = GGUI.Text {
        parent = content, anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -8 } },
        text = f.bb("PvPAssistant"),
    }

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
                label = f.grey("W/L"), --win/loss
                width = 40,
                justifyOptions = { type = "H", align = "CENTER" },
            },
            {
                label = f.grey("Season Best"), -- season best
                width = 90,
                justifyOptions = { type = "H", align = "CENTER" },
            }
        },
        rowConstructor = function(columns)
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local scoreColumn = columns[3]
            local seasonBestColumn = columns[4]

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
            seasonBestColumn.text = GGUI.Text {
                parent = seasonBestColumn, anchorParent = seasonBestColumn, offsetX = 5,
                text = "", justifyOptions = { type = "H", align = "CENTER" },
            }
        end,
        disableScrolling = true,
        parent = content,
        sizeY = 130,
        anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -45, offsetX = 0, } },
        hideScrollbar = true,
    }
end

function PvPAssistant.PVPINFO.FRAMES:UpdateDisplay()
    local ratingList = PvPAssistant.PVPINFO.frame.content.ratingList --[[@as GGUI.FrameList]]
    local personalRatedInfo = PvPAssistant.PVPINFO:GetPersonalRatingInfo()

    ratingList:Remove()
    for mode, ratedInfo in GUTIL:OrderedPairs(personalRatedInfo, function(a, b) return a > b end) do
        ratingList:Add(function(row, columns)
            local typeColumn = columns[1]
            local ratingColumn = columns[2]
            local scoreColumn = columns[3]
            local seasonBestColumn = columns[4]

            typeColumn.text:SetText(PvPAssistant.CONST.PVP_MODES_NAMES[mode])
            ratingColumn.text:SetText(f.l(ratedInfo.rating or 0))
            local seasonWon = ratedInfo.seasonWon or 0
            local seasonLost = (ratedInfo.seasonPlayed or 0) - seasonWon
            scoreColumn.text:SetText(f.g(seasonWon) .. " - " .. f.r(seasonLost))
            seasonBestColumn.text:SetText(f.e(ratedInfo.seasonBest))

            local tooltipText = ""
            tooltipText = tooltipText .. f.white(PvPAssistant.CONST.PVP_MODES_NAMES[mode]) .. "\n"
            tooltipText = tooltipText .. f.white("- Rating: " .. f.l(ratedInfo.rating or 0)) .. "\n"
            tooltipText = tooltipText .. f.white("\n- Season Best: " .. f.l(ratedInfo.seasonBest or 0)) .. "\n"
            tooltipText = tooltipText .. f.white("-  Played: " .. f.white(ratedInfo.seasonPlayed or 0)) .. "\n"
            tooltipText = tooltipText .. f.white("-  Won: " .. f.g(seasonWon)) .. "\n"
            tooltipText = tooltipText .. f.white("-  Lost: " .. f.r(seasonLost)) .. "\n"
            tooltipText = tooltipText .. f.white("\n- Weekly Best: " .. f.l(ratedInfo.weeklyBest or 0)) .. "\n"
            tooltipText = tooltipText .. f.white("-  Played: " .. f.white(ratedInfo.weeklyPlayed or 0)) .. "\n"
            tooltipText = tooltipText ..
                f.white("-  Won: " .. f.g((ratedInfo.weeklyWon or 0))) .. "\n"
            tooltipText = tooltipText ..
                f.white("-  Lost: " .. f.r((ratedInfo.weeklyPlayed or 0) - (ratedInfo.weeklyWon or 0))) .. "\n"


            row.tooltipOptions = {
                owner = row.frame,
                anchor = "ANCHOR_RIGHT",
                text = tooltipText,
            }
        end)
    end

    ratingList:UpdateDisplay()
end
