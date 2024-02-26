---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL
local f = GUTIL:GetFormatter()

---@class MAIN_FRAME
PvPLookup.MAIN_FRAME = PvPLookup.MAIN_FRAME

---@class PvPLookup.MAIN_FRAME.FRAMES
PvPLookup.MAIN_FRAME.FRAMES = {}

function PvPLookup.MAIN_FRAME.FRAMES:Init()
    local sizeX = 750
    local sizeY = 650
    ---@class PvPLookup.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = GGUI.Frame {
        moveable = true, frameID = PvPLookup.CONST.FRAMES.MAIN_FRAME,
        sizeX = sizeX, sizeY = sizeY, frameConfigTable = PvPLookupGGUIConfig, frameTable = PvPLookup.MAIN.FRAMES,
        backdropOptions = PvPLookup.CONST.MAIN_FRAME_BACKDROP, globalName = PvPLookup.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME
    }

    -- makes it closeable on Esc
    tinsert(UISpecialFrames, PvPLookup.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME)

    frame.content.titleLogo = GGUI.Text {
        parent = frame.content, anchorParent = frame.content, offsetY = -15, offsetX = 30,
        text = GUTIL:ColorizeText(" PVP-LOOKUP", GUTIL.COLORS.LEGENDARY), scale = 1.7,
        anchorA = "TOPLEFT", anchorB = "TOPLEFT",
    }

    ---@class PvPLookup.MAIN_FRAME.CONTENT : Frame
    frame.content = frame.content
    local tabContentOffsetY = -50
    local tabButtonScale = 1
    ---@class PvPLookup.MAIN_FRAME.MATCH_HISTORY_TAB : GGUI.Tab
    frame.content.matchHistoryTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Match History", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.titleLogo.frame,
            offsetY = 1,
            offsetX = 27,
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

    ---@class PvPLookup.MAIN_FRAME.MATCH_HISTORY_TAB.CONTENT
    frame.content.matchHistoryTab.content = frame.content.matchHistoryTab.content
    local matchHistoryTab = frame.content.matchHistoryTab
    ---@class PvPLookup.MAIN_FRAME.MATCH_HISTORY_TAB.CONTENT
    matchHistoryTab.content = matchHistoryTab.content


    ---@class PvPLookup.MAIN_FRAME.DR_OVERVIEW_TAB : GGUI.Tab
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
    ---@class PvPLookup.MAIN_FRAME.DR_OVERVIEW_TAB.CONTENT
    frame.content.drOverviewTab.content = frame.content.drOverviewTab.content
    local drOverviewTab = frame.content.drOverviewTab
    ---@class PvPLookup.MAIN_FRAME.DR_OVERVIEW_TAB.CONTENT
    drOverviewTab.content = drOverviewTab.content

    ---@class PvPLookup.MAIN_FRAME.CC_CATALOGUE_TAB : GGUI.Tab
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
    ---@class PvPLookup.MAIN_FRAME.CC_CATALOGUE_TAB.CONTENT
    frame.content.ccCatalogueTab.content = frame.content.ccCatalogueTab.content
    local ccCatalogueTab = frame.content.ccCatalogueTab
    ---@class PvPLookup.MAIN_FRAME.CC_CATALOGUE_TAB.CONTENT
    ccCatalogueTab.content = ccCatalogueTab.content

    GGUI.TabSystem { matchHistoryTab, ccCatalogueTab, drOverviewTab }

    frame.content.logo = GGUI.Text {
        parent = frame.content, anchorParent = frame.content.titleLogo.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = 0, offsetY = 2,
        text = PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.028)
    }

    frame.content.closeButton = GGUI.Button {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT",
        offsetX = 0, offsetY = 0,
        label = f.white("X"),
        buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.TAB_BUTTON,
        fontOptions = {
            fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = 17,
        sizeY = 15,
        clickCallback = function()
            frame:Hide()
        end
    }

    PvPLookup.MAIN_FRAME.frame = frame

    PvPLookup.MAIN_FRAME.FRAMES:InitMatchHistoryTab()
    PvPLookup.MAIN_FRAME.FRAMES:InitCC_CATALOGUE_TAB()
    PvPLookup.MAIN_FRAME.FRAMES:InitDR_OVERVIEW_TAB()

    frame:Hide()
end

function PvPLookup.MAIN_FRAME.FRAMES:InitMatchHistoryTab()
    ---@class PvPLookup.MAIN_FRAME.MATCH_HISTORY_TAB
    local matchHistoryTab = PvPLookup.MAIN_FRAME.frame.content.matchHistoryTab
    ---@type PvPLookup.MAIN_FRAME.CC_CATALOGUE_TAB
    local ccCatalogueTab = PvPLookup.MAIN_FRAME.frame.content.ccCatalogueTab
    ---@class PvPLookup.MAIN_FRAME.MATCH_HISTORY_TAB.CONTENT
    matchHistoryTab.content = matchHistoryTab.content

    ---@class PvPLookup.History.ClassFilterFrame : GGUI.Frame
    matchHistoryTab.content.classFilterFrame = GGUI.Frame {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content,
        anchorA = "TOP", anchorB = "TOP", backdropOptions = PvPLookup.CONST.CLASS_FILTER_FRAME_BACKDROP,
        sizeX = 715, sizeY = 100, offsetY = 0,
    }

    matchHistoryTab.content.classFilterFrame.title = GGUI.Text {
        parent = matchHistoryTab.content.classFilterFrame.frame, anchorParent = matchHistoryTab.content.classFilterFrame.content,
        anchorA = "TOP", anchorB = "TOP", text = "Class Filtering", offsetY = -15,
        fontOptions = {
            fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
            height = 15,
        },
    }

    matchHistoryTab.content.classFilterFrame.frame:SetFrameLevel(matchHistoryTab.content:GetFrameLevel() + 10)

    ---@type GGUI.ClassIcon[]
    matchHistoryTab.content.classFilterFrame.classFilterButtons = {}

    -- init class filter
    matchHistoryTab.activeClassFilters = {}
    local classFilterIconSize = 35
    local classFilterIconOffsetX = 45
    local classFilterIconOffsetY = -10
    local classFilterIconSpacingX = 14
    local function CreateClassFilterIcon(classFile, anchorParent, offX, offY, anchorA, anchorB)
        local classFilterIcon = GGUI.ClassIcon {
            sizeX = classFilterIconSize, sizeY = classFilterIconSize,
            parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = anchorParent,
            initialClass = classFile, offsetX = offX, offsetY = offY, anchorA = anchorA, anchorB = anchorB,
            showTooltip = true,
        }

        classFilterIcon.frame:SetScript("OnClick", function()
            if not matchHistoryTab.activeClassFilters[classFile] then
                matchHistoryTab.activeClassFilters[classFile] = true
                classFilterIcon:Desaturate()
                -- reload list with new filters
                PvPLookup.MAIN_FRAME.FRAMES:UpdateHistory()
            else
                matchHistoryTab.activeClassFilters[classFile] = nil
                classFilterIcon:Saturate()
                -- reload list with new filters
                PvPLookup.MAIN_FRAME.FRAMES:UpdateHistory()
            end
        end)

        return classFilterIcon
    end
    local t = {}
    FillLocalizedClassList(t)
    local classFiles = GUTIL:Map(t, function(_, classFile)
        -- ignore hidden test class or whatever this is
        if classFile == "Adventurer" then
            return nil
        end
        return classFile
    end)
    local currentAnchor = matchHistoryTab.content.classFilterFrame.frame
    for i, classFile in pairs(classFiles) do
        local anchorB = "RIGHT"
        local offX = classFilterIconSpacingX
        local offY = 0
        if i == 1 then
            anchorB = "LEFT"
            offX = classFilterIconOffsetX
            offY = classFilterIconOffsetY
        end
        local classFilterIcon = CreateClassFilterIcon(classFile, currentAnchor, offX, offY, "LEFT", anchorB)
        currentAnchor = classFilterIcon.frame
    end


    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = GUTIL:ColorizeText("Date", GUTIL.COLORS.GREY),
            width = 145,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Map", GUTIL.COLORS.GREY),
            width = 65,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Team", GUTIL.COLORS.GREY),
            width = 100,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Mmr", GUTIL.COLORS.GREY),
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Damage", GUTIL.COLORS.GREY),
            width = 75,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Healing", GUTIL.COLORS.GREY),
            width = 75,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Change", GUTIL.COLORS.GREY),
            width = 70,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Rating", GUTIL.COLORS.GREY),
            width = 100,
            justifyOptions = { type = "H", align = "CENTER" },
        },
    }
    local listScale = 0.997
    matchHistoryTab.content.matchHistoryList = GGUI.FrameList {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content.classFilterFrame.frame, offsetX = 0, hideScrollbar = true,
        anchorA = "TOP", anchorB = "BOTTOM", scale = listScale, offsetY = -25, rowHeight = 30,
        rowBackdrops = { PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B },
        selectionOptions = { noSelectionColor = true, hoverRGBA = { 1, 1, 1, 0.1 } },
        sizeY = 460, columnOptions = columnOptions, rowConstructor = function(columns)
        local dateColumn = columns[1]
        local mapColumn = columns[2]
        local teamColumn = columns[3]
        local mmrColumn = columns[4]
        local damageColumn = columns[5]
        local healingColumn = columns[6]
        local changeColumn = columns[7]
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
            initialClass = "WARLOCK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        teamColumn.icon32 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.icon31.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "WARRIOR", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        teamColumn.icon33 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.icon32.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "MONK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        teamColumn.icon21 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn, anchorA = "LEFT", anchorB = "LEFT", offsetX = 16 + iconSize / 2,
            initialClass = "WARLOCK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        teamColumn.icon22 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.icon21.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "WARRIOR", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }

        local iconSizeSS = 13

        teamColumn.iconSS1 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn, anchorA = "LEFT", anchorB = "LEFT", offsetX = 28, offsetY = 7,
            initialClass = "WARLOCK", sizeX = iconSizeSS, sizeY = iconSizeSS,
            showTooltip = true,
        }
        teamColumn.iconSS2 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.iconSS1.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "WARRIOR", sizeX = iconSizeSS, sizeY = iconSizeSS,
            showTooltip = true,
        }
        teamColumn.iconSS3 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.iconSS2.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "MONK", sizeX = iconSizeSS, sizeY = iconSizeSS,
            showTooltip = true,
        }

        teamColumn.iconSS4 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.iconSS1.frame, anchorA = "TOPLEFT", anchorB = "BOTTOMLEFT", offsetX = 0, offsetY = -1,
            initialClass = "WARLOCK", sizeX = iconSizeSS, sizeY = iconSizeSS,
            showTooltip = true,
        }
        teamColumn.iconSS5 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.iconSS4.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "WARRIOR", sizeX = iconSizeSS, sizeY = iconSizeSS,
            showTooltip = true,
        }
        teamColumn.iconSS6 = GGUI.ClassIcon {
            parent = teamColumn, anchorParent = teamColumn.iconSS5.frame, anchorA = "LEFT", anchorB = "RIGHT",
            initialClass = "MONK", sizeX = iconSizeSS, sizeY = iconSizeSS,
            showTooltip = true,
        }

        teamColumn.iconsSoloShuffle = { teamColumn.iconSS1, teamColumn.iconSS2, teamColumn.iconSS3, teamColumn.iconSS4,
            teamColumn.iconSS5, teamColumn.iconSS6 }
        teamColumn.iconsTwo = { teamColumn.icon21, teamColumn.icon22 }
        teamColumn.iconsThree = { teamColumn.icon31, teamColumn.icon32, teamColumn.icon33 }

        ---@param team PvPLookup.Team
        teamColumn.SetTeam = function(self, team, isSoloShuffle)
            for _, icon in pairs(teamColumn.iconsTwo) do
                icon:Hide()
            end
            for _, icon in pairs(teamColumn.iconsThree) do
                icon:Hide()
            end
            for _, icon in pairs(teamColumn.iconsSoloShuffle) do
                icon:Hide()
            end
            if isSoloShuffle then
                for index, icon in pairs(teamColumn.iconsSoloShuffle) do
                    icon:Show()
                    local player = team.players[index]
                    if player then
                        icon:SetClass(team.players[index].specID)
                    else
                        icon:SetClass(nil)
                    end
                end
            end
            if #team.players == 3 then
                for index, icon in pairs(teamColumn.iconsThree) do
                    icon:Show()
                    icon:SetClass(team.players[index].specID)
                end
            elseif #team.players == 2 then
                for index, icon in pairs(teamColumn.iconsTwo) do
                    icon:Show()
                    icon:SetClass(team.players[index].specID)
                end
            elseif #team.players == 1 then
                teamColumn.iconsThree[1]:Hide()
                teamColumn.iconsThree[3]:Hide()

                teamColumn.iconsThree[2]:Show()
                teamColumn.iconsThree[2]:SetClass(team.players[1].specID)
            end
        end
        mmrColumn.text = GGUI.Text {
            parent = mmrColumn, anchorParent = mmrColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        changeColumn.text = GGUI.Text {
            parent = changeColumn, anchorParent = changeColumn, justifyOptions = { type = "H", align = "CENTER" }
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
            if not playerRating then
                ratingColumn.texture:Hide()
                return
            else
                ratingColumn.texture:Show()
            end
            local rankingIcon = PvPLookup.UTIL:GetIconByRating(playerRating)
            if rankingIcon then
                ratingColumn.texture:SetTexture(rankingIcon)
            end
        end
    end
    }

    local dropdownSizeY = 25
    local dropdownScale = 1

    matchHistoryTab.content.teamDisplayDropdown = GGUI.CustomDropdown {
        parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = ccCatalogueTab.button.frame,
        anchorA = "LEFT", anchorB = "RIGHT", width = 110, offsetX = 10,
        initialData = {
            {
                label = GUTIL:ColorizeText("Enemy Team", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.DISPLAY_TEAMS.ENEMY_TEAM,
            },
            {
                label = GUTIL:ColorizeText("My Team", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM
            },
        },
        initialLabel = GUTIL:ColorizeText("My Team", GUTIL.COLORS.WHITE),
        initialValue = PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM,
        clickCallback = function(self, label, value)
            PvPLookup.MAIN_FRAME.FRAMES:UpdateHistory()
        end,
        buttonOptions = {
            buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale
        },
        arrowOptions = PvPLookup.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPLookup.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = dropdownScale,
        }
    }

    matchHistoryTab.content.pvpModeDropdown = GGUI.CustomDropdown {
        parent = matchHistoryTab.content.classFilterFrame.content, anchorParent = matchHistoryTab.content.teamDisplayDropdown.frame.frame,
        anchorA = "LEFT", anchorB = "RIGHT", width = 70, offsetX = 10,
        initialData = {
            {
                label = GUTIL:ColorizeText("All", GUTIL.COLORS.WHITE),
                value = nil,
            },
            {
                label = GUTIL:ColorizeText("Solo", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.PVP_MODES.SOLO,
            },
            {
                label = GUTIL:ColorizeText("2v2", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.PVP_MODES.TWOS,
            },
            {
                label = GUTIL:ColorizeText("3v3", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.PVP_MODES.THREES,
            },
            {
                label = GUTIL:ColorizeText("BG", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.PVP_MODES.BATTLEGROUND,
            },
        },
        initialLabel = GUTIL:ColorizeText("All", GUTIL.COLORS.WHITE),
        initialValue = nil,
        clickCallback = function(self, label, value)
            PvPLookup.MAIN_FRAME.FRAMES:UpdateHistory()
        end,
        buttonOptions = {
            buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale,
        },
        arrowOptions = PvPLookup.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPLookup.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = dropdownScale,
        }
    }
end

function PvPLookup.MAIN_FRAME.FRAMES:InitCC_CATALOGUE_TAB()
    local ccCatalogueTab = PvPLookup.MAIN_FRAME.frame.content.ccCatalogueTab
    ---@class PvPLookup.MAIN_FRAME.CC_CATALOGUE_TAB.CONTENT
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
        sizeY = 500, showBorder = true, offsetY = -40,
        columnOptions = columnOptions,
        rowBackdrops = { PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B },
        selectionOptions = { noSelectionColor = true, hoverRGBA = { 1, 1, 1, 0.1 } },
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
                classColumn.className:SetText(f.class(LOCALIZED_CLASS_NAMES_MALE[class], class))
            end

            specColumn.icon = GGUI.ClassIcon {
                parent = specColumn, anchorParent = specColumn, enableMouse = false, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "LEFT",
            }

            specColumn.className = GGUI.Text {
                parent = specColumn, anchorParent = specColumn.icon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "?",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3,
            }

            specColumn.SetSpec = function(self, specID)
                specColumn.icon:SetClass(specID)
                local specName = select(2, GetSpecializationInfoByID(specID))
                classColumn.className:SetText(f.class(specName, specColumn.icon.class))
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

    PvPLookup.MAIN_FRAME:FillCCData()
end

function PvPLookup.MAIN_FRAME.FRAMES:InitDR_OVERVIEW_TAB()
    local drOverviewTab = PvPLookup.MAIN_FRAME.frame.content.drOverviewTab
    ---@class PvPLookup.MAIN_FRAME.DR_OVERVIEW_TAB.CONTENT
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

    drOverviewTab.content.drList:Hide() -- Temp

    PvPLookup.MAIN_FRAME:FillDRData()
end

function PvPLookup.MAIN_FRAME.FRAMES:UpdateHistory()
    local matchHistoryTab = PvPLookup.MAIN_FRAME.frame.content.matchHistoryTab
    local matchHistoryList = matchHistoryTab.content.matchHistoryList

    matchHistoryTab.content.matchHistoryList:Remove()

    local pvpModeFilter = PvPLookup.MAIN_FRAME:GetSelectedModeFilter()
    local displayedTeam = PvPLookup.MAIN_FRAME:GetDisplayTeam()

    local matchHistories = PvPLookup.DB.MATCH_HISTORY:Get()

    local filteredHistory = GUTIL:Filter(matchHistories or {},
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
            if not pvpModeFilter then
                return not classFiltered
            else
                return matchHistory.pvpMode == pvpModeFilter and not classFiltered
            end
        end)


    for _, matchHistory in pairs(filteredHistory) do
        matchHistoryList:Add(function(row)
            local columns = row.columns
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local teamColumn = columns[3]
            local mmrColumn = columns[4]
            local damageColumn = columns[5]
            local healingColumn = columns[6]
            local changeColumn = columns[7]
            local ratingColumn = columns[8]

            local matchHistory = PvPLookup.MatchHistory:Deserialize(matchHistory)

            local date = date("!*t", matchHistory.timestamp / 1000) -- use ! because it is already localized time and divide by 1000 because date constructor needs seconds
            local formattedDate = string.format("%d.%d.%d %d:%d", date.day, date.month, date.year, date.hour, date.min)
            dateColumn.text:SetText(formattedDate)
            local mapAbbreviation = PvPLookup.UTIL:GetMapAbbreviation(matchHistory.mapInfo.name)
            mapColumn.text:SetText(f.r(mapAbbreviation))

            if displayedTeam == PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM then
                teamColumn:SetTeam(matchHistory.playerTeam)
                if matchHistory.isRated then
                    mmrColumn.text:SetText(matchHistory.playerTeam.ratingInfo.ratingMMR)
                else
                    mmrColumn.text:SetText(f.grey("-"))
                end
                damageColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.playerTeam.damage))
                healingColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.playerTeam.healing))
            else
                teamColumn:SetTeam(matchHistory.enemyTeam)
                if matchHistory.isRated then
                    mmrColumn.text:SetText(matchHistory.enemyTeam.ratingInfo.ratingMMR)
                else
                    mmrColumn.text:SetText(f.grey("-"))
                end
                damageColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.enemyTeam.damage))
                healingColumn.text:SetText(PvPLookup.UTIL:FormatDamageNumber(matchHistory.enemyTeam.healing))
            end

            if displayedTeam == PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM then
                team = matchHistory.playerTeam
            else
                team = matchHistory.enemyTeam
            end

            if matchHistory.isRated then
                changeColumn.text:SetText(FormatValueWithSign(matchHistory.player.scoreData.ratingChange))
                ratingColumn.text:SetText(matchHistory.player.scoreData.bgRating)
                ratingColumn:SetIconByRating(matchHistory.player.scoreData.bgRating)
            else
                changeColumn.text:SetText(f.grey("-"))
                ratingColumn.text:SetText(f.grey("-"))
                ratingColumn:SetIconByRating(nil)
            end

            local tooltipText = matchHistory:GetTooltipText()

            row.tooltipOptions = {
                anchor = "ANCHOR_CURSOR",
                owner = row.frame,
                text = f.white(tooltipText),
            }
        end)
    end

    matchHistoryList:UpdateDisplay()
end

function PvPLookup.MAIN_FRAME:FillCCData()
    local ccCatalogueTab = PvPLookup.MAIN_FRAME.frame.content.ccCatalogueTab
    local ccList = ccCatalogueTab.content.ccList

    for i = 1, 30 do
        ccList:Add(function(row, columns)
            local classColumn = columns[1]
            local specColumn = columns[2]
            local spellColumn = columns[3]
            local durationColumn = columns[4]

            classColumn:SetClass("WARRIOR")
            specColumn:SetSpec(72)    -- Fury

            spellColumn:SetSpell(853) -- hammer of justice
            durationColumn:SetDuration(6)

            row.tooltipOptions = {
                anchor = "ANCHOR_RIGHT",
                owner = row.frame,
                spellID = 853
            }
        end)
    end

    ccList:UpdateDisplay()
end

function PvPLookup.MAIN_FRAME:FillDRData()
    local drOverviewTab = PvPLookup.MAIN_FRAME.frame.content.drOverviewTab
    local drList = drOverviewTab.content.drList

    for i = 1, 30 do
        drList:Add(function(row)
            local columns = row.columns
            local specColumn = columns[1]
            local spellColumn = columns[2]
            local drColumn = columns[3]

            specColumn.icon:SetClass("WARRIOR")
            -- spellColumn.icon
            drColumn.text:SetText("DR Info")
        end)
    end

    drList:UpdateDisplay()
end
