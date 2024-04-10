---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.ABILITY_CATALOGUE
PvPAssistant.ABILITY_CATALOGUE = {}

---@type PvPAssistant.ABILITY_CATALOGUE.ABILITIES_TAB
PvPAssistant.ABILITY_CATALOGUE.abilitiesTab = nil

---@return table<PvPAssistant.AbilityTypes, boolean>
function PvPAssistant.ABILITY_CATALOGUE:GetAbilityTypeFilters()
    return self.abilitiesTab.typeFilters
end

---@return table<PvPAssistant.SpecRole, boolean>
function PvPAssistant.ABILITY_CATALOGUE:GetSpecRoleFilters()
    return self.abilitiesTab.roleFilters
end
