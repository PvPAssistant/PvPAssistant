---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.DB
PvPLookup.DB = {}

---@type table<number, PvPLookup.MatchHistory[]>
PvPLookupHistoryDB = PvPLookupHistoryDB or {}

