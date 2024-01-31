---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.MAIN_FRAME
PvPLookup.MAIN_FRAME = {}

---@type PvPLookup.MAIN_FRAME.FRAME
PvPLookup.MAIN_FRAME.frame = nil


---@return PvPLookup.Const.PVPModes? pvpMode
function PvPLookup.MAIN_FRAME:GetSelectedModeFilter()
    local mainFrame = PvPLookup.MAIN_FRAME.frame
    if not mainFrame then
        error("PVPLookup Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return PvPLookup.Const.DisplayTeams displayTeams
function PvPLookup.MAIN_FRAME:GetDisplayTeam()
    local mainFrame = PvPLookup.MAIN_FRAME.frame
    if not mainFrame then
        error("PVPLookup Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.teamDisplayDropdown.selectedValue
end
