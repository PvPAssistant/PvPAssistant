---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
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

---@class PvPAssistant.Player
---@field name string
---@field realm string
---@field class string
---@field specID number
---@field scoreData PVPScoreInfo

---@class PvPAssistant.Team
---@field name? string
---@field players PvPAssistant.Player[]
---@field damage number
---@field healing number
---@field kills number
---@field ratingInfo PVPTeamInfo

---@class PvPAssistant.MatchHistory
---@overload fun(): PvPAssistant.MatchHistory
PvPAssistant.MatchHistory = PvPAssistant.Object:extend()

function PvPAssistant.MatchHistory:new()
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
    ---@type PvPAssistant.Team
    self.playerTeam = nil
    ---@type PvPAssistant.Team
    self.enemyTeam = nil
    ---@type number
    self.duration = nil
    ---@type boolean
    self.isRated = false
    ---@type PvPAssistant.Const.PVPModes
    self.pvpMode = nil
    ---@type boolean
    self.win = nil
    ---@type number
    self.season = nil
    ---@type PvPAssistant.Player
    self.player = nil
    ---@type Enum.PvPMatchState
    self.pvpMatchState = nil
end

---@class PvPAssistant.MatchHistory.Serialized
---@field timestamp number
---@field mapInfo InstanceInfo
---@field isArena boolean
---@field isBattleground boolean
---@field isSoloShuffle boolean
---@field playerTeam PvPAssistant.Team
---@field enemyTeam PvPAssistant.Team
---@field duration number
---@field isRated boolean
---@field pvpMode PvPAssistant.Const.PVPModes
---@field win boolean
---@field season number
---@field player PvPAssistant.Player
---@field pvpMatchState Enum.PvPMatchState

---@return PvPAssistant.MatchHistory.Serialized
function PvPAssistant.MatchHistory:Serialize()
    ---@type PvPAssistant.MatchHistory.Serialized
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
        pvpMatchState = self.pvpMatchState,
    }

    return serialized
end

---@param serializedData PvPAssistant.MatchHistory.Serialized
---@return PvPAssistant.MatchHistory matchHistory
function PvPAssistant.MatchHistory:Deserialize(serializedData)
    local matchHistory = PvPAssistant.MatchHistory()
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
    matchHistory.pvpMatchState = serializedData.pvpMatchState
    return matchHistory
end
