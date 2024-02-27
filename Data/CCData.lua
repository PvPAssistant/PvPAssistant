---@class PvPLookup
local PvPLookup = select(2, ...)

local SPECS = PvPLookup.CONST.SPEC_IDS
local TYPES = PvPLookup.CONST.CC_SPELL_TYPES
local SEVERITY = PvPLookup.CONST.PVP_CC_SEVERITY

---@class PvPLookup.SpellCCData.UpgradeInfo
---@field spellID number
---@field type PvPLookup.CCSpellTypes
---@field duration? number
---@field severity PvPLookup.PVPCCSeverity


---@class PvPLookup.SpellCCData
---@field spellID number
---@field type PvPLookup.CCSpellTypes
---@field duration? number
---@field talentUpgrades? PvPLookup.SpellCCData.UpgradeInfo[] -- spellID list of potential talent upgrades including severity and type
---@field passive? boolean
---@field severity PvPLookup.PVPCCSeverity

---@type table<ClassFile, table<PvPLookup.SpecIDs|ClassFile, PvPLookup.SpellCCData[]>>
PvPLookup.CC_DATA = {
    WARRIOR = {
        WARRIOR = {
            {
                spellID = 23920, -- Spell Reflect
                type = TYPES.REFLECT,
                duration = 5,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 100, -- Charge
                type = TYPES.ROOT,
                duration = 1,
                severity = SEVERITY.LOW,
            },
            {
                spellID = 46968, -- Shockwave
                type = TYPES.STUN,
                duration = 2,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 107570, -- Stormbolt
                type = TYPES.STUN,
                duration = 4,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 12323, -- Piercing Howl
                type = TYPES.SLOW,
                duration = 8,
                severity = SEVERITY.LOW,
            },
            {
                spellID = 396719, -- Thunderclap
                type = TYPES.SLOW,
                duration = 10,
                talentUpgrades = {
                    {
                        spellID = 275339, -- Crackling Thunder
                        type = TYPES.SLOW,
                        severity = SEVERITY.LOW
                    },
                },
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.FURY] = {
        },
        [SPECS.PROTECTION] = {
        },
    },
    PALADIN = {
        PALADIN = {
            {
                spellID = 66008, -- Repentance
                type = TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 853, -- Hammer of Justice
                type = TYPES.STUN,
                duration = 3,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 115750, -- Blinding Light
                type = TYPES.DISORIENT,
                duration = 4,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 410126, -- Searing Glare (PvP Talent)
                type = TYPES.DISORIENT,
                duration = 4,
                severity = SEVERITY.MEDIUM,
            },
        },
        [SPECS.RETRIBUTION] = {
        },
        [SPECS.HOLY_PALADIN] = {

        },
        [SPECS.PROTECTION_PALADIN] = {
            {
                spellID = 215652, -- Shield of Virtue (PvP Talent)
                type = TYPES.SILENCE,
                duration = 3,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 228049, -- Guardian of the Forgotten Queen (PvP Talent)
                type = TYPES.IMMUNITY,
                duration = 10,
                severity = SEVERITY.HIGH,
            }
        },
    },
    DEATHKNIGHT = {
        DEATHKNIGHT = {
            {
                spellID = 383269, -- Abomination Limn
                type = TYPES.GRIP,
                duration = 12,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 221562, -- Asphyxiate
                type = TYPES.STUN,
                duration = 5,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 49576, -- Death Grip
                type = TYPES.GRIP,
                duration = 1,
                severity = SEVERITY.HIGH,
                talentUpgrades = {
                    {
                        spellID = 202731, -- walking dead
                        type = TYPES.SLOW,
                        severity = SEVERITY.MEDIUM,
                        duration = 8,
                    },
                    {
                        spellID = 389679, -- clenching grasp
                        type = TYPES.SLOW,
                        severity = SEVERITY.MEDIUM,
                        duration = 6,
                    }
                }
            },
            {
                spellID = 45524, -- Chains of Ice
                type = TYPES.SLOW,
                duration = 8,
                severity = SEVERITY.LOW
            },
            {
                spellID = 207167, -- Blinding Sleet
                type = TYPES.DISORIENT,
                duration = 5,
                severity = SEVERITY.HIGH
            },
        },
        [SPECS.BLOOD] = {
            {
                spellID = 108199, -- Mass Grip
                type = TYPES.GRIP,
                duration = 1,
                severity = SEVERITY.MEDIUM
            },
        },
        [SPECS.FROST] = {
            {
                spellID = 279302, -- Frostwyrms Fury
                type = TYPES.SLOW,
                duration = 10,
                severity = SEVERITY.MEDIUM,
                talentUpgrades = {
                    {
                        spellID = 377047, -- Absolute Zero
                        type = TYPES.ROOT,
                        severity = SEVERITY.LOW,
                        duration = 3
                    }
                }
            },
            {
                spellID = 196770, -- Dead of Winter (PvP Talent)
                type = TYPES.SLOW,
                duration = 2,
                passive = true,
                severity = SEVERITY.LOW,
                talentUpgrades = {
                    {
                        spellID = 287250,
                        type = TYPES.STUN,
                        severity = SEVERITY.HIGH,
                        duration = 4,
                    },
                },
            },
        },
        [SPECS.UNHOLY] = {
            {
                spellID = 77606, -- Dark Simulacrum (PvP Talent)
                type = TYPES.REFLECT,
                duration = 12,
                severity = SEVERITY.MEDIUM
            },
            {
                spellID = 47476, -- Strangulate (PvP Talent)
                type = TYPES.SILENCE,
                duration = 4,
                severity = SEVERITY.MEDIUM
            },
            {
                spellID = 356512, -- Doomburst (PvP Talent)
                type = TYPES.SLOW,
                duration = 3,
                severity = SEVERITY.LOW,
                passive = true,
            },
        },
    },
    HUNTER = {
        HUNTER = {
            {
                spellID = 19386, -- Wyvern Sting
                type = TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 187650, -- Freezing Trap
                type = TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.MEDIUM,
            },
        },
        [SPECS.MARKSMANSHIP] = {

        },
        [SPECS.BEAST_MASTERY] = {

        },
        [SPECS.SURVIVAL] = {

        },
    },
    MAGE = {
        MAGE = {

        },
        [SPECS.ARCANE] = {
        },
        [SPECS.FIRE] = {

        },
        [SPECS.FROST] = {

        },
    },
    ROGUE = {
        ROGUE = {

        },
        [SPECS.ASSASSINATION] = {

        },
        [SPECS.OUTLAW] = {

        },
        [SPECS.SUBTLETY] = {

        },
    },
    DEMONHUNTER = {
        DEMONHUNTER = {

        },
        [SPECS.HAVOC] = {

        },
    },
    MONK = {
        MONK = {

        },
        [SPECS.BREWMASTER] = {

        },
        [SPECS.MISTWEAVER] = {

        },
        [SPECS.WINDWALKER] = {

        },
    },
    PRIEST = {
        PRIEST = {
        },
        [SPECS.DISCIPLINE] = {

        },
        [SPECS.HOLY] = {

        },
        [SPECS.SHADOW] = {

        },
    },
    SHAMAN = {
        SHAMAN = {

        },
        [SPECS.ELEMENTAL] = {

        },
        [SPECS.ENHANCEMENT] = {

        },
        [SPECS.RESTORATION] = {

        },
    },
    WARLOCK = {
        WARLOCK = {

        },
        [SPECS.AFFLICTION] = {

        },
        [SPECS.DEMONOLOGY] = {

        },
        [SPECS.DESTRUCTION] = {

        },
    },
    EVOKER = {
        EVOKER = {

        },
        [SPECS.DEVASTATION] = {
        },
    }









}
