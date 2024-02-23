---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL

---@class InstanceInfo
---@field name string
---@field instanceType string
---@field difficultyID number
---@field difficultyName string
---@field maxPlayers number
---@field dynamicDifficulty number
---@field isDynamic boolean
---@field instanceID number
---@field instanceGroupSize number
---@field LfgDungeonID number

---@class BattlefieldScore
---@field name string
---@field killingBlows number
---@field honorableKills number
---@field deaths number
---@field honorGained number
---@field faction number
---@field race string
---@field class string
---@field classToken string ClassFile ?
---@field damageDone number
---@field healingDone number
---@field bgRating number
---@field ratingChange number
---@field preMatchMMR number
---@field mmrChange number
---@field talentSpec string

---@class PvPLookup.Player
---@field name string
---@field realm string
---@field class string
---@field specID number
---@field scoreData BattlefieldScore

---@class PvPLookup.Team
---@field name? string
---@field players PvPLookup.Player[]
---@field damage number
---@field healing number
---@field kills number
---@field ratingInfo PVPTeamInfo

---@class PvPLookup.MatchHistory
---@overload fun(): PvPLookup.MatchHistory
PvPLookup.MatchHistory = PvPLookup.Object:extend()

function PvPLookup.MatchHistory:new()
    ---@type number
    self.timestamp = nil
    ---@type InstanceInfo
    self.mapInfo = nil
    ---@type boolean
    self.isArena = false
    ---@type boolean
    self.isBattleground = false
    ---@type PvPLookup.Team
    self.playerTeam = nil
    ---@type PvPLookup.Team
    self.enemyTeam = nil
    ---@type number
    self.duration = nil
    ---@type boolean
    self.isRated = false
    ---@type PvPLookup.Const.PVPModes
    self.pvpMode = nil
    ---@type boolean
    self.win = nil
    ---@type number
    self.season = nil
    ---@type PvPLookup.Player
    self.player = nil
end

--- STATIC create a match history instance based on current match ending screen
---@return PvPLookup.MatchHistory?
function PvPLookup.MatchHistory:CreateFromEndScreen()
    -- force showing all players
    SetBattlefieldScoreFaction(-1)

    -- for comparison
    local playerName, _ = UnitName("player")
    local playerRealm = GetRealmName()
    local enemySpecIDs = {}
    local partySpecIDs = {}

    local numPlayers = GetNumBattlefieldScores()

    ---@type BattlefieldScore[]
    local battlefieldScores = {}
    for playerIndex = 1, numPlayers do
        local bfScore = { GetBattlefieldScore(playerIndex) }
        ---@type BattlefieldScore
        local score = {
            name = bfScore[1],
            killingBlows = bfScore[2],
            honorableKills = bfScore[3],
            deaths = bfScore[4],
            honorGained = bfScore[5],
            faction = bfScore[6],
            race = bfScore[7],
            class = bfScore[8],
            classToken = bfScore[9],
            damageDone = bfScore[10],
            healingDone = bfScore[11],
            bgRating = bfScore[12],
            ratingChange = bfScore[13],
            preMatchMMR = bfScore[14],
            mmrChange = bfScore[15],
            talentSpec = bfScore[16],
        }
        table.insert(battlefieldScores, score)
    end

    -- DEBUG START

    local playerSpecializationID = GetSpecialization()
    local apiData = {
        GetNumArenaOpponentSpecs = GetNumArenaOpponentSpecs() or "nil",
        GetBattlefieldScore = battlefieldScores,
        IsRatedArena = C_PvP.IsRatedArena(),
        IsMatchConsideredArena = C_PvP.IsMatchConsideredArena(),
        enemySpecIDs = enemySpecIDs,
        partySpecIDs = partySpecIDs,
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

    PvPLookup.DEBUG:DebugTable(apiData, "GatheredAPIData " .. (GetTimePreciseSec() * 1000))

    table.insert(PvPLookupDebugDB, apiData)

    -- DEBUG END

    local playerTeam = GetBattlefieldArenaFaction()

    if not playerTeam then
        error("PvPLookup: Could not fetch player team")
        return
    end

    local enemyTeam = (playerTeam == 0 and 1) or 0


    local playerTeamRatingInfo = C_PvP.GetTeamInfo(playerTeam)
    local enemyTeamRatingInfo = C_PvP.GetTeamInfo(enemyTeam)

    if not playerTeamRatingInfo or not enemyTeamRatingInfo then
        error("PvPLookup: Could not parse team infos")
        return
    end

    local isRated = playerTeamRatingInfo.ratingNew > 0 or enemyTeamRatingInfo.ratingNew > 0

    ---@type PvPLookup.Player[]
    local playerTeam = {}
    local enemyTeam = {}
    local player = nil
    for _, battlefieldScore in ipairs(battlefieldScores) do
        local name, realm = strsplit("-", battlefieldScore.name)
        realm = realm or playerRealm

        local specDescriptor = battlefieldScore.talentSpec .. " " .. battlefieldScore.class
        ---@type PvPLookup.Player
        local arenaPlayer = {
            name = name,
            realm = realm,
            class = battlefieldScore.classToken,
            specID = PvPLookup.SPEC_LOOKUP:LookUp(specDescriptor),
            scoreData = battlefieldScore,
        }
        if battlefieldScore.faction == playerTeam then
            tinsert(playerTeam, arenaPlayer)

            if arenaPlayer.name == playerName and arenaPlayer.realm == playerRealm then
                player = arenaPlayer
            end
        else
            tinsert(enemyTeam, arenaPlayer)
        end
    end

    ---@type PvPLookup.Team
    local playerTeam = {
        players = playerTeam,
        damage = GUTIL:Fold(playerTeam, 0, function(tD, p)
            return tD + (p.scoreData.damageDone or 0)
        end),
        healing = GUTIL:Fold(playerTeam, 0, function(tD, p)
            return tD + (p.scoreData.healingDone or 0)
        end),
        kills = GUTIL:Fold(playerTeam, 0, function(tD, p)
            return tD + (p.scoreData.killingBlows or 0)
        end),
        ratingInfo = playerTeamRatingInfo,
    }

    ---@type PvPLookup.Team
    local enemyTeam = {
        players = enemyTeam,
        damage = GUTIL:Fold(enemyTeam, 0, function(tD, p)
            return tD + (p.scoreData.damageDone or 0)
        end),
        healing = GUTIL:Fold(enemyTeam, 0, function(tD, p)
            return tD + (p.scoreData.healingDone or 0)
        end),
        kills = GUTIL:Fold(enemyTeam, 0, function(tD, p)
            return tD + (p.scoreData.killingBlows or 0)
        end),
        ratingInfo = enemyTeamRatingInfo,
    }

    local highestTeamSize = GUTIL:Fold(GUTIL:Concat({ playerTeam, enemyTeam }), 0, function(hTS, team)
        if hTS < team.ratingInfo.size then
            return team.ratingInfo.size
        else
            return hTS
        end
    end)

    local instanceInfo = { GetInstanceInfo() }

    local matchHistory = PvPLookup.MatchHistory()
    matchHistory.duration = C_PvP.GetActiveMatchDuration() * 1000 -- seconds -> ms
    matchHistory.isArena = C_PvP.IsArena()
    matchHistory.isBattleground = C_PvP.IsBattleground()
    matchHistory.isRated = isRated
    matchHistory.isSoloShuffle = C_PvP.IsSoloShuffle()
    matchHistory.enemyTeam = enemyTeam
    matchHistory.playerTeam = playerTeam
    matchHistory.win = C_PvP.GetActiveMatchWinner() == playerTeam
    matchHistory.season = GetCurrentArenaSeason() or 0
    matchHistory.mapInfo = {
        name = instanceInfo[1],
        instanceType = instanceInfo[2],
        difficultyID = instanceInfo[3],
        difficultyName = instanceInfo[4],
        maxPlayers = instanceInfo[5],
        dynamicDifficulty = instanceInfo[6],
        isDynamic = instanceInfo[7],
        instanceID = instanceInfo[8],
        instanceGroupSize = instanceInfo[9],
        LfgDungeonID = instanceInfo[10],
    }
    matchHistory.pvpMode = (matchHistory.isBattleground and PvPLookup.CONST.PVP_MODES.BATTLEGROUND) or
        (matchHistory.isSoloShuffle and PvPLookup.CONST.PVP_MODES.SOLO) or
        (matchHistory.isArena and highestTeamSize <= 2 and PvPLookup.CONST.PVP_MODES.TWOS) or
        (matchHistory.isArena and highestTeamSize <= 3 and PvPLookup.CONST.PVP_MODES.THREES)
    matchHistory.player = player
    matchHistory.timestamp = (C_DateAndTime.GetServerTimeLocal() * 1000) - matchHistory.duration

    return matchHistory
end
