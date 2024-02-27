---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.ArenaGuide : Frame
PvPLookup.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS" })

---@type GGUI.Frame
PvPLookup.ARENA_GUIDE.frame = nil

function PvPLookup.ARENA_GUIDE:GetArenaSpecIDs()
    local specIDS = {
        [PvPLookup.CONST.DISPLAY_TEAMS.PLAYER_TEAM] = {},
        [PvPLookup.CONST.DISPLAY_TEAMS.ENEMY_TEAM] = {},
    }

    for i = 1, GetNumArenaOpponents() do
        tinsert(specIDS.ENEMY_TEAM, GetArenaOpponentSpec(i))
    end

    -- player is not accessible with "partyX" UnitId
    tinsert(specIDS.PLAYER_TEAM, PvPLookup.UTIL:GetSpecializationIDByUnit("player"))
    for i = 1, GetNumGroupMembers() - 1 do
        tinsert(specIDS.PLAYER_TEAM, PvPLookup.UTIL:GetSpecializationIDByUnit("party" .. i))
    end

    return specIDS
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
