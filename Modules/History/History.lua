---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.History
PvPLookup.HISTORY = {}

function PvPLookup.HISTORY:Init()

    ---@class PVPTestFrame : GGUI.Frame
    local frame = GGUI.Frame{
        title="PVP-Lookup", moveable=true, closeable=true, collapseable=true,
        sizeX=600, sizeY=400, frameConfigTable=PvPLookupGGUIConfig, 
        frameTable=PvPLookup.MAIN.FRAMES, 
        frameID=PvPLookup.CONST.FRAMES.HISTORY_FRAME
    }

    frame.backgroundTexture = frame.frame:CreateTexture(nil, "BACKGROUND")
    frame.backgroundTexture:SetAllPoints(true)
    frame.backgroundTexture:SetAtlas('pvpscoreboard-background')

    ---@class PVPTestFrame.Content
    frame.content = frame.content

    frame.content.modeDropdown = GGUI.Dropdown{
        parent=frame.content, anchorParent=frame.content, anchorA="TOPRIGHT", anchorB="TOPRIGHT", offsetX=-20, offsetY=-20, sizeX=30,
        initialLabel="Select..", initialData={
            {
                label="Solo Shuffle",
                value = 1,
            },
            {
                label="2v2",
                value = 2,
            },
            {
                label="3v3",
                value = 3,
            },
            {
                label="RBG",
                value = 4,
            },
        }
    }

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label="Player",
            width=100,
        },
        {
            label="Rating",
            width=100,
        },
        {
            label="Damage",
            width=100,
        },
        {
            label="Healing",
            width=100,
        },
    }

    frame.content.pvpList = GGUI.FrameList{
        parent=frame.content, anchorParent=frame.title.frame, offsetY=-50, anchorA="TOP", anchorB="TOP", showBorder=true,
        sizeY=300,columnOptions=columnOptions, rowConstructor = function (columns)
            local playerColumn = columns[1]
            local ratingColumn = columns[2]
            local damageColumn = columns[3]
            local healingColumn = columns[4]

            playerColumn.text = GGUI.Text{
                parent=playerColumn, anchorParent=playerColumn,
            }
            ratingColumn.text = GGUI.Text{
                parent=ratingColumn, anchorParent=ratingColumn,
            }
            damageColumn.text = GGUI.Text{
                parent=damageColumn, anchorParent=damageColumn,
            }
            healingColumn.text = GGUI.Text{
                parent=healingColumn, anchorParent=healingColumn,
            }
        end
    }

    for i = 1, 100 do
        frame.content.pvpList:Add(function (row)
            local columns = row.columns
            local playerColumn = columns[1]
            local ratingColumn = columns[2]
            local damageColumn = columns[3]
            local healingColumn = columns[4]

            playerColumn.text:SetText("Some Player")
            ratingColumn.text:SetText(1000)
            damageColumn.text:SetText(20000)
            healingColumn.text:SetText(300000)
        end)
    end

    frame.content.pvpList:UpdateDisplay()
end