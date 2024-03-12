---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GUTIL = PvpAssistant.GUTIL
local debug = PvpAssistant.DEBUG:GetDebugPrint()

---@class PvpAssistant.ArenaGuide : Frame
PvpAssistant.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_STATE_CHANGED" })

---@type GGUI.Frame
PvpAssistant.ARENA_GUIDE.frame = nil

PvpAssistant.ARENA_GUIDE.specIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

function PvpAssistant.ARENA_GUIDE:UpdateAndShow()
    if C_PvP.IsArena() and not UnitAffectingCombat("player") and PvpAssistantOptions.arenaGuideEnable then
        PvpAssistant.ARENA_GUIDE.frame:Show()
        PvpAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
    end
end

function PvpAssistant.ARENA_GUIDE:ResetSpecIDs()
    PvpAssistant.ARENA_GUIDE.specIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }
end

function PvpAssistant.ARENA_GUIDE:UpdateArenaSpecIDs()
    -- only update list if its bigger than before!
    -- meaning do not update if someone leaves...
    local numOpponents = GetNumArenaOpponentSpecs()
    if #PvpAssistant.ARENA_GUIDE.specIDs.ENEMY_TEAM < numOpponents then
        for i = 1, numOpponents do
            local specID, _ = GetArenaOpponentSpec(i)
            PvpAssistant.ARENA_GUIDE.specIDs.ENEMY_TEAM[i] = specID
        end
    end

    local numGroupMembers = GetNumGroupMembers()
    if #PvpAssistant.ARENA_GUIDE.specIDs.PLAYER_TEAM < numGroupMembers then
        -- player is not accessible with "partyX" UnitId
        local playerSpecID = PvpAssistant.UTIL:GetSpecializationIDByUnit("player")
        PvpAssistant.ARENA_GUIDE.specIDs.PLAYER_TEAM[1] = playerSpecID
        for i = 1, numGroupMembers - 1 do
            local specID = PvpAssistant.UTIL:GetSpecializationIDByUnit("party" .. i)
            PvpAssistant.ARENA_GUIDE.specIDs.PLAYER_TEAM[i + 1] = specID
        end
    end
end

function PvpAssistant.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    -- only if guide is enabled and we are within an arena match
    debug("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    PvpAssistant.ARENA_GUIDE:UpdateAndShow()
end

function PvpAssistant.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    -- only if guide is enabled and we are within an arena match
    debug("GROUP_ROSTER_UPDATE")
    PvpAssistant.ARENA_GUIDE:UpdateAndShow()
end

function PvpAssistant.ARENA_GUIDE:PVP_MATCH_STATE_CHANGED()
    local state = C_PvP.GetActiveMatchState()
    -- local isShuffle = C_PvP.IsSoloShuffle()

    if state == Enum.PvPMatchState.StartUp then
        debug("PVP_MATCH_STATE_CHANGED: StartUp")
        PvpAssistant.ARENA_GUIDE:ResetSpecIDs()
    end

    if state == Enum.PvPMatchState.Waiting then
        debug("PVP_MATCH_STATE_CHANGED: Waiting")
    end
    if state == Enum.PvPMatchState.PostRound then
        debug("PVP_MATCH_STATE_CHANGED: PostRound")
        PvpAssistant.ARENA_GUIDE:ResetSpecIDs()
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
