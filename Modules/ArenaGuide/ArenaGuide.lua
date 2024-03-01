---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL
local debug = Arenalogs.DEBUG:GetDebugPrint()

---@class Arenalogs.ArenaGuide : Frame
Arenalogs.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_STATE_CHANGED" })

---@type GGUI.Frame
Arenalogs.ARENA_GUIDE.frame = nil

Arenalogs.ARENA_GUIDE.specIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

function Arenalogs.ARENA_GUIDE:UpdateAndShow()
    if not UnitAffectingCombat("player") then
        Arenalogs.ARENA_GUIDE.frame:Show() -- TODO: Make optional and muteable for current match
        Arenalogs.ARENA_GUIDE.FRAMES:UpdateDisplay()
    end
end

function Arenalogs.ARENA_GUIDE:ResetSpecIDs()
    Arenalogs.ARENA_GUIDE.specIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }
end

function Arenalogs.ARENA_GUIDE:UpdateArenaSpecIDs()
    -- only update list if its bigger than before!
    -- meaning do not update if someone leaves...
    local numOpponents = GetNumArenaOpponentSpecs()
    if #Arenalogs.ARENA_GUIDE.specIDs.ENEMY_TEAM < numOpponents then
        for i = 1, numOpponents do
            local specID, _ = GetArenaOpponentSpec(i)
            Arenalogs.ARENA_GUIDE.specIDs.ENEMY_TEAM[i] = specID
        end
    end

    local numGroupMembers = GetNumGroupMembers()
    if #Arenalogs.ARENA_GUIDE.specIDs.PLAYER_TEAM < numGroupMembers then
        -- player is not accessible with "partyX" UnitId
        local playerSpecID = Arenalogs.UTIL:GetSpecializationIDByUnit("player")
        Arenalogs.ARENA_GUIDE.specIDs.PLAYER_TEAM[1] = playerSpecID
        for i = 1, numGroupMembers - 1 do
            local specID = Arenalogs.UTIL:GetSpecializationIDByUnit("party" .. i)
            Arenalogs.ARENA_GUIDE.specIDs.PLAYER_TEAM[i + 1] = specID
        end
    end
end

function Arenalogs.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    debug("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    Arenalogs.ARENA_GUIDE:UpdateAndShow()
end

function Arenalogs.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    debug("GROUP_ROSTER_UPDATE")
    Arenalogs.ARENA_GUIDE:UpdateAndShow()
end

function Arenalogs.ARENA_GUIDE:PVP_MATCH_STATE_CHANGED()
    local state = C_PvP.GetActiveMatchState()
    -- local isShuffle = C_PvP.IsSoloShuffle()

    if state == Enum.PvPMatchState.StartUp then
        debug("PVP_MATCH_STATE_CHANGED: StartUp")
        Arenalogs.ARENA_GUIDE:ResetSpecIDs()
    end

    if state == Enum.PvPMatchState.Waiting then
        debug("PVP_MATCH_STATE_CHANGED: Waiting")
    end
    if state == Enum.PvPMatchState.PostRound then
        debug("PVP_MATCH_STATE_CHANGED: PostRound")
        Arenalogs.ARENA_GUIDE:ResetSpecIDs()
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
