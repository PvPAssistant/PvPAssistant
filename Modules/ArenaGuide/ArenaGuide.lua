---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.ArenaGuide : Frame
PvPLookup.ARENA_GUIDE = GUTIL:CreateRegistreeForEvents({ "GROUP_ROSTER_UPDATE", "ARENA_PREP_OPPONENT_SPECIALIZATIONS",
    "PLAYER_JOINED_PVP_MATCH" })

---@type GGUI.Frame
PvPLookup.ARENA_GUIDE.frame = nil

PvPLookup.ARENA_GUIDE.specIDs = {
    PLAYER_TEAM = {},
    ENEMY_TEAM = {},
}

function PvPLookup.ARENA_GUIDE:UpdateArenaSpecIDs()
    for i = 1, GetNumArenaOpponents() do
        local specID, _ = GetArenaOpponentSpec(i)
        local playerUID = PvPLookup.UTIL:GetPlayerUIDByUnit("arena" .. i)
        PvPLookup.ARENA_GUIDE.specIDs.ENEMY_TEAM[playerUID] = specID
    end

    -- player is not accessible with "partyX" UnitId
    local playerPlayerUID = PvPLookup.UTIL:GetPlayerUIDByUnit("player")
    local playerSpecID = PvPLookup.UTIL:GetSpecializationIDByUnit("player")
    PvPLookup.ARENA_GUIDE.specIDs.PLAYER_TEAM[playerPlayerUID] = playerSpecID
    for i = 1, GetNumGroupMembers() - 1 do
        local specID = PvPLookup.UTIL:GetSpecializationIDByUnit("party" .. i)
        local playerUID = PvPLookup.UTIL:GetPlayerUIDByUnit("party" .. i)
        PvPLookup.ARENA_GUIDE.specIDs.PLAYER_TEAM[playerUID] = specID
    end
end

--- this is called whenever a member of the opposite arena party joins
function PvPLookup.ARENA_GUIDE:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
end

function PvPLookup.ARENA_GUIDE:GROUP_ROSTER_UPDATE()
    PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
end

function PvPLookup.ARENA_GUIDE:PLAYER_JOINED_PVP_MATCH()
    -- clear
    PvPLookup.ARENA_GUIDE.specIDs = {
        PLAYER_TEAM = {},
        ENEMY_TEAM = {},
    }
    PvPLookup.ARENA_GUIDE.frame:Show() -- TODO: Make optional
    PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
end
