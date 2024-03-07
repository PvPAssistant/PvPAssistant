---@class Arenalogs
local Arenalogs = select(2, ...)

---@class ArenalogsDB.Database
---@field version number
---@field data table

---@class Arenalogs.DB
Arenalogs.DB = {}

---@class Arenalogs.DB.MATCH_HISTORY
Arenalogs.DB.MATCH_HISTORY = {}

---@class Arenalogs.DB.DEBUG
Arenalogs.DB.DEBUG = {}

---@class Arenalogs.DB.TOOLTIP_OPTIONS
Arenalogs.DB.TOOLTIP_OPTIONS = {}

---@class Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP
Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP = {}

---@class Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP
Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@class Arenalogs.PlayerTooltipData.ModeData
---@field rating number
---@field win number
---@field loss number
---@field exp number

---@class Arenalogs.PlayerTooltipData
---@field ratingData table<Arenalogs.Const.PVPModes, Arenalogs.PlayerTooltipData.ModeData>

---@class Arenalogs.DB.PLAYER_DATA
Arenalogs.DB.PLAYER_DATA = {}

---@class ArenalogsDB
---@field matchHistory ArenalogsDB.Database
---@field playerData ArenalogsDB.Database
---@field debugData ArenalogsDB.Database
---@field tooltipOptions ArenalogsDB.Database
ArenalogsDB = ArenalogsDB or {}

function Arenalogs.DB:Init()
    if not ArenalogsDB.matchHistory then
        ArenalogsDB.matchHistory = {
            version = 2,
            ---@type table<PlayerUID, Arenalogs.MatchHistory.Serialized[]>
            data = {}
        }
    end

    if not ArenalogsDB.playerData then
        ArenalogsDB.playerData = {
            version = 1,
            ---@type table<PlayerUID, table<Arenalogs.Const.PVPModes, InspectArenaData | InspectPVPData>>
            data = {}
        }
    end

    if not ArenalogsDB.debugData then
        ArenalogsDB.debugData = {
            version = 1,
            ---@type any
            data = {}
        }
    end

    if not ArenalogsDB.tooltipOptions then
        ArenalogsDB.tooltipOptions = {
            version = 1,
            data = {
                playerTooltip = {
                    enabled = true,
                    [Arenalogs.CONST.PVP_MODES.TWOS] = true,
                    [Arenalogs.CONST.PVP_MODES.THREES] = true,
                    [Arenalogs.CONST.PVP_MODES.SOLO_SHUFFLE] = true,
                    [Arenalogs.CONST.PVP_MODES.BATTLEGROUND] = true,
                },
                spellTooltip = {
                    enabled = true,
                    [Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.TYPE] = true,
                    [Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE] = true,
                    [Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY] = true,
                    [Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION] = true,
                    [Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA] = true,
                },
            },
        }
    end


    Arenalogs.DB:HandleMigrations()
end

function Arenalogs.DB:HandleMigrations()
    self.MATCH_HISTORY:HandleMigrations()
end

function Arenalogs.DB.MATCH_HISTORY:HandleMigrations()
    -- sub 1 -> 2 Just wipe
    if ArenalogsDB.matchHistory.version <= 1 then
        self:Clear()
        ArenalogsDB.matchHistory.version = 2
    end
end

---@param playerUID PlayerUID
---@return Arenalogs.MatchHistory.Serialized[]
function Arenalogs.DB.MATCH_HISTORY:Get(playerUID)
    ArenalogsDB.matchHistory.data[playerUID] = ArenalogsDB.matchHistory.data[playerUID] or {}
    return ArenalogsDB.matchHistory.data[playerUID]
end

---@param matchHistory Arenalogs.MatchHistory
---@param playerUID PlayerUID?
function Arenalogs.DB.MATCH_HISTORY:Save(matchHistory, playerUID)
    playerUID = playerUID or Arenalogs.UTIL:GetPlayerUIDByUnit("player")
    ArenalogsDB.matchHistory.data[playerUID] = ArenalogsDB.matchHistory.data[playerUID] or {}
    tinsert(ArenalogsDB.matchHistory.data[playerUID], matchHistory:Serialize())
end

function Arenalogs.DB.MATCH_HISTORY:Clear()
    wipe(ArenalogsDB.matchHistory.data)
end

---@param playerUID PlayerUID
---@return table<Arenalogs.Const.PVPModes, InspectArenaData | InspectPVPData>?
function Arenalogs.DB.PLAYER_DATA:Get(playerUID)
    return ArenalogsDB.playerData.data[playerUID]
end

---@param playerUID PlayerUID
---@param playerPvPData table<Arenalogs.Const.PVPModes, InspectArenaData | InspectPVPData>
function Arenalogs.DB.PLAYER_DATA:Save(playerUID, playerPvPData)
    ArenalogsDB.playerData.data[playerUID] = playerPvPData
end

function Arenalogs.DB.PLAYER_DATA:Clear()
    wipe(ArenalogsDB.playerData.data)
end

---@param data table
function Arenalogs.DB.DEBUG:Add(data)
    tinsert(ArenalogsDB.debugData.data, data)
end

---@return table[]
function Arenalogs.DB.DEBUG:Get()
    return ArenalogsDB.debugData.data
end

function Arenalogs.DB.TOOLTIP_OPTIONS:Clear()
    wipe(ArenalogsDB.tooltipOptions.data.playerTooltip)
    wipe(ArenalogsDB.tooltipOptions.data.spellTooltip)
end

function Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Clear()
    wipe(ArenalogsDB.tooltipOptions.data.playerTooltip)
end

function Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Clear()
    wipe(ArenalogsDB.tooltipOptions.data.spellTooltip)
end

---@param mode Arenalogs.Const.PVPModes
---@return boolean enabled
function Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
    return ArenalogsDB.tooltipOptions.data.playerTooltip[mode]
end

---@param mode
---@return boolean enabled
function Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(mode)
    return ArenalogsDB.tooltipOptions.data.spellTooltip[mode]
end

---@return boolean enabled
function Arenalogs.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
    return ArenalogsDB.tooltipOptions.data.playerTooltip.enabled == nil or
        ArenalogsDB.tooltipOptions.data.playerTooltip.enabled
end

---@return boolean enabled
function Arenalogs.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
    return ArenalogsDB.tooltipOptions.data.spellTooltip.enabled == nil or
        ArenalogsDB.tooltipOptions.data.spellTooltip.enabled
end
