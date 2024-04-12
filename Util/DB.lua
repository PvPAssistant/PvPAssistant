---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistantDB.Database
---@field version number
---@field data table

---@class PvPAssistant.DB
PvPAssistant.DB = {}

---@class PvPAssistant.DB.MATCH_HISTORY
PvPAssistant.DB.MATCH_HISTORY = {}

---@class PvPAssistant.DB.DEBUG
PvPAssistant.DB.DEBUG = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS
PvPAssistant.DB.TOOLTIP_OPTIONS = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP
PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP = {}

---@class PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP
PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP = {}

---@class PvPAssistant.DB.CHARACTER_DATA
PvPAssistant.DB.CHARACTER_DATA = {}

---@class PvPAssistant.DB.RECOMMENDATION_DATA
PvPAssistant.DB.RECOMMENDATION_DATA = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@class PvPAssistant.PlayerTooltipData.ModeData
---@field rating number
---@field win number
---@field loss number
---@field exp number

---@class PvPAssistant.PlayerTooltipData
---@field ratingData table<PvPAssistant.Const.PVPModes, PvPAssistant.PlayerTooltipData.ModeData>

---@class PvPAssistant.DB.PLAYER_DATA
PvPAssistant.DB.PLAYER_DATA = {}

---@class PvPAssistant.CharacterData
---@field name string
---@field realm string
---@field class ClassFile

---@class PvPAssistantDB
---@field matchHistory PvPAssistantDB.Database
---@field playerData PvPAssistantDB.Database
---@field debugData PvPAssistantDB.Database
---@field tooltipOptions PvPAssistantDB.Database
---@field characterData PvPAssistantDB.Database
PvPAssistantDB = PvPAssistantDB or {}

function PvPAssistant.DB:Init()
    if not PvPAssistantDB.characterData then
        PvPAssistantDB.characterData = {
            version = 1,
            ---@type table<PlayerUID, PvPAssistant.CharacterData>
            data = {}
        }
    end
    if not PvPAssistantDB.matchHistory then
        PvPAssistantDB.matchHistory = {
            version = 4,
            ---@type table<PlayerUID, PvPAssistant.MatchHistory.Serialized[]>
            data = {},
            ---@type table<PlayerUID, PvPAssistant.MatchHistory.Serialized[]>
            tempShuffleData = {}
        }
    end

    if not PvPAssistantDB.playerData then
        PvPAssistantDB.playerData = {
            version = 1,
            ---@type table<PlayerUID, table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>>
            data = {}
        }
    end

    if not PvPAssistantDB.debugData then
        PvPAssistantDB.debugData = {
            version = 1,
            ---@type any
            data = {}
        }
    end

    if not PvPAssistantDB.tooltipOptions then
        PvPAssistantDB.tooltipOptions = {
            version = 1,
            data = {
                playerTooltip = {
                    enabled = true,
                    [PvPAssistant.CONST.PVP_MODES.TWOS] = true,
                    [PvPAssistant.CONST.PVP_MODES.THREES] = true,
                    [PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE] = true,
                    [PvPAssistant.CONST.PVP_MODES.BATTLEGROUND] = true,
                },
                spellTooltip = {
                    enabled = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION] = true,
                    [PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA] = true,
                },
            },
        }
    end


    PvPAssistant.DB:HandleMigrations()
end

function PvPAssistant.DB:HandleMigrations()
    self.MATCH_HISTORY:HandleMigrations()
end

function PvPAssistant.DB.MATCH_HISTORY:HandleMigrations()
    -- 1 -> 2 Just wipe
    if PvPAssistantDB.matchHistory.version <= 1 then
        self:Clear()
        PvPAssistantDB.matchHistory.version = 2
    end

    -- 2 -> 3 Introduce tempShuffleData or wipe it
    if PvPAssistantDB.matchHistory.version <= 3 then
        PvPAssistantDB.matchHistory.tempShuffleData = {}
        PvPAssistantDB.matchHistory.version = 4
    end

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

function PvPAssistant.DB.MATCH_HISTORY:Clear()
    wipe(PvPAssistantDB.matchHistory.data)
    self:ClearShuffleData()
end

function PvPAssistant.DB.MATCH_HISTORY:ClearShuffleData()
    if PvPAssistantDB.matchHistory.tempShuffleData then
        wipe(PvPAssistantDB.matchHistory.tempShuffleData)
    end
end

---@param playerUID PlayerUID
---@return table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>?
function PvPAssistant.DB.PLAYER_DATA:Get(playerUID)
    return PvPAssistantDB.playerData.data[playerUID]
end

---@param playerUID PlayerUID
---@param playerPvPData table<PvPAssistant.Const.PVPModes, InspectArenaData | InspectPVPData>
function PvPAssistant.DB.PLAYER_DATA:Save(playerUID, playerPvPData)
    PvPAssistantDB.playerData.data[playerUID] = playerPvPData
end

function PvPAssistant.DB.PLAYER_DATA:Clear()
    wipe(PvPAssistantDB.playerData.data)
end

---@param data table
function PvPAssistant.DB.DEBUG:Add(data)
    tinsert(PvPAssistantDB.debugData.data, data)
end

---@return table[]
function PvPAssistant.DB.DEBUG:Get()
    return PvPAssistantDB.debugData.data
end

function PvPAssistant.DB.TOOLTIP_OPTIONS:Clear()
    wipe(PvPAssistantDB.tooltipOptions.data.playerTooltip)
    wipe(PvPAssistantDB.tooltipOptions.data.spellTooltip)
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Clear()
    wipe(PvPAssistantDB.tooltipOptions.data.playerTooltip)
end

function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Clear()
    wipe(PvPAssistantDB.tooltipOptions.data.spellTooltip)
end

---@param mode PvPAssistant.Const.PVPModes
---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:Get(mode)
    return PvPAssistantDB.tooltipOptions.data.playerTooltip[mode]
end

---@param mode
---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:Get(mode)
    return PvPAssistantDB.tooltipOptions.data.spellTooltip[mode]
end

---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.PLAYER_TOOLTIP:IsEnabled()
    return PvPAssistantDB.tooltipOptions.data.playerTooltip.enabled == nil or
        PvPAssistantDB.tooltipOptions.data.playerTooltip.enabled
end

---@return boolean enabled
function PvPAssistant.DB.TOOLTIP_OPTIONS.SPELL_TOOLTIP:IsEnabled()
    return PvPAssistantDB.tooltipOptions.data.spellTooltip.enabled == nil or
        PvPAssistantDB.tooltipOptions.data.spellTooltip.enabled
end

function PvPAssistant.DB.CHARACTER_DATA:Clear()
    wipe(PvPAssistantDB.characterData.data)
end

---@return PvPAssistant.CharacterData? characterData
function PvPAssistant.DB.CHARACTER_DATA:Get(characterUID)
    return PvPAssistantDB.characterData.data[characterUID]
end

---@param characterUID PlayerUID
---@param characterData PvPAssistant.CharacterData
function PvPAssistant.DB.CHARACTER_DATA:Save(characterUID, characterData)
    PvPAssistantDB.characterData.data[characterUID] = characterData
end

---@param characterUID PlayerUID
function PvPAssistant.DB.CHARACTER_DATA:GetClass(characterUID)
    local characterData = self:Get(characterUID)
    if characterData then
        return characterData.class
    end
end

---@return PvPAssistant.CharacterData[]
function PvPAssistant.DB.CHARACTER_DATA:GetAll()
    return PvPAssistantDB.characterData.data
end

function PvPAssistant.DB.CHARACTER_DATA:Init()
    local playerUID = PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    local playerClass = select(2, UnitClass("player"))
    local name, realm = strsplit("-", playerUID)

    ---@type PvPAssistant.CharacterData
    local characterData = {
        name = name,
        realm = realm,
        class = playerClass,
    }

    self:Save(playerUID, characterData)
end

---@alias UnitGUID string
---@class PvPAssistant.RecommendationData
---@field note string
---@field rating number

function PvPAssistant.DB.RECOMMENDATION_DATA:Init()
    if not PvPAssistantDB.recommendationData then
        PvPAssistantDB.recommendationData = {
            version = 1,
            ---@type table<UnitGUID, PvPAssistant.RecommendationData>
            data = {}
        }
    end
end
function PvPAssistant.DB.RECOMMENDATION_DATA:Clear()
    wipe(PvPAssistantDB.recommendationData.data)
end

---@return PvPAssistant.RecommendationData? unitData
function PvPAssistant.DB.RECOMMENDATION_DATA:Get(unitGUID)
    return PvPAssistantDB.recommendationData.data[unitGUID]
end

---@param unitData PvPAssistant.RecommendationData
function PvPAssistant.DB.RECOMMENDATION_DATA:Save(unitGUID, unitData)
    PvPAssistantDB.recommendationData.data[unitGUID] = unitData
end

---@return PvPAssistant.RecommendationData[]
function PvPAssistant.DB.RECOMMENDATION_DATA:GetAll()
    return PvPAssistantDB.recommendationData.data
end

function PvPAssistant.DB.RECOMMENDATION_DATA:Migrate() end