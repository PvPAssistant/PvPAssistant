---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.History
PvPLookup.HISTORY = PvPLookup.HISTORY

---@class PvPLookup.History.Frames
PvPLookup.HISTORY.FRAMES = {}

function PvPLookup.HISTORY.FRAMES:Init()
    local sizeX = 700
    local sizeY = 670
    ---@class PvPLookup.HistoryFrame : GGUI.Frame
    local frame = GGUI.Frame{
        moveable=true, closeable=true, frameID=PvPLookup.CONST.FRAMES.HISTORY_FRAME,
        sizeX=sizeX, sizeY=sizeY, frameConfigTable=PvPLookupGGUIConfig, frameTable=PvPLookup.MAIN.FRAMES,
        backdropOptions=PvPLookup.CONST.HISTORY_BACKDROP,
    }

    frame.content.borderFrame = GGUI.Frame{
        parent=frame.content, anchorParent=frame.content, sizeX=sizeX-30, sizeY=sizeY-90, offsetY=-28,
        backdropOptions=PvPLookup.CONST.HISTORY_FRAME_INNER_BORDER_BACKDROP,
    }

    frame.content.borderFrame.frame:SetFrameLevel(frame.content:GetFrameLevel()+10)

    ---@class PvPLookup.HistoryFrame.Content
    frame.content = frame.content

    ---@class PvPLookup.HistoryFrame.MatchHistoryTab : GGUI.BlizzardTab
    frame.content.matchHistoryTab = GGUI.BlizzardTab{
        parent=frame.content, anchorParent=frame.content, anchorA="CENTER", anchorB="CENTER",
        sizeX=sizeX, sizeY=sizeY, initialTab = true, top=true,
        buttonOptions={
            label="Match History",
            anchorParent=frame.content.borderFrame.content,
            offsetY = -2,
            offsetX = 3,
        }
    }
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    frame.content.matchHistoryTab.content = frame.content.matchHistoryTab.content
    local matchHistoryTab = frame.content.matchHistoryTab
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    matchHistoryTab.content = matchHistoryTab.content

    
    ---@class PvPLookup.HistoryFrame.DROverviewTab : GGUI.BlizzardTab
    frame.content.drOverviewTab = GGUI.BlizzardTab{
        parent=frame.content, anchorParent=frame.content, anchorA="CENTER", anchorB="CENTER",
        sizeX=sizeX, sizeY=sizeY, top=true,
        buttonOptions={
            label="DR Overview",
            anchorParent=frame.content.matchHistoryTab.button,
            anchorA="LEFT",
            anchorB="RIGHT",
        }
    }
    ---@class PvPLookup.HistoryFrame.DROverviewTab.Content
    frame.content.drOverviewTab.content = frame.content.drOverviewTab.content
    local drOverviewTab = frame.content.drOverviewTab
    ---@class PvPLookup.HistoryFrame.DROverviewTab.Content
    drOverviewTab.content = drOverviewTab.content

    ---@class PvPLookup.HistoryFrame.CCCatalogueTab : GGUI.BlizzardTab
    frame.content.ccCatalogueTab = GGUI.BlizzardTab{
        parent=frame.content, anchorParent=frame.content, anchorA="CENTER", anchorB="CENTER",
        sizeX=sizeX, sizeY=sizeY,  top=true,
        buttonOptions={
            label="CC Catalogue",
            anchorParent=frame.content.drOverviewTab.button,
            anchorA="LEFT",
            anchorB="RIGHT",
        }
    }
    ---@class PvPLookup.HistoryFrame.CCCatalogueTab.Content
    frame.content.ccCatalogueTab.content = frame.content.ccCatalogueTab.content
    local ccCatalogueTab = frame.content.ccCatalogueTab
    ---@class PvPLookup.HistoryFrame.CCCatalogueTab.Content
    ccCatalogueTab.content = ccCatalogueTab.content

    GGUI.BlizzardTabSystem{matchHistoryTab, ccCatalogueTab, drOverviewTab}

    frame.content.title = GGUI.Text{
        parent=frame.content, anchorParent=frame.content, anchorA="TOP", anchorB="TOP", offsetY=-10, offsetX=7,
        text=GUTIL:ColorizeText("PVP-LOOKUP", GUTIL.COLORS.LEGENDARY), scale=2,
    }

    frame.content.logo = GGUI.Text{
        parent=frame.content, anchorParent=frame.content.title.frame, anchorA="RIGHT", anchorB="LEFT", offsetX=0, offsetY=2,
        text=PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.028)
    }

    PvPLookup.HISTORY.frame = frame

    PvPLookup.HISTORY.FRAMES:InitMatchHistoryTab()
    PvPLookup.HISTORY.FRAMES:InitCCCatalogueTab()
    PvPLookup.HISTORY.FRAMES:InitDROverviewTab()

    frame:Hide()
end

function PvPLookup.HISTORY.FRAMES:InitMatchHistoryTab()
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab
    local matchHistoryTab = PvPLookup.HISTORY.frame.content.matchHistoryTab
    local borderFrame = PvPLookup.HISTORY.frame.content.borderFrame
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    matchHistoryTab.content = matchHistoryTab.content
    
    matchHistoryTab.content.score = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content, anchorA="TOP", anchorB="TOP", offsetY=-43,
        text = GUTIL:ColorizeText("27", GUTIL.COLORS.GREEN) .. " - " .. GUTIL:ColorizeText("19", GUTIL.COLORS.RED), scale = 4,
    }

    matchHistoryTab.content.ratingTitle = GGUI.Text{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.score.frame, anchorA="TOP", anchorB="BOTTOM",
        text= "RATING " .. GUTIL:ColorizeText("1496", GUTIL.COLORS.GOLD) .. " - " .. GUTIL:ColorizeText("2456", GUTIL.COLORS.LEGENDARY), 
        scale = 1, 
    }

    local statHeadersOffsetX = 30
    local statHeadersOffsetY = 4
    matchHistoryTab.content.damageHeader = GGUI.Text{
        parent=matchHistoryTab.content,anchorParent=matchHistoryTab.content.score.frame, anchorA="RIGHT", anchorB="LEFT", 
        offsetX = -statHeadersOffsetX, offsetY=statHeadersOffsetY,
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
        offsetX = statHeadersOffsetX, offsetY=statHeadersOffsetY,
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

    ---@class PvPLookup.History.ClassFilterFrame : GGUI.Frame
    matchHistoryTab.content.classFilterFrame = GGUI.Frame{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content.score.frame, 
        anchorA="BOTTOM", anchorB="TOP", backdropOptions=PvPLookup.CONST.HISTORY_FRAME_INNER_BORDER_BACKDROP,
        sizeX=580, sizeY=50, offsetY=3,
    }

    matchHistoryTab.content.classFilterFrame.title = GGUI.Text{
        parent=matchHistoryTab.content.classFilterFrame.frame, anchorParent=matchHistoryTab.content.classFilterFrame.content,
        anchorA="BOTTOMLEFT", anchorB="TOPLEFT", text="Class Filters", offsetX=25,
    }

    matchHistoryTab.content.classFilterFrame.frame:SetFrameLevel(matchHistoryTab.content:GetFrameLevel()+10)

    ---@type GGUI.ClassIcon[]
    matchHistoryTab.content.classFilterFrame.classFilterButtons = {}

    -- init class filter
    matchHistoryTab.activeClassFilters = {}
    local classFilterIconSize=30
    local function CreateClassFilterIcon(class, anchorParent, offX, offY, anchorA, anchorB)
        local classFilterIcon = GGUI.ClassIcon{
            sizeX=classFilterIconSize, sizeY=classFilterIconSize,
            parent=matchHistoryTab.content.classFilterFrame.content, anchorParent=anchorParent,
            initialClass=class, offsetX=offX, offsetY=offY, anchorA=anchorA, anchorB=anchorB, showBorder=true,
        }

        classFilterIcon.frame:SetScript("OnClick", function ()
            if not matchHistoryTab.activeClassFilters[class] then
                matchHistoryTab.activeClassFilters[class] = true
                classFilterIcon:Desaturate()
                -- reload list with new filters
                PvPLookup.HISTORY:UpdateHistory()
            else
                matchHistoryTab.activeClassFilters[class] = nil
                classFilterIcon:Saturate()
                -- reload list with new filters
                PvPLookup.HISTORY:UpdateHistory()
            end
        end)

        return classFilterIcon
    end

    local currentAnchor = matchHistoryTab.content.classFilterFrame.frame
    for i, class in pairs(PvPLookup.CONST.CLASSES) do
        local anchorB = "RIGHT"
        local offX = 15
        if i == 1 then
            anchorB="LEFT"
            offX=27
        end
        local classFilterIcon = CreateClassFilterIcon(class, currentAnchor, offX, 0, "LEFT", anchorB)
        currentAnchor = classFilterIcon.frame
    end


    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label="Date",
            width=140,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="Map",
            width=60,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="Team",
            width=100,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="MMR",
            width=70,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="Duration",
            width=70,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="Damage",
            width=70,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="Healing",
            width=70,
            justifyOptions={type="H", align="CENTER"},
        },
        {
            label="Rating",
            width=70,
            justifyOptions={type="H", align="CENTER"},
        },
    }

    matchHistoryTab.content.pvpList = GGUI.FrameList{
        parent=matchHistoryTab.content, anchorParent=matchHistoryTab.content, offsetY=-300, offsetX=-10,
        anchorA="TOP", anchorB="TOP", scale = 0.85, showBorder = true,
        rowBackdrops={PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B},
        sizeY=450,columnOptions=columnOptions, rowConstructor = function (columns)
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
        parent=matchHistoryTab.content, anchorParent = borderFrame.frame, anchorA="TOPRIGHT", anchorB="TOPRIGHT", width = 100, offsetX=-100, offsetY=-5,
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
end

function PvPLookup.HISTORY.FRAMES:InitCCCatalogueTab()
    local ccCatalogueTab = PvPLookup.HISTORY.frame.content.ccCatalogueTab
    ---@class PvPLookup.HistoryFrame.CCCatalogueTab.Content
    ccCatalogueTab.content = ccCatalogueTab.content
end
function PvPLookup.HISTORY.FRAMES:InitDROverviewTab()
    local drOverviewTab = PvPLookup.HISTORY.frame.content.drOverviewTab
    ---@class PvPLookup.HistoryFrame.DROverviewTab.Content
    drOverviewTab.content = drOverviewTab.content

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = "Spec",
            width = 40,
            justifyOptions = {type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A,
        },
        {
            label = "Spell",
            width = 40,
            justifyOptions = {type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B,
        },
        {
            label = "DR",
            width = 70,
            justifyOptions = {type="H", align="CENTER"},
            backdropOptions = PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A,
        },
    }

    drOverviewTab.content.drList = GGUI.FrameList{
        parent=drOverviewTab.content, anchorParent=drOverviewTab.content, anchorA="TOP", anchorB="TOP",
        sizeY = 300, showBorder = true, offsetY = -150,
        columnOptions = columnOptions,
        rowConstructor = function (columns)
            local specColumn = columns[1]
            local spellColumn = columns[2]
            local drColumn = columns[3]

            local iconSize = 23
            specColumn.icon = GGUI.ClassIcon{
                parent=specColumn, anchorParent=specColumn, enableMouse=false, sizeX=iconSize, sizeY=iconSize,
            }

            spellColumn.icon = GGUI.Icon{ -- TODO: SpellIcon?
                parent=spellColumn, anchorParent=spellColumn, sizeX=iconSize, sizeY=iconSize,
            }

            drColumn.text = GGUI.Text{ -- TODO: SpellIcon?
                parent=drColumn, anchorParent=drColumn, text="Some DR", justifyOptions={type="H", align="CENTER"},
            }

        end
    }

    PvPLookup.HISTORY:FillDRData()
end


function PvPLookup.HISTORY:UpdateHistory()

    local matchHistoryTab = PvPLookup.HISTORY.frame.content.matchHistoryTab
    local pvpList = matchHistoryTab.content.pvpList

    matchHistoryTab.content.pvpList:Remove()

    local pvpModeFilter = PvPLookup.HISTORY:GetSelectedModeFilter()
    local displayedTeam = PvPLookup.HISTORY:GetDisplayTeam()

    ---@type PvPLookup.MatchHistory[]
    local filteredHistory = GUTIL:Filter(PvPLookupHistoryDB or {}, 
    ---@param matchHistory PvPLookup.MatchHistory
    function (matchHistory)
        local classFiltered = false
        ---@type PvPLookup.Player[]
        local players = {}
        if displayedTeam == PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM then
            players = matchHistory.playerTeam.players
        else
            players = matchHistory.enemyTeam.players
        end

        for _, player in pairs(players) do
            if matchHistoryTab.activeClassFilters[player.class] then
                classFiltered = true
            end
        end
        return matchHistory.pvpMode == pvpModeFilter and not classFiltered
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

function PvPLookup.HISTORY:FillDRData()
    local drOverviewTab = PvPLookup.HISTORY.frame.content.drOverviewTab
    local drList = drOverviewTab.content.drList

    for i=1, 30 do
        drList:Add(function (row)
            local columns = row.columns
            local specColumn = columns[1]
            local spellColumn = columns[2]
            local drColumn = columns[3]

            specColumn.icon:SetClass(GGUI.CONST.CLASSES.WARRIOR)
            -- spellColumn.icon
            drColumn.text:SetText("DR Info")
        end)
    end

    drList:UpdateDisplay()
end