---[[ ArenaDeathAnalyzer Arena_Death_Analyzer ARENA_DEATH_ANALYZER ]]
---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL
local debug = Arenalogs.DEBUG:GetDebugPrint()

---@class Arenalogs.ArenaDeathAnalyzer : Frame
Arenalogs.ARENA_DEATH_ANALYZER = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE",
    "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_STATE_CHANGED" })

---@type GGUI.Frame
Arenalogs.ARENA_DEATH_ANALYZER.frame = nil

Arenalogs.ARENA_DEATH_ANALYZER.specIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

function Arenalogs.ARENA_DEATH_ANALYZER:UpdateAndShow()
    if C_PvP.IsArena() and not UnitAffectingCombat("player") and ArenalogsOptions.ArenaDeathAnalyzerEnable then
        Arenalogs.ARENA_DEATH_ANALYZER.frame:Show()
        Arenalogs.ARENA_DEATH_ANALYZER.FRAMES:UpdateDisplay()
    end
end

function Arenalogs.ARENA_DEATH_ANALYZER:ResetSpecIDs()
    Arenalogs.ARENA_DEATH_ANALYZER.specIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }
end

function Arenalogs.ARENA_DEATH_ANALYZER:UpdateArenaSpecIDs()
    -- only update list if its bigger than before!
    -- meaning do not update if someone leaves...
    local numOpponents = GetNumArenaOpponentSpecs()
    if #Arenalogs.ARENA_DEATH_ANALYZER.specIDs.ENEMY_TEAM < numOpponents then
        for i = 1, numOpponents do
            local specID, _ = GetArenaOpponentSpec(i)
            Arenalogs.ARENA_DEATH_ANALYZER.specIDs.ENEMY_TEAM[i] = specID
        end
    end

    local numGroupMembers = GetNumGroupMembers()
    if #Arenalogs.ARENA_DEATH_ANALYZER.specIDs.PLAYER_TEAM < numGroupMembers then
        -- player is not accessible with "partyX" UnitId
        local playerSpecID = Arenalogs.UTIL:GetSpecializationIDByUnit("player")
        Arenalogs.ARENA_DEATH_ANALYZER.specIDs.PLAYER_TEAM[1] = playerSpecID
        for i = 1, numGroupMembers - 1 do
            local specID = Arenalogs.UTIL:GetSpecializationIDByUnit("party" .. i)
            Arenalogs.ARENA_DEATH_ANALYZER.specIDs.PLAYER_TEAM[i + 1] = specID
        end
    end
end

function Arenalogs.ARENA_DEATH_ANALYZER:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    -- only if guide is enabled and we are within an arena match
    debug("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    Arenalogs.ARENA_DEATH_ANALYZER:UpdateAndShow()
end

function Arenalogs.ARENA_DEATH_ANALYZER:GROUP_ROSTER_UPDATE()
    -- only if guide is enabled and we are within an arena match
    debug("GROUP_ROSTER_UPDATE")
    Arenalogs.ARENA_DEATH_ANALYZER:UpdateAndShow()
end

function Arenalogs.ARENA_DEATH_ANALYZER:PVP_MATCH_STATE_CHANGED()
    local state = C_PvP.GetActiveMatchState()
    -- local isShuffle = C_PvP.IsSoloShuffle()

    if state == Enum.PvPMatchState.StartUp then
        debug("PVP_MATCH_STATE_CHANGED: StartUp")
        Arenalogs.ARENA_DEATH_ANALYZER:ResetSpecIDs()
    end

    if state == Enum.PvPMatchState.Waiting then
        debug("PVP_MATCH_STATE_CHANGED: Waiting")
    end
    if state == Enum.PvPMatchState.PostRound then
        debug("PVP_MATCH_STATE_CHANGED: PostRound")
        Arenalogs.ARENA_DEATH_ANALYZER:ResetSpecIDs()
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
