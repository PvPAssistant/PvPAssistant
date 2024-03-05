---@class Arenalogs
local Arenalogs = select(2, ...)

local GGUI = Arenalogs.GGUI
local GUTIL = Arenalogs.GUTIL

---@class Arenalogs.MAIN_FRAME
Arenalogs.MAIN_FRAME = {}

---@type Arenalogs.MAIN_FRAME.FRAME
Arenalogs.MAIN_FRAME.frame = nil

---@type Frame
Arenalogs.MAIN_FRAME.matchHistoryTooltipFrame = nil


---@return Arenalogs.Const.PVPModes? pvpMode
function Arenalogs.MAIN_FRAME:GetSelectedModeFilter()
    local mainFrame = Arenalogs.MAIN_FRAME.frame
    if not mainFrame then
        error("Arenalogs Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return Arenalogs.Const.DisplayTeams displayTeams
function Arenalogs.MAIN_FRAME:GetDisplayTeam()
    local mainFrame = Arenalogs.MAIN_FRAME.frame
    if not mainFrame then
        error("Arenalogs Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.teamDisplayDropdown.selectedValue
end
