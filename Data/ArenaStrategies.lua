---@class PvPAssistant
local PvPAssistant = select(2, ...)

local f = PvPAssistant.GUTIL:GetFormatter()

---@class PvPAssistant.ArenaStrategies
PvPAssistant.ARENA_STRATEGIES = {
    data = {}
}

local function mapStrategy(specIDs, strategyText)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    PvPAssistant.ARENA_STRATEGIES.data[specCombinationID] = strategyText
end


function PvPAssistant.ARENA_STRATEGIES:Get(specIDs)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    return PvPAssistant.ARENA_STRATEGIES.data[specCombinationID]
end

mapStrategy({
        PvPAssistant.CONST.SPEC_IDS.HOLY_PALADIN,
        PvPAssistant.CONST.SPEC_IDS.ARMS
    },
    [[
Try to focus the Paladin first until he pops his Divine Shield.
This strategy was brought to you by someone who does not know any arena tactics so you might not want to do this.
]])

mapStrategy({
        PvPAssistant.CONST.SPEC_IDS.HOLY_PALADIN,
        PvPAssistant.CONST.SPEC_IDS.ASSASSINATION,
        PvPAssistant.CONST.SPEC_IDS.BLOOD,
    },
    [[
Try to burst down the Blood DK first.
This strategy was brought to you by the enemy assassination rogue.
    ]])
