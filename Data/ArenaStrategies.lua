---@class PvPLookup
local PvPLookup = select(2, ...)

local f = PvPLookup.GUTIL:GetFormatter()

---@class PvPLookup.ArenaStrategies
PvPLookup.ARENA_STRATEGIES = {
    data = {}
}

local function mapStrategy(specIDs, strategyText)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    PvPLookup.ARENA_STRATEGIES.data[specCombinationID] = strategyText
end


function PvPLookup.ARENA_STRATEGIES:Get(specIDs)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    return PvPLookup.ARENA_STRATEGIES.data[specCombinationID]
end

mapStrategy({
        PvPLookup.CONST.SPEC_IDS.HOLY_PALADIN,
        PvPLookup.CONST.SPEC_IDS.ARMS
    },
    [[
Try to focus the Paladin first until he pops his Divine Shield.
This strategy was brought to you by someone who does not know any arena tactics so you might not want to do this.
]])

mapStrategy({
        PvPLookup.CONST.SPEC_IDS.HOLY_PALADIN,
        PvPLookup.CONST.SPEC_IDS.ASSASSINATION,
        PvPLookup.CONST.SPEC_IDS.BLOOD,
    },
    [[
Try to burst down the Blood DK first.
This strategy was brought to you by the enemy assassination rogue.
    ]])
