---@class PvpAssistant
local PvpAssistant = select(2, ...)

local f = PvpAssistant.GUTIL:GetFormatter()

---@class PvpAssistant.ArenaStrategies
PvpAssistant.ARENA_STRATEGIES = {
    data = {}
}

local function mapStrategy(specIDs, strategyText)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    PvpAssistant.ARENA_STRATEGIES.data[specCombinationID] = strategyText
end


function PvpAssistant.ARENA_STRATEGIES:Get(specIDs)
    table.sort(specIDs)
    local specCombinationID = table.concat(specIDs)
    return PvpAssistant.ARENA_STRATEGIES.data[specCombinationID]
end

mapStrategy({
        PvpAssistant.CONST.SPEC_IDS.HOLY_PALADIN,
        PvpAssistant.CONST.SPEC_IDS.ARMS
    },
    [[
Try to focus the Paladin first until he pops his Divine Shield.
This strategy was brought to you by someone who does not know any arena tactics so you might not want to do this.
]])

mapStrategy({
        PvpAssistant.CONST.SPEC_IDS.HOLY_PALADIN,
        PvpAssistant.CONST.SPEC_IDS.ASSASSINATION,
        PvpAssistant.CONST.SPEC_IDS.BLOOD,
    },
    [[
Try to burst down the Blood DK first.
This strategy was brought to you by the enemy assassination rogue.
    ]])
