---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

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
            offsetX = 24,
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
                PvPLookup.MAIN_FRAME:UpdateHistory()
            else
                matchHistoryTab.activeClassFilters[class] = nil
                classFilterIcon:Saturate()
                -- reload list with new filters
                PvPLookup.MAIN_FRAME:UpdateHistory()
            end
        end)

        return classFilterIcon
    end

    local currentAnchor = matchHistoryTab.content.classFilterFrame.frame
    for i, class in pairs(PvPLookup.CONST.CLASSES) do
        local anchorB = "RIGHT"
        local offX = classFilterIconSpacingX
        local offY = 0
        if i == 1 then
            anchorB = "LEFT"
            offX = classFilterIconOffsetX
            offY = classFilterIconOffsetY
        end
        local classFilterIcon = CreateClassFilterIcon(class, currentAnchor, offX, offY, "LEFT", anchorB)
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
        anchorA = "TOP", anchorB = "BOTTOM", scale = listScale, offsetY = -25,
        rowBackdrops = { PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A, PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B },
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
            PvPLookup.MAIN_FRAME:UpdateHistory()
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
                label = GUTIL:ColorizeText("RGB", GUTIL.COLORS.WHITE),
                value = PvPLookup.CONST.PVP_MODES.RBG,
            },
        },
        initialLabel = GUTIL:ColorizeText("2v2", GUTIL.COLORS.WHITE),
        initialValue = PvPLookup.CONST.PVP_MODES.TWOS,
        clickCallback = function(self, label, value)
            PvPLookup.MAIN_FRAME:UpdateHistory()
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
    ccCatalogueTab.content.ccList:Hide() -- Temp

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

function PvPLookup.MAIN_FRAME:UpdateHistory()
    local matchHistoryTab = PvPLookup.MAIN_FRAME.frame.content.matchHistoryTab
    local matchHistoryList = matchHistoryTab.content.matchHistoryList

    matchHistoryTab.content.matchHistoryList:Remove()

    local pvpModeFilter = PvPLookup.MAIN_FRAME:GetSelectedModeFilter()
    local displayedTeam = PvPLookup.MAIN_FRAME:GetDisplayTeam()

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
            -- local totalSeconds = matchHistory.duration / 1000
            -- -- Calculate minutes and remaining seconds
            -- local minutes = math.floor(totalSeconds / 60)
            -- local seconds = totalSeconds % 60

            changeColumn.text:SetText(FormatValueWithSign(matchHistory.ratingChange))
            ratingColumn.text:SetText(matchHistory.rating)
            ratingColumn:SetIconByRating(matchHistory.rating)
        end)
    end

    matchHistoryList:UpdateDisplay()
end

function PvPLookup.MAIN_FRAME:FillCCData()
    local ccCatalogueTab = PvPLookup.MAIN_FRAME.frame.content.ccCatalogueTab
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

function PvPLookup.MAIN_FRAME:FillDRData()
    local drOverviewTab = PvPLookup.MAIN_FRAME.frame.content.drOverviewTab
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
