---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = ...

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL

---@class PvPAssistant.PLAYERRECOMMENDATION : Frame
-- maybe also PLAYER_JOINED_PVP_MATCH
PvPAssistant.PLAYERRECOMMENDATION = GUTIL:CreateRegistreeForEvents { "ADDON_LOADED", "PVP_MATCH_COMPLETE" }
PvPAssistant.PLAYERRECOMMENDATION.PLAYERGUID = UnitGUID("player")

function PvPAssistant.PLAYERRECOMMENDATION:ADDON_LOADED(loadedAddon)
    if addonName == loadedAddon then
        PvPAssistant.DB.RECOMMENDATION_DATA:Init()
        self.FRAMES:Init()
    end
end

function PvPAssistant.PLAYERRECOMMENDATION:PVP_MATCH_COMPLETE()
    local units = {}
    for unitIndex = 1, GetNumBattlefieldScores() do
        tinsert(units, C_PvP.GetScoreInfo(unitIndex))
    end
    self.FRAMES:OpenFrame(units)
end

SLASH_TESTPLAYERRECOMMENDUI1 = "/test";
SlashCmdList["TESTPLAYERRECOMMENDUI"] = function()
    local classes = {}
    for class in pairs(RAID_CLASS_COLORS) do tinsert(classes, class) end
    local consonants = { 'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x',
        'y',
        'z' }
    local vowels = { 'a', 'e', 'i', 'o', 'u' }
    local function generateRandomName()
        local nameLength = math.random(2, 12)
        local name = ''
        local isVowel = false
        for i = 1, nameLength do
            if isVowel then
                name = name .. vowels[math.random(1, #vowels)]
            else
                name = name .. consonants[math.random(1, #consonants)]
            end
            isVowel = not isVowel
        end
        return name
    end
    local function generateRandomGUID()
        local guid = 'Player-'
        guid = guid .. math.random(1000, 9999)
        guid = guid .. '-'
        for i = 1, 8 do
            guid = guid .. string.format("%X", math.random(0, 15))
        end
        return guid
    end
    local function generateRandomPlayer()
        local guid = generateRandomGUID()
        local name = generateRandomName()
        local class = classes[math.random(1, #classes)]
        return {
            name = name,
            classToken = class,
            guid = guid,
        }
    end

    local players = {}
    for i = 1, 10 do
        tinsert(players, generateRandomPlayer())
    end

    PvPAssistant.PLAYERRECOMMENDATION.FRAMES:OpenFrame(players)
end
