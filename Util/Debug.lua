---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.DEBUG
PvPLookup.DEBUG = {}

PvPLookupDEBUG = PvPLookup.DEBUG

PvPLookupDebugDB = PvPLookupDebugDB or {}

local DevTool = DevTool

function PvPLookup.DEBUG:CreateHistoryDummyData()
    wipe(PvPLookupHistoryDB)
    --- 2v2s
    for _ = 1, 150 do
        local matchHistory = PvPLookup.MatchHistory()
        matchHistory.timestamp = GetServerTime()
        matchHistory.map = "TTP"
        matchHistory.playerTeam = {
            players = {
                {
                    class = "WARRIOR",
                    spec = "FURY",
                    name = "Player1",
                    server = GetRealmName(),
                },
                {
                    class = "ROGUE",
                    spec = "SUBTLETY",
                    name = "Player2",
                    server = GetRealmName(),
                },
            }
        }
        matchHistory.enemyTeam = {
            players = {
                {
                    class = "MAGE",
                    spec = "FROST_MAGE",
                    name = "Enemy1",
                    server = GetRealmName(),
                },
                {
                    class = "DEMONHUNTER",
                    spec = "HAVOC",
                    name = "Enemy2",
                    server = GetRealmName(),
                },
            }
        }
        matchHistory.playerMMR = 1134
        matchHistory.enemyMMR = 1133
        matchHistory.duration = 200000
        matchHistory.playerDamage = 4000000
        matchHistory.enemyDamage = 3000000
        matchHistory.playerHealing = 2000000
        matchHistory.enemyHealing = 100000
        matchHistory.isRated = true
        matchHistory.isArena = true
        matchHistory.rating = 1478
        matchHistory.ratingChange = 17
        matchHistory.pvpMode = PvPLookup.CONST.PVP_MODES.TWOS
        matchHistory.win = true
        matchHistory.season = GetCurrentArenaSeason() or 0
        table.insert(PvPLookupHistoryDB, matchHistory)
    end
    --- 3v3s
    for _ = 1, 150 do
        local matchHistory = PvPLookup.MatchHistory()
        matchHistory.timestamp = GetServerTime()
        matchHistory.map = "RoL"
        matchHistory.playerTeam = {
            players = {
                {
                    class = "WARRIOR",
                    spec = "FURY",
                    name = "Player1",
                    server = GetRealmName(),
                },
                {
                    class = "WARLOCK",
                    spec = "DESTRUCTION",
                    name = "Player2",
                    server = GetRealmName(),
                },
                {
                    class = "ROGUE",
                    spec = "SUBTLETY",
                    name = "Player3",
                    server = GetRealmName(),
                },
            }
        }
        matchHistory.enemyTeam = {
            players = {
                {
                    class = "MAGE",
                    spec = "FROST_MAGE",
                    name = "Enemy1",
                    server = GetRealmName(),
                },
                {
                    class = "PALADIN",
                    spec = "HOLY",
                    name = "Enemy2",
                    server = GetRealmName(),
                },
                {
                    class = "DEMONHUNTER",
                    spec = "HAVOC",
                    name = "Enemy3",
                    server = GetRealmName(),
                },
            }
        }
        matchHistory.playerMMR = 1234
        matchHistory.enemyMMR = 1233
        matchHistory.duration = 200000
        matchHistory.playerDamage = 4000000
        matchHistory.enemyDamage = 3000000
        matchHistory.playerHealing = 2000000
        matchHistory.enemyHealing = 100000
        matchHistory.isRated = true
        matchHistory.isArena = true
        matchHistory.rating = 1478
        matchHistory.ratingChange = -17
        matchHistory.pvpMode = PvPLookup.CONST.PVP_MODES.THREES
        matchHistory.win = false
        matchHistory.season = GetCurrentArenaSeason() or 0
        table.insert(PvPLookupHistoryDB, matchHistory)
    end
end

function PvPLookup.DEBUG:CreatePlayerDummyData()
    PvPLookup.DB.PLAYER_DATA:Clear()

    local playerUID = PvPLookup.UTIL:GetPlayerUIDByUnit("player")

    ---@type PvPLookup.PlayerTooltipData
    local playerTooltipData = {
        ratingData = {
            [PvPLookup.CONST.PVP_MODES.TWOS] = {
                rating = 2168,
                win = 190,
                loss = 95,
                exp = 2657,
            },
            [PvPLookup.CONST.PVP_MODES.THREES] = {
                rating = 2568,
                win = 601,
                loss = 95,
                exp = 2895,
            },
            [PvPLookup.CONST.PVP_MODES.BATTLEGROUND] = {
                rating = 2168,
                win = 69,
                loss = 16,
                exp = 3145,
            },
            [PvPLookup.CONST.PVP_MODES.SOLO_SHUFFLE] = {
                rating = 2168,
                win = 567,
                loss = 109,
                exp = 2345,
            },
        },
    }
    PvPLookup.DB.PLAYER_DATA:Save(playerUID, playerTooltipData)
end

---@return PvPLookup
function PvPLookup.DEBUG:RUN()
    return PvPLookup
end

---@param t table
---@param label string?
function PvPLookup.DEBUG:DebugTable(t, label)
    if DevTool then
        DevTool:AddData(t, label)
    end
end

function PvPLookup.DEBUG:RetrieveMatchData()
    local matchHistory = PvPLookup.MatchHistory:CreateFromEndScreen()
end

function PvPLookup.DEBUG:GetSpecializationIDByUnit(unit)
    return PvPLookup.UTIL:GetSpecializationIDByUnit(unit)
end

function PvPLookup.DEBUG:InspectSpecLookup()
    self:DebugTable(PvPLookup.SPEC_LOOKUP.lookupTable, "SpecLookup")
end

function PvPLookup.DEBUG:UpdateAndInspectArenaSpecs()
    PvPLookup.ARENA_GUIDE:UpdateArenaSpecIDs()
    self:DebugTable(PvPLookup.ARENA_GUIDE.specIDs, "ManualDebugSpecIDs")
end
