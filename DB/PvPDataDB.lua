---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.PVP_DATA
PvPAssistant.DB.PVP_DATA = {}

---@class PlayerPvPData
---@field ratings table<PvPAssistant.Const.PVPModes, number>
---@field shuffleSpecRatings table<number, number> specID -> rating

function PvPAssistant.DB.PVP_DATA:Init()
    PvPAssistant.DB.DEBUG:ClearAll()

    local libCBOR = LibStub("LibCBOR-1.0")

    local cborString = PvPAssistant.PVP_DATA
    local deserializedData = libCBOR:Deserialize(cborString)

    PvPAssistant.PVP_DATA = deserializedData
end

---@return PlayerPvPData? bracketData
function PvPAssistant.DB.PVP_DATA:GetByUnit(unit)
    if not unit then return nil end

    if PvPAssistant.DB.DEBUG_IDS:Get("PLAYER_TOOLTIP") then
        return self:GetDebugPvPData(unit)
    end


    local unitName, unitRealm = UnitNameUnmodified(unit)
    unitRealm = unitRealm or GetNormalizedRealmName()
    unitRealm = PvPAssistant.UTIL:CamelCaseToDashSeparated(unitRealm) -- temporary adaption to pvp data format

    local data = self:Get(unitName, unitRealm, select(2, UnitClass(unit)))

    return data
end

---@param characterName string -- e.g. Slarky
---@param realmName string -- e.g. tarren-mill
---@param class? ClassFile
function PvPAssistant.DB.PVP_DATA:Get(characterName, realmName, class)
    local realmPlayers = PvPAssistant.PVP_DATA[realmName]
    if not realmPlayers then return end

    ---@diagnostic disable-next-line: undefined-field
    local dbData = realmPlayers[characterName]

    if not dbData then
        return
    end

    ---@type PlayerPvPData
    local playerPvPData = {
        ratings = {},
        shuffleSpecRatings = {},
    }

    --- 2v2,3v3,rbg,shuffle-1,shuffle-2,shuffle-3,shuffle-4
    for index, mode in ipairs(PvPAssistant.CONST.PVP_DATA_BRACKET_ORDER) do
        local rating = dbData[index]
        if index < 4 then
            playerPvPData.ratings[mode] = rating
        elseif class then
            local unitClassID = PvPAssistant.CONST.CLASS_ID[class]
            local specIndex = (3 - index) * -1
            local specID = GetSpecializationInfoForClassID(unitClassID, specIndex)
            if specID then
                playerPvPData.shuffleSpecRatings[specID] = rating
            end
        end
    end

    return playerPvPData
end

---@return PlayerPvPData debugPvPData
function PvPAssistant.DB.PVP_DATA:GetDebugPvPData(unit)
    local class = select(2, UnitClass(unit))
    local classID = PvPAssistant.CONST.CLASS_ID[class]
    local playerPvPData = {
        ratings = {
            [PvPAssistant.CONST.PVP_MODES.BATTLEGROUND] = 1234,
            [PvPAssistant.CONST.PVP_MODES.TWOS] = 2345,
            [PvPAssistant.CONST.PVP_MODES.THREES] = 3456,
        },
        shuffleSpecRatings = {},
    }

    for i = 1, 4 do
        local specID = GetSpecializationInfoForClassID(classID, i)
        if specID then
            playerPvPData.shuffleSpecRatings[specID] = 1234 * i
        end
    end

    return playerPvPData
end
