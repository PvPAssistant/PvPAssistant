---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.History
PvPLookup.HISTORY = PvPLookup.HISTORY

---@type PvPLookup.HistoryFrame
PvPLookup.HISTORY.frame = nil

---@class PvPLookup.History.Frames
PvPLookup.HISTORY.FRAMES = {}

function PvPLookup.HISTORY.FRAMES:Init()
    local sizeX = 700
    local sizeY = 630
    ---@class PvPLookup.HistoryFrame : GGUI.Frame
    local frame = GGUI.Frame{
        moveable=true, closeable=true, collapseable=true, frameID=PvPLookup.CONST.FRAMES.HISTORY_FRAME,
        sizeX=sizeX, sizeY=sizeY, frameConfigTable=PvPLookupGGUIConfig, frameTable=PvPLookup.MAIN.FRAMES,
        backdropOptions=PvPLookup.CONST.HISTORY_BACKDROP
    }

    local titleFrame = GGUI.Frame{
        parent=frame.content, anchorParent=frame.content,anchorA="BOTTOM", anchorB="TOP", offsetY=-40,
        sizeX=200, sizeY=60,
        backdropOptions=PvPLookup.CONST.HISTORY_TITLE_BACKDROP
    }

    titleFrame.frame:SetFrameLevel(frame.frame:GetFrameLevel()+10)

    titleFrame.content.title = GGUI.Text{
        parent=titleFrame.content, anchorParent=titleFrame.content,
        text=GUTIL:ColorizeText("PVP-LOOKUP", GUTIL.COLORS.LEGENDARY), scale=2,
    }

    frame.content.logo = GGUI.Text{
        parent=frame.content, anchorParent=titleFrame.content.title.frame, anchorA="BOTTOM", anchorB="TOP", offsetY=7,
        text=PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.07)
    }

    
    frame.content.score = GGUI.Text{
        parent=frame.content, anchorParent=frame.title.frame, anchorA="TOP", anchorB="BOTTOM", offsetY=-10,
        text = GUTIL:ColorizeText("27", GUTIL.COLORS.GREEN) .. " - " .. GUTIL:ColorizeText("19", GUTIL.COLORS.RED), scale = 4,
    }

    frame.content.ratingTitle = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.score.frame, anchorA="TOP", anchorB="BOTTOM",
        text= "RATING " .. GUTIL:ColorizeText("1496", GUTIL.COLORS.GOLD) .. " - " .. GUTIL:ColorizeText("2456", GUTIL.COLORS.LEGENDARY), 
        scale = 1, 
    }

    local statHeadersOffsetX = 30
    frame.content.damageHeader = GGUI.Text{
        parent=frame.content,anchorParent=frame.content.score.frame, anchorA="RIGHT", anchorB="LEFT", 
        offsetX = -statHeadersOffsetX,
        text=GUTIL:ColorizeText("DAMAGE", GUTIL.COLORS.LEGENDARY), scale = 2,
    }

    frame.content.damageBestTitle = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.damageHeader.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "ARENA BEST: ", justifyOptions={type="H", align="LEFT"}, offsetX=0,
    }
    frame.content.damageBestValue = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.damageBestTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "40.7M", justifyOptions={type="H", align="LEFT"}
    }
    frame.content.damageTotalTitle = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.damageBestTitle.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "TOTAL: ", justifyOptions={type="H", align="RIGHT"}, offsetY=-5,
    }
    frame.content.damageTotalValue = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.damageTotalTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "1.38B", justifyOptions={type="H", align="LEFT"}
    }

    frame.content.healingHeader = GGUI.Text{
        parent=frame.content,anchorParent=frame.content.score.frame, anchorA="LEFT", anchorB="RIGHT", 
        offsetX = statHeadersOffsetX,
        text=GUTIL:ColorizeText("HEALING", GUTIL.COLORS.GOLD), scale = 2,
    }

    frame.content.healingBestTitle = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.healingHeader.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "ARENA BEST: ", justifyOptions={type="H", align="LEFT"}, offsetX=0,
    }
    frame.content.healingBestValue = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.healingBestTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "40.7M", justifyOptions={type="H", align="LEFT"}
    }
    frame.content.healingTotalTitle = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.healingBestTitle.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "TOTAL: ", justifyOptions={type="H", align="RIGHT"}, offsetY=-5,
    }
    frame.content.healingTotalValue = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.healingTotalTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "1.38B", justifyOptions={type="H", align="LEFT"}
    }
    
    ---@class PVPTestFrame.Content
    frame.content = frame.content

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label="Date",
            width=150,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A,
        },
        {
            label="Map",
            width=60,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B,
        },
        {
            label="Team",
            width=100,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A,
        },
        {
            label="MMR",
            width=70,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B,
        },
        {
            label="Duration",
            width=70,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A,
        },
        {
            label="Damage",
            width=70,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B,
        },
        {
            label="Healing",
            width=70,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A,
        },
        {
            label="Rating",
            width=70,
            justifyOptions={type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B,
        },
    }

    frame.content.pvpList = GGUI.FrameList{
        parent=frame.content, anchorParent=frame.title.frame, offsetY=-170, anchorA="TOP", anchorB="TOP", scale = 0.85, showBorder = true,
        sizeY=500,columnOptions=columnOptions, rowConstructor = function (columns)
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local teamColumn = columns[3]
            local mmrColumn = columns[4]
            local durationColumn = columns[5]
            local damageColumn = columns[6]
            local healingColumn = columns[7]
            local ratingColumn = columns[8]

            dateColumn.text = GGUI.Text{
                parent=dateColumn, anchorParent=dateColumn, justifyOptions={type="H", align="CENTER"}
            }
            mapColumn.text = GGUI.Text{
                parent=mapColumn, anchorParent=mapColumn,justifyOptions={type="H", align="CENTER"}
            }
            local iconSize = 23
            teamColumn.icon1 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn, anchorA="LEFT", anchorB="LEFT", offsetX=16,
                initialClass=GGUI.CONST.CLASSES.WARLOCK, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            teamColumn.icon2 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn.icon1.frame, anchorA="LEFT", anchorB= "RIGHT",
                initialClass=GGUI.CONST.CLASSES.WARRIOR, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            teamColumn.icon3 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn.icon2.frame, anchorA="LEFT", anchorB= "RIGHT",
                initialClass=GGUI.CONST.CLASSES.WINDWALKER, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            mmrColumn.text = GGUI.Text{
                parent=mmrColumn, anchorParent=mmrColumn,justifyOptions={type="H", align="CENTER"}
            }
            durationColumn.text = GGUI.Text{
                parent=durationColumn, anchorParent=durationColumn,justifyOptions={type="H", align="CENTER"}
            }
            damageColumn.text = GGUI.Text{
                parent=damageColumn, anchorParent=damageColumn,justifyOptions={type="H", align="CENTER"}
            }
            healingColumn.text = GGUI.Text{
                parent=healingColumn, anchorParent=healingColumn,justifyOptions={type="H", align="CENTER"}
            }
            ratingColumn.text = GGUI.Text{
                parent=ratingColumn, anchorParent=ratingColumn,justifyOptions={type="H", align="CENTER"}
            }
        end
    }

    --frame:Hide()

    PvPLookup.HISTORY.frame = frame
end


function PvPLookup.HISTORY:UpdateHistory()
    --- DUMMY DATA
    for _ = 1, 100 do
        PvPLookup.HISTORY.frame.content.pvpList:Add(function (row)
            local columns = row.columns
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local teamColumn = columns[3]
            local mmrColumn = columns[4]
            local durationColumn = columns[5]
            local damageColumn = columns[6]
            local healingColumn = columns[7]
            local ratingColumn = columns[8]

            dateColumn.text:SetText("29.12.2023 15:00")
            mapColumn.text:SetText(GUTIL:ColorizeText("RoL", GUTIL.COLORS.RED))
            ---teamColumn
            mmrColumn.text:SetText("1234")
            durationColumn.text:SetText("5:34")
            damageColumn.text:SetText("1.4M")
            healingColumn.text:SetText("576K")
            ratingColumn.text:SetText("+42")
        end)
    end

    PvPLookup.HISTORY.frame.content.pvpList:UpdateDisplay()
end