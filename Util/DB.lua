---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistantDB.Database
---@field version number
---@field data table

---@class PvPAssistant.DB
PvPAssistant.DB = {}

---@class PvPAssistant.DB.MATCH_HISTORY
PvPAssistant.DB.MATCH_HISTORY = {}

---@class PvPAssistant.DB.DEBUG
PvPAssistant.DB.DEBUG = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS
PvPAssistant.DB.TOOLTIP_OPTIONS = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP
PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP
PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@class PvPAssistant.PlayerTooltipData.ModeData
---@field rating number
---@field win number
---@field loss number
---@field exp number

---@class PvPAssistant.PlayerTooltipData
---@field ratingData table<PvPAssistant.Const.PVPModes, PvPAssistant.PlayerTooltipData.ModeData>

---@class PvPAssistant.DB.PLAYER_DATA
PvPAssistant.DB.PLAYER_DATA = {}

---@class PvPAssistantDB
---@field matchHistory PvPAssistantDB.Database
---@field playerData PvPAssistantDB.Database
---@field debugData PvPAssistantDB.Database
---@field tooltipOptions PvPAssistantDB.Database
PvPAssistantDB = PvPAssistantDB or {}

function PvPAssistant.DB:Init()
    if not PvPAssistantDB.matchHistory then
        PvPAssistantDB.matchHistory = {
            version = 2,
            ---@type table<PlayerUID, PvPAssistant.MatchHistory.Serialized[]>
            data = {}
        }
    end

    if not PvPAssistantDB.playerData then
        PvPAssistantDB.playerData = {
            version = 1,
            ---@type table<PlayerUID, table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>>
            data = {}
        }
    end

    if not PvPAssistantDB.debugData then
        PvPAssistantDB.debugData = {
            version = 1,
            ---@type any
            data = {}
        }
    end

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


    PvPAssistant.DB:HandleMigrations()
end

function PvPAssistant.DB:HandleMigrations()
    self.MATCH_HISTORY:HandleMigrations()
end

function PvPAssistant.DB.MATCH_HISTORY:HandleMigrations()
    -- sub 1 -> 2 Just wipe
    if PvPAssistantDB.matchHistory.version <= 1 then
        self:Clear()
        PvPAssistantDB.matchHistory.version = 2
    end
end

---@param playerUID PlayerUID
---@return PvPAssistant.MatchHistory.Serialized[]
function PvPAssistant.DB.MATCH_HISTORY:Get(playerUID)
    PvPAssistantDB.matchHistory.data[playerUID] = PvPAssistantDB.matchHistory.data[playerUID] or {}
    return PvPAssistantDB.matchHistory.data[playerUID]
end

---@param matchHistory PvPAssistant.MatchHistory
---@param playerUID PlayerUID?
function PvPAssistant.DB.MATCH_HISTORY:Save(matchHistory, playerUID)
    playerUID = playerUID or PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    PvPAssistantDB.matchHistory.data[playerUID] = PvPAssistantDB.matchHistory.data[playerUID] or {}
    tinsert(PvPAssistantDB.matchHistory.data[playerUID], matchHistory:Serialize())
end

function PvPAssistant.DB.MATCH_HISTORY:Clear()
    wipe(PvPAssistantDB.matchHistory.data)
end

---@param playerUID PlayerUID
---@return table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>?
function PvPAssistant.DB.PLAYER_DATA:Get(playerUID)
    return PvPAssistantDB.playerData.data[playerUID]
end

---@param playerUID PlayerUID
---@param playerPvPData table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>
function PvPAssistant.DB.PLAYER_DATA:Save(playerUID, playerPvPData)
    PvPAssistantDB.playerData.data[playerUID] = playerPvPData
end

function PvPAssistant.DB.PLAYER_DATA:Clear()
    wipe(PvPAssistantDB.playerData.data)
end

---@param data table
function PvPAssistant.DB.DEBUG:Add(data)
    tinsert(PvPAssistantDB.debugData.data, data)
end

---@return table[]
function PvPAssistant.DB.DEBUG:Get()
    return PvPAssistantDB.debugData.data
end

function PvPAssistant.DB.TOOLTIP_OPTIONS:Clear()
    wipe(PvPAssistantDB.tooltipOptions.data.playerTooltip)
    wipe(PvPAssistantDB.tooltipOptions.data.spellTooltip)
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Clear()
    wipe(PvPAssistantDB.tooltipOptions.data.playerTooltip)
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Clear()
    wipe(PvPAssistantDB.tooltipOptions.data.spellTooltip)
end

---@param mode PvPAssistant.Const.PVPModes
---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
    return PvPAssistantDB.tooltipOptions.data.playerTooltip[mode]
end

---@param mode
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
