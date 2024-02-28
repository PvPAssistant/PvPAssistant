---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.ArenaGuide : Frame
PvPLookup.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH", "PLAYER_ENTERING_WORLD" })

---@type GGUI.Frame
PvPLookup.ARENA_GUIDE.frame = nil

PvPLookup.ARENA_GUIDE.specIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

function PvPLookup.ARENA_GUIDE:UpdateAndShow()
    if not UnitAffectingCombat("player") then
        PvPLookup.ARENA_GUIDE.frame:Show() -- TODO: Make optional and muteable for current match
        PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
    end
end

function PvPLookup.ARENA_GUIDE:UpdateArenaSpecIDs()
    -- only update list if its bigger than before!
    -- meaning do not update if someone leaves...
    local numOpponents = GetNumArenaOpponentSpecs()
    if #PvPLookup.ARENA_GUIDE.specIDs.ENEMY_TEAM < numOpponents then
        for i = 1, numOpponents do
            local specID, _ = GetArenaOpponentSpec(i)
            PvPLookup.ARENA_GUIDE.specIDs.ENEMY_TEAM[i] = specID
        end
    end

    local numGroupMembers = GetNumGroupMembers()
    if #PvPLookup.ARENA_GUIDE.specIDs.PLAYER_TEAM < numGroupMembers then
        -- player is not accessible with "partyX" UnitId
        local playerSpecID = PvPLookup.UTIL:GetSpecializationIDByUnit("player")
        PvPLookup.ARENA_GUIDE.specIDs.PLAYER_TEAM[1] = playerSpecID
        for i = 1, numGroupMembers - 1 do
            local specID = PvPLookup.UTIL:GetSpecializationIDByUnit("party" .. i)
            PvPLookup.ARENA_GUIDE.specIDs.PLAYER_TEAM[i + 1] = specID
        end
    end
end

--- this is called whenever a member of the opposite arena party joins
function PvPLookup.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    PvPLookup.ARENA_GUIDE:UpdateAndShow()
end

function PvPLookup.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    PvPLookup.ARENA_GUIDE:UpdateAndShow()
end

PvPLookup.ARENA_GUIDE.resetSpecIDs = true
-- fires multiple times thats why we need a bool to check that its just once per arena at start
function PvPLookup.ARENA_GUIDE:PLAYER_JOINED_PVP_MATCH()
    if PvPLookup.ARENA_GUIDE.resetSpecIDs then
        print("Reseting SpecID Table")
        -- clear
        PvPLookup.ARENA_GUIDE.specIDs = {
            PLAYER_TEAM = {},
            ENEMY_TEAM = {},
        }
        PvPLookup.ARENA_GUIDE:UpdateAndShow()
        PvPLookup.ARENA_GUIDE.resetSpecIDs = false
    end
end

function PvPLookup.ARENA_GUIDE:PLAYER_ENTERING_WORLD()
    PvPLookup.ARENA_GUIDE.resetSpecIDs = true
end
