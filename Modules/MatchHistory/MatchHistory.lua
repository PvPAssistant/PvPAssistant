---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MATCH_HISTORY
PvPAssistant.MATCH_HISTORY = {}

---@type Frame
PvPAssistant.MATCH_HISTORY.matchHistoryTooltipFrame = nil

function PvPAssistant.MATCH_HISTORY:InitMatchHistoryCharacterDropdownData()
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
end

---@return GGUI.CustomDropdownData[] dropdownData
function PvPAssistant.MATCH_HISTORY:GetCharacterDropdownData()
    return GUTIL:Map(PvPAssistant.DB.CHARACTER_DATA:GetAll(), function(characterData, characterUID)
        return {
            label = f.class(characterData.name, characterData.class),
            value = characterUID,
        }
    end)
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
