---@class Arenalogs
local Arenalogs = select(2, ...)

local GGUI = Arenalogs.GGUI
local GUTIL = Arenalogs.GUTIL
local f = GUTIL:GetFormatter()

---@class MAIN_FRAME
Arenalogs.MAIN_FRAME = Arenalogs.MAIN_FRAME

---@class Arenalogs.MAIN_FRAME.FRAMES
Arenalogs.MAIN_FRAME.FRAMES = {}

function Arenalogs.MAIN_FRAME.FRAMES:Init()
    local sizeX = 750
    local sizeY = 650
    ---@class Arenalogs.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = GGUI.Frame {
        moveable = true, frameID = Arenalogs.CONST.FRAMES.MAIN_FRAME,
        sizeX = sizeX, sizeY = sizeY, frameConfigTable = ArenalogsGGUIConfig, frameTable = Arenalogs.MAIN.FRAMES,
        backdropOptions = Arenalogs.CONST.MAIN_FRAME_BACKDROP, globalName = Arenalogs.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME
    }

    -- makes it closeable on Esc
    tinsert(UISpecialFrames, Arenalogs.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME)

    frame.content.titleLogo = Arenalogs.UTIL:CreateLogo(frame.content,
        {
            {
                anchorParent = frame.content,
                anchorA = "TOPLEFT",
                anchorB = "TOPLEFT",
                offsetX = 30,
                offsetY = -15,
            }
        })

    ---@class Arenalogs.MAIN_FRAME.CONTENT : Frame
    frame.content = frame.content
    local tabContentOffsetY = -50
    local tabButtonScale = 1
    ---@class Arenalogs.MAIN_FRAME.MATCH_HISTORY_TAB : GGUI.Tab
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
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        }
    }

    ---@class Arenalogs.MAIN_FRAME.MATCH_HISTORY_TAB.CONTENT
    frame.content.matchHistoryTab.content = frame.content.matchHistoryTab.content
    local matchHistoryTab = frame.content.matchHistoryTab
    ---@class Arenalogs.MAIN_FRAME.MATCH_HISTORY_TAB.CONTENT
    matchHistoryTab.content = matchHistoryTab.content


    ---@class Arenalogs.MAIN_FRAME.DR_OVERVIEW_TAB : GGUI.Tab
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
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        },
    }
    ---@class Arenalogs.MAIN_FRAME.DR_OVERVIEW_TAB.CONTENT
    frame.content.drOverviewTab.content = frame.content.drOverviewTab.content
    local drOverviewTab = frame.content.drOverviewTab
    ---@class Arenalogs.MAIN_FRAME.DR_OVERVIEW_TAB.CONTENT
    drOverviewTab.content = drOverviewTab.content

    ---@class Arenalogs.MAIN_FRAME.ABILITIES_TAB : GGUI.Tab
    frame.content.abilitiesTab = GGUI.Tab {
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
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        }
    }
    ---@class Arenalogs.MAIN_FRAME.ABILITIES_TAB.CONTENT
    frame.content.abilitiesTab.content = frame.content.abilitiesTab.content
    local ccCatalogueTab = frame.content.abilitiesTab
    ---@class Arenalogs.MAIN_FRAME.ABILITIES_TAB.CONTENT
    ccCatalogueTab.content = ccCatalogueTab.content

    GGUI.TabSystem { matchHistoryTab, ccCatalogueTab, drOverviewTab }

    frame.content.closeButton = GGUI.Button {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT",
        offsetX = -8, offsetY = -8,
        label = f.white("x"),
        buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.TAB_BUTTON,
        fontOptions = {
            fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = 15,
        sizeY = 15,
        clickCallback = function()
            frame:Hide()
        end
    }

    Arenalogs.MAIN_FRAME.frame = frame

    Arenalogs.MAIN_FRAME.FRAMES:InitMatchHistoryTab()
    Arenalogs.MAIN_FRAME.FRAMES:InitABILITIES_CATALOGUE_TAB()
    Arenalogs.MAIN_FRAME.FRAMES:InitDR_OVERVIEW_TAB()

    frame:Hide()
end

function Arenalogs.MAIN_FRAME.FRAMES:InitMatchHistoryTab()
    ---@class Arenalogs.MAIN_FRAME.MATCH_HISTORY_TAB
    local matchHistoryTab = Arenalogs.MAIN_FRAME.frame.content.matchHistoryTab
    ---@type Arenalogs.MAIN_FRAME.ABILITIES_TAB
    local ccCatalogueTab = Arenalogs.MAIN_FRAME.frame.content.abilitiesTab
    ---@class Arenalogs.MAIN_FRAME.MATCH_HISTORY_TAB.CONTENT
    matchHistoryTab.content = matchHistoryTab.content

    ---@class Arenalogs.History.ClassFilterFrame : GGUI.Frame
    matchHistoryTab.content.classFilterFrame = GGUI.Frame {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content,
        anchorA = "TOP", anchorB = "TOP", backdropOptions = Arenalogs.CONST.CLASS_FILTER_FRAME_BACKDROP,
        sizeX = 715, sizeY = 100, offsetY = 0,
    }

    matchHistoryTab.content.classFilterFrame.title = GGUI.Text {
        parent = matchHistoryTab.content.classFilterFrame.frame, anchorParent = matchHistoryTab.content.classFilterFrame.content,
        anchorA = "TOP", anchorB = "TOP", text = "Class Filtering", offsetY = -15,
        fontOptions = {
            fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
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
                Arenalogs.MAIN_FRAME.FRAMES:UpdateHistory()
            else
                matchHistoryTab.activeClassFilters[classFile] = nil
                classFilterIcon:Saturate()
                -- reload list with new filters
                Arenalogs.MAIN_FRAME.FRAMES:UpdateHistory()
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
            width = 20,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = GUTIL:ColorizeText("Date", GUTIL.COLORS.GREY),
            width = 135,
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
        rowBackdrops = { Arenalogs.CONST.HISTORY_COLUMN_BACKDROP_A, Arenalogs.CONST.HISTORY_COLUMN_BACKDROP_B },
        selectionOptions = { noSelectionColor = true, hoverRGBA = Arenalogs.CONST.FRAME_LIST_HOVER_RGBA },
        sizeY = 460, columnOptions = columnOptions, rowConstructor = function(columns)
        local winColumn = columns[1]
        local dateColumn = columns[2]
        local mapColumn = columns[3]
        local teamColumn = columns[4]
        local mmrColumn = columns[5]
        local damageColumn = columns[6]
        local healingColumn = columns[7]
        local changeColumn = columns[8]
        local ratingColumn = columns[9]

        winColumn.text = GGUI.Text {
            parent = winColumn, anchorPoints = { { anchorParent = winColumn } },
        }
        local winIconScale = 0.15
        function winColumn:SetWin(win)
            if win then
                winColumn.text:SetText(Arenalogs.MEDIA:GetAsTextIcon(Arenalogs.MEDIA.IMAGES.GREEN_DOT, winIconScale))
            else
                winColumn.text:SetText(Arenalogs.MEDIA:GetAsTextIcon(Arenalogs.MEDIA.IMAGES.RED_DOT, winIconScale))
            end
        end

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

        ---@param team Arenalogs.Team
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
            local rankingIcon = Arenalogs.UTIL:GetIconByRating(playerRating)
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
                value = Arenalogs.CONST.DISPLAY_TEAMS.ENEMY_TEAM,
            },
            {
                label = GUTIL:ColorizeText("My Team", GUTIL.COLORS.WHITE),
                value = Arenalogs.CONST.DISPLAY_TEAMS.PLAYER_TEAM
            },
        },
        initialLabel = GUTIL:ColorizeText("My Team", GUTIL.COLORS.WHITE),
        initialValue = Arenalogs.CONST.DISPLAY_TEAMS.PLAYER_TEAM,
        clickCallback = function(self, label, value)
            Arenalogs.MAIN_FRAME.FRAMES:UpdateHistory()
        end,
        buttonOptions = {
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale
        },
        arrowOptions = Arenalogs.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = Arenalogs.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
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
                value = Arenalogs.CONST.PVP_MODES.SOLO_SHUFFLE,
            },
            {
                label = GUTIL:ColorizeText("2v2", GUTIL.COLORS.WHITE),
                value = Arenalogs.CONST.PVP_MODES.TWOS,
            },
            {
                label = GUTIL:ColorizeText("3v3", GUTIL.COLORS.WHITE),
                value = Arenalogs.CONST.PVP_MODES.THREES,
            },
            {
                label = GUTIL:ColorizeText("BG", GUTIL.COLORS.WHITE),
                value = Arenalogs.CONST.PVP_MODES.BATTLEGROUND,
            },
        },
        initialLabel = GUTIL:ColorizeText("All", GUTIL.COLORS.WHITE),
        initialValue = nil,
        clickCallback = function(self, label, value)
            Arenalogs.MAIN_FRAME.FRAMES:UpdateHistory()
        end,
        buttonOptions = {
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale,
        },
        arrowOptions = Arenalogs.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = Arenalogs.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = dropdownScale,
        }
    }
end

function Arenalogs.MAIN_FRAME.FRAMES:InitABILITIES_CATALOGUE_TAB()
    local ccCatalogueTab = Arenalogs.MAIN_FRAME.frame.content.abilitiesTab
    ---@class Arenalogs.MAIN_FRAME.ABILITIES_TAB.CONTENT
    ccCatalogueTab.content = ccCatalogueTab.content

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = f.grey("Class - Specialization"),
            width = 180,
            justifyOptions = { type = "H", align = "LEFT" },
        },
        {
            label = f.grey("Spell"),
            width = 150,
            justifyOptions = { type = "H", align = "LEFT" },
        },
        {
            label = f.grey("Type"),
            width = 120,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Duration"),
            width = 100,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Talent Upgrades"),
            width = 130,
            justifyOptions = { type = "H", align = "CENTER" },
        },
    }

    ccCatalogueTab.content.abilityList = GGUI.FrameList {
        parent = ccCatalogueTab.content, anchorParent = ccCatalogueTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeY = 500, showBorder = true, offsetY = -40, offsetX = -8,
        columnOptions = columnOptions,
        rowBackdrops = { Arenalogs.CONST.HISTORY_COLUMN_BACKDROP_A, Arenalogs.CONST.HISTORY_COLUMN_BACKDROP_B },
        selectionOptions = { noSelectionColor = true, hoverRGBA = Arenalogs.CONST.FRAME_LIST_HOVER_RGBA },
        rowConstructor = function(columns)
            local classSpecColumn = columns[1]
            local spellColumn = columns[2]
            local typeColumn = columns[3]
            local durationColumn = columns[4]
            local upgradeColumn = columns[5]

            local iconSize = 23
            classSpecColumn.classIcon = GGUI.ClassIcon {
                parent = classSpecColumn, anchorParent = classSpecColumn, enableMouse = false, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "LEFT",
            }

            classSpecColumn.specIcon = GGUI.ClassIcon {
                parent = classSpecColumn, anchorParent = classSpecColumn.classIcon.frame, enableMouse = false, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "RIGHT",
            }

            classSpecColumn.className = GGUI.Text {
                parent = classSpecColumn, anchorParent = classSpecColumn.specIcon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3, scale = 0.9
            }

            classSpecColumn.SetClass = function(self, class, specID)
                classSpecColumn.classIcon:SetClass(class)
                if specID then
                    classSpecColumn.specIcon:Show()
                    classSpecColumn.specIcon:SetClass(specID)
                    local specName = select(2, GetSpecializationInfoByID(specID))
                    classSpecColumn.className:SetText(f.class(
                        tostring(LOCALIZED_CLASS_NAMES_MALE[class]) .. " - " .. tostring(specName),
                        class))
                else
                    classSpecColumn.specIcon:Hide()
                    classSpecColumn.className:SetText(f.class(LOCALIZED_CLASS_NAMES_MALE[class], class))
                end
            end

            typeColumn.text = GGUI.Text {
                parent = typeColumn, anchorParent = typeColumn, justifyOptions = { type = "H", align = "LEFT" },
            }

            spellColumn.icon = GGUI.SpellIcon {
                parent = spellColumn, anchorParent = spellColumn, sizeX = iconSize, sizeY = iconSize, anchorA = "LEFT", anchorB = "LEFT",
                initialSpellID = 179057 -- debug: chaos nova
            }

            spellColumn.spellName = GGUI.Text {
                parent = spellColumn, anchorParent = spellColumn.icon.frame, justifyOptions = { type = "H", align = "LEFT" }, text = "?",
                anchorA = "LEFT", anchorB = "RIGHT", offsetX = 3, wrap = true, fixedWidth = 150, scale = 0.9,
            }

            spellColumn.SetSpell = function(self, spellID)
                spellColumn.icon:SetSpell(spellID)
                local spellname = select(1, GetSpellInfo(spellID))
                spellColumn.spellName:SetText(spellname)
            end

            durationColumn.text = GGUI.Text {
                parent = durationColumn, anchorParent = durationColumn, text = "5 Seconds", justifyOptions = { type = "H", align = "CENTER" },
            }

            durationColumn.SetDuration = function(self, seconds)
                if seconds then
                    durationColumn.text:SetText(tostring(seconds) .. " Seconds")
                else
                    durationColumn.text:SetText("")
                end
            end
            local numIcons = 5
            local spacingX = 5
            local upgradeIconSize = 20

            upgradeColumn.icons = {}
            local lastAnchor
            for i = 1, numIcons do
                local offsetX = spacingX
                local anchorParent = lastAnchor
                local anchorB = "RIGHT"
                if i == 1 then
                    offsetX = 5
                    anchorB = "LEFT"
                    anchorParent = upgradeColumn
                end
                local spellIcon = GGUI.SpellIcon {
                    parent = upgradeColumn, anchorParent = anchorParent,
                    anchorA = "LEFT", anchorB = anchorB, offsetX = offsetX, sizeX = upgradeIconSize, sizeY = upgradeIconSize
                }
                lastAnchor = spellIcon.frame

                tinsert(upgradeColumn.icons, spellIcon)
            end

            upgradeColumn.setIcons = function(self, spellUpgrades)
                for i = 1, #spellUpgrades do
                    local icon = upgradeColumn.icons[i]
                    local spellUpgradeData = spellUpgrades and spellUpgrades[i]
                    if not icon then
                        return
                    end
                    if not spellUpgradeData then
                        icon:Hide()
                    else
                        icon:SetSpell(spellUpgradeData.spellID)
                        icon:Show()
                    end
                end
            end
        end
    }

    Arenalogs.MAIN_FRAME:FillAbilityData()
end

function Arenalogs.MAIN_FRAME.FRAMES:InitDR_OVERVIEW_TAB()
    local drOverviewTab = Arenalogs.MAIN_FRAME.frame.content.drOverviewTab
    ---@class Arenalogs.MAIN_FRAME.DR_OVERVIEW_TAB.CONTENT
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
        columnOptions = columnOptions, rowBackdrops = { Arenalogs.CONST.HISTORY_COLUMN_BACKDROP_A, Arenalogs.CONST.HISTORY_COLUMN_BACKDROP_B },
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

    Arenalogs.MAIN_FRAME:FillDRData()
end

function Arenalogs.MAIN_FRAME.FRAMES:UpdateHistory()
    local matchHistoryTab = Arenalogs.MAIN_FRAME.frame.content.matchHistoryTab
    local matchHistoryList = matchHistoryTab.content.matchHistoryList

    matchHistoryTab.content.matchHistoryList:Remove()

    local pvpModeFilter = Arenalogs.MAIN_FRAME:GetSelectedModeFilter()
    local displayedTeam = Arenalogs.MAIN_FRAME:GetDisplayTeam()

    local matchHistories = Arenalogs.DB.MATCH_HISTORY:Get()

    local filteredHistory = GUTIL:Filter(matchHistories or {},
        function(matchHistory)
            local classFiltered = false
            ---@type Arenalogs.Player[]
            local players = {}
            if displayedTeam == Arenalogs.CONST.DISPLAY_TEAMS.PLAYER_TEAM then
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

    local filteredHistory = GUTIL:Sort(filteredHistory, function(a, b)
        return a.timestamp > b.timestamp
    end)


    for _, matchHistory in pairs(filteredHistory) do
        matchHistoryList:Add(function(row)
            local columns = row.columns
            local winColumn = columns[1]
            local dateColumn = columns[2]
            local mapColumn = columns[3]
            local teamColumn = columns[4]
            local mmrColumn = columns[5]
            local damageColumn = columns[6]
            local healingColumn = columns[7]
            local changeColumn = columns[8]
            local ratingColumn = columns[9]

            local matchHistory = Arenalogs.MatchHistory:Deserialize(matchHistory)

            local date = date("!*t", matchHistory.timestamp / 1000) -- use ! because it is already localized time and divide by 1000 because date constructor needs seconds
            local formattedDate = string.format("%d.%d.%d %d:%d", date.day, date.month, date.year, date.hour, date.min)
            dateColumn.text:SetText(formattedDate)
            local mapAbbreviation = Arenalogs.UTIL:GetMapAbbreviation(matchHistory.mapInfo.name)
            mapColumn.text:SetText(f.r(mapAbbreviation))

            if displayedTeam == Arenalogs.CONST.DISPLAY_TEAMS.PLAYER_TEAM or matchHistory.isSoloShuffle then
                teamColumn:SetTeam(matchHistory.playerTeam)
                if matchHistory.isRated then
                    mmrColumn.text:SetText(matchHistory.playerTeam.ratingInfo.ratingMMR)
                else
                    mmrColumn.text:SetText(f.grey("-"))
                end
                damageColumn.text:SetText(Arenalogs.UTIL:FormatDamageNumber(matchHistory.playerTeam.damage))
                healingColumn.text:SetText(Arenalogs.UTIL:FormatDamageNumber(matchHistory.playerTeam.healing))
            else
                teamColumn:SetTeam(matchHistory.enemyTeam)
                if matchHistory.isRated then
                    mmrColumn.text:SetText(matchHistory.enemyTeam.ratingInfo.ratingMMR)
                else
                    mmrColumn.text:SetText(f.grey("-"))
                end
                damageColumn.text:SetText(Arenalogs.UTIL:FormatDamageNumber(matchHistory.enemyTeam.damage))
                healingColumn.text:SetText(Arenalogs.UTIL:FormatDamageNumber(matchHistory.enemyTeam.healing))
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

            winColumn:SetWin(matchHistory.win)

            row.tooltipOptions = {
                anchor = "ANCHOR_CURSOR",
                owner = row.frame,
                text = f.white(tooltipText),
            }
        end)
    end

    matchHistoryList:UpdateDisplay()
end

function Arenalogs.MAIN_FRAME:FillAbilityData()
    local ccCatalogueTab = Arenalogs.MAIN_FRAME.frame.content.abilitiesTab
    local abilityList = ccCatalogueTab.content.abilityList

    for classFile, specData in pairs(Arenalogs.ABILITY_DATA) do
        for specID, spells in pairs(specData) do
            for _, abilityData in ipairs(spells) do
                abilityList:Add(function(row, columns)
                    local classOrSpecColumn = columns[1]
                    local spellColumn = columns[2]
                    local typeColumn = columns[3]
                    local durationColumn = columns[4]
                    local upgradeColumn = columns[5]

                    if classFile ~= specID then
                        classOrSpecColumn:SetClass(classFile, specID)
                    else
                        classOrSpecColumn:SetClass(classFile)
                    end
                    spellColumn:SetSpell(abilityData.spellID) -- Hammer of justice
                    typeColumn.text:SetText(f.l(tostring(abilityData.abilityType) .. "-" .. tostring(abilityData.subType)))
                    durationColumn:SetDuration(abilityData.duration)

                    upgradeColumn:setIcons(abilityData.talentUpgrades or {})

                    row.tooltipOptions = {
                        anchor = "ANCHOR_RIGHT",
                        owner = row.frame,
                        spellID = abilityData.spellID
                    }
                end)
            end
        end
    end

    abilityList:UpdateDisplay()
end

function Arenalogs.MAIN_FRAME:FillDRData()
    local drOverviewTab = Arenalogs.MAIN_FRAME.frame.content.drOverviewTab
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
