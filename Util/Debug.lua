---@class PvpAssistant
local PvpAssistant = select(2, ...)

local f = PvpAssistant.GUTIL:GetFormatter()

---@class PvpAssistant.DEBUG
PvpAssistant.DEBUG = {}

PvpAssistantDEBUG = PvpAssistant.DEBUG

local DevTool = DevTool

function PvpAssistant.DEBUG:CreateHistoryDummyData()
    wipe(PvpAssistantHistoryDB)
    --- 2v2s
    for _ = 1, 150 do
        local matchHistory = PvpAssistant.MatchHistory()
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
        matchHistory.pvpMode = PvpAssistant.CONST.PVP_MODES.TWOS
        matchHistory.win = true
        matchHistory.season = GetCurrentArenaSeason() or 0
        table.insert(PvpAssistantHistoryDB, matchHistory)
    end
    --- 3v3s
    for _ = 1, 150 do
        local matchHistory = PvpAssistant.MatchHistory()
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
        matchHistory.pvpMode = PvpAssistant.CONST.PVP_MODES.THREES
        matchHistory.win = false
        matchHistory.season = GetCurrentArenaSeason() or 0
        table.insert(PvpAssistantHistoryDB, matchHistory)
    end
end

function PvpAssistant.DEBUG:CreatePlayerDummyData()
    PvpAssistant.DB.PLAYER_DATA:Clear()

    local playerUID = PvpAssistant.UTIL:GetPlayerUIDByUnit("player")

    ---@type PvpAssistant.PlayerTooltipData
    local playerTooltipData = {
        ratingData = {
            [PvpAssistant.CONST.PVP_MODES.TWOS] = {
                rating = 2168,
                win = 190,
                loss = 95,
                exp = 2657,
            },
            [PvpAssistant.CONST.PVP_MODES.THREES] = {
                rating = 2568,
                win = 601,
                loss = 95,
                exp = 2895,
            },
            [PvpAssistant.CONST.PVP_MODES.BATTLEGROUND] = {
                rating = 2168,
                win = 69,
                loss = 16,
                exp = 3145,
            },
            [PvpAssistant.CONST.PVP_MODES.SOLO_SHUFFLE] = {
                rating = 2168,
                win = 567,
                loss = 109,
                exp = 2345,
            },
        },
    }
    PvpAssistant.DB.PLAYER_DATA:Save(playerUID, playerTooltipData)
end

---@return PvpAssistant
function PvpAssistant.DEBUG:RUN()
    return PvpAssistant
end

---@param t table
---@param label string?
function PvpAssistant.DEBUG:DebugTable(t, label)
    if DevTool and PvpAssistantOptions.enableDebug then
        DevTool:AddData(t, label)
    end
end

function PvpAssistant.DEBUG:RetrieveMatchData()
    local matchHistory = PvpAssistant.MatchHistory:CreateFromEndScreen()
end

function PvpAssistant.DEBUG:GetSpecializationIDByUnit(unit)
    return PvpAssistant.UTIL:GetSpecializationIDByUnit(unit)
end

function PvpAssistant.DEBUG:InspectSpecLookup()
    self:DebugTable(PvpAssistant.SPEC_LOOKUP.lookupTable, "SpecLookup")
end

function PvpAssistant.DEBUG:UpdateAndInspectArenaSpecs()
    PvpAssistant.ARENA_GUIDE:UpdateArenaSpecIDs()
    self:DebugTable(PvpAssistant.ARENA_GUIDE.specIDs, "ManualDebugSpecIDs")
end

function PvpAssistant.DEBUG:GetDebugPrint()
    return function(text)
        if PvpAssistantOptions.enableDebug then
            print(f.l("AL Debug: ") .. tostring(text))
        end
    end
end
