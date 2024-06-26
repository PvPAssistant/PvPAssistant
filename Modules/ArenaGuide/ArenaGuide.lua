---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.ArenaGuide : Frame
PvPAssistant.ARENA_GUIDE = {}

--- if enabled will fake a 3v3 team
PvPAssistant.ARENA_GUIDE.debug = false

---@type GGUI.Frame
PvPAssistant.ARENA_GUIDE.frame = nil

function PvPAssistant.ARENA_GUIDE:Init()
    PvPAssistant.DATA_COLLECTION:RegisterForArenaSpecIDUpdate(function()
        if not UnitAffectingCombat("player") and PvPAssistant.DB.GENERAL_OPTIONS:Get("ARENA_GUIDE_ENABLED") then
            PvPAssistant.ARENA_GUIDE.frame:Show()
            PvPAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
        end
    end)
end
