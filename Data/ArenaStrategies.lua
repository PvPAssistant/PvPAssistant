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
mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.BLOOD,
    PvPAssistant.CONST.SPEC_IDS.FROST_DK,
    PvPAssistant.CONST.SPEC_IDS.UNHOLY,
}, [[
    Focus on isolating the Unholy Death Knight first due to their high burst potential and ability to control the battlefield with pets. Keep pressure on them to prevent them from applying their full disease rotation.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.HAVOC,
    PvPAssistant.CONST.SPEC_IDS.VENGEANCE,
}, [[
    Target the Havoc Demon Hunter first for their high mobility and burst damage. Use stuns and slows strategically to limit their ability to kite and utilize their mobility to their advantage.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.BALANCE,
    PvPAssistant.CONST.SPEC_IDS.FERAL,
    PvPAssistant.CONST.SPEC_IDS.GUARDIAN,
    PvPAssistant.CONST.SPEC_IDS.RESTORATION_DRUID,
}, [[
    Aim to control the Restoration Druid early with crowd control to limit their healing output. Druids can be slippery; use interrupts and stuns effectively, especially when they try to cast their more potent heals.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.AUGMENTATION,
    PvPAssistant.CONST.SPEC_IDS.DEVASTATION,
    PvPAssistant.CONST.SPEC_IDS.PRESERVATION,
}, [[
    Prioritize the Preservation Evoker to reduce the enemy team's sustainability. Watch out for their strong area control abilities and try to bait out their defensive cooldowns before committing to a full engage.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.BEAST_MASTERY,
    PvPAssistant.CONST.SPEC_IDS.MARKSMANSHIP,
    PvPAssistant.CONST.SPEC_IDS.SURVIVAL,
}, [[
    Concentrate attacks on the Beast Mastery Hunter to reduce the overall pressure their pets can apply. Utilize line of sight to disrupt the Marksmanship Hunter's long-range attacks.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.ARCANE,
    PvPAssistant.CONST.SPEC_IDS.FIRE,
    PvPAssistant.CONST.SPEC_IDS.FROST,
}, [[
    Isolate and focus the Fire Mage due to their potential for explosive burst damage. Interrupt key spells like Pyroblast and control their movement to prevent effective kiting.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.BREWMASTER_MONK,
    PvPAssistant.CONST.SPEC_IDS.MISTWEAVER_MONK,
    PvPAssistant.CONST.SPEC_IDS.WINDWALKER_MONK,
}, [[
    The Mistweaver Monk should be your primary target due to their strong healing and mobility. Apply consistent pressure to prevent them from freely healing and repositioning.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.HOLY_PALADIN,
    PvPAssistant.CONST.SPEC_IDS.PROTECTION_PALADIN,
    PvPAssistant.CONST.SPEC_IDS.RETRIBUTION_PALADIN,
}, [[
    Focus on the Retribution Paladin first to mitigate their high burst damage and self-sustain capabilities. Beware of their defensive cooldowns like Divine Shield.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.DISCIPLINE_PRIEST,
    PvPAssistant.CONST.SPEC_IDS.HOLY_PRIEST,
    PvPAssistant.CONST.SPEC_IDS.SHADOW_PRIEST,
}, [[
    Target the Discipline Priest to limit their ability to mitigate damage through shields and healing. Use silences and interrupts effectively to prevent their spellcasting.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.ASSASSINATION_ROGUE,
    PvPAssistant.CONST.SPEC_IDS.OUTLAW_ROGUE,
    PvPAssistant.CONST.SPEC_IDS.SUBTLETY_ROGUE,
}, [[
    Neutralize the Subtlety Rogue quickly to prevent them from controlling the fight with their stealth and burst capabilities. Keep an eye out for their vanish and try to reveal them with AoE when possible.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.ELEMENTAL_SHAMAN,
    PvPAssistant.CONST.SPEC_IDS.ENHANCEMENT_SHAMAN,
    PvPAssistant.CONST.SPEC_IDS.RESTORATION_SHAMAN,
}, [[
    Prioritize the Restoration Shaman for their versatile healing and utility. Interrupt key spells like Healing Wave and Chain Heal to cripple their healing output.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.AFFLICTION_WARLOCK,
    PvPAssistant.CONST.SPEC_IDS.DEMONOLOGY_WARLOCK,
    PvPAssistant.CONST.SPEC_IDS.DESTRUCTION_WARLOCK,
}, [[
    Focus on the Affliction Warlock to prevent them from ramping up their damage over time. Use dispels to manage their curses and afflictions effectively.
    ]])

mapStrategy({
    PvPAssistant.CONST.SPEC_IDS.ARMS_WARRIOR,
    PvPAssistant.CONST.SPEC_IDS.FURY_WARRIOR,
    PvPAssistant.CONST.SPEC_IDS.PROTECTION_WARRIOR,
}, [[
    The Arms Warrior should be your first target due to their ability to deal significant burst damage and control opponents with stuns and fears. Keep them slowed to limit their mobility.
    ]])
