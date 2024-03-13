---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL

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

---@return PvPAssistant.Const.DisplayTeams displayTeams
function PvPAssistant.MAIN_FRAME:GetDisplayTeam()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.teamDisplayDropdown.selectedValue
end
