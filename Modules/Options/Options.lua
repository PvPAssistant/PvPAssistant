---@class Arenalogs
local Arenalogs = select(2, ...)

---@class Arenalogs.Options
Arenalogs.OPTIONS = {}

ArenalogsOptions = ArenalogsOptions or {
    enableDebug = false
}

function Arenalogs.OPTIONS:Init()
    self:HandleOptionsUpdates()
    Arenalogs.OPTIONS.optionsPanel = CreateFrame("Frame", "ArenalogsOptionsPanel")
    Arenalogs.OPTIONS.optionsPanel.name = "Arenalogs"

    InterfaceOptions_AddCategory(self.optionsPanel)
end

function Arenalogs.OPTIONS:HandleOptionsUpdates()
    if ArenalogsOptions then
        ArenalogsOptions.enableDebug = ArenalogsOptions.enableDebug or false
    end
end
