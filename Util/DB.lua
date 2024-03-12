---@class PvpAssistant
local PvpAssistant = select(2, ...)

---@class PvpAssistantDB.Database
---@field version number
---@field data table

---@class PvpAssistant.DB
PvpAssistant.DB = {}

---@class PvpAssistant.DB.MATCH_HISTORY
PvpAssistant.DB.MATCH_HISTORY = {}

---@class PvpAssistant.DB.DEBUG
PvpAssistant.DB.DEBUG = {}

---@class PvpAssistant.DB.TOOLTIP_OPTIONS
PvpAssistant.DB.TOOLTIP_OPTIONS = {}

---@class PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP
PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP = {}

---@class PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP
PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@class PvpAssistant.PlayerTooltipData.ModeData
---@field rating number
---@field win number
---@field loss number
---@field exp number

---@class PvpAssistant.PlayerTooltipData
---@field ratingData table<PvpAssistant.Const.PVPModes, PvpAssistant.PlayerTooltipData.ModeData>

---@class PvpAssistant.DB.PLAYER_DATA
PvpAssistant.DB.PLAYER_DATA = {}

---@class PvpAssistantDB
---@field matchHistory PvpAssistantDB.Database
---@field playerData PvpAssistantDB.Database
---@field debugData PvpAssistantDB.Database
---@field tooltipOptions PvpAssistantDB.Database
PvpAssistantDB = PvpAssistantDB or {}

function PvpAssistant.DB:Init()
    if not PvpAssistantDB.matchHistory then
        PvpAssistantDB.matchHistory = {
            version = 2,
            ---@type table<PlayerUID, PvpAssistant.MatchHistory.Serialized[]>
            data = {}
        }
    end

    if not PvpAssistantDB.playerData then
        PvpAssistantDB.playerData = {
            version = 1,
            ---@type table<PlayerUID, table<PvpAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>>
            data = {}
        }
    end

    if not PvpAssistantDB.debugData then
        PvpAssistantDB.debugData = {
            version = 1,
            ---@type any
            data = {}
        }
    end

    if not PvpAssistantDB.tooltipOptions then
        PvpAssistantDB.tooltipOptions = {
            version = 1,
            data = {
                playerTooltip = {
                    enabled = true,
                    [PvpAssistant.CONST.PVP_MODES.TWOS] = true,
                    [PvpAssistant.CONST.PVP_MODES.THREES] = true,
                    [PvpAssistant.CONST.PVP_MODES.SOLO_SHUFFLE] = true,
                    [PvpAssistant.CONST.PVP_MODES.BATTLEGROUND] = true,
                },
                spellTooltip = {
                    enabled = true,
                    [PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE] = true,
                    [PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE] = true,
                    [PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY] = true,
                    [PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION] = true,
                    [PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA] = true,
                },
            },
        }
    end


    PvpAssistant.DB:HandleMigrations()
end

function PvpAssistant.DB:HandleMigrations()
    self.MATCH_HISTORY:HandleMigrations()
end

function PvpAssistant.DB.MATCH_HISTORY:HandleMigrations()
    -- sub 1 -> 2 Just wipe
    if PvpAssistantDB.matchHistory.version <= 1 then
        self:Clear()
        PvpAssistantDB.matchHistory.version = 2
    end
end

---@param playerUID PlayerUID
---@return PvpAssistant.MatchHistory.Serialized[]
function PvpAssistant.DB.MATCH_HISTORY:Get(playerUID)
    PvpAssistantDB.matchHistory.data[playerUID] = PvpAssistantDB.matchHistory.data[playerUID] or {}
    return PvpAssistantDB.matchHistory.data[playerUID]
end

---@param matchHistory PvpAssistant.MatchHistory
---@param playerUID PlayerUID?
function PvpAssistant.DB.MATCH_HISTORY:Save(matchHistory, playerUID)
    playerUID = playerUID or PvpAssistant.UTIL:GetPlayerUIDByUnit("player")
    PvpAssistantDB.matchHistory.data[playerUID] = PvpAssistantDB.matchHistory.data[playerUID] or {}
    tinsert(PvpAssistantDB.matchHistory.data[playerUID], matchHistory:Serialize())
end

function PvpAssistant.DB.MATCH_HISTORY:Clear()
    wipe(PvpAssistantDB.matchHistory.data)
end

---@param playerUID PlayerUID
---@return table<PvpAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>?
function PvpAssistant.DB.PLAYER_DATA:Get(playerUID)
    return PvpAssistantDB.playerData.data[playerUID]
end

---@param playerUID PlayerUID
---@param playerPvPData table<PvpAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>
function PvpAssistant.DB.PLAYER_DATA:Save(playerUID, playerPvPData)
    PvpAssistantDB.playerData.data[playerUID] = playerPvPData
end

function PvpAssistant.DB.PLAYER_DATA:Clear()
    wipe(PvpAssistantDB.playerData.data)
end

---@param data table
function PvpAssistant.DB.DEBUG:Add(data)
    tinsert(PvpAssistantDB.debugData.data, data)
end

---@return table[]
function PvpAssistant.DB.DEBUG:Get()
    return PvpAssistantDB.debugData.data
end

function PvpAssistant.DB.TOOLTIP_OPTIONS:Clear()
    wipe(PvpAssistantDB.tooltipOptions.data.playerTooltip)
    wipe(PvpAssistantDB.tooltipOptions.data.spellTooltip)
end

function PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Clear()
    wipe(PvpAssistantDB.tooltipOptions.data.playerTooltip)
end

function PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Clear()
    wipe(PvpAssistantDB.tooltipOptions.data.spellTooltip)
end

---@param mode PvpAssistant.Const.PVPModes
---@return boolean enabled
function PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
    return PvpAssistantDB.tooltipOptions.data.playerTooltip[mode]
end

---@param mode
---@return boolean enabled
function PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(mode)
    return PvpAssistantDB.tooltipOptions.data.spellTooltip[mode]
end

---@return boolean enabled
function PvpAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
    return PvpAssistantDB.tooltipOptions.data.playerTooltip.enabled == nil or
        PvpAssistantDB.tooltipOptions.data.playerTooltip.enabled
end

---@return boolean enabled
function PvpAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
    return PvpAssistantDB.tooltipOptions.data.spellTooltip.enabled == nil or
        PvpAssistantDB.tooltipOptions.data.spellTooltip.enabled
end
