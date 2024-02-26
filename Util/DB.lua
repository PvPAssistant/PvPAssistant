---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookupDB.Database
---@field version number
---@field data table

---@class PvPLookup.DB
PvPLookup.DB = {}

---@class PvPLookup.DB.MATCH_HISTORY
PvPLookup.DB.MATCH_HISTORY = {}

---@class PvPLookup.DB.DEBUG
PvPLookup.DB.DEBUG = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@class PvPLookup.PlayerTooltipData.ModeData
---@field rating number
---@field win number
---@field loss number
---@field exp number

---@class PvPLookup.PlayerTooltipData
---@field ratingData table<PvPLookup.Const.PVPModes, PvPLookup.PlayerTooltipData.ModeData>

---@class PvPLookup.DB.PLAYER_DATA
PvPLookup.DB.PLAYER_DATA = {}

---@class PvPLookupDB
---@field matchHistory PvPLookupDB.Database
---@field playerData PvPLookupDB.Database
---@field debugData PvPLookupDB.Database
PvPLookupDB = PvPLookupDB or {}

function PvPLookup.DB:Init()
    if not PvPLookupDB.matchHistory then
        PvPLookupDB.matchHistory = {
            version = 1,
            ---@type PvPLookup.MatchHistory.Serialized[]
            data = {}
        }
    end

    if not PvPLookupDB.playerData then
        PvPLookupDB.playerData = {
            version = 1,
            ---@type table<PlayerUID, table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>>
            data = {}
        }
    end

    if not PvPLookupDB.debugData then
        PvPLookupDB.debugData = {
            version = 1,
            ---@type any
            data = {}
        }
    end


    PvPLookup.DB:HandleMigrations()
end

function PvPLookup.DB:HandleMigrations()

end

---@return PvPLookup.MatchHistory.Serialized[]
function PvPLookup.DB.MATCH_HISTORY:Get()
    return PvPLookupDB.matchHistory.data
end

---@param matchHistory PvPLookup.MatchHistory
function PvPLookup.DB.MATCH_HISTORY:Save(matchHistory)
    tinsert(PvPLookupDB.matchHistory.data, matchHistory:Serialize())
end

function PvPLookup.DB.MATCH_HISTORY:Clear()
    wipe(PvPLookupDB.matchHistory.data)
end

---@param playerUID PlayerUID
---@return table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>?
function PvPLookup.DB.PLAYER_DATA:Get(playerUID)
    return PvPLookupDB.playerData.data[playerUID]
end

---@param playerUID PlayerUID
---@param playerPvPData table<PvPLookup.Const.PVPModes, InspectArenaData | InspectPVPData>
function PvPLookup.DB.PLAYER_DATA:Save(playerUID, playerPvPData)
    PvPLookupDB.playerData.data[playerUID] = playerPvPData
end

function PvPLookup.DB.PLAYER_DATA:Clear()
    wipe(PvPLookupDB.playerData.data)
end

---@param data table
function PvPLookup.DB.DEBUG:Add(data)
    tinsert(PvPLookupDB.debugData.data, data)
end

---@return table[]
function PvPLookup.DB.DEBUG:Get()
    return PvPLookupDB.debugData.data
end
