---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MATCH_HISTORY
PvPAssistant.MATCH_HISTORY = {}

---@type Frame
PvPAssistant.MATCH_HISTORY.matchHistoryTooltipFrame = nil

function PvPAssistant.MATCH_HISTORY:InitMatchHistoryDropdownData()
    local matchHistoryTab = PvPAssistant.MAIN_FRAME.frame.content.matchHistoryTab
    local characterDropdown = matchHistoryTab.content.characterDropdown

    local characterDropdownData = PvPAssistant.MATCH_HISTORY:GetCharacterDropdownData()

    local playerDropdownData = GUTIL:Find(characterDropdownData, function(dropdownData)
        return dropdownData.value == PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    end)

    characterDropdown:SetData({
        data = characterDropdownData,
        initialLabel = playerDropdownData.label,
        initialValue = playerDropdownData.value
    })

    self.FRAMES:UpdateSpecializationDropdown()
    self.FRAMES:UpdateMapDropdown()
end

---@return GGUI.CustomDropdownData[] dropdownData
function PvPAssistant.MATCH_HISTORY:GetCharacterDropdownData()
    return GUTIL:Map(PvPAssistant.DB.CHARACTERS:GetAll(), function(characterData, characterUID)
        return {
            label = f.class(characterData.name, characterData.class),
            value = characterUID,
        }
    end)
end

---@return GGUI.CustomDropdownData[] dropdownData
function PvPAssistant.MATCH_HISTORY:GetMapDropdownData()
    local selectedCharacterUID = self:GetSelectedCharacterUID()
    local matchHistories = PvPAssistant.DB.MATCH_HISTORY:Get(selectedCharacterUID)

    ---@type GGUI.CustomDropdownData[]
    local dropdownData = {
        {
            label = f.white("All"),
            value = nil
        }
    }

    local mappedIDs = {}

    for _, matchHistory in ipairs(matchHistories) do
        local instanceID = matchHistory.mapInfo.instanceID

        if not mappedIDs[instanceID] then
            local mapAbbreviation = PvPAssistant.UTIL:GetMapAbbreviation(matchHistory.mapInfo.name)

            ---@type GGUI.CustomDropdownData
            local dData = {
                label = f.r(mapAbbreviation),
                value = instanceID,
                tooltipOptions = {
                    anchor = "ANCHOR_CURSOR_RIGHT",
                    text = f.r(matchHistory.mapInfo.name)
                }
            }

            tinsert(dropdownData, dData)

            mappedIDs[instanceID] = true
        end
    end

    return dropdownData
end

---@param a PvPAssistant.Player
---@param b PvPAssistant.Player
function PvPAssistant.MATCH_HISTORY.SortPlayerBySpecRole(a, b)
    local prioA = PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY[PvPAssistant.CONST.SPEC_ROLE_MAP[a.specID]]
    local prioB = PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY[PvPAssistant.CONST.SPEC_ROLE_MAP[b.specID]]

    return prioA > prioB
end

---@return PvPAssistant.Const.PVPModes? pvpMode
function PvPAssistant.MATCH_HISTORY:GetSelectedModeFilter()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return self.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return PlayerUID selectedCharacterUID?
function PvPAssistant.MATCH_HISTORY:GetSelectedCharacterUID()
    return self.matchHistoryTab.content.characterDropdown.selectedValue
end

---@return number specID?
function PvPAssistant.MATCH_HISTORY:GetSelectedSpecID()
    return self.matchHistoryTab.content.specDropdown.selectedValue
end

---@return number instanceID?
function PvPAssistant.MATCH_HISTORY:GetSelectedMapInstanceID()
    return self.matchHistoryTab.content.mapDropdown.selectedValue
end
