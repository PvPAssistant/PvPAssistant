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
PvPAssistant.MAIN_FRAME.tabButtonSizeX = 110
PvPAssistant.MAIN_FRAME.tabButtonSizeY = 25

---@return Frame
function PvPAssistant.MAIN_FRAME:GetParentFrame()
    return PvPAssistant.MAIN_FRAME.frame.frame
end
