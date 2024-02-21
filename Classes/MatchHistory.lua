---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.Player
---@field class string
---@field spec string
---@field name string
---@field server string

---@class PvPLookup.Team
---@field players PvPLookup.Player[]

---@class PvPLookup.MatchHistory
---@overload fun(): PvPLookup.MatchHistory
PvPLookup.MatchHistory = PvPLookup.Object:extend()

function PvPLookup.MatchHistory:new()
    ---@type number
    self.timestamp = nil
    ---@type string
    self.map = nil
    ---@type boolean
    self.isArena = false
    ---@type boolean
    self.isBattleground = false
    ---@type PvPLookup.Team
    self.playerTeam = nil
    ---@type PvPLookup.Team
    self.enemyTeam = nil
    ---@type number
    self.playerMMR = nil
    ---@type number
    self.enemyMMR = nil
    ---@type number
    self.duration = nil
    ---@type number
    self.playerDamage = nil
    ---@type number
    self.enemyDamage = nil
    ---@type number
    self.playerHealing = nil
    ---@type number
    self.enemyHealing = nil
    ---@type boolean
    self.isRated = false
    ---@type number
    self.rating = nil
    ---@type number
    self.ratingChange = nil
    ---@type PvPLookup.Const.PVPModes
    self.pvpMode = nil
    ---@type boolean
    self.win = nil
    ---@type number
    self.season = nil
end

--- STATIC create a match history instance based on current match ending screen
---@return PvPLookup.MatchHistory?
function PvPLookup.MatchHistory:CreateFromEndScreen()
    -- force showing all players
    SetBattlefieldScoreFaction(-1)

    local arenaOpponentSpecIDs = {}
    for opponentID = 1, GetNumArenaOpponentSpecs() do
        arenaOpponentSpecIDs[opponentID] = GetArenaOpponentSpec(opponentID)
    end

    local numPlayers = GetNumBattlefieldScores()

    local playerData = {}
    for playerIndex = 1, numPlayers do
        table.insert(playerData, GetBattlefieldScore(playerIndex))
    end

    local playerSpecializationID = GetSpecialization()
    local apiData = {
        playerData = playerData,
        IsRatedArena = C_PvP.IsRatedArena(),
        IsMatchConsideredArena = C_PvP.IsMatchConsideredArena(),
        arenaOpponentSpecIDs = arenaOpponentSpecIDs,
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



    PvPLookup.DEBUG:DebugTable(apiData, "GatheredAPIData " .. GetTimePreciseSec() * 1000)

    table.insert(PvPLookupDebugDB, apiData)
end
