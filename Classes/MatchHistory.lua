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
---@overload fun(timestamp:number, map:string, playerTeam: PvPLookup.Team , enemyTeam: PvPLookup.Team , playerMMR: number, enemyMMR: number, duration: number, playerDamage: number, enemyDamage: number, playerHealing: number, enemyHealing: number, rating: number, ratingChange: number, pvpMode: PvPLookup.Const.PVPModes, win:boolean): PvPLookup.MatchHistory
PvPLookup.MatchHistory = PvPLookup.Object:extend()

---@param timestamp number
---@param map string
---@param playerTeam PvPLookup.Team
---@param enemyTeam PvPLookup.Team
---@param playerMMR number
---@param enemyMMR number
---@param duration number
---@param playerDamage number
---@param enemyDamage number
---@param playerHealing number
---@param enemyHealing number
---@param rating number
---@param ratingChange number
---@param pvpMode PvPLookup.Const.PVPModes
---@param win boolean
function PvPLookup.MatchHistory:new(timestamp, map, playerTeam, enemyTeam, playerMMR, enemyMMR, duration, playerDamage,
                                    enemyDamage, playerHealing, enemyHealing, rating, ratingChange, pvpMode, win)
    self.timestamp = timestamp
    self.map = map
    self.playerTeam = playerTeam
    self.enemyTeam = enemyTeam
    self.playerMMR = playerMMR
    self.enemyMMR = enemyMMR
    self.duration = duration
    self.playerDamage = playerDamage
    self.enemyDamage = enemyDamage
    self.playerHealing = playerHealing
    self.enemyHealing = enemyHealing
    self.rating = rating
    self.ratingChange = ratingChange
    self.pvpMode = pvpMode
    self.win = win
end

--- STATIC create a match history instance based on current match ending screen
---@return PvPLookup.MatchHistory?
function PvPLookup.MatchHistory:CreateFromEndScreen()
    -- GetInspectSpecialization

    local arenaOpponentSpecIDs = {}
    for opponentID = 1, GetNumArenaOpponentSpecs() do
        arenaOpponentSpecIDs[opponentID] = GetArenaOpponentSpec(opponentID)
    end

    local playerSpecializationID = GetSpecialization()
    local apiData = {
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
        GetTeamInfo_2 = C_PvP.GetTeamInfo(2) or "nil",
        IsActiveMatchRegistered = C_PvP.IsActiveMatchRegistered(),
        IsMatchFactional = C_PvP.IsMatchFactional(),
        IsPVPMap = C_PvP.IsPVPMap(),
        IsRatedMap = C_PvP.IsRatedMap(),
    }

    PvPLookup.DEBUG:DebugTable(apiData, "GatheredAPIData " .. GetTimePreciseSec() * 1000)

    table.insert(PvPLookupDebugDB, apiData)

    -- local timestamp = nil
    -- local map = nil
    -- local playerTeam = nil
    -- local enemyTeam = nil
    -- local playerMMR = nil
    -- local enemyMMR = nil
    -- local duration = nil
    -- local playerDamage = nil
    -- local enemyDamage = nil
    -- local playerHealing = nil
    -- local enemyHealing = nil
    -- local rating = nil
    -- local ratingChange = nil
    -- local pvpMode = nil
    -- local win = nil



    -- local matchHistory = PvPLookup.MatchHistory(timestamp, map, playerTeam, enemyTeam, playerMMR, enemyMMR, duration,
    --     playerDamage,
    --     enemyDamage, playerHealing, enemyHealing, rating, ratingChange, pvpMode, win)
end
