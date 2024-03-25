---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local debug = PvPAssistant.DEBUG:GetDebugPrint()


---@class PvPAssistant.DataCollection : Frame
PvPAssistant.DATA_COLLECTION = GUTIL:CreateRegistreeForEvents { "PVP_MATCH_COMPLETE", "PLAYER_JOINED_PVP_MATCH", "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PVP_MATCH_STATE_CHANGED" }

---@class PvPAssistant.DATA_COLLECTION.ArenaSpecIDs
PvPAssistant.DATA_COLLECTION.arenaSpecIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

PvPAssistant.DATA_COLLECTION.enableCombatLog = false

---@type function[]
PvPAssistant.DATA_COLLECTION.arenaSpecIDUpdateCallbacks = {}

function PvPAssistant.DATA_COLLECTION:PVP_MATCH_COMPLETE()
    debug("PvPAssistant: PvP Match Completed")
    debug("LoggingCombat: " .. tostring(LoggingCombat(false)))

    debug("PvPAssistant: Saving Match Data...")
    local matchHistory = self:CreateMatchHistoryFromEndScore()
    PvPAssistant.DB.MATCH_HISTORY:Save(matchHistory)

    PvPAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()
end

function PvPAssistant.DATA_COLLECTION:PLAYER_JOINED_PVP_MATCH()
    if not PvPAssistant.DATA_COLLECTION.enableCombatLog then
        debug("PvPAssistant: Joined PvP Match")
        debug("LoggingCombat: " .. tostring(LoggingCombat(true)))

        PvPAssistant.DATA_COLLECTION.enableCombatLog = true
    end
end

---@return PvPAssistant.MatchHistory?
function PvPAssistant.DATA_COLLECTION:CreateMatchHistoryFromEndScore()
    PvPAssistant.DEBUG:GatherDebugAPIDataFromMatchEnd()

    -- force showing all players
    SetBattlefieldScoreFaction(-1)

    -- for comparison
    local playerName, _ = UnitName("player")
    local playerRealm = GetRealmName()

    local numPlayers = GetNumBattlefieldScores()

    ---@type PVPScoreInfo[]
    local pvpScores = {}
    for playerIndex = 1, numPlayers do
        local playerPvPScore = C_PvP.GetScoreInfo(playerIndex)
        table.insert(pvpScores, playerPvPScore)
    end

    local isSoloShuffle = C_PvP.IsSoloShuffle()

    local playerTeamID = GetBattlefieldArenaFaction()

    if not playerTeamID then
        error("PvPAssistant: Could not fetch player team id")
        return
    end

    local enemyTeamID = (playerTeamID == 0 and 1) or 0


    local playerTeamRatingInfo = C_PvP.GetTeamInfo(playerTeamID)
    local enemyTeamRatingInfo = C_PvP.GetTeamInfo(enemyTeamID)

    if not playerTeamRatingInfo or not enemyTeamRatingInfo then
        error("PvPAssistant: Could not parse team infos")
        return
    end

    ---@type PvPAssistant.Player[]
    local playerTeam = {}
    local enemyTeam = {}
    local player = nil
    for _, pvpScore in ipairs(pvpScores) do
        local name, realm = strsplit("-", pvpScore.name)
        realm = realm or playerRealm

        local specDescriptor = pvpScore.talentSpec .. " " .. pvpScore.className
        ---@type PvPAssistant.Player
        local arenaPlayer = {
            name = name,
            realm = realm,
            class = pvpScore.classToken,
            specID = PvPAssistant.SPEC_LOOKUP:LookUp(specDescriptor),
            scoreData = pvpScore,
        }
        if pvpScore.faction == playerTeamID or isSoloShuffle then
            tinsert(playerTeam, arenaPlayer)

            if arenaPlayer.name == playerName and arenaPlayer.realm == playerRealm then
                player = arenaPlayer
            end
        else
            tinsert(enemyTeam, arenaPlayer)
        end
    end

    ---@type PvPAssistant.Team
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

    ---@type PvPAssistant.Team
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

    local highestTeamSize = GUTIL:Fold({ playerTeamRatingInfo, enemyTeamRatingInfo }, 0,
        function(hTS, ratingInfo)
            if hTS < ratingInfo.size then
                return ratingInfo.size
            else
                return hTS
            end
        end)

    local instanceInfo = { GetInstanceInfo() }

    local matchHistory = PvPAssistant.MatchHistory()
    matchHistory.duration = C_PvP.GetActiveMatchDuration() * 1000 -- seconds -> ms
    matchHistory.isArena = C_PvP.IsArena()
    matchHistory.isBattleground = C_PvP.IsBattleground()
    matchHistory.isSoloShuffle = isSoloShuffle
    matchHistory.isRated = isSoloShuffle or
        (playerTeamRatingInfo.ratingMMR > 0 or enemyTeamRatingInfo.ratingMMR > 0)
    matchHistory.enemyTeam = enemyTeam
    matchHistory.playerTeam = playerTeam
    matchHistory.win = C_PvP.GetActiveMatchWinner() == playerTeamID
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
    matchHistory.pvpMode = (matchHistory.isBattleground and PvPAssistant.CONST.PVP_MODES.BATTLEGROUND) or
        (matchHistory.isSoloShuffle and PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE) or
        (matchHistory.isArena and highestTeamSize <= 2 and PvPAssistant.CONST.PVP_MODES.TWOS) or
        (matchHistory.isArena and highestTeamSize <= 3 and PvPAssistant.CONST.PVP_MODES.THREES)
    matchHistory.player = player
    matchHistory.timestamp = (C_DateAndTime.GetServerTimeLocal() * 1000) - matchHistory.duration
    return matchHistory
end

---@param callback function
function PvPAssistant.DATA_COLLECTION:RegisterForArenaSpecIDUpdate(callback)
    tinsert(self.arenaSpecIDUpdateCallbacks, callback)
end

---@return PvPAssistant.DATA_COLLECTION.ArenaSpecIDs
function PvPAssistant.DATA_COLLECTION:GetArenaSpecIDs()
    return self.arenaSpecIDs
end

function PvPAssistant.DATA_COLLECTION:ResetSpecIDs()
    PvPAssistant.DATA_COLLECTION.arenaSpecIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }
end

function PvPAssistant.DATA_COLLECTION:UpdateArenaSpecIDs()
    -- only update list if its bigger than before!
    -- meaning do not update if someone leaves...
    local numOpponents = GetNumArenaOpponentSpecs()
    if #PvPAssistant.DATA_COLLECTION.arenaSpecIDs.ENEMY_TEAM < numOpponents then
        for i = 1, numOpponents do
            local specID, _ = GetArenaOpponentSpec(i)
            PvPAssistant.DATA_COLLECTION.arenaSpecIDs.ENEMY_TEAM[i] = specID
        end
    end

    local numGroupMembers = GetNumGroupMembers()
    if #PvPAssistant.DATA_COLLECTION.arenaSpecIDs.PLAYER_TEAM < numGroupMembers then
        -- player is not accessible with "partyX" UnitId
        local playerSpecID = PvPAssistant.UTIL:GetSpecializationIDByUnit("player")
        PvPAssistant.DATA_COLLECTION.arenaSpecIDs.PLAYER_TEAM[1] = playerSpecID
        for i = 1, numGroupMembers - 1 do
            local specID = PvPAssistant.UTIL:GetSpecializationIDByUnit("party" .. i)
            PvPAssistant.DATA_COLLECTION.arenaSpecIDs.PLAYER_TEAM[i + 1] = specID
        end
    end

    -- then call all registered callbacks
    for _, callback in ipairs(self.arenaSpecIDUpdateCallbacks) do
        callback()
    end
end

function PvPAssistant.DATA_COLLECTION:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    if C_PvP.IsArena() then
        debug("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
        self:UpdateArenaSpecIDs()
    end
end

function PvPAssistant.DATA_COLLECTION:GROUP_ROSTER_UPDATE()
    if C_PvP.IsArena() then
        debug("GROUP_ROSTER_UPDATE")
        self:UpdateArenaSpecIDs()
    end
end

function PvPAssistant.DATA_COLLECTION:PVP_MATCH_STATE_CHANGED()
    local state = C_PvP.GetActiveMatchState()
    -- local isShuffle = C_PvP.IsSoloShuffle()

    if state == Enum.PvPMatchState.StartUp then
        debug("PVP_MATCH_STATE_CHANGED: StartUp")
        PvPAssistant.DATA_COLLECTION:ResetSpecIDs()
    end

    if state == Enum.PvPMatchState.Waiting then
        debug("PVP_MATCH_STATE_CHANGED: Waiting")
    end
    if state == Enum.PvPMatchState.PostRound then
        debug("PVP_MATCH_STATE_CHANGED: PostRound")
        -- DEBUG TODO Remove after testing
        if C_PvP.IsSoloShuffle() then
            local intermediateShuffleMatchHistory = self:CreateMatchHistoryFromEndScore()
            local playerUID = PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
            PvPAssistant.DB.MATCH_HISTORY:SaveShuffleMatch(intermediateShuffleMatchHistory, playerUID)
        end
        --
        PvPAssistant.DATA_COLLECTION:ResetSpecIDs()
    end
    if state == Enum.PvPMatchState.Inactive then
        debug("PVP_MATCH_STATE_CHANGED: Inactive")
    end
    if state == Enum.PvPMatchState.Engaged then
        debug("PVP_MATCH_STATE_CHANGED: Engaged")
    end
    if state == Enum.PvPMatchState.Complete then
        debug("PVP_MATCH_STATE_CHANGED: Complete")
    end
end
