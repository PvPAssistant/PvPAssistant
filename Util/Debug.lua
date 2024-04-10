---@class PvPAssistant
local PvPAssistant = select(2, ...)

local f = PvPAssistant.GUTIL:GetFormatter()

---@class PvPAssistant.DEBUG
PvPAssistant.DEBUG = {}

PvPAssistantDEBUG = PvPAssistant.DEBUG

local DevTool = DevTool

---@deprecated
function PvPAssistant.DEBUG:CreateHistoryDummyData()
    wipe(PvPAssistantHistoryDB)
    --- 2v2s
    for _ = 1, 150 do
        local matchHistory = PvPAssistant.MatchHistory()
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
        matchHistory.pvpMode = PvPAssistant.CONST.PVP_MODES.TWOS
        matchHistory.win = true
        matchHistory.season = GetCurrentArenaSeason() or 0
        table.insert(PvPAssistantHistoryDB, matchHistory)
    end
    --- 3v3s
    for _ = 1, 150 do
        local matchHistory = PvPAssistant.MatchHistory()
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
        matchHistory.pvpMode = PvPAssistant.CONST.PVP_MODES.THREES
        matchHistory.win = false
        matchHistory.season = GetCurrentArenaSeason() or 0
        table.insert(PvPAssistantHistoryDB, matchHistory)
    end
end

---@deprecated
function PvPAssistant.DEBUG:CreatePlayerDummyData()
    PvPAssistant.DB.PLAYER_DATA:Clear()

    local playerUID = PvPAssistant.UTIL:GetPlayerUIDByUnit("player")

    ---@type PvPAssistant.PlayerTooltipData
    local playerTooltipData = {
        ratingData = {
            [PvPAssistant.CONST.PVP_MODES.TWOS] = {
                rating = 2168,
                win = 190,
                loss = 95,
                exp = 2657,
            },
            [PvPAssistant.CONST.PVP_MODES.THREES] = {
                rating = 2568,
                win = 601,
                loss = 95,
                exp = 2895,
            },
            [PvPAssistant.CONST.PVP_MODES.BATTLEGROUND] = {
                rating = 2168,
                win = 69,
                loss = 16,
                exp = 3145,
            },
            [PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE] = {
                rating = 2168,
                win = 567,
                loss = 109,
                exp = 2345,
            },
        },
    }
    PvPAssistant.DB.PLAYER_DATA:Save(playerUID, playerTooltipData)
end

---@return PvPAssistant
function PvPAssistant.DEBUG:Get()
    return PvPAssistant
end

---@param t table
---@param label string?
function PvPAssistant.DEBUG:DebugTable(t, label)
    if DevTool and PvPAssistant.DB.GENERAL_OPTIONS:Get("DEBUG") then
        DevTool:AddData(t, label)
    end
end

function PvPAssistant.DEBUG:RetrieveMatchData()
    local matchHistory = PvPAssistant.DATA_COLLECTION:CreateMatchHistoryFromEndScore()
end

function PvPAssistant.DEBUG:GetSpecializationIDByUnit(unit)
    return PvPAssistant.UTIL:GetSpecializationIDByUnit(unit)
end

function PvPAssistant.DEBUG:InspectSpecLookup()
    self:DebugTable(PvPAssistant.SPEC_LOOKUP.lookupTable, "SpecLookup")
end

function PvPAssistant.DEBUG:UpdateAndInspectArenaSpecs()
    PvPAssistant.DATA_COLLECTION:UpdateArenaSpecIDs()
    self:DebugTable(PvPAssistant.DATA_COLLECTION.arenaSpecIDs, "ManualDebugSpecIDs")
end

function PvPAssistant.DEBUG:GetDebugPrint()
    return function(text)
        if PvPAssistant.DB.GENERAL_OPTIONS:Get("DEBUG") then
            print(f.l("AL Debug: ") .. tostring(text))
        end
    end
end

function PvPAssistant.DEBUG:GatherDebugAPIDataFromMatchEnd()
    local playerSpecializationID = GetSpecialization()
    local apiData = {
        GetNumArenaOpponentSpecs = GetNumArenaOpponentSpecs() or "nil",
        IsRatedArena = C_PvP.IsRatedArena(),
        IsMatchConsideredArena = C_PvP.IsMatchConsideredArena(),
        GetBattlefieldArenaFaction = GetBattlefieldArenaFaction() or "nil",
        GetBattlefieldTeamInfo_0 = { GetBattlefieldTeamInfo(0) or "nil" },
        GetBattlefieldTeamInfo_1 = { GetBattlefieldTeamInfo(1) or "nil" },
        GetNumArenaOpponents = GetNumArenaOpponents() or "nil",
        IsSoloShuffle = C_PvP.IsSoloShuffle(),

        CanDisplayDamage = C_PvP.CanDisplayDamage(),
        CanDisplayDeaths = C_PvP.CanDisplayDeaths(),
        CanDisplayHealing = C_PvP.CanDisplayHealing(),
        CanDisplayHonorableKills = C_PvP.CanDisplayHonorableKills(),
        CanDisplayKillingBlows = C_PvP.CanDisplayKillingBlows(),
        CanPlayerUseRatedPVPUI = { C_PvP.CanPlayerUseRatedPVPUI() },
        DoesMatchOutcomeAffectRating = C_PvP.DoesMatchOutcomeAffectRating(),
        GetActiveMatchBracket = C_PvP.GetActiveMatchBracket() or "nil",
        GetActiveMatchDuration = C_PvP.GetActiveMatchDuration() or "nil",
        GetActiveMatchState = C_PvP.GetActiveMatchState() or "nil",
        GetActiveMatchWinner = C_PvP.GetActiveMatchWinner() or "nil",
        GetCustomVictoryStatID = C_PvP.GetCustomVictoryStatID() or "nil",
        GetGlobalPvpScalingInfoForSpecID = C_PvP.GetGlobalPvpScalingInfoForSpecID(playerSpecializationID) or "nil",
        GetMatchPVPStatColumns = C_PvP.GetMatchPVPStatColumns() or "nil",
        GetPVPActiveMatchPersonalRatedInfo = C_PvP.GetPVPActiveMatchPersonalRatedInfo() or "nil",
        GetPVPSeasonRewardAchievementID = C_PvP.GetPVPSeasonRewardAchievementID() or "nil",
        GetScoreInfoByPlayerGuid_Player = C_PvP.GetScoreInfoByPlayerGuid(UnitGUID("player")) or "nil",
        GetSeasonBestInfo = { C_PvP.GetSeasonBestInfo() or "nil" },
        GetTeamInfo_0 = C_PvP.GetTeamInfo(0) or "nil",
        GetTeamInfo_1 = C_PvP.GetTeamInfo(1) or "nil",
        IsActiveMatchRegistered = C_PvP.IsActiveMatchRegistered(),
        IsMatchFactional = C_PvP.IsMatchFactional(),
        IsPVPMap = C_PvP.IsPVPMap(),
        IsRatedMap = C_PvP.IsRatedMap(),
    }

    PvPAssistant.DEBUG:DebugTable(apiData, "GatheredAPIData " .. (GetTimePreciseSec() * 1000))
    PvPAssistant.DB.DEBUG:Save(apiData)
end
