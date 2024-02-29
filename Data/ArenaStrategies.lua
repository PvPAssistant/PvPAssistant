---@class Arenalogs
local Arenalogs = select(2, ...)

local f = Arenalogs.GUTIL:GetFormatter()

---@class Arenalogs.ArenaStrategies
Arenalogs.ARENA_STRATEGIES = {
    data = {}
}

local function mapStrategy(specIDs, strategyText)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    Arenalogs.ARENA_STRATEGIES.data[specCombinationID] = strategyText
end


function Arenalogs.ARENA_STRATEGIES:Get(specIDs)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    return Arenalogs.ARENA_STRATEGIES.data[specCombinationID]
end

mapStrategy({
        Arenalogs.CONST.SPEC_IDS.HOLY_PALADIN,
        Arenalogs.CONST.SPEC_IDS.ARMS
    },
    [[
Try to focus the Paladin first until he pops his Divine Shield.
This strategy was brought to you by someone who does not know any arena tactics so you might not want to do this.
]])

mapStrategy({
        Arenalogs.CONST.SPEC_IDS.HOLY_PALADIN,
        Arenalogs.CONST.SPEC_IDS.ASSASSINATION,
        Arenalogs.CONST.SPEC_IDS.BLOOD,
    },
    [[
Try to burst down the Blood DK first.
This strategy was brought to you by the enemy assassination rogue.
    ]])
