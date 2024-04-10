---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MAIN_FRAME
PvPAssistant.MAIN_FRAME = {}

---@type PvPAssistant.MAIN_FRAME.FRAME
PvPAssistant.MAIN_FRAME.frame = nil

PvPAssistant.MAIN_FRAME.tabContentSizeX = 750
PvPAssistant.MAIN_FRAME.tabContentSizeY = 650
PvPAssistant.MAIN_FRAME.tabContentOffsetY = -50

---@return Frame
function PvPAssistant.MAIN_FRAME:GetParentFrame()
    return PvPAssistant.MAIN_FRAME.frame.frame
end

---@return PvPAssistant.Const.PVPModes? pvpMode
function PvPAssistant.MAIN_FRAME:GetSelectedModeFilter()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return mainFrame.content.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return table<PvPAssistant.AbilityTypes, boolean>
function PvPAssistant.MAIN_FRAME:GetAbilityTypeFilters()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return mainFrame.content.abilitiesTab.typeFilters
end

---@return table<PvPAssistant.SpecRole, boolean>
function PvPAssistant.MAIN_FRAME:GetSpecRoleFilters()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return mainFrame.content.abilitiesTab.roleFilters
end
