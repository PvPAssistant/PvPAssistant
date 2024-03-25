---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.DataCollection : Frame
PvPAssistant.DATA_COLLECTION = GUTIL:CreateRegistreeForEvents { "PVP_MATCH_COMPLETE" }

function PvPAssistant.DATA_COLLECTION:PVP_MATCH_COMPLETE()
    debug("PvPAssistant: PvP Match Completed")
    debug("LoggingCombat: " .. tostring(LoggingCombat(false)))

    debug("PvPAssistant: Saving Match Data...")
    local matchHistory = PvPAssistant.MatchHistory:CreateFromEndScreen()
    PvPAssistant.DB.MATCH_HISTORY:Save(matchHistory)

    PvPAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()
end
