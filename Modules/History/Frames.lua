---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.History
PvPLookup.HISTORY = PvPLookup.HISTORY

---@class PvPLookup.History.Frames
PvPLookup.HISTORY.FRAMES = {}

function PvPLookup.HISTORY.FRAMES:Init()
    local sizeX = 1100
    local sizeY = 600
    ---@class PVPTestFrame : GGUI.Frame
    local frame = GGUI.Frame{
        moveable=true, closeable=true, collapseable=true, frameID=PvPLookup.CONST.FRAMES.HISTORY_FRAME,
        sizeX=sizeX, sizeY=sizeY, frameConfigTable=PvPLookupGGUIConfig, frameTable=PvPLookup.MAIN.FRAMES,
        backdropOptions=PvPLookup.CONST.HISTORY_BACKDROP
    }

    local titleFrame = GGUI.Frame{
        parent=frame.content, anchorParent=frame.content,anchorA="BOTTOM", anchorB="TOP", offsetY=-40,
        sizeX=200, sizeY=60,
        backdropOptions=PvPLookup.CONST.HISTORY_BACKDROP
    }

    titleFrame.frame:SetFrameLevel(frame.frame:GetFrameLevel()+10)

    titleFrame.content.title = GGUI.Text{
        parent=titleFrame.content, anchorParent=titleFrame.content,
        text=GUTIL:ColorizeText("PVP-LOOKUP", GUTIL.COLORS.LEGENDARY), scale=2,
    }

    -- frame.backgroundTexture = frame.frame:CreateTexture(nil, "BACKGROUND")
    -- frame.backgroundTexture:SetAllPoints(true)
    -- frame.backgroundTexture:SetAtlas('pvpscoreboard-background')

    frame.content.logo = GGUI.Text{
        parent=frame.content, anchorParent=titleFrame.content.title.frame, anchorA="BOTTOM", anchorB="TOP", offsetY=7,
        text=PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.07)
    }
    
    PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.5)

    ---@class PVPTestFrame.Content
    frame.content = frame.content

    -- frame.content.modeDropdown = GGUI.Dropdown{
    --     parent=frame.content, anchorParent=frame.content, anchorA="TOPRIGHT", anchorB="TOPRIGHT", offsetX=-50, offsetY=-30, width=100,
    --     initialLabel="Select..", initialData={
    --         {
    --             label="Solo Shuffle",
    --             value = PvPLookup.CONST.PVP_MODES.SOLO,
    --         },
    --         {
    --             label="2v2",
    --             value = PvPLookup.CONST.PVP_MODES.TWOS,
    --         },
    --         {
    --             label="3v3",
    --             value = PvPLookup.CONST.PVP_MODES.THREES,
    --         },
    --         {
    --             label="RBG",
    --             value = PvPLookup.CONST.PVP_MODES.RGB,
    --         },
    --     }
    -- }

    frame.content.score = GGUI.Text{
        parent=frame.content, anchorParent=frame.title.frame, anchorA="TOP", anchorB="BOTTOM", offsetY=-10,
        text = GUTIL:ColorizeText("27", GUTIL.COLORS.GREEN) .. " - " .. GUTIL:ColorizeText("19", GUTIL.COLORS.RED), scale = 4,
    }

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label="Date",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Map",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Team",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Rating",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Enemy",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Rating",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Duration",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Damage",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Damage",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
        {
            label="Rating (+/-)",
            width=100,
            justifyOptions={type="H", align="CENTER"}
        },
    }

    frame.content.pvpList = GGUI.FrameList{
        parent=frame.content, anchorParent=frame.title.frame, offsetY=-150, anchorA="TOP", anchorB="TOP", showBorder=true,
        sizeY=300,columnOptions=columnOptions, rowConstructor = function (columns)
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local teamColumn = columns[3]
            local teamRatingColumn = columns[4]
            local enemyColumn = columns[5]
            local enemyRatingColumn = columns[6]
            local durationColumn = columns[7]
            local teamDamageColumn = columns[8]
            local enemyDamageColumn = columns[9]
            local ratingChangeColumn = columns[10]

            dateColumn.text = GGUI.Text{
                parent=dateColumn, anchorParent=dateColumn, justifyOptions={type="H", align="CENTER"}
            }
            mapColumn.text = GGUI.Text{
                parent=mapColumn, anchorParent=mapColumn,justifyOptions={type="H", align="CENTER"}
            }
            teamColumn.text = GGUI.Text{
                parent=teamColumn, anchorParent=teamColumn,justifyOptions={type="H", align="CENTER"},
            }
            teamRatingColumn.text = GGUI.Text{
                parent=teamRatingColumn, anchorParent=teamRatingColumn,justifyOptions={type="H", align="CENTER"}
            }
            enemyColumn.text = GGUI.Text{
                parent=enemyColumn, anchorParent=enemyColumn,justifyOptions={type="H", align="CENTER"}
            }
            enemyRatingColumn.text = GGUI.Text{
                parent=enemyRatingColumn, anchorParent=enemyRatingColumn,justifyOptions={type="H", align="CENTER"}
            }
            durationColumn.text = GGUI.Text{
                parent=durationColumn, anchorParent=durationColumn,justifyOptions={type="H", align="CENTER"}
            }
            teamDamageColumn.text = GGUI.Text{
                parent=teamDamageColumn, anchorParent=teamDamageColumn,justifyOptions={type="H", align="CENTER"}
            }
            enemyDamageColumn.text = GGUI.Text{
                parent=enemyDamageColumn, anchorParent=enemyDamageColumn,justifyOptions={type="H", align="CENTER"}
            }
            ratingChangeColumn.text = GGUI.Text{
                parent=ratingChangeColumn, anchorParent=ratingChangeColumn,justifyOptions={type="H", align="CENTER"}
            }
        end
    }

    for i = 1, 100 do
        frame.content.pvpList:Add(function (row)
            local columns = row.columns
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local teamColumn = columns[3]
            local teamRatingColumn = columns[4]
            local enemyColumn = columns[5]
            local enemyRatingColumn = columns[6]
            local durationColumn = columns[7]
            local teamDamageColumn = columns[8]
            local enemyDamageColumn = columns[9]
            local ratingChangeColumn = columns[10]

            -- https://warcraft.wiki.gg/wiki/API_C_CreatureInfo.GetClassInfo
            local mageTexture = select(3, GetClassInfo(8))
            local warriorTexture = select(3, GetClassInfo(1))
            local classIconSize = 20

            dateColumn.text:SetText("Some Player")
            mapColumn.text:SetText(GUTIL:ColorizeText("RoL", GUTIL.COLORS.RED))
            teamColumn.text:SetText(GUTIL:IconToText(mageTexture, classIconSize, classIconSize) .. " " .. GUTIL:IconToText(warriorTexture, classIconSize, classIconSize))
            teamRatingColumn.text:SetText(1234)
            enemyColumn.text:SetText(GUTIL:IconToText(mageTexture, classIconSize, classIconSize) .. " " .. GUTIL:IconToText(warriorTexture, classIconSize, classIconSize))
            enemyRatingColumn.text:SetText(20000)
            durationColumn.text:SetText("5:34")
            teamDamageColumn.text:SetText("1.4M")
            enemyDamageColumn.text:SetText("576K")
            ratingChangeColumn.text:SetText(GUTIL:ColorizeText("+42", GUTIL.COLORS.GREEN))
        end)
    end

    frame.content.pvpList:UpdateDisplay()

    --frame:Hide()
end