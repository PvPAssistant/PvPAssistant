---@class Arenalogs
local Arenalogs = select(2, ...)

local GGUI = Arenalogs.GGUI
local GUTIL = Arenalogs.GUTIL

---@class Arenalogs.PvPInfo
Arenalogs.PVPINFO = {}

---@class Arenalogs.PvPInfoFrame
Arenalogs.PVPINFO.frame = nil

---@class Arenalogs.PVPINFO.PersonalRatingInfo
---@field rating number
---@field seasonBest number
---@field weeklyBest number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number
---@field cap number

---@return table<Arenalogs.Const.PVPModes, Arenalogs.PVPINFO.PersonalRatingInfo>
function Arenalogs.PVPINFO:GetPersonalRatingInfo()
    local personalRatedInfo = {}

    for mode, bracketID in pairs(Arenalogs.CONST.PVP_MODES_BRACKET_IDS) do
        personalRatedInfo[mode] = self:ConvertPersonalRatedInfo({ GetPersonalRatedInfo(bracketID) })
    end

    return personalRatedInfo
end

---@param personalRatedInfo table https://warcraft.wiki.gg/wiki/API_GetPersonalRatedInfo
function Arenalogs.PVPINFO:ConvertPersonalRatedInfo(personalRatedInfo)
    ---@type Arenalogs.PVPINFO.PersonalRatingInfo
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
