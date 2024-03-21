---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MAIN_FRAME
PvPAssistant.MAIN_FRAME = {}

---@type PvPAssistant.MAIN_FRAME.FRAME
PvPAssistant.MAIN_FRAME.frame = nil

---@type Frame
PvPAssistant.MAIN_FRAME.matchHistoryTooltipFrame = nil


---@return PvPAssistant.Const.PVPModes? pvpMode
function PvPAssistant.MAIN_FRAME:GetSelectedModeFilter()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return PlayerUID selectedCharacterUID?
function PvPAssistant.MAIN_FRAME:GetSelectedCharacterUID()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.characterDropdown.selectedValue
end

---@return GGUI.CustomDropdownData[] dropdownData
function PvPAssistant.MAIN_FRAME:GetCharacterDropdownData()
    return GUTIL:Map(PvPAssistant.DB.CHARACTER_DATA:GetAll(), function(characterData, characterUID)
        return {
            label = f.class(characterData.name, characterData.class),
            value = characterUID,
        }
    end)
end

---@param a PvPAssistant.Player
---@param b PvPAssistant.Player
function PvPAssistant.MAIN_FRAME.SortPlayerBySpecRole(a, b)
    local prioA = PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY[PvPAssistant.CONST.SPEC_ROLE_MAP[a.specID]]
    local prioB = PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY[PvPAssistant.CONST.SPEC_ROLE_MAP[b.specID]]

    return prioA > prioB
end
