---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.TOOLTIP_OPTIONS : PvPAssistant.DB.Repository
PvPAssistant.DB.TOOLTIP_OPTIONS = PvPAssistant.DB:RegisterRepository()

---@class PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP
PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP
PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP = {}

function PvPAssistant.DB.TOOLTIP_OPTIONS:Init()
    if not PvPAssistantDB.tooltipOptions then
        PvPAssistantDB.tooltipOptions = {
            version = 1,
            data = {
                playerTooltip = {
                    enabled = true,
                    [PvPAssistant.CONST.PVP_MODES.TWOS] = true,
                    [PvPAssistant.CONST.PVP_MODES.THREES] = true,
                    [PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE] = true,
                    [PvPAssistant.CONST.PVP_MODES.BATTLEGROUND] = true,
                },
                spellTooltip = {
                    enabled = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA] = true,
                },
            },
        }
    end
end

function PvPAssistant.DB.TOOLTIP_OPTIONS:ClearAll()
    self.PLAYER_TOOLTIP:ClearAll()
    self.SPELL_TOOLTIP:ClearAll()
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:ClearAll()
    wipe(PvPAssistantDB.tooltipOptions.data.playerTooltip)
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:ClearAll()
    wipe(PvPAssistantDB.tooltipOptions.data.spellTooltip)
end

---@param mode PvPAssistant.Const.PVPModes
---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
    return PvPAssistantDB.tooltipOptions.data.playerTooltip[mode]
end

---@param mode PvPAssistant.OPTIONS.SPELL_TOOLTIP.KEYS
---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(mode)
    return PvPAssistantDB.tooltipOptions.data.spellTooltip[mode]
end

---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
    return PvPAssistantDB.tooltipOptions.data.playerTooltip.enabled == nil or
        PvPAssistantDB.tooltipOptions.data.playerTooltip.enabled
end

---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
    return PvPAssistantDB.tooltipOptions.data.spellTooltip.enabled == nil or
        PvPAssistantDB.tooltipOptions.data.spellTooltip.enabled
end

function PvPAssistant.DB.TOOLTIP_OPTIONS:Migrate()
    self.PLAYER_TOOLTIP:Migrate()
    self.SPELL_TOOLTIP:Migrate()
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Migrate() end

function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Migrate() end
