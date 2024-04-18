---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.PVP_DATA
PvPAssistant.DB.PVP_DATA = {}

---@class PlayerPvPData
---@field ratings table<PvPAssistant.Const.PVPModes, number>
---@field shuffleSpecRatings table<number, number> specID -> rating

---@return PlayerPvPData? bracketData
function PvPAssistant.DB.PVP_DATA:GetByUnit(unit)
    if not unit then return nil end

    local unitName, unitRealm = UnitNameUnmodified(unit)
    unitRealm = unitRealm or GetNormalizedRealmName()
    unitRealm = PvPAssistant.UTIL:CamelCaseToDashSeparated(unitRealm) -- temporary adaption to pvp data format

    local playerUIDDashSeparated = unitName .. unitRealm

    return self:Get(playerUIDDashSeparated)
end

---@param playerUIDDashSeparated string -- e.g. slarky-tarren-mill
---@param class? ClassFile
function PvPAssistant.DB.PVP_DATA:Get(playerUIDDashSeparated, class)
    ---@diagnostic disable-next-line: undefined-field
    local unitPvPData = PvPAssistant.PVP_DATA[playerUIDDashSeparated]

    if not unitPvPData then
        return
    end

    ---@type PlayerPvPData
    local playerPvPData = {
        ratings = {},
        shuffleSpecRatings = {},
    }

    --- 2v2,3v3,rbg,shuffle-1,shuffle-2,shuffle-3,shuffle-4
    for index, mode in ipairs(PvPAssistant.CONST.PVP_DATA_BRACKET_ORDER) do
        local rating = unitPvPData[index]
        if index < 4 then
            playerPvPData.ratings[mode] = rating
        elseif class then
            local unitClassID = select(3, class)
            local specIndex = (3 - index) * -1
            local specID = GetSpecializationInfoForClassID(unitClassID, specIndex)
            if specID then
                playerPvPData.shuffleSpecRatings[specID] = rating
            end
        end
    end

    return playerPvPData
end
