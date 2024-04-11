---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.Options
PvPAssistant.OPTIONS = {}

function PvPAssistant.OPTIONS:Init()
    PvPAssistant.OPTIONS.optionsPanel = CreateFrame("Frame", "PvPAssistantOptionsPanel")
    PvPAssistant.OPTIONS.optionsPanel.name = "PvPAssistant"

    InterfaceOptions_AddCategory(self.optionsPanel)
end
