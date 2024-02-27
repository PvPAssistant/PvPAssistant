---@class PvPLookup
local PvPLookup = select(2, ...)

local f = PvPLookup.GUTIL:GetFormatter()

local function mapCombinations(specIDs, strategyText)
    if #specIDs == 2 then
        PvPLookup.ARENA_STRATEGIES[specIDs[1] .. specIDs[2]] = strategyText
        PvPLookup.ARENA_STRATEGIES[specIDs[2] .. specIDs[1]] = strategyText
    elseif #specIDs == 3 then
        PvPLookup.ARENA_STRATEGIES[specIDs[1] .. specIDs[2] .. specIDs[3]] = strategyText
        PvPLookup.ARENA_STRATEGIES[specIDs[1] .. specIDs[3] .. specIDs[2]] = strategyText

        PvPLookup.ARENA_STRATEGIES[specIDs[2] .. specIDs[1] .. specIDs[3]] = strategyText
        PvPLookup.ARENA_STRATEGIES[specIDs[2] .. specIDs[3] .. specIDs[1]] = strategyText

        PvPLookup.ARENA_STRATEGIES[specIDs[3] .. specIDs[2] .. specIDs[1]] = strategyText
        PvPLookup.ARENA_STRATEGIES[specIDs[3] .. specIDs[1] .. specIDs[2]] = strategyText
    end
end

---@class PvPLookup.ArenaStrategies
PvPLookup.ARENA_STRATEGIES = {}

mapCombinations({
        PvPLookup.CONST.SPEC_IDS.HOLY_PALADIN,
        PvPLookup.CONST.SPEC_IDS.ARMS
    },
    "Try to focus the Paladin first until he pops his Divine Shield. Then retreat, wait and focus again after the immunity is gone.\n\nThis strategy was brought to you by someone who does not know any Arena Tactics so you might not want to do this.")
