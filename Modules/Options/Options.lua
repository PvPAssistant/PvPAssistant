---@class PvPLookup
local PvPLookup = select(2, ...)

PvPLookup.OPTIONS = {}
PvPLookup.OPTIONS.DROPDOWNS = {}
PvPLookup.OPTIONS.PERBOSSCHECKBOXES = {}
PvPLookup.OPTIONS.HELPICONS_DEFAULT_RAID = {}
PvPLookup.OPTIONS.HELPICONS_DEFAULT_DIFF = {}

function PvPLookup.OPTIONS:GetTalentsData()
    -- #### TALENTS
    ---@type number|string[]
    local talentSetIDs = PvPLookup.TALENTS:GetTalentSets()

    -- convert to dropdown data, always include starter build label
    local talentsDropdownData = {
        {
            label=PvPLookup.CONST.LABEL_NO_SET,
            value=nil
        },
        {
            label=PvPLookup.CONST.STARTER_BUILD,
            value=Constants.TraitConsts.STARTER_BUILD_TRAIT_CONFIG_ID
        }
    }
    table.foreach(talentSetIDs, function(_, configID)
        local setName = PvPLookup.TALENTS:GetTalentSetNameByID(configID)
        table.insert(talentsDropdownData, {
            label=setName,
            value=configID,
        })
    end)
    return talentsDropdownData
end

function PvPLookup.OPTIONS:GetAddonsData()
    if not PvPLookup.ADDONS.AVAILABLE then
        return nil
    end
    local addonSets = PvPLookup.ADDONS:GetAddonSets()

    -- convert to dropdown data, always include starter build label
    local addonsDropdownData = {
        {
            label=PvPLookup.CONST.LABEL_NO_SET,
            value=nil
        }
    }

    table.foreach(addonSets, function(setName, _)
        table.insert(addonsDropdownData, {
            label=setName,
            value=setName,
        })
    end)
    return addonsDropdownData
end
function PvPLookup.OPTIONS:GetEquipData()
    local equipSets = PvPLookup.EQUIP:GetEquipSets()

    -- convert to dropdown data, always include starter build label
    local equipDropdownData = {
        {
            label=PvPLookup.CONST.LABEL_NO_SET,
            value=nil
        }
    }

    table.foreach(equipSets, function(_, setID)
        local setName = PvPLookup.EQUIP:GetEquipSetNameByID(setID)
        table.insert(equipDropdownData, {
            label=setName,
            value=setID,
        })
    end)
    return equipDropdownData
end
function PvPLookup.OPTIONS:GetSpecData()
    local specs = PvPLookup.SPEC:GetSpecSets()

    -- convert to dropdown data, always include starter build label
    local specDropdownData = {
        {
            label=PvPLookup.CONST.LABEL_NO_SET,
            value=nil
        }
    }

    table.foreach(specs, function(_, setName)
        table.insert(specDropdownData, {
            label=setName,
            value=setName,
        })
    end)
    return specDropdownData
end
function PvPLookup.OPTIONS:Init()

    PvPLookup.OPTIONS.optionsPanel = CreateFrame("Frame", "LoadoutReminderOptionsPanel")

	PvPLookup.OPTIONS.optionsPanel:HookScript("OnShow", function(self)
		end)

    PvPLookup.OPTIONS.optionsPanel.name = "Loadout Reminder"
	local title = PvPLookup.OPTIONS.optionsPanel:CreateFontString('optionsTitle', 'OVERLAY', 'GameFontNormal')
    title:SetPoint("TOP", 0, 0)
	title:SetText("Loadout Reminder Options")

    ---@type GGUI.DropdownData
    local difficultyDropdownData = PvPLookup.GUTIL:Map(PvPLookup.CONST.DIFFICULTY, function (diff)
        return {
            label=PvPLookup.CONST.DIFFICULTY_DISPLAY_NAMES[diff],
            value=diff,
        }
    end)

    local difficultyDropdownData = PvPLookup.GUTIL:Sort(difficultyDropdownData, function (a, b)
        return PvPLookup.CONST.DIFFICULTY_SORT_ORDER[a.value] < PvPLookup.CONST.DIFFICULTY_SORT_ORDER[b.value]
    end)

    ---@type GGUI.Dropdown
    PvPLookup.OPTIONS.difficultyDropdown = PvPLookup.GGUI.Dropdown({
        parent=PvPLookup.OPTIONS.optionsPanel, 
        anchorParent=PvPLookup.OPTIONS.optionsPanel, offsetY=-30,
        anchorA="TOP", anchorB="TOP", label="Difficulty", initialData=difficultyDropdownData,
        initialLabel=PvPLookup.CONST.DIFFICULTY_DISPLAY_NAMES.DEFAULT, initialValue=PvPLookup.CONST.DIFFICULTY.DEFAULT,
        clickCallback=function ()
            PvPLookup.OPTIONS:ReloadDropdowns()
        end
    })

    local dropdownData = {
        TALENTS = PvPLookup.OPTIONS:GetTalentsData(),
        EQUIP = PvPLookup.OPTIONS:GetEquipData(),
        SPEC = PvPLookup.OPTIONS:GetSpecData(),
        ADDONS = PvPLookup.OPTIONS:GetAddonsData()
    }

    local tabContentX=623
    local tabContentY=500
    local tabOffsetY = -60

    --- GENERAL
    ---@type GGUI.Tab
    local generalTab = PvPLookup.GGUI.Tab({
        buttonOptions=
        {
            label="General", parent=PvPLookup.OPTIONS.optionsPanel, anchorParent=PvPLookup.OPTIONS.optionsPanel, adjustWidth=true,
            anchorA="TOPLEFT", anchorB="TOPLEFT", offsetX=20,offsetY=-20
        },
        canBeEnabled=true,
        parent=PvPLookup.OPTIONS.optionsPanel,
        anchorParent=PvPLookup.OPTIONS.optionsPanel,
        anchorA="CENTER", anchorB="CENTER", offsetX=0,offsetY=tabOffsetY,
        sizeX=tabContentX, sizeY=tabContentY,
    })

    local dbFunctions = {
        TALENTS= {
            Save = function (_, tabID, data)
                PvPLookup.DB.TALENTS:SaveInstanceSet(tabID, data)
            end,
            Get = function (_, tabID)
                return PvPLookup.DB.TALENTS:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
            end,
            GetInitialData = function (_, tabID)
                local talentSetID = PvPLookup.DB.TALENTS:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
                local label = (talentSetID and PvPLookup.TALENTS:GetTalentSetNameByID(talentSetID)) or nil
                return {
                    label=label,
                    value=talentSetID
                }
            end
        },
        EQUIP= {
            Save = function (_, tabID, data)
                PvPLookup.DB.EQUIP:SaveInstanceSet(tabID, data)
            end,
            Get = function (_, tabID)
                return PvPLookup.DB.EQUIP:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
            end,
            GetInitialData = function (_, tabID)
                local equipSetID = PvPLookup.DB.EQUIP:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
                local label = (equipSetID and PvPLookup.EQUIP:GetEquipSetNameByID(equipSetID)) or nil
                return {
                    label=label,
                    value=equipSetID
                }
            end
        },
        SPEC= {
            Save = function (_, tabID, data)
                PvPLookup.DB.SPEC:SaveInstanceSet(tabID, data)
            end,
            Get = function (_, tabID)
                return PvPLookup.DB.SPEC:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
            end,
            GetInitialData = function (_, tabID)
                local setName = PvPLookup.DB.SPEC:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
                return {
                    label=setName,
                    value=setName
                }
            end
        },
        ADDONS= {
            Save = function (_, tabID, data)
                PvPLookup.DB.ADDONS:SaveInstanceSet(tabID, data)
            end,
            Get = function (_, tabID)
                return PvPLookup.DB.ADDONS:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
            end,
            GetInitialData = function (_, tabID)
                local setName = PvPLookup.DB.ADDONS:GetInstanceSet(tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(tabID))
                return {
                    label=setName,
                    value=setName
                }
            end
        },
    }

    PvPLookup.OPTIONS:CreateTabListWithDropdowns(generalTab.content, 
        PvPLookup.GUTIL:Filter(PvPLookup.CONST.INSTANCE_TYPES, function(it) return it ~= PvPLookup.CONST.INSTANCE_TYPES.RAID end), 
        PvPLookup.CONST.INSTANCE_TYPES_DISPLAY_NAMES, dropdownData, dbFunctions, 100, 0, 35)

    -- ### RAIDS

    ---@type GGUI.Tab
    local raidsTab = PvPLookup.GGUI.Tab({
        buttonOptions=
        {
            label="Raids", parent=PvPLookup.OPTIONS.optionsPanel, anchorParent=generalTab.button.frame, adjustWidth=true,
            anchorA="LEFT", anchorB="RIGHT", offsetX=10,
        },
        canBeEnabled=true,
        parent=PvPLookup.OPTIONS.optionsPanel,
        anchorParent=PvPLookup.OPTIONS.optionsPanel,
        anchorA="CENTER", anchorB="CENTER", offsetX=0,offsetY=tabOffsetY,
        sizeX=tabContentX, sizeY=tabContentY,
    })

    PvPLookup.OPTIONS:CreateRaidTabList(raidsTab.content, dropdownData)

    PvPLookup.GGUI.TabSystem({generalTab, raidsTab})

    InterfaceOptions_AddCategory(self.optionsPanel)
end

function PvPLookup.OPTIONS:CreateRaidTabList(parent, dropdownData)
    local subTabSizeX= 100
    local tabContentX = 500
    local tabContentY = 500

    local tabs = {}

    local raids = PvPLookup.CONST.RAIDS
    
    local lastAnchor = parent
    local anchorB = "TOPLEFT"
    local offsetY = -20
    for _, raid in pairs(raids) do
        local label = PvPLookup.CONST.RAID_DISPLAY_NAMES[raid]
        local tab = PvPLookup.GGUI.Tab({
            buttonOptions=
            {
                label=label, parent=parent, anchorParent=lastAnchor,
                anchorA="TOPLEFT", anchorB=anchorB, offsetX=0,offsetY=offsetY, sizeY=20, sizeX=subTabSizeX
            },
            canBeEnabled=true,
            parent=parent,
            anchorParent=parent,
            anchorA="CENTER", anchorB="CENTER", offsetX=0,offsetY=0,
            sizeX=tabContentX, sizeY=tabContentY,
        })

        tab.content.title = PvPLookup.GGUI.Text({
            parent=tab.content,anchorParent=tab.content,anchorA="TOP", anchorB="TOP", offsetY=40, 
            text=label, offsetX=160,
        })

        local selectedDifficulty = PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID)

        local perBossOptionKey = PvPLookup.OPTIONS:GetPerBossOptionKey(selectedDifficulty, raid)

        if raid ~= PvPLookup.CONST.RAIDS.DEFAULT then
            ---@class LoadoutReminder.PerBossCheckbox : GGUI.Checkbox
            tab.content.perBossCheckbox = PvPLookup.GGUI.Checkbox({
                parent=tab.content, 
                anchorParent=tab.content, 
                anchorA="TOP", anchorB="TOP", offsetX=-135, offsetY=10,
                initialValue=LoadoutReminderOptionsV2[perBossOptionKey],
                label="Boss Loadouts",
                tooltip="When this is checked, you will be reminded for individual bosses for the selected raid of the selected difficulty.",
                clickCallback=function (_, checked)
                    local difficulty = PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID)
                    local key = PvPLookup.OPTIONS:GetPerBossOptionKey(difficulty, raid)
                    LoadoutReminderOptionsV2[key] = checked
                    PvPLookup.MAIN:CheckSituations()
                end
            })
            tab.content.perBossCheckbox.Reload = function ()
                local difficulty = PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID)
                local key = PvPLookup.OPTIONS:GetPerBossOptionKey(difficulty, raid)
                tab.content.perBossCheckbox:SetChecked(LoadoutReminderOptionsV2[key])
            end
            table.insert(PvPLookup.OPTIONS.PERBOSSCHECKBOXES, tab.content.perBossCheckbox)

            tab.content.perBossCheckbox:Hide() -- cause initial difficulty is default and thats where we do not want the checkbox to show

            ---@class GGUI.HelpIcon
            table.insert(PvPLookup.OPTIONS.HELPICONS_DEFAULT_DIFF, PvPLookup.GGUI.HelpIcon({parent=tab.content, anchorParent=tab.content,
                anchorA="TOP", anchorB="TOP", offsetX=-90, offsetY=0,
                text="You will be reminded of this loadouts when loading into the selected raid of any difficulty\nwhere individual boss loadouts are toggled" .. 
                PvPLookup.GUTIL:ColorizeText(" ON", PvPLookup.GUTIL.COLORS.GREEN),
            }))
        else
            table.insert(PvPLookup.OPTIONS.HELPICONS_DEFAULT_RAID, PvPLookup.GGUI.HelpIcon({parent=tab.content, anchorParent=tab.content,
                anchorA="TOP", anchorB="TOP", offsetX=-90, offsetY=0,
                text="You will be reminded of this loadout when loading into any raid (of the selected difficulty)\nwhere individual boss loadouts are toggled" .. 
                PvPLookup.GUTIL:ColorizeText(" OFF", PvPLookup.GUTIL.COLORS.RED),
            }))
        end

        local bosses = PvPLookup.GUTIL:Filter(PvPLookup.CONST.BOSS_ID_MAP, function (boss)
            return string.sub(boss, 1, string.len(raid)) == raid
        end)

        bosses = PvPLookup.GUTIL:ToSet(bosses)
        bosses = PvPLookup.GUTIL:Sort(bosses, function (a, b)
            return PvPLookup.CONST.BOSS_SORT_ORDER[a] <  PvPLookup.CONST.BOSS_SORT_ORDER[b]
        end)

        local dbFunctions = {
            TALENTS= {
                Save = function (_, tabID, data)
                    PvPLookup.DB.TALENTS:SaveRaidSet(raid, tabID, data)
                end,
                Get = function (_, tabID)
                    return PvPLookup.DB.TALENTS:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                end,
                GetInitialData = function (_, tabID)
                    local setID = PvPLookup.DB.TALENTS:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                    local label = (setID and PvPLookup.TALENTS:GetTalentSetNameByID(setID)) or nil
                    return {
                        label=label,
                        value=setID
                    }
                end
            },
            EQUIP= {
                Save = function (_, tabID, data)
                    PvPLookup.DB.EQUIP:SaveRaidSet(raid, tabID, data)
                end,
                Get = function (_, tabID)
                    return PvPLookup.DB.EQUIP:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                end,
                GetInitialData = function (_, tabID)
                    local setID = PvPLookup.DB.EQUIP:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                    local label = (setID and PvPLookup.EQUIP:GetEquipSetNameByID(setID)) or nil
                    return {
                        label=label,
                        value=setID
                    }
                end
            },
            SPEC= {
                Save = function (_, tabID, data)
                    PvPLookup.DB.SPEC:SaveRaidSet(raid, tabID, data)
                end,
                Get = function (_, tabID)
                    return PvPLookup.DB.SPEC:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                end,
                GetInitialData = function (_, tabID)
                    local setName = PvPLookup.DB.SPEC:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                    return {
                        label=setName,
                        value=setName
                    }
                end
            },
            ADDONS= {
                Save = function (_, tabID, data)
                    PvPLookup.DB.ADDONS:SaveRaidSet(raid, tabID, data)
                end,
                Get = function (_, tabID)
                    return PvPLookup.DB.ADDONS:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                end,
                GetInitialData = function (_, tabID)
                    local setName = PvPLookup.DB.ADDONS:GetRaidSet(raid, tabID, PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID))
                    return {
                        label=setName,
                        value=setName
                    }
                end
            },
        }

        PvPLookup.OPTIONS:CreateTabListWithDropdowns(tab.content, bosses, PvPLookup.CONST.BOSS_NAMES, dropdownData, dbFunctions, 200, 60, 0, 100, 15)
        table.insert(tabs, tab)
        --
        lastAnchor = tab.button.frame
        anchorB = "BOTTOMLEFT"
        offsetY = 0
    end

    PvPLookup.GGUI.TabSystem(tabs)

    return tabs
end

function PvPLookup.OPTIONS:CreateTabListWithDropdowns(parent, idTable, nameTable, dropdownData, dbFunctions, buttonWidth, baseOffsetX, baseOffsetY, titleOffsetX, titleOffsetY)
    local tabContentX = 500
    local tabContentY = 500

    baseOffsetX = baseOffsetX or 0
    baseOffsetY = baseOffsetY or 0
    titleOffsetX = titleOffsetX or 0
    titleOffsetY = titleOffsetY or (baseOffsetY-20)

    local tabs = {}

    local lastAnchor = parent
    local anchorB = "TOPLEFT"
    local offsetY = -20
    local offsetX = baseOffsetX
    for _, tabID in pairs(idTable) do
        local label = nameTable[tabID]
        local tab = PvPLookup.GGUI.Tab({
            buttonOptions=
            {
                label=label, parent=parent, anchorParent=lastAnchor,
                anchorA="TOPLEFT", anchorB=anchorB, offsetX=offsetX,offsetY=offsetY, sizeY=20, sizeX=buttonWidth
            },
            canBeEnabled=true,
            parent=parent,
            anchorParent=parent,
            anchorA="CENTER", anchorB="CENTER", offsetX=0,offsetY=0,
            sizeX=tabContentX, sizeY=tabContentY,
        })

        tab.content.title = PvPLookup.GGUI.Text({
            parent=tab.content,anchorParent=tab.content,anchorA="TOP", anchorB="TOP", offsetY=titleOffsetY, 
            text=label, offsetX=titleOffsetX+baseOffsetX,
        })

        PvPLookup.OPTIONS:CreateReminderTypeDropdowns(tab.content, tab.content.title.frame, "TOP", "BOTTOM", 0, -20, dropdownData, dbFunctions, tabID)
        table.insert(tabs, tab)
        --
        lastAnchor = tab.button.frame
        anchorB = "BOTTOMLEFT"
        offsetY = 0
        offsetX = 0
    end

    PvPLookup.GGUI.TabSystem(tabs)

    return tabs
end

function PvPLookup.OPTIONS:CreateReminderTypeDropdowns(parent, anchorParent, anchorA, anchorB, offsetX, offsetY, dropdownData, dbFunctions, tabID)
    local dropdownSpacingY = -21
    local talentData = dropdownData.TALENTS
    local initialTalent = dbFunctions.TALENTS:GetInitialData(tabID)
    ---@type GGUI.Dropdown
    local talentsDropdown = PvPLookup.GGUI.Dropdown({
        parent=parent, anchorParent=anchorParent,
        anchorA=anchorA,anchorB=anchorB, offsetX=offsetX,offsetY=offsetY,label="Talent Set",
        initialData=talentData, initialValue=initialTalent.value, initialLabel=initialTalent.label or PvPLookup.CONST.LABEL_NO_SET,
        clickCallback=function (self, _, data)
            dbFunctions.TALENTS:Save(tabID, data)
            PvPLookup.MAIN:CheckSituations()
        end,
    })
    talentsDropdown.Reload = function (_, dropdownData)
        local initialData = dbFunctions.TALENTS:GetInitialData(tabID)
        talentsDropdown:SetData({data=dropdownData.TALENTS, initialValue=initialData.value, initialLabel=initialData.label or PvPLookup.CONST.LABEL_NO_SET})
    end
    local equipData = dropdownData.EQUIP
    local initialEquip = dbFunctions.EQUIP:GetInitialData(tabID)
    local equipDropdown = PvPLookup.GGUI.Dropdown({
        parent=parent, anchorParent=talentsDropdown.frame,
        anchorA="TOP",anchorB="BOTTOM", offsetX=0,offsetY=dropdownSpacingY,label="Equip Set",
        initialData=equipData, initialValue=initialEquip.value, initialLabel=initialEquip.label or PvPLookup.CONST.LABEL_NO_SET,
        clickCallback=function (self, _, data)
            dbFunctions.EQUIP:Save(tabID, data)
            PvPLookup.MAIN:CheckSituations()
        end,
    })
    equipDropdown.Reload = function (_, dropdownData)
        local initialData = dbFunctions.EQUIP:GetInitialData(tabID)
        equipDropdown:SetData({data=dropdownData.EQUIP, initialValue=initialData.value, initialLabel=initialData.label or PvPLookup.CONST.LABEL_NO_SET})
    end
    local specData = dropdownData.SPEC
    local initialSpec = dbFunctions.SPEC:GetInitialData(tabID)
    local specDropdown = PvPLookup.GGUI.Dropdown({
        parent=parent, anchorParent=equipDropdown.frame,
        anchorA="TOP",anchorB="BOTTOM", offsetX=0,offsetY=dropdownSpacingY,label="Specialization",
        initialData=specData, initialValue=initialSpec.value, initialLabel=initialSpec.label or PvPLookup.CONST.LABEL_NO_SET,
        clickCallback=function (self, _, data)
            dbFunctions.SPEC:Save(tabID, data)
            PvPLookup.MAIN:CheckSituations()
        end,
    })
    specDropdown.Reload = function (_, dropdownData)
        local initialData = dbFunctions.SPEC:GetInitialData(tabID)
        specDropdown:SetData({data=dropdownData.SPEC, initialValue=initialData.value, initialLabel=initialData.label or PvPLookup.CONST.LABEL_NO_SET})
    end

    table.insert(PvPLookup.OPTIONS.DROPDOWNS, talentsDropdown)
    table.insert(PvPLookup.OPTIONS.DROPDOWNS, equipDropdown)
    table.insert(PvPLookup.OPTIONS.DROPDOWNS, specDropdown)

    local addonData = dropdownData.ADDONS

    if not addonData then
        return
    end

    local initialAddons = dbFunctions.ADDONS:GetInitialData(tabID)
    local addonDropdown = PvPLookup.GGUI.Dropdown({
        parent=parent, anchorParent=specDropdown.frame,
        anchorA="TOP",anchorB="BOTTOM", offsetX=0,offsetY=dropdownSpacingY,label="Addon Set",
        initialData=addonData, initialValue=initialAddons.value, initialLabel=initialAddons.label or PvPLookup.CONST.LABEL_NO_SET,
        clickCallback=function (self, _, data)
            dbFunctions.ADDONS:Save(tabID, data)
            PvPLookup.MAIN:CheckSituations()
        end,
    })
    addonDropdown.Reload = function (_, dropdownData)
        local initialData = dbFunctions.ADDONS:GetInitialData(tabID)
        addonDropdown:SetData({data=dropdownData.ADDONS, initialValue=initialData.value, initialLabel=initialData.label or PvPLookup.CONST.LABEL_NO_SET})
    end

    
    table.insert(PvPLookup.OPTIONS.DROPDOWNS, addonDropdown)
end

function PvPLookup.OPTIONS:ReloadDropdowns()

    if not PvPLookup.MAIN.READY then
        return
    end

    local dropdownData = {
        TALENTS = PvPLookup.OPTIONS:GetTalentsData(),
        EQUIP = PvPLookup.OPTIONS:GetEquipData(),
        SPEC = PvPLookup.OPTIONS:GetSpecData(),
        ADDONS = PvPLookup.OPTIONS:GetAddonsData()
    }

    local selectedDifficulty = PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(PvPLookup.CONST.INSTANCE_TYPES.RAID)

    for _, dropdown in pairs(PvPLookup.OPTIONS.DROPDOWNS) do
        dropdown:Reload(dropdownData)
    end

    for _, checkBox in pairs(PvPLookup.OPTIONS.PERBOSSCHECKBOXES) do
        checkBox:Reload()
        checkBox:SetVisible(selectedDifficulty ~= PvPLookup.CONST.DIFFICULTY.DEFAULT)
    end

    for _, helpIcon in pairs(PvPLookup.OPTIONS.HELPICONS_DEFAULT_DIFF) do
        helpIcon:SetVisible(selectedDifficulty == PvPLookup.CONST.DIFFICULTY.DEFAULT)
    end
end

function PvPLookup.OPTIONS:GetSelectedDifficultyBySupportedInstanceTypes(instanceType)
    local difficulty = "DEFAULT"
	if PvPLookup.UTIL:InstanceTypeSupportsDifficulty(instanceType) then
		difficulty = PvPLookup.OPTIONS.difficultyDropdown.selectedValue
	end
	return difficulty
end

function PvPLookup.OPTIONS:GetPerBossOptionKey(difficulty, raid)
    return difficulty .. "_" .. raid .. "_PerBoss"
end

function PvPLookup.OPTIONS:HasRaidLoadoutsPerBoss()
	local raid = PvPLookup.UTIL:GetCurrentRaid()
	if not raid then
		return false
	end
	local difficulty = PvPLookup.UTIL:GetInstanceDifficulty()
    if not difficulty then
        -- happens on first execution after going into a raid.. next exec should include difficulty
        return false
    end
	local optionKey = PvPLookup.OPTIONS:GetPerBossOptionKey(difficulty, raid)

	return LoadoutReminderOptionsV2[optionKey]
end