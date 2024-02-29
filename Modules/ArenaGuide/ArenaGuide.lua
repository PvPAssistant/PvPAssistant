---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL

---@class Arenalogs.ArenaGuide : Frame
Arenalogs.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH", "PLAYER_ENTERING_WORLD" })

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

-- Arenalogs.ARENA_GUIDE.resetSpecIDs = true
--- this is called whenever a member of the opposite arena party joins
function Arenalogs.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    Arenalogs.ARENA_GUIDE:ResetSpecIDs()
    Arenalogs.ARENA_GUIDE:UpdateAndShow()
end

function Arenalogs.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    Arenalogs.ARENA_GUIDE:ResetSpecIDs()
    Arenalogs.ARENA_GUIDE:UpdateAndShow()
end

-- fires multiple times thats why we need a bool to check that its just once per arena at start
function Arenalogs.ARENA_GUIDE:PLAYER_JOINED_PVP_MATCH()
    -- if Arenalogs.ARENA_GUIDE.resetSpecIDs then
    --     -- Arenalogs.ARENA_GUIDE:ResetSpecIDs()
    --     Arenalogs.ARENA_GUIDE:UpdateAndShow()
    --     Arenalogs.ARENA_GUIDE.resetSpecIDs = false
    -- end
end

function Arenalogs.ARENA_GUIDE:PLAYER_ENTERING_WORLD()
    -- Arenalogs.ARENA_GUIDE.resetSpecIDs = true
end
