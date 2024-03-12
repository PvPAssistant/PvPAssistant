---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GGUI = PvpAssistant.GGUI
local GUTIL = PvpAssistant.GUTIL

---@class PvpAssistant.MAIN_FRAME
PvpAssistant.MAIN_FRAME = {}

---@type PvpAssistant.MAIN_FRAME.FRAME
PvpAssistant.MAIN_FRAME.frame = nil

---@type Frame
PvpAssistant.MAIN_FRAME.matchHistoryTooltipFrame = nil


---@return PvpAssistant.Const.PVPModes? pvpMode
function PvpAssistant.MAIN_FRAME:GetSelectedModeFilter()
    local mainFrame = PvpAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvpAssistant Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return PvpAssistant.Const.DisplayTeams displayTeams
function PvpAssistant.MAIN_FRAME:GetDisplayTeam()
    local mainFrame = PvpAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvpAssistant Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.teamDisplayDropdown.selectedValue
end
