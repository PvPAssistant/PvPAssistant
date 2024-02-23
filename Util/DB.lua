---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookupDB.Database
---@field version number
---@field data table

---@class PvPLookup.DB
PvPLookup.DB = {}

---@class PvPLookup.DB.MATCH_HISTORY
PvPLookup.DB.MATCH_HISTORY = {}

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
PvPLookupDB = PvPLookupDB or {}

function PvPLookup.DB:Init()
    if not PvPLookupDB.matchHistory then
        PvPLookupDB.matchHistory = {
            version = 1,
            ---@type PvPLookup.MatchHistory[]
            data = {}
        }
    end

    if not PvPLookupDB.playerData then
        PvPLookupDB.playerData = {
            version = 1,
            ---@type table<PlayerUID, PvPLookup.PlayerTooltipData>
            data = {}
        }
    end


    PvPLookup.DB:HandleMigrations()
end

function PvPLookup.DB:HandleMigrations()

end

function PvPLookup.DB.MATCH_HISTORY:Get()
    return PvPLookupDB.matchHistory.data
end

---@param matchHistory PvPLookup.MatchHistory
function PvPLookup.DB.MATCH_HISTORY:Save(matchHistory)
    tinsert(PvPLookupDB.matchHistory.data, matchHistory)
end

function PvPLookup.DB.MATCH_HISTORY:Clear()
    wipe(PvPLookupDB.matchHistory.data)
end

---@param playerUID PlayerUID
function PvPLookup.DB.PLAYER_DATA:Get(playerUID)
    PvPLookupDB.playerData.data[playerUID] = PvPLookupDB.playerData.data[playerUID] or {}
    PvPLookupDB.playerData.data[playerUID].ratingData = PvPLookupDB.playerData.data[playerUID].ratingData or {}
    return PvPLookupDB.playerData.data[playerUID]
end

---@param playerUID PlayerUID
---@param playerTooltipData PvPLookup.PlayerTooltipData
function PvPLookup.DB.PLAYER_DATA:Save(playerUID, playerTooltipData)
    PvPLookupDB.playerData.data[playerUID] = playerTooltipData
end

function PvPLookup.DB.PLAYER_DATA:Clear()
    wipe(PvPLookupDB.playerData.data)
end
