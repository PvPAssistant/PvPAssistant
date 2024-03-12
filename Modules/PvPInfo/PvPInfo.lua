---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GGUI = PvpAssistant.GGUI
local GUTIL = PvpAssistant.GUTIL

---@class PvpAssistant.PvPInfo
PvpAssistant.PVPINFO = {}

---@class PvpAssistant.PvPInfoFrame
PvpAssistant.PVPINFO.frame = nil

---@class PvpAssistant.PVPINFO.PersonalRatingInfo
---@field rating number
---@field seasonBest number
---@field weeklyBest number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number
---@field cap number

---@return table<PvpAssistant.Const.PVPModes, PvpAssistant.PVPINFO.PersonalRatingInfo>
function PvpAssistant.PVPINFO:GetPersonalRatingInfo()
    local personalRatedInfo = {}

    for mode, bracketID in pairs(PvpAssistant.CONST.PVP_MODES_BRACKET_IDS) do
        personalRatedInfo[mode] = self:ConvertPersonalRatedInfo({ GetPersonalRatedInfo(bracketID) })
    end

    return personalRatedInfo
end

---@param personalRatedInfo table https://warcraft.wiki.gg/wiki/API_GetPersonalRatedInfo
function PvpAssistant.PVPINFO:ConvertPersonalRatedInfo(personalRatedInfo)
    ---@type PvpAssistant.PVPINFO.PersonalRatingInfo
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
