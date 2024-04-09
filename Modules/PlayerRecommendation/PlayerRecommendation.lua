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
        self.FRAMES:Init()
        -- Testing with wowlua that's why i put this in _G
        _G["PvPAssistant"] = PvPAssistant
    end
end

function PvPAssistant.PLAYERRECOMMENDATION:PVP_MATCH_COMPLETE()
    local units = {}
    for unitIndex = 1, GetNumBattlefieldScores() do
        tinsert(units, C_PvP.GetScoreInfo(unitIndex))
    end
    self.FRAMES:OpenFrame(units)
end
