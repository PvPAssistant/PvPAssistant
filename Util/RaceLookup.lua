---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.RACE_LOOKUP
PvPAssistant.RACE_LOOKUP = {}
PvPAssistant.RACE_LOOKUP.lookupTable = {}

--- https://warcraft.wiki.gg/wiki/RaceId
function PvPAssistant.RACE_LOOKUP:Init()
    wipe(PvPAssistant.RACE_LOOKUP.lookupTable)

    for raceID = 1, 80 do
        local raceInfo = C_CreatureInfo.GetRaceInfo(raceID)

        if raceInfo then
            PvPAssistant.RACE_LOOKUP.lookupTable[raceInfo.raceName] = PvPAssistant.RACE_LOOKUP.lookupTable
                [raceInfo.raceName] or {}

            tinsert(PvPAssistant.RACE_LOOKUP.lookupTable[raceInfo.raceName], raceInfo.clientFileString)
        end
    end
end

---@param localizedRaceName string
---@return string[]? clientFileStrings
function PvPAssistant.RACE_LOOKUP:LookUp(localizedRaceName)
    return self.lookupTable[localizedRaceName]
end

---@param localizedRaceName string
---@return string
function PvPAssistant.RACE_LOOKUP:GetIcon(localizedRaceName)
    local clientFileStrings = self:LookUp(localizedRaceName)

    for _, clientFileString in ipairs(clientFileStrings) do
        local icon = PvPAssistant.CONST.RACE_ICON_MAP[clientFileString]
        if icon then
            return icon
        end
    end

    print("race icon not found: " .. tostring(localizedRaceName))

    return "Interface\\Icons\\INV_Misc_QuestionMark"
end
