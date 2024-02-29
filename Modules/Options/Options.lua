---@class Arenalogs
local Arenalogs = select(2, ...)

---@class Arenalogs.Options
Arenalogs.OPTIONS = {}

function Arenalogs.OPTIONS:Init()

    Arenalogs.OPTIONS.optionsPanel = CreateFrame("Frame", "ArenalogsOptionsPanel")
    Arenalogs.OPTIONS.optionsPanel.name = "Arenalogs"

    InterfaceOptions_AddCategory(self.optionsPanel)
end