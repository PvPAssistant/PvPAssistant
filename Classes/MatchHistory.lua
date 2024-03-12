---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GUTIL = PvpAssistant.GUTIL
local f = GUTIL:GetFormatter()

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

---@class PvpAssistant.Player
---@field name string
---@field realm string
---@field class string
---@field specID number
---@field scoreData PVPScoreInfo

---@class PvpAssistant.Team
---@field name? string
---@field players PvpAssistant.Player[]
---@field damage number
---@field healing number
---@field kills number
---@field ratingInfo PVPTeamInfo

---@class PvpAssistant.MatchHistory
---@overload fun(): PvpAssistant.MatchHistory
PvpAssistant.MatchHistory = PvpAssistant.Object:extend()

function PvpAssistant.MatchHistory:new()
    ---@type number
    self.timestamp = nil
    ---@type InstanceInfo
    self.mapInfo = nil
    ---@type boolean
    self.isArena = false
    ---@type boolean
    self.isBattleground = false
    ---@type boolean
    self.isSoloShuffle = false
    ---@type PvpAssistant.Team
    self.playerTeam = nil
    ---@type PvpAssistant.Team
    self.enemyTeam = nil
    ---@type number
    self.duration = nil
    ---@type boolean
    self.isRated = false
    ---@type PvpAssistant.Const.PVPModes
    self.pvpMode = nil
    ---@type boolean
    self.win = nil
    ---@type number
    self.season = nil
    ---@type PvpAssistant.Player
    self.player = nil
end

--- STATIC create a match history instance based on current match ending screen
---@return PvpAssistant.MatchHistory?
function PvpAssistant.MatchHistory:CreateFromEndScreen()
    -- force showing all players
    SetBattlefieldScoreFaction(-1)

    -- for comparison
    local playerName, _ = UnitName("player")
    local playerRealm = GetRealmName()
    local enemySpecIDs = {}
    local partySpecIDs = {}

    local numPlayers = GetNumBattlefieldScores()

    ---@type PVPScoreInfo[]
    local pvpScores = {}
    for playerIndex = 1, numPlayers do
        local playerPvPScore = C_PvP.GetScoreInfo(playerIndex)
        table.insert(pvpScores, playerPvPScore)
    end

    -- DEBUG START

    local playerSpecializationID = GetSpecialization()
    local apiData = {
        GetNumArenaOpponentSpecs = GetNumArenaOpponentSpecs() or "nil",
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

    PvpAssistant.DEBUG:DebugTable(apiData, "GatheredAPIData " .. (GetTimePreciseSec() * 1000))
    PvpAssistant.DB.DEBUG:Add(apiData)

    -- DEBUG END

    local isSoloShuffle = C_PvP.IsSoloShuffle()

    local playerTeamID = GetBattlefieldArenaFaction()

    if not playerTeamID then
        error("PvpAssistant: Could not fetch player team id")
        return
    end

    local enemyTeamID = (playerTeamID == 0 and 1) or 0


    local playerTeamRatingInfo = C_PvP.GetTeamInfo(playerTeamID)
    local enemyTeamRatingInfo = C_PvP.GetTeamInfo(enemyTeamID)

    if not playerTeamRatingInfo or not enemyTeamRatingInfo then
        error("PvpAssistant: Could not parse team infos")
        return
    end

    ---@type PvpAssistant.Player[]
    local playerTeam = {}
    local enemyTeam = {}
    local player = nil
    for _, pvpScore in ipairs(pvpScores) do
        local name, realm = strsplit("-", pvpScore.name)
        realm = realm or playerRealm

        local specDescriptor = pvpScore.talentSpec .. " " .. pvpScore.className
        ---@type PvpAssistant.Player
        local arenaPlayer = {
            name = name,
            realm = realm,
            class = pvpScore.classToken,
            specID = PvpAssistant.SPEC_LOOKUP:LookUp(specDescriptor),
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

    ---@type PvpAssistant.Team
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

    ---@type PvpAssistant.Team
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

    local matchHistory = PvpAssistant.MatchHistory()
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
    matchHistory.pvpMode = (matchHistory.isBattleground and PvpAssistant.CONST.PVP_MODES.BATTLEGROUND) or
        (matchHistory.isSoloShuffle and PvpAssistant.CONST.PVP_MODES.SOLO_SHUFFLE) or
        (matchHistory.isArena and highestTeamSize <= 2 and PvpAssistant.CONST.PVP_MODES.TWOS) or
        (matchHistory.isArena and highestTeamSize <= 3 and PvpAssistant.CONST.PVP_MODES.THREES)
    matchHistory.player = player
    matchHistory.timestamp = (C_DateAndTime.GetServerTimeLocal() * 1000) - matchHistory.duration
    return matchHistory
end

---@param player PvpAssistant.Player
---@return string
function PvpAssistant.MatchHistory:GetTooltipTextForPlayer(player)
    local tooltipText =
        f.class(player.name .. "-" .. player.realm, player.class)
    if self.isRated then
        local rating = player.scoreData.rating
        local ratingIcon = PvpAssistant.UTIL:GetIconByRating(rating)
        local iconText = GUTIL:IconToText(ratingIcon, 20, 20)
        tooltipText = tooltipText ..
            " " .. iconText .. " " .. rating
    end
    tooltipText = tooltipText ..
        "\n - Damage / Heal: " ..
        PvpAssistant.UTIL:FormatDamageNumber(player.scoreData.damageDone) ..
        " / " .. PvpAssistant.UTIL:FormatDamageNumber(player.scoreData.healingDone) .. "\n"
    if self.isArena then
        tooltipText = tooltipText ..
            " - Kills: " .. player.scoreData.killingBlows .. "\n"
    else
        tooltipText = tooltipText ..
            " - Kills / Deaths: " .. player.scoreData.killingBlows .. " / " .. player.scoreData.deaths .. "\n"
    end

    return tooltipText
end

---@param team PvpAssistant.Team
---@return string
function PvpAssistant.MatchHistory:GetTooltipTextForTeam(team)
    local tooltipText = ""

    for _, player in ipairs(team.players) do
        tooltipText = tooltipText .. self:GetTooltipTextForPlayer(player)
    end

    return tooltipText
end

function PvpAssistant.MatchHistory:GetTooltipText()
    local tooltipText = ""
    if self.isArena then
        tooltipText = tooltipText .. "Arena"
        tooltipText = tooltipText .. " " .. tostring(PvpAssistant.CONST.PVP_MODES_NAMES[self.pvpMode])
        if self.isRated then
            tooltipText = tooltipText .. " - Rated"
        end
    elseif self.isBattleground then
        tooltipText = tooltipText .. "Battleground"
        tooltipText = tooltipText .. " " .. tostring(PvpAssistant.CONST.PVP_MODES_NAMES[self.pvpMode])
        if self.isRated then
            tooltipText = tooltipText .. " - Rated"
        end
    end
    if self.isSoloShuffle then
        local wins = self.player.scoreData.stats[1] and self.player.scoreData.stats[1].pvpStatValue
        if wins and wins > 0 then
            tooltipText = tooltipText .. " ( " .. f.g(wins .. " Wins") .. " )"
        else
            tooltipText = tooltipText .. " ( " .. f.r("0 Wins") .. " )"
        end
    else
        if self.win then
            tooltipText = tooltipText .. " ( " .. f.g("Win") .. " )"
        else
            tooltipText = tooltipText .. " ( " .. f.r("Lost") .. " )"
        end
    end
    tooltipText = tooltipText .. "\nMap: " .. self.mapInfo.name
    tooltipText = tooltipText .. "\n\n"

    if self.isSoloShuffle then
        tooltipText = tooltipText .. f.g("Players:\n") .. self:GetTooltipTextForTeam(self.playerTeam)
    else
        tooltipText = tooltipText .. f.g("Your Team:\n") .. self:GetTooltipTextForTeam(self.playerTeam)
        tooltipText = tooltipText .. f.r("\nEnemy Team:\n") .. self:GetTooltipTextForTeam(self.enemyTeam)
    end

    return tooltipText
end

---@return Frame tooltipFrame
function PvpAssistant.MatchHistory:FillTooltipFrame()
    local tooltipFrame = PvpAssistant.MAIN_FRAME.matchHistoryTooltipFrame.contentFrame --[[@as GGUI.Frame]]
    local content = tooltipFrame.content --[[@as PvpAssistant.MAIN_FRAME.TooltipFrame.Content]]

    local playerList = content.playerList

    content.modeText:SetText(f.white(PvpAssistant.CONST.PVP_MODES_NAMES[self.pvpMode] or "<?>"))
    content.mapText:SetText(f.bb(self.mapInfo.name))
    if self.isSoloShuffle then
        local wins = self.player.scoreData.stats[1] and self.player.scoreData.stats[1].pvpStatValue
        if wins and wins > 0 then
            content.winText:SetText(f.g(wins .. " Wins"))
        else
            content.winText:SetText(f.r("0 Wins"))
        end
    else
        if self.win then
            content.winText:SetText(f.g("Win"))
        else
            content.winText:SetText(f.r("Loss"))
        end
    end

    local playerTeamSize = #self.playerTeam.players
    for playerIndex, player in ipairs(GUTIL:Concat { self.playerTeam.players, self.enemyTeam.players }) do
        playerList:Add(function(row, columns)
            local playerColumn = columns[1]
            local dmgColumn = columns[2]
            local healColumn = columns[3]
            local killColumn = columns[4]

            -- If i am the last player in my team show the separator line, otherwise hide
            row:SetSeparatorLine(playerIndex == playerTeamSize)

            playerColumn.text:SetText(f.class(player.name, player.class))
            dmgColumn.text:SetText(PvpAssistant.UTIL:FormatDamageNumber(player.scoreData.damageDone))
            healColumn.text:SetText(PvpAssistant.UTIL:FormatDamageNumber(player.scoreData.healingDone))
            killColumn.text:SetText(PvpAssistant.UTIL:FormatDamageNumber(player.scoreData.killingBlows))
        end)
    end

    playerList:UpdateDisplay()


    return PvpAssistant.MAIN_FRAME.matchHistoryTooltipFrame
end

---@class PvpAssistant.MatchHistory.Serialized
---@field timestamp number
---@field mapInfo InstanceInfo
---@field isArena boolean
---@field isBattleground boolean
---@field isSoloShuffle boolean
---@field playerTeam PvpAssistant.Team
---@field enemyTeam PvpAssistant.Team
---@field duration number
---@field isRated boolean
---@field pvpMode PvpAssistant.Const.PVPModes
---@field win boolean
---@field season number
---@field player PvpAssistant.Player

---@return PvpAssistant.MatchHistory.Serialized
function PvpAssistant.MatchHistory:Serialize()
    ---@type PvpAssistant.MatchHistory.Serialized
    local serialized = {
        timestamp = self.timestamp,
        mapInfo = self.mapInfo,
        isArena = self.isArena,
        isBattleground = self.isBattleground,
        isSoloShuffle = self.isSoloShuffle,
        playerTeam = self.playerTeam,
        enemyTeam = self.enemyTeam,
        duration = self.duration,
        isRated = self.isRated,
        pvpMode = self.pvpMode,
        win = self.win,
        season = self.season,
        player = self.player,
    }

    return serialized
end

---@param serializedData PvpAssistant.MatchHistory.Serialized
---@return PvpAssistant.MatchHistory matchHistory
function PvpAssistant.MatchHistory:Deserialize(serializedData)
    local matchHistory = PvpAssistant.MatchHistory()
    matchHistory.timestamp = serializedData.timestamp
    matchHistory.mapInfo = serializedData.mapInfo
    matchHistory.isArena = serializedData.isArena
    matchHistory.isBattleground = serializedData.isBattleground
    matchHistory.isSoloShuffle = serializedData.isSoloShuffle
    matchHistory.playerTeam = serializedData.playerTeam
    matchHistory.enemyTeam = serializedData.enemyTeam
    matchHistory.duration = serializedData.duration
    matchHistory.isRated = serializedData.isRated
    matchHistory.pvpMode = serializedData.pvpMode
    matchHistory.win = serializedData.win
    matchHistory.season = serializedData.season
    matchHistory.player = serializedData.player
    return matchHistory
end
