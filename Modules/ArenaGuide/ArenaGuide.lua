---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.ArenaGuide : Frame
PvPLookup.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH" })

---@type GGUI.Frame
PvPLookup.ARENA_GUIDE.frame = nil

function PvPLookup.ARENA_GUIDE:GetArenaSpecIDs()
    local specIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }

    for i = 1, GetNumArenaOpponents() do
        tinsert(specIDs.ENEMY_TEAM, GetArenaOpponentSpec(i))
    end

    -- player is not accessible with "partyX" UnitId
    tinsert(specIDs.PLAYER_TEAM, PvPLookup.UTIL:GetSpecializationIDByUnit("player"))
    for i = 1, GetNumGroupMembers() - 1 do
        tinsert(specIDs.PLAYER_TEAM, PvPLookup.UTIL:GetSpecializationIDByUnit("party" .. i))
    end

    return specIDs
end

--- this is called whenever a member of the opposite arena party joins
function PvPLookup.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    PvPLookup.ARENA_GUIDE.frame:Show()
    PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
end

function PvPLookup.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    PvPLookup.ARENA_GUIDE.frame:Show()
    PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
end

function PvPLookup.ARENA_GUIDE:PLAYER_JOINED_PVP_MATCH()
    PvPLookup.ARENA_GUIDE.frame:Show()
    PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
end
