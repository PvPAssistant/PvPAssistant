---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.ArenaGuide : Frame
PvPAssistant.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_STATE_CHANGED" })

---@type GGUI.Frame
PvPAssistant.ARENA_GUIDE.frame = nil

PvPAssistant.ARENA_GUIDE.specIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

function PvPAssistant.ARENA_GUIDE:UpdateAndShow()
    if C_PvP.IsArena() and not UnitAffectingCombat("player") and PvPAssistantOptions.arenaGuideEnable then
        PvPAssistant.ARENA_GUIDE.frame:Show()
        PvPAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
    end
end

function PvPAssistant.ARENA_GUIDE:ResetSpecIDs()
    PvPAssistant.ARENA_GUIDE.specIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }
end

function PvPAssistant.ARENA_GUIDE:UpdateArenaSpecIDs()
    -- only update list if its bigger than before!
    -- meaning do not update if someone leaves...
    local numOpponents = GetNumArenaOpponentSpecs()
    if #PvPAssistant.ARENA_GUIDE.specIDs.ENEMY_TEAM < numOpponents then
        for i = 1, numOpponents do
            local specID, _ = GetArenaOpponentSpec(i)
            PvPAssistant.ARENA_GUIDE.specIDs.ENEMY_TEAM[i] = specID
        end
    end

    local numGroupMembers = GetNumGroupMembers()
    if #PvPAssistant.ARENA_GUIDE.specIDs.PLAYER_TEAM < numGroupMembers then
        -- player is not accessible with "partyX" UnitId
        local playerSpecID = PvPAssistant.UTIL:GetSpecializationIDByUnit("player")
        PvPAssistant.ARENA_GUIDE.specIDs.PLAYER_TEAM[1] = playerSpecID
        for i = 1, numGroupMembers - 1 do
            local specID = PvPAssistant.UTIL:GetSpecializationIDByUnit("party" .. i)
            PvPAssistant.ARENA_GUIDE.specIDs.PLAYER_TEAM[i + 1] = specID
        end
    end
end

function PvPAssistant.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    -- only if guide is enabled and we are within an arena match
    debug("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    PvPAssistant.ARENA_GUIDE:UpdateAndShow()
end

function PvPAssistant.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    -- only if guide is enabled and we are within an arena match
    debug("GROUP_ROSTER_UPDATE")
    PvPAssistant.ARENA_GUIDE:UpdateAndShow()
end

function PvPAssistant.ARENA_GUIDE:PVP_MATCH_STATE_CHANGED()
    local state = C_PvP.GetActiveMatchState()
    -- local isShuffle = C_PvP.IsSoloShuffle()

    if state == Enum.PvPMatchState.StartUp then
        debug("PVP_MATCH_STATE_CHANGED: StartUp")
        PvPAssistant.ARENA_GUIDE:ResetSpecIDs()
    end

    if state == Enum.PvPMatchState.Waiting then
        debug("PVP_MATCH_STATE_CHANGED: Waiting")
    end
    if state == Enum.PvPMatchState.PostRound then
        debug("PVP_MATCH_STATE_CHANGED: PostRound")
        PvPAssistant.ARENA_GUIDE:ResetSpecIDs()
    end
    if state == Enum.PvPMatchState.Inactive then
        debug("PVP_MATCH_STATE_CHANGED: Inactive")
    end
    if state == Enum.PvPMatchState.Engaged then
        debug("PVP_MATCH_STATE_CHANGED: Engaged")
    end
    if state == Enum.PvPMatchState.Complete then
        debug("PVP_MATCH_STATE_CHANGED: Complete")
    end
end
