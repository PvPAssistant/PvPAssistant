---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = select(1, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class MAIN_FRAME
PvPAssistant.MAIN_FRAME = PvPAssistant.MAIN_FRAME

---@class PvPAssistant.MAIN_FRAME.FRAMES
PvPAssistant.MAIN_FRAME.FRAMES = {}

function PvPAssistant.MAIN_FRAME.FRAMES:Init()
    local sizeX = 750
    local sizeY = 650
    ---@class PvPAssistant.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = GGUI.Frame {
        moveable = true, frameID = PvPAssistant.CONST.FRAMES.MAIN_FRAME,
        sizeX = sizeX, sizeY = sizeY, frameConfigTable = PvPAssistantGGUIConfig, frameTable = PvPAssistant.MAIN.FRAMES,
        backdropOptions = PvPAssistant.CONST.MAIN_FRAME_BACKDROP, globalName = PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME
    }

    PvPAssistant.MAIN_FRAME.frame = frame

    -- makes it closeable on Esc
    tinsert(UISpecialFrames, PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME)

    frame.content.titleLogo = PvPAssistant.UTIL:CreateLogo(frame.content,
        {
            {
                anchorParent = frame.content,
                anchorA = "TOPLEFT",
                anchorB = "TOPLEFT",
                offsetX = 30,
                offsetY = -15,
            }
        })

    frame.content.updateText = GGUI.Text {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.titleLogo.frame, anchorA = "BOTTOMRIGHT", anchorB = "TOPRIGHT", offsetY = 5 } },
        text = f.l("*Update Beta" .. C_AddOns.GetAddOnMetadata(addonName, "version")),
        tooltipOptions = {
            owner = frame.frame,
            anchor = "ANCHOR_TOPLEFT",
            text = PvPAssistant.CONST.NEWS,
        },
    }

    ---@class PvPAssistant.MAIN_FRAME.CONTENT : Frame
    frame.content = frame.content
    local tabContentOffsetY = -50

    frame.content.matchHistoryTab = PvPAssistant.MATCH_HISTORY.FRAMES:InitMatchHistoryTab()

    ---@class PvPAssistant.MAIN_FRAME.ABILITIES_TAB : GGUI.Tab
    frame.content.abilitiesTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Ability Catalogue", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.matchHistoryTab.button.frame,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            offsetX = 10,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }
    ---@class PvPAssistant.MAIN_FRAME.ABILITIES_TAB.CONTENT
    frame.content.abilitiesTab.content = frame.content.abilitiesTab.content
    local abilitiesTab = frame.content.abilitiesTab
    ---@class PvPAssistant.MAIN_FRAME.ABILITIES_TAB.CONTENT
    abilitiesTab.content = abilitiesTab.content

    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE_TAB : GGUI.Tab
    frame.content.gearCatalogueTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Gear Guide", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.abilitiesTab.button.frame,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            offsetX = 10,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        }
    }
    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE.CONTENT
    frame.content.gearCatalogueTab.content = frame.content.gearCatalogueTab.content
    local gearCatalogueTab = frame.content.gearCatalogueTab
    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE.CONTENT
    gearCatalogueTab.content = gearCatalogueTab.content

    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB : GGUI.Tab
    frame.content.optionsTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.OPTIONS_ICON, 18, 18, 0, -1),
            anchorPoints = { {
                anchorParent = frame.content,
                anchorA = "TOPRIGHT",
                anchorB = "TOPRIGHT",
                offsetY = -8,
                offsetX = -35,
            } },
            parent = frame.content,
            sizeX = 20, sizeY = 20,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.OPTIONS_BUTTON,
            scale = tabButtonScale,
        }
    }

    frame.content.discordButton = GGUI.Button {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.optionsTab.button.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -6, } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DISCORD_BUTTON,
        cleanTemplate = true,
        sizeX = 20, sizeY = 20,
        clickCallback = function()
            GGUI:ShowPopup {
                copyText = PvPAssistant.CONST.DISCORD_INVITE,
                parent = frame.content, anchorParent = frame.content.discordButton.frame,
                title = "Join our Discord! (CTRL+C to Copy)", sizeX = 280, sizeY = 100,
                okButtonLabel = f.white("Ok"),
            }
        end
    }

    frame.content.DONATE_BUTTON = GGUI.Button {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.optionsTab.button.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -30, } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DONATE_BUTTON, -- Updated to use the new DonateButton textures
        cleanTemplate = true,
        sizeX = 20, sizeY = 20,
        clickCallback = function()
            GGUI:ShowPopup {
                copyText = PvPAssistant.CONST.DONATE_URL,
                parent = frame.content, anchorParent = frame.content.DONATE_BUTTON.frame, -- Ensure this references the correct button
                title = "Kofi donation page! (CTRL+C to Copy)", sizeX = 280, sizeY = 100,
                okButtonLabel = f.white("Ok"),
            }
        end
    }



    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB.CONTENT
    frame.content.optionsTab.content = frame.content.optionsTab.content
    local optionsTab = frame.content.optionsTab
    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB.CONTENT
    optionsTab.content = optionsTab.content

    GGUI.TabSystem { frame.content.matchHistoryTab, abilitiesTab, gearCatalogueTab, optionsTab }

    frame.content.closeButton = GGUI.Button {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT",
        offsetX = -8, offsetY = -8,
        label = f.white("X"),
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        fontOptions = {
            fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = 20,
        sizeY = 20,
        clickCallback = function()
            frame:Hide()
        end
    }

    PvPAssistant.MAIN_FRAME.FRAMES:InitAbilitiesCatalogueTab()
    PvPAssistant.MAIN_FRAME.FRAMES:InitGearCatalogue()
    PvPAssistant.OPTIONS:InitOptionsTab()

    frame:Hide()
end

function PvPAssistant.MAIN_FRAME.FRAMES:InitAbilitiesCatalogueTab()
    local abilitiesTab = PvPAssistant.MAIN_FRAME.frame.content.abilitiesTab
    ---@class PvPAssistant.MAIN_FRAME.ABILITIES_TAB.CONTENT
    abilitiesTab.content = abilitiesTab.content

    local classFilterFrame, classFilterTable = PvPAssistant.UTIL:CreateClassFilterFrame({
        parent = abilitiesTab.content,
        anchorPoint = { anchorParent = abilitiesTab.content, anchorA = "TOP", anchorB = "TOP" },
        clickCallback = function(_, _)
            PvPAssistant.MAIN_FRAME.FRAMES:UpdateAbilityData()
        end
    })

    abilitiesTab.content.classFilterFrame = classFilterFrame
    abilitiesTab.activeClassFilters = classFilterTable

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

    abilitiesTab.content.abilityList = GGUI.FrameList {
        parent = abilitiesTab.content, anchorParent = abilitiesTab.content.classFilterFrame.frame, anchorA = "TOP", anchorB = "BOTTOM",
        sizeY = 430, showBorder = true, offsetY = -55, offsetX = -8,
        columnOptions = columnOptions,
        rowBackdrops = { PvPAssistant.CONST.HISTORY_COLUMN_BACKDROP_A, PvPAssistant.CONST.HISTORY_COLUMN_BACKDROP_B },
        selectionOptions = { noSelectionColor = true, hoverRGBA = PvPAssistant.CONST.FRAME_LIST_HOVER_RGBA },
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
                if not spellUpgrades then
                    -- just hide all
                    table.foreach(upgradeColumn.icons, function(_, icon)
                        icon:Hide()
                    end)
                    return
                end
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

    abilitiesTab.content.typeFilterFrame = GGUI.Frame {
        parent = abilitiesTab.content, anchorParent = abilitiesTab.content.classFilterFrame.frame,
        anchorA = "TOPLEFT", anchorB = "BOTTOMLEFT", backdropOptions = PvPAssistant.CONST.FILTER_FRAME_BACKDROP,
        sizeX = 130, sizeY = 50, offsetY = 10, offsetX = 0,
    }

    abilitiesTab.typeFilters = {}

    local typeFilterButtonSize = 35

    abilitiesTab.content.defFilterButton = GGUI.ToggleButton {
        cleanTemplate = true,
        parent = abilitiesTab.content.typeFilterFrame.content,
        anchorPoints = { { anchorParent = abilitiesTab.content.typeFilterFrame.content, anchorA = "LEFT", anchorB = "LEFT", offsetY = 0, offsetX = 7 } },
        sizeX = typeFilterButtonSize, sizeY = typeFilterButtonSize,
        tooltipOptions = {
            text = f.bb("Defensive Abilities"),
            anchor = "ANCHOR_CURSOR"
        },
        buttonTextureOptions = {
            isAtlas = true,
            normal = 'Warfronts-BaseMapIcons-Alliance-Armory-Minimap',
            highlight = 'Warfronts-BaseMapIcons-Alliance-Armory-Minimap',
            disabled = 'Warfronts-BaseMapIcons-Alliance-Armory-Minimap',
            pushed = 'Warfronts-BaseMapIcons-Alliance-Armory-Minimap',
        },
        optionsTable = abilitiesTab.typeFilters,
        optionsKey = PvPAssistant.CONST.ABILITY_TYPES.DEFENSIVE,
        onToggleCallback = function()
            self:UpdateAbilityData()
        end
    }

    abilitiesTab.content.offFilterButton = GGUI.ToggleButton {
        cleanTemplate = true,
        parent = abilitiesTab.content.typeFilterFrame.content,
        anchorPoints = { { anchorParent = abilitiesTab.content.defFilterButton.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = 5 } },
        sizeX = typeFilterButtonSize, sizeY = typeFilterButtonSize,
        tooltipOptions = {
            text = f.r("Offensive Abilities"),
            anchor = "ANCHOR_CURSOR_RIGHT"
        },
        buttonTextureOptions = {
            isAtlas = true,
            normal = 'Warfronts-BaseMapIcons-Horde-Barracks-Minimap',
            highlight = 'Warfronts-BaseMapIcons-Horde-Barracks-Minimap',
            disabled = 'Warfronts-BaseMapIcons-Horde-Barracks-Minimap',
            pushed = 'Warfronts-BaseMapIcons-Horde-Barracks-Minimap',
        },
        optionsTable = abilitiesTab.typeFilters,
        optionsKey = PvPAssistant.CONST.ABILITY_TYPES.OFFENSIVE,
        onToggleCallback = function()
            self:UpdateAbilityData()
        end
    }

    abilitiesTab.content.ccFilterButton = GGUI.ToggleButton {
        cleanTemplate = true,
        parent = abilitiesTab.content.typeFilterFrame.content,
        anchorPoints = { { anchorParent = abilitiesTab.content.offFilterButton.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = 6 } },
        sizeX = typeFilterButtonSize - 5, sizeY = typeFilterButtonSize - 5,
        tooltipOptions = {
            text = f.l("Crowd Control Abilities"),
            anchor = "ANCHOR_CURSOR"
        },
        buttonTextureOptions = {
            isAtlas = true,
            normal = 'Vehicle-Trap-Gold',
            highlight = 'Vehicle-Trap-Gold',
            disabled = 'Vehicle-Trap-Gold',
            pushed = 'Vehicle-Trap-Gold',
        },
        optionsTable = abilitiesTab.typeFilters,
        optionsKey = PvPAssistant.CONST.ABILITY_TYPES.CC,
        onToggleCallback = function()
            self:UpdateAbilityData()
        end
    }

    abilitiesTab.content.roleFilterFrame = GGUI.Frame {
        parent = abilitiesTab.content, anchorParent = abilitiesTab.content.typeFilterFrame.frame,
        anchorA = "LEFT", anchorB = "RIGHT", backdropOptions = PvPAssistant.CONST.FILTER_FRAME_BACKDROP,
        sizeX = 130, sizeY = 50, offsetX = 3,
    }

    abilitiesTab.roleFilters = {}

    local rolefilterButtonSize = 30

    abilitiesTab.content.tankFilterButton = GGUI.ToggleButton {
        cleanTemplate = true,
        parent = abilitiesTab.content.roleFilterFrame.content,
        anchorPoints = { { anchorParent = abilitiesTab.content.roleFilterFrame.content, anchorA = "LEFT", anchorB = "LEFT", offsetY = 0, offsetX = 16 } },
        sizeX = rolefilterButtonSize, sizeY = rolefilterButtonSize,
        tooltipOptions = {
            text = f.bb("Tank Specs"),
            anchor = "ANCHOR_CURSOR"
        },
        buttonTextureOptions = {
            isAtlas = true,
            normal = 'UI-Frame-TankIcon',
            highlight = 'UI-Frame-TankIcon',
            disabled = 'UI-Frame-TankIcon',
            pushed = 'UI-Frame-TankIcon',
        },
        optionsTable = abilitiesTab.roleFilters,
        optionsKey = PvPAssistant.CONST.SPEC_ROLE.TANK,
        onToggleCallback = function()
            self:UpdateAbilityData()
        end
    }

    abilitiesTab.content.healerFilterButton = GGUI.ToggleButton {
        cleanTemplate = true,
        parent = abilitiesTab.content.roleFilterFrame.content,
        anchorPoints = { { anchorParent = abilitiesTab.content.tankFilterButton.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = 5 } },
        sizeX = rolefilterButtonSize, sizeY = rolefilterButtonSize,
        tooltipOptions = {
            text = f.g("Healer Specs"),
            anchor = "ANCHOR_CURSOR_RIGHT"
        },
        buttonTextureOptions = {
            isAtlas = true,
            normal = 'UI-Frame-HealerIcon',
            highlight = 'UI-Frame-HealerIcon',
            disabled = 'UI-Frame-HealerIcon',
            pushed = 'UI-Frame-HealerIcon',
        },
        optionsTable = abilitiesTab.roleFilters,
        optionsKey = PvPAssistant.CONST.SPEC_ROLE.HEALER,
        onToggleCallback = function()
            self:UpdateAbilityData()
        end
    }

    abilitiesTab.content.ddFilterButton = GGUI.ToggleButton {
        cleanTemplate = true,
        parent = abilitiesTab.content.roleFilterFrame.content,
        anchorPoints = { { anchorParent = abilitiesTab.content.healerFilterButton.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = 5 } },
        sizeX = rolefilterButtonSize, sizeY = rolefilterButtonSize,
        tooltipOptions = {
            text = f.r("Damage Specs"),
            anchor = "ANCHOR_CURSOR"
        },
        buttonTextureOptions = {
            isAtlas = true,
            normal = 'UI-Frame-DpsIcon',
            highlight = 'UI-Frame-DpsIcon',
            disabled = 'UI-Frame-DpsIcon',
            pushed = 'UI-Frame-DpsIcon',
        },
        optionsTable = abilitiesTab.roleFilters,
        optionsKey = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,
        onToggleCallback = function()
            self:UpdateAbilityData()
        end
    }

    PvPAssistant.MAIN_FRAME.FRAMES:UpdateAbilityData()
end

function PvPAssistant.MAIN_FRAME.FRAMES:InitGearCatalogue()
    local gearCatalogueTab = PvPAssistant.MAIN_FRAME.frame.content.gearCatalogueTab
    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE_TAB.CONTENT
    gearCatalogueTab.content = gearCatalogueTab.content

    gearCatalogueTab.content.wip = GGUI.Text {
        parent = gearCatalogueTab.content, anchorPoints = { { anchorParent = gearCatalogueTab.content, offsetY = 60 } },
        text = f.l("WORK IN PROGRESS")
    }
end

function PvPAssistant.MAIN_FRAME.FRAMES:UpdateAbilityData()
    local ccCatalogueTab = PvPAssistant.MAIN_FRAME.frame.content
        .abilitiesTab --[[@as PvPAssistant.MAIN_FRAME.ABILITIES_TAB]]
    local abilityList = ccCatalogueTab.content.abilityList
    local typeFilters = PvPAssistant.MAIN_FRAME:GetAbilityTypeFilters()
    local roleFilters = PvPAssistant.MAIN_FRAME:GetSpecRoleFilters()
    abilityList:Remove()
    for classFile, specData in pairs(PvPAssistant.ABILITY_DATA) do
        if not ccCatalogueTab.activeClassFilters[classFile] then
            for specID, spells in pairs(specData) do
                local specRole = PvPAssistant.CONST.SPEC_ROLE_MAP[specID]
                -- to generalized to DD (filter filters melee)
                if specRole == PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE then
                    specRole = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE
                end
                if roleFilters[specRole] then
                    for _, abilityData in ipairs(spells) do
                        local abilityType = abilityData.abilityType
                        if typeFilters[abilityType] then
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
                                typeColumn.text:SetText(f.l(tostring(abilityData.abilityType) ..
                                    "-" .. tostring(abilityData.subType)))
                                durationColumn:SetDuration(abilityData.duration)

                                upgradeColumn:setIcons(abilityData.talentUpgrades)

                                row.tooltipOptions = {
                                    anchor = "ANCHOR_RIGHT",
                                    owner = row.frame,
                                    spellID = abilityData.spellID
                                }
                            end)
                        end
                    end
                end
            end
        end
    end

    abilityList:UpdateDisplay()
end
