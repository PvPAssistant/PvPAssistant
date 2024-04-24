---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.MATCH_HISTORY : PvPAssistant.DB.Repository
PvPAssistant.DB.MATCH_HISTORY = PvPAssistant.DB:RegisterRepository()

function PvPAssistant.DB.MATCH_HISTORY:Init()
    if not PvPAssistantDB.matchHistory then
        PvPAssistantDB.matchHistory = {
            version = 7,
            ---@type table<PlayerUID, PvPAssistant.MatchHistory.Serialized[]>
            data = {},
            ---@type table<PlayerUID, PvPAssistant.MatchHistory.Serialized[]>
            tempShuffleData = {}
        }
    end
end

function PvPAssistant.DB.MATCH_HISTORY:Migrate()
    -- 1 -> 2 Just wipe
    if PvPAssistantDB.matchHistory.version <= 1 then
        self:ClearAll()
        PvPAssistantDB.matchHistory.version = 2
    end

    -- 2/3 -> 4 Introduce tempShuffleData or wipe it
    if PvPAssistantDB.matchHistory.version <= 3 then
        PvPAssistantDB.matchHistory.tempShuffleData = {}
        PvPAssistantDB.matchHistory.version = 4
    end
    -- 4 -> 5
    if PvPAssistantDB.matchHistory.version <= 5 then
        wipe(PvPAssistantDB.matchHistory.tempShuffleData)
        PvPAssistantDB.matchHistory.version = 6

        -- normalize realm names
        for _, matches in pairs(PvPAssistantDB.matchHistory.data) do
            for _, match in ipairs(matches) do
                ---@type PvPAssistant.MatchHistory.Serialized
                local match = match
                match.player.realm = string.gsub(match.player.realm, " ", "") -- normalize realm name

                for _, player in ipairs(match.playerTeam.players) do
                    player.realm = string.gsub(player.realm, " ", "") -- normalize realm name
                end

                for _, player in ipairs(match.enemyTeam.players) do
                    player.realm = string.gsub(player.realm, " ", "") -- normalize realm name
                end
            end
        end
    end
    -- 6 -> 7
    if PvPAssistantDB.matchHistory.version == 6 then
        PvPAssistant.DB.MATCH_HISTORY:ClearShuffleData()
        PvPAssistantDB.matchHistory.version = 7
    end
end

---@param playerUID PlayerUID
---@return PvPAssistant.MatchHistory.Serialized[]
function PvPAssistant.DB.MATCH_HISTORY:Get(playerUID)
    PvPAssistantDB.matchHistory.data[playerUID] = PvPAssistantDB.matchHistory.data[playerUID] or {}
    return PvPAssistantDB.matchHistory.data[playerUID]
end

---@param matchHistory PvPAssistant.MatchHistory
---@param playerUID PlayerUID?
function PvPAssistant.DB.MATCH_HISTORY:Save(matchHistory, playerUID)
    playerUID = playerUID or PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    PvPAssistantDB.matchHistory.data[playerUID] = PvPAssistantDB.matchHistory.data[playerUID] or {}
    tinsert(PvPAssistantDB.matchHistory.data[playerUID], matchHistory:Serialize())
end

---@param playerUID PlayerUID
---@return PvPAssistant.MatchHistory.Serialized[]
function PvPAssistant.DB.MATCH_HISTORY:GetShuffleMatches(playerUID)
    PvPAssistantDB.matchHistory.tempShuffleData[playerUID] = PvPAssistantDB.matchHistory.tempShuffleData[playerUID] or {}
    return PvPAssistantDB.matchHistory.tempShuffleData[playerUID]
end

---@param matchHistory PvPAssistant.MatchHistory
---@param playerUID PlayerUID?
function PvPAssistant.DB.MATCH_HISTORY:SaveShuffleMatch(matchHistory, playerUID)
    playerUID = playerUID or PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    PvPAssistantDB.matchHistory.tempShuffleData[playerUID] = PvPAssistantDB.matchHistory.tempShuffleData[playerUID] or {}
    tinsert(PvPAssistantDB.matchHistory.tempShuffleData[playerUID], matchHistory:Serialize())
end

function PvPAssistant.DB.MATCH_HISTORY:ClearAll()
    wipe(PvPAssistantDB.matchHistory.data)
    self:ClearShuffleData()
end

function PvPAssistant.DB.MATCH_HISTORY:ClearShuffleData()
    if PvPAssistantDB.matchHistory.tempShuffleData then
        wipe(PvPAssistantDB.matchHistory.tempShuffleData)
    end
end
