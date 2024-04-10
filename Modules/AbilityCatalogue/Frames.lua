---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class ABILITY_CATALOGUE
PvPAssistant.ABILITY_CATALOGUE = PvPAssistant.ABILITY_CATALOGUE

---@class PvPAssistant.ABILITY_CATALOGUE.FRAMES
PvPAssistant.ABILITY_CATALOGUE.FRAMES = {}

---@return PvPAssistant.ABILITY_CATALOGUE.ABILITIES_TAB abilitiesTab
function PvPAssistant.ABILITY_CATALOGUE.FRAMES:InitAbilitiesCatalogueTab()
    ---@class PvPAssistant.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = PvPAssistant.MAIN_FRAME.frame

    ---@class PvPAssistant.ABILITY_CATALOGUE.ABILITIES_TAB : GGUI.Tab
    frame.content.abilitiesTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = PvPAssistant.MAIN_FRAME.tabContentSizeX, sizeY = PvPAssistant.MAIN_FRAME.tabContentSizeY, offsetY = PvPAssistant.MAIN_FRAME.tabContentOffsetY, canBeEnabled = true,
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

    PvPAssistant.ABILITY_CATALOGUE.abilitiesTab = frame.content.abilitiesTab

    ---@class PvPAssistant.ABILITY_CATALOGUE.ABILITIES_TAB.CONTENT : Frame
    frame.content.abilitiesTab.content = frame.content.abilitiesTab.content
    local abilitiesTab = frame.content.abilitiesTab
    ---@class PvPAssistant.ABILITY_CATALOGUE.ABILITIES_TAB.CONTENT : Frame
    abilitiesTab.content = abilitiesTab.content

    local abilitiesTab = PvPAssistant.MAIN_FRAME.frame.content.abilitiesTab
    ---@class PvPAssistant.ABILITY_CATALOGUE.ABILITIES_TAB.CONTENT
    abilitiesTab.content = abilitiesTab.content

    local classFilterFrame, classFilterTable = PvPAssistant.UTIL:CreateClassFilterFrame({
        parent = abilitiesTab.content,
        anchorPoint = { anchorParent = abilitiesTab.content, anchorA = "TOP", anchorB = "TOP" },
        clickCallback = function(_, _)
            PvPAssistant.ABILITY_CATALOGUE.FRAMES:UpdateAbilityData()
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

    PvPAssistant.ABILITY_CATALOGUE.FRAMES:UpdateAbilityData()

    return abilitiesTab
end

function PvPAssistant.ABILITY_CATALOGUE.FRAMES:UpdateAbilityData()
    local abilitiesTab = PvPAssistant.ABILITY_CATALOGUE.abilitiesTab
    local abilityList = abilitiesTab.content.abilityList
    local typeFilters = PvPAssistant.ABILITY_CATALOGUE:GetAbilityTypeFilters()
    local roleFilters = PvPAssistant.ABILITY_CATALOGUE:GetSpecRoleFilters()
    abilityList:Remove()
    for classFile, specData in pairs(PvPAssistant.ABILITY_DATA) do
        if not abilitiesTab.activeClassFilters[classFile] then
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
