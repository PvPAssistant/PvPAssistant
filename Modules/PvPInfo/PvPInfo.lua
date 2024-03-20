---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL

---@class PvPAssistant.PvPInfo : Frame
PvPAssistant.PVPINFO = GUTIL:CreateRegistreeForEvents { "ADDON_LOADED" }

---@class PvPAssistant.PvPInfoFrame
PvPAssistant.PVPINFO.frame = nil

---@class PvPAssistant.PVPINFO.PersonalRatingInfo
---@field rating number
---@field seasonBest number
---@field weeklyBest number
---@field seasonPlayed number
---@field seasonWon number
---@field weeklyPlayed number
---@field weeklyWon number
---@field cap number

function PvPAssistant.PVPINFO:ADDON_LOADED(addonName)
    if addonName == "Blizzard_PVPUI" then
        self.FRAMES:Init()
        self.FRAMES:UpdateDisplay()
    end
end

---@return table<PvPAssistant.Const.PVPModes, PvPAssistant.PVPINFO.PersonalRatingInfo>
function PvPAssistant.PVPINFO:GetPersonalRatingInfo()
    local personalRatedInfo = {}

    for mode, bracketID in pairs(PvPAssistant.CONST.PVP_MODES_BRACKET_IDS) do
        personalRatedInfo[mode] = self:ConvertPersonalRatedInfo({ GetPersonalRatedInfo(bracketID) })
    end

    return personalRatedInfo
end

---@param personalRatedInfo table https://warcraft.wiki.gg/wiki/API_GetPersonalRatedInfo
function PvPAssistant.PVPINFO:ConvertPersonalRatedInfo(personalRatedInfo)
    ---@type PvPAssistant.PVPINFO.PersonalRatingInfo
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
