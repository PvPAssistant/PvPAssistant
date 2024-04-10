---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.Options
PvPAssistant.OPTIONS = {}

PvPAssistantOptions = PvPAssistantOptions or {
    enableDebug = false,

    -- Arena Guide
    arenaGuideEnable = true,
}

---@param optionName string
---@param value any
function PvPAssistant.OPTIONS:InitDefaultValue(optionName, value)
    if PvPAssistantOptions[optionName] == nil then
        PvPAssistantOptions[optionName] = value
    end
end

function PvPAssistant.OPTIONS:Init()
    self:HandleOptionsUpdates()
    PvPAssistant.OPTIONS.optionsPanel = CreateFrame("Frame", "PvPAssistantOptionsPanel")
    PvPAssistant.OPTIONS.optionsPanel.name = "PvPAssistant"

    InterfaceOptions_AddCategory(self.optionsPanel)
end

function PvPAssistant.OPTIONS:HandleOptionsUpdates()
    if PvPAssistantOptions then
        PvPAssistant.OPTIONS:InitDefaultValue("enableDebug", false)
        PvPAssistant.OPTIONS:InitDefaultValue("arenaGuideEnable", true)
    end
end
