---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.PvPInfo
PvPLookup.PVPINFO = {}

---@class PvPLookup.PvPInfoFrame
PvPLookup.PVPINFO.frame = nil

---@class PvPLookup.PVPINFO.PersonalRatingInfo
---@field rating number
---@field seasonBest number
---@field weeklyBest number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number
---@field cap number

---@return table<PvPLookup.Const.PVPModes, PvPLookup.PVPINFO.PersonalRatingInfo>
function PvPLookup.PVPINFO:GetPersonalRatingInfo()
    local personalRatedInfo = {}

    for mode, bracketID in pairs(PvPLookup.CONST.PVP_MODES_BRACKET_IDS) do
        personalRatedInfo[mode] = self:ConvertPersonalRatedInfo({ GetPersonalRatedInfo(bracketID) })
    end

    return personalRatedInfo
end

---@param personalRatedInfo table https://warcraft.wiki.gg/wiki/API_GetPersonalRatedInfo
function PvPLookup.PVPINFO:ConvertPersonalRatedInfo(personalRatedInfo)
    ---@type PvPLookup.PVPINFO.PersonalRatingInfo
    local personalRatingInfo = {
        rating = personalRatedInfo[1],
        seasonBest = personalRatedInfo[2],
        weeklyBest = personalRatedInfo[3],
        seasonPlayed = personalRatedInfo[4],
        seasonWon = personalRatedInfo[5],
        weeklyPlayed = personalRatedInfo[6],
        weeklyWon = personalRatedInfo[7],
        cap = personalRatedInfo[8],
    }
    return personalRatingInfo
end
