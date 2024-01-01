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
        backdropOptions=PvPLookup.CONST.HISTORY_BACKDROP, globalName="PvPLookupHistoryFrame"
    }

    ---@class PvPLookup.HistoryFrame.Content
    frame.content = frame.content

    ---@class PvPLookup.HistoryFrame.MatchHistoryTab : GGUI.BlizzardTab
    frame.content.matchHistoryTab = GGUI.BlizzardTab{
        parent=frame.content, anchorParent=frame.content, anchorA="CENTER", anchorB="CENTER",
        sizeX=sizeX, sizeY=sizeY, initialTab = true,
        buttonOptions={
            label="Match History",
        }
    }
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    frame.content.matchHistoryTab.content = frame.content.matchHistoryTab.content
    local matchHistoryTab = frame.content.matchHistoryTab
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    matchHistoryTab.content = matchHistoryTab.content

    ---@class PvPLookup.HistoryFrame.CCOverviewTab : GGUI.BlizzardTab
    frame.content.ccOverviewTab = GGUI.BlizzardTab{
        parent=frame.content, anchorParent=frame.content, anchorA="CENTER", anchorB="CENTER",
        sizeX=sizeX, sizeY=sizeY, 
        buttonOptions={
            label="CC Overview",
            anchorParent=frame.content.matchHistoryTab.button,
            anchorA="LEFT",
            anchorB="RIGHT",
        }
    }
    ---@class PvPLookup.HistoryFrame.CCOverviewTab.Content
    frame.content.ccOverviewTab.content = frame.content.ccOverviewTab.content
    local ccOverviewTab = frame.content.ccOverviewTab
    ---@class PvPLookup.HistoryFrame.CCOverviewTab.Content
    ccOverviewTab.content = ccOverviewTab.content

    GGUI.BlizzardTabSystem{matchHistoryTab, ccOverviewTab}

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

    
    matchHistoryTab.content.score = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content, anchorA="TOP", anchorB="TOP", offsetY=-10,
        text = GUTIL:ColorizeText("27", GUTIL.COLORS.GREEN) .. " - " .. GUTIL:ColorizeText("19", GUTIL.COLORS.RED), scale = 4,
    }

    matchHistoryTab.content.ratingTitle = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.score.frame, anchorA="TOP", anchorB="BOTTOM",
        text= "RATING " .. GUTIL:ColorizeText("1496", GUTIL.COLORS.GOLD) .. " - " .. GUTIL:ColorizeText("2456", GUTIL.COLORS.LEGENDARY), 
        scale = 1, 
    }

    local statHeadersOffsetX = 30
    matchHistoryTab.content.damageHeader = GGUI.Text{
        parent=matchHistoryTab.content,anchorParent=matchHistoryTab.content.score.frame, anchorA="RIGHT", anchorB="LEFT", 
        offsetX = -statHeadersOffsetX,
        text=GUTIL:ColorizeText("DAMAGE", GUTIL.COLORS.LEGENDARY), scale = 2,
    }

    matchHistoryTab.content.damageBestTitle = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.damageHeader.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "ARENA BEST: ", justifyOptions={type="H", align="LEFT"}, offsetX=0,
    }
    matchHistoryTab.content.damageBestValue = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.damageBestTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "40.7M", justifyOptions={type="H", align="LEFT"}
    }
    matchHistoryTab.content.damageTotalTitle = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.damageBestTitle.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "TOTAL: ", justifyOptions={type="H", align="RIGHT"}, offsetY=-5,
    }
    matchHistoryTab.content.damageTotalValue = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.damageTotalTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "1.38B", justifyOptions={type="H", align="LEFT"}
    }

    matchHistoryTab.content.healingHeader = GGUI.Text{
        parent=matchHistoryTab.content,anchorParent=matchHistoryTab.content.score.frame, anchorA="LEFT", anchorB="RIGHT", 
        offsetX = statHeadersOffsetX,
        text=GUTIL:ColorizeText("HEALING", GUTIL.COLORS.GOLD), scale = 2,
    }

    matchHistoryTab.content.healingBestTitle = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.healingHeader.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "ARENA BEST: ", justifyOptions={type="H", align="LEFT"}, offsetX=0,
    }
    matchHistoryTab.content.healingBestValue = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.healingBestTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "40.7M", justifyOptions={type="H", align="LEFT"}
    }
    matchHistoryTab.content.healingTotalTitle = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.healingBestTitle.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT",
        scale = 1, text = "TOTAL: ", justifyOptions={type="H", align="RIGHT"}, offsetY=-5,
    }
    matchHistoryTab.content.healingTotalValue = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.healingTotalTitle.frame, anchorA="LEFT", anchorB="RIGHT", offsetX=1,
        scale = 1, text = "1.38B", justifyOptions={type="H", align="LEFT"}
    }


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

    matchHistoryTab.content.pvpList = GGUI.FrameList{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content, offsetY=-170, anchorA="TOP", anchorB="TOP", scale = 0.85, showBorder = true,
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
            teamColumn.icon31 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn, anchorA="LEFT", anchorB="LEFT", offsetX=16,
                initialClass=GGUI.CONST.CLASSES.WARLOCK, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            teamColumn.icon32 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn.icon31.frame, anchorA="LEFT", anchorB= "RIGHT",
                initialClass=GGUI.CONST.CLASSES.WARRIOR, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            teamColumn.icon33 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn.icon32.frame, anchorA="LEFT", anchorB= "RIGHT",
                initialClass=GGUI.CONST.CLASSES.WINDWALKER, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            teamColumn.icon21 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn, anchorA="LEFT", anchorB="LEFT", offsetX=16 + iconSize/2,
                initialClass=GGUI.CONST.CLASSES.WARLOCK, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }
            teamColumn.icon22 = GGUI.ClassIcon{
                parent=teamColumn, anchorParent=teamColumn.icon21.frame, anchorA="LEFT", anchorB= "RIGHT",
                initialClass=GGUI.CONST.CLASSES.WARRIOR, sizeX=iconSize, sizeY=iconSize, enableMouse=false,
            }

            teamColumn.iconsTwo = {teamColumn.icon21, teamColumn.icon22}
            teamColumn.iconsThree = {teamColumn.icon31, teamColumn.icon32, teamColumn.icon33}

            ---@param team PvPLookup.Team
            teamColumn.SetTeam = function (self, team)
                if #team.players == 3 then
                    for index, icon in pairs(teamColumn.iconsThree) do
                        icon:Show()
                        icon:SetClass(team.players[index].spec)
                    end
                    for _, icon in pairs(teamColumn.iconsTwo) do
                        icon:Hide()
                    end
                elseif #team.players == 2 then
                    for _, icon in pairs(teamColumn.iconsThree) do
                        icon:Hide()
                    end
                    for index, icon in pairs(teamColumn.iconsTwo) do
                        icon:Show()
                        icon:SetClass(team.players[index].spec)
                    end
                end
            end
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

    matchHistoryTab.content.teamDisplayDropdown = GGUI.Dropdown{
        parent=matchHistoryTab.content, anchorParent = matchHistoryTab.content.pvpList.frame, anchorA="TOPLEFT", anchorB="BOTTOMLEFT", offsetX=-17, width = 100,
        initialData={
            {
                label="Enemy Team",
                value = "ENEMY_TEAM"
            },
            {
                label="My Team",
                value = "PLAYER_TEAM"
            },
        },
        initialLabel = "My Team",
        initialValue = "PLAYER_TEAM",
        clickCallback=function (self, label, value)
            PvPLookup.HISTORY:UpdateHistory()
        end
    }

    matchHistoryTab.content.pvpModeDropdown = GGUI.Dropdown{
        parent=matchHistoryTab.content, anchorParent = matchHistoryTab.content.teamDisplayDropdown.frame, anchorA="LEFT", anchorB="RIGHT", width=50, offsetX=-30,
        initialData={
            {
                label="Solo",
                value = PvPLookup.CONST.PVP_MODES.SOLO,
            },
            {
                label="2v2",
                value = PvPLookup.CONST.PVP_MODES.TWOS,
            },
            {
                label="3v3",
                value = PvPLookup.CONST.PVP_MODES.THREES,
            },
            {
                label="RGB",
                value = PvPLookup.CONST.PVP_MODES.RGB,
            },
        },
        initialLabel = "2v2",
        initialValue = PvPLookup.CONST.PVP_MODES.TWOS,
        clickCallback=function (self, label, value)
            PvPLookup.HISTORY:UpdateHistory()
        end
    }

    --frame:Hide()

    PvPLookup.HISTORY.frame = frame
end


function PvPLookup.HISTORY:UpdateHistory()

    local matchHistoryTab = PvPLookup.HISTORY.frame.content.matchHistoryTab
    local pvpList = matchHistoryTab.content.pvpList

    matchHistoryTab.content.pvpList:Remove()

    local pvpModeFilter = PvPLookup.HISTORY:GetSelectedModeFilter()

    ---@type PvPLookup.MatchHistory[]
    local filteredHistory = GUTIL:Filter(PvPLookupHistoryDB or {}, 
    ---@param matchHistory PvPLookup.MatchHistory
    function (matchHistory)
        return matchHistory.pvpMode == pvpModeFilter
    end)

    for _, matchHistory in pairs(filteredHistory) do
        pvpList:Add(function (row)
            local columns = row.columns
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local teamColumn = columns[3]
            local mmrColumn = columns[4]
            local durationColumn = columns[5]
            local damageColumn = columns[6]
            local healingColumn = columns[7]
            local ratingColumn = columns[8]

            local date = date("*t", matchHistory.timestamp)
            local formattedDate = string.format("%d.%d.%d %d:%d", date.day, date.month, date.year, date.hour, date.min)
            dateColumn.text:SetText(formattedDate)
            mapColumn.text:SetText(GUTIL:ColorizeText(matchHistory.map, GUTIL.COLORS.RED))

            local displayedTeam = PvPLookup.HISTORY:GetDisplayTeam()

            if displayedTeam == PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM then
                teamColumn:SetTeam(matchHistory.playerTeam)
                mmrColumn.text:SetText(matchHistory.playerMMR)
                damageColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.playerDamage))
                healingColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.playerHealing))
            else
                teamColumn:SetTeam(matchHistory.enemyTeam)
                mmrColumn.text:SetText(matchHistory.enemyMMR)
                damageColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.enemyDamage))
                healingColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.enemyHealing))
            end

            -- Convert milliseconds to seconds
            local totalSeconds = matchHistory.duration / 1000
            -- Calculate minutes and remaining seconds
            local minutes = math.floor(totalSeconds / 60)
            local seconds = totalSeconds % 60

            durationColumn.text:SetText(minutes .. ":" .. seconds)
            ratingColumn.text:SetText(matchHistory.rating)            
        end)
    end

    pvpList:UpdateDisplay()
end