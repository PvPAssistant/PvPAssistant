---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.History
PvPLookup.HISTORY = PvPLookup.HISTORY

---@class PvPLookup.History.Frames
PvPLookup.HISTORY.FRAMES = {}

function PvPLookup.HISTORY.FRAMES:Init()
    local sizeX = 710
    local sizeY = 650
    ---@class PvPLookup.HistoryFrame : GGUI.Frame
    local frame = GGUI.Frame {
        moveable = true, frameID = PvPLookup.CONST.FRAMES.HISTORY_FRAME,
        sizeX = sizeX, sizeY = sizeY, frameConfigTable = PvPLookupGGUIConfig, frameTable = PvPLookup.MAIN.FRAMES,
        backdropOptions = PvPLookup.CONST.HISTORY_BACKDROP,
    }

    frame.content.titleLogo = GGUI.Text {
        parent = frame.content, anchorParent = frame.content, offsetY = -15, offsetX = 30,
        text = GUTIL:ColorizeText("PVP-LOOKUP", GUTIL.COLORS.LEGENDARY), scale = 1.7,
        anchorA = "TOPLEFT", anchorB = "TOPLEFT",
    }

    ---@class PvPLookup.HistoryFrame.Content : Frame
    frame.content = frame.content
    local tabContentOffsetY = -50
    local tabButtonScale = 1.1
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab : GGUI.Tab
    frame.content.matchHistoryTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Match History", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.titleLogo.frame,
            offsetY = 1,
            offsetX = 30,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        }
    }

    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    frame.content.matchHistoryTab.content = frame.content.matchHistoryTab.content
    local matchHistoryTab = frame.content.matchHistoryTab
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    matchHistoryTab.content = matchHistoryTab.content


    ---@class PvPLookup.HistoryFrame.DROverviewTab : GGUI.Tab
    frame.content.drOverviewTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("DR Overview", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.matchHistoryTab.button.frame,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            offsetX = 10,
            buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        },
    }
    ---@class PvPLookup.HistoryFrame.DROverviewTab.Content
    frame.content.drOverviewTab.content = frame.content.drOverviewTab.content
    local drOverviewTab = frame.content.drOverviewTab
    ---@class PvPLookup.HistoryFrame.DROverviewTab.Content
    drOverviewTab.content = drOverviewTab.content

    ---@class PvPLookup.HistoryFrame.CCCatalogueTab : GGUI.Tab
    frame.content.ccCatalogueTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("CC Catalogue", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.drOverviewTab.button.frame,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            offsetX = 10,
            buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        }
    }
    ---@class PvPLookup.HistoryFrame.CCCatalogueTab.Content
    frame.content.ccCatalogueTab.content = frame.content.ccCatalogueTab.content
    local ccCatalogueTab = frame.content.ccCatalogueTab
    ---@class PvPLookup.HistoryFrame.CCCatalogueTab.Content
    ccCatalogueTab.content = ccCatalogueTab.content

    GGUI.TabSystem { matchHistoryTab, ccCatalogueTab, drOverviewTab }

    frame.content.logo = GGUI.Text {
        parent = frame.content, anchorParent = frame.content.titleLogo.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = 0, offsetY = 2,
        text = PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.028)
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
    ---@class PvPLookup.HistoryFrame.MatchHistoryTab.Content
    matchHistoryTab.content = matchHistoryTab.content

    ---@class PvPLookup.History.ClassFilterFrame : GGUI.Frame
    matchHistoryTab.content.classFilterFrame = GGUI.Frame {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content,
        anchorA = "TOP", anchorB = "TOP", backdropOptions = PvPLookup.CONST.CLASS_FILTER_FRAME_BACKDROP,
        sizeX = 677, sizeY = 80, offsetY = 0,
    }

    matchHistoryTab.content.classFilterFrame.title = GGUI.Text {
        parent = matchHistoryTab.content.classFilterFrame.frame, anchorParent = matchHistoryTab.content.classFilterFrame.content,
        anchorA = "TOP", anchorB = "TOP", text = "FILTERS", offsetY = -11, scale = 1.2,
    }

    matchHistoryTab.content.classFilterFrame.frame:SetFrameLevel(matchHistoryTab.content:GetFrameLevel() + 10)

    ---@type GGUI.ClassIcon[]
    matchHistoryTab.content.classFilterFrame.classFilterButtons = {}

    -- init class filter
    matchHistoryTab.activeClassFilters = {}
    local classFilterIconSize = 32
    local function CreateClassFilterIcon(class, anchorParent, offX, offY, anchorA, anchorB)
        local classFilterIcon = GGUI.ClassIcon {
            sizeX = classFilterIconSize, sizeY = classFilterIconSize,
            parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = anchorParent,
            initialClass = class, offsetX = offX, offsetY = offY, anchorA = anchorA, anchorB = anchorB,
        }

        classFilterIcon.frame:SetScript("OnClick", function()
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
        local offX = 14
        local offY = 0
        if i == 1 then
            anchorB = "LEFT"
            offX = 70
            offY = -15
        end
        local classFilterIcon = CreateClassFilterIcon(class, currentAnchor, offX, offY, "LEFT", anchorB)
        currentAnchor = classFilterIcon.frame
    end


    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = "Date",
            width = 140,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Map",
            width = 60,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Team",
            width = 100,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "MMR",
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Duration",
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Damage",
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Healing",
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Rating",
            width = 80,
            justifyOptions = { type = "H", align = "CENTER" },
        },
    }
    local listScale = 0.997
    matchHistoryTab.content.pvpList = GGUI.FrameList {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content.classFilterFrame.frame, offsetX = 0, hideScrollbar = true,
        anchorA = "TOP", anchorB = "BOTTOM", scale = listScale, offsetY = -40,
        rowBackdrops = { PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B },
        sizeY = 460, columnOptions = columnOptions, rowConstructor = function(columns)
        local dateColumn = columns[1]
        local mapColumn = columns[2]
        local teamColumn = columns[3]
        local mmrColumn = columns[4]
        local durationColumn = columns[5]
        local damageColumn = columns[6]
        local healingColumn = columns[7]
        local ratingColumn = columns[8]

        dateColumn.text = GGUI.Text {
            parent = dateColumn, anchorParent = dateColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        mapColumn.text = GGUI.Text {
            parent = mapColumn, anchorParent = mapColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        local iconSize = 23
        teamColumn.icon31 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn, anchorA = "LEFT", anchorB = "LEFT", offsetX = 16,
            initialClass = GGUI.CONST.CLASSES.WARLOCK, sizeX = iconSize, sizeY = iconSize, enableMouse = false,
        }
        teamColumn.icon32 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.icon31.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = GGUI.CONST.CLASSES.WARRIOR, sizeX = iconSize, sizeY = iconSize, enableMouse = false,
        }
        teamColumn.icon33 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.icon32.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = GGUI.CONST.CLASSES.WINDWALKER, sizeX = iconSize, sizeY = iconSize, enableMouse = false,
        }
        teamColumn.icon21 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn, anchorA = "LEFT", anchorB = "LEFT", offsetX = 16 + iconSize / 2,
            initialClass = GGUI.CONST.CLASSES.WARLOCK, sizeX = iconSize, sizeY = iconSize, enableMouse = false,
        }
        teamColumn.icon22 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.icon21.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = GGUI.CONST.CLASSES.WARRIOR, sizeX = iconSize, sizeY = iconSize, enableMouse = false,
        }

        teamColumn.iconsTwo = { teamColumn.icon21, teamColumn.icon22 }
        teamColumn.iconsThree = { teamColumn.icon31, teamColumn.icon32, teamColumn.icon33 }

        ---@param team PvPLookup.Team
        teamColumn.SetTeam = function(self, team)
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
        mmrColumn.text = GGUI.Text {
            parent = mmrColumn, anchorParent = mmrColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        durationColumn.text = GGUI.Text {
            parent = durationColumn, anchorParent = durationColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        damageColumn.text = GGUI.Text {
            parent = damageColumn, anchorParent = damageColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        healingColumn.text = GGUI.Text {
            parent = healingColumn, anchorParent = healingColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        ratingColumn.text = GGUI.Text {
            parent = ratingColumn, anchorParent = ratingColumn, justifyOptions = { type = "H", align = "CENTER" },
            offsetX = 10,
        }
        local ratingIconSize = 20
        ratingColumn.texture = GGUI.Texture {
            parent = ratingColumn, anchorParent = ratingColumn.text.frame, anchorA = "RIGHT", anchorB = "LEFT",
            sizeX = ratingIconSize, sizeY = ratingIconSize,
        }

        ratingColumn.SetIconByRating = function(self, playerRating)
            local rankingTexture
            for _, ratingData in ipairs(PvPLookup.CONST.RATING_ICON_MAP) do
                if playerRating >= ratingData.rating then
                    rankingTexture = ratingData.icon
                end
            end
            if rankingTexture then
                ratingColumn.texture:SetTexture(rankingTexture)
            end
        end
    end
    }

    matchHistoryTab.content.teamDisplayDropdown = GGUI.Dropdown {
        parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = matchHistoryTab.content.classFilterFrame.frame,
        anchorA = "TOPRIGHT", anchorB = "TOPRIGHT", width = 100, offsetX = -125, offsetY = -5,
        initialData = {
            {
                label = "Enemy Team",
                value = "ENEMY_TEAM"
            },
            {
                label = "My Team",
                value = "PLAYER_TEAM"
            },
        },
        initialLabel = "My Team",
        initialValue = "PLAYER_TEAM",
        clickCallback = function(self, label, value)
            PvPLookup.HISTORY:UpdateHistory()
        end
    }

    matchHistoryTab.content.pvpModeDropdown = GGUI.Dropdown {
        parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = matchHistoryTab.content.teamDisplayDropdown.frame, anchorA = "LEFT", anchorB = "RIGHT", width = 50, offsetX = -30,
        initialData = {
            {
                label = "Solo",
                value = PvPLookup.CONST.PVP_MODES.SOLO,
            },
            {
                label = "2v2",
                value = PvPLookup.CONST.PVP_MODES.TWOS,
            },
            {
                label = "3v3",
                value = PvPLookup.CONST.PVP_MODES.THREES,
            },
            {
                label = "RGB",
                value = PvPLookup.CONST.PVP_MODES.RGB,
            },
        },
        initialLabel = "2v2",
        initialValue = PvPLookup.CONST.PVP_MODES.TWOS,
        clickCallback = function(self, label, value)
            PvPLookup.HISTORY:UpdateHistory()
        end
    }

    -- matchHistoryTab.content.teamDisplayDropdownCustom = GGUI.CustomDropdown {
    --     parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = matchHistoryTab.content.classFilterFrame.content,
    --     anchorA = "BOTTOMRIGHT", anchorB = "TOPRIGHT",
    --     initialLabel = "SelectedValue1",
    --     initialValue = 1,
    --     initialData = {
    --         {
    --             label = "SelectedValue1",
    --             value = 1,
    --         },
    --         {
    --             label = "SelectedValue2",
    --             value = 2,
    --         },
    --         {
    --             label = "SelectedValue3",
    --             value = 3,
    --         },
    --         {
    --             label = "SelectedValue4",
    --             value = 4,
    --         },
    --         {
    --             label = "SelectedValue5",
    --             value = 5,
    --         },
    --     },
    -- }
    --matchHistoryTab.content.teamDisplayDropdownCustom:Hide() -- temporary
end

function PvPLookup.HISTORY.FRAMES:InitCCCatalogueTab()
    local ccCatalogueTab = PvPLookup.HISTORY.frame.content.ccCatalogueTab
    ---@class PvPLookup.HistoryFrame.CCCatalogueTab.Content
    ccCatalogueTab.content = ccCatalogueTab.content

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = "Class",
            width = 150,
            justifyOptions = { type = "H", align = "LEFT" },
        },
        {
            label = "Spec",
            width = 150,
            justifyOptions = { type = "H", align = "LEFT" },
        },
        {
            label = "Spell",
            width = 150,
            justifyOptions = { type = "H", align = "LEFT" },
        },
        {
            label = "Duration",
            width = 100,
            justifyOptions = { type = "H", align = "CENTER" },
        },
    }

    ccCatalogueTab.content.ccList = GGUI.FrameList {
        parent = ccCatalogueTab.content, anchorParent = ccCatalogueTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeY = 500, showBorder = true, offsetY = -120,
        columnOptions = columnOptions, rowBackdrops = { PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B },
        rowConstructor = function(columns)
            local classColumn = columns[1]
            local specColumn = columns[2]
            local spellColumn = columns[3]
            local durationColumn = columns[4]

            local iconSize = 23
            classColumn.icon = GGUI.ClassIcon {
                parent = classColumn, anchorParent = classColumn, enableMouse = false, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "LEFT",
            }

            classColumn.className = GGUI.Text {
                parent = classColumn, anchorParent = classColumn.icon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "?",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3,
            }

            classColumn.SetClass = function(self, class)
                classColumn.icon:SetClass(class)
                classColumn.className:SetText(GUTIL:ColorizeText(PvPLookup.CONST.CLASS_NAMES[class],
                    GUTIL.CLASS_COLORS[class]))
            end

            specColumn.icon = GGUI.ClassIcon {
                parent = specColumn, anchorParent = specColumn, enableMouse = false, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "LEFT",
            }

            specColumn.className = GGUI.Text {
                parent = specColumn, anchorParent = specColumn.icon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "?",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3,
            }

            specColumn.SetClass = function(self, class)
                specColumn.icon:SetClass(class)
                specColumn.className:SetText(GUTIL:ColorizeText(PvPLookup.CONST.CLASS_NAMES[class],
                    GUTIL.CLASS_COLORS[class]))
            end

            spellColumn.icon = GGUI.SpellIcon {
                parent = spellColumn, anchorParent = spellColumn, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "LEFT",
                initialSpellID = 179057 -- debug: chaos nova
            }

            spellColumn.spellName = GGUI.Text {
                parent = spellColumn, anchorParent = spellColumn.icon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "?",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3,
            }

            spellColumn.SetSpell = function(self, spellID)
                spellColumn.icon:SetSpell(spellID)
                spellColumn.spellName:SetText(select(1, GetSpellInfo(spellID)))
            end

            durationColumn.text = GGUI.Text {
                parent = durationColumn, anchorParent = durationColumn, text = "5 Seconds", justifyOptions = { type = "H", align = "CENTER" },
            }

            durationColumn.SetDuration = function(self, seconds)
                durationColumn.text:SetText(tostring(seconds) .. " Seconds")
            end
        end
    }

    PvPLookup.HISTORY:FillCCData()
end

function PvPLookup.HISTORY.FRAMES:InitDROverviewTab()
    local drOverviewTab = PvPLookup.HISTORY.frame.content.drOverviewTab
    ---@class PvPLookup.HistoryFrame.DROverviewTab.Content
    drOverviewTab.content = drOverviewTab.content

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = "Class",
            width = 40,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Spec",
            width = 40,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Spell",
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = "Duration",
            width = 50,
            justifyOptions = { type = "H", align = "CENTER" },
        },
    }

    drOverviewTab.content.drList = GGUI.FrameList {
        parent = drOverviewTab.content, anchorParent = drOverviewTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeY = 300, showBorder = true, offsetY = -150,
        columnOptions = columnOptions, rowBackdrops = { PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B },
        rowConstructor = function(columns)
            local specColumn = columns[1]
            local spellColumn = columns[2]
            local drColumn = columns[3]

            local iconSize = 23
            specColumn.icon = GGUI.ClassIcon {
                parent = specColumn, anchorParent = specColumn, enableMouse = false, sizeX = iconSize, sizeY = iconSize,
            }

            spellColumn.icon = GGUI.Icon { -- TODO: SpellIcon?
                parent = spellColumn, anchorParent = spellColumn, sizeX = iconSize, sizeY = iconSize,
            }

            drColumn.text = GGUI.Text { -- TODO: SpellIcon?
                parent = drColumn, anchorParent = drColumn, text = "Some DR", justifyOptions = { type = "H", align = "CENTER" },
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
        function(matchHistory)
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
        pvpList:Add(function(row)
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
            ratingColumn:SetIconByRating(matchHistory.rating)
        end)
    end

    pvpList:UpdateDisplay()
end

function PvPLookup.HISTORY:FillCCData()
    local ccCatalogueTab = PvPLookup.HISTORY.frame.content.ccCatalogueTab
    local ccList = ccCatalogueTab.content.ccList

    for i = 1, 30 do
        ccList:Add(function(row)
            local columns = row.columns
            local classColumn = columns[1]
            local specColumn = columns[2]
            local spellColumn = columns[3]
            local durationColumn = columns[4]

            classColumn:SetClass(GGUI.CONST.CLASSES.WARRIOR)
            specColumn:SetClass(GGUI.CONST.CLASSES.FURY)

            spellColumn:SetSpell(853) -- hammer of justice
            durationColumn:SetDuration(6)
        end)
    end

    ccList:UpdateDisplay()
end

function PvPLookup.HISTORY:FillDRData()
    local drOverviewTab = PvPLookup.HISTORY.frame.content.drOverviewTab
    local drList = drOverviewTab.content.drList

    for i = 1, 30 do
        drList:Add(function(row)
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
