---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.Abilities
PvPLookup.ABILITIES = {}

---@param specIDs number[]
---@return table<number, PvPLookup.AbilityData[]>
function PvPLookup.ABILITIES:GetAbilitiesForSpecs(specIDs)
    local abilities = {}
    for classFile, specList in pairs(PvPLookup.ABILITY_DATA) do
        for specID, spellList in pairs(specList) do
            if tContains(specIDs, specID) then
                abilities[specID] = GUTIL:Concat({ spellList, specList[classFile] })
            end
        end
    end
    return abilities
end

local SPECS = PvPLookup.CONST.SPEC_IDS
local TYPES = PvPLookup.CONST.ABILITY_TYPES
local SUB_TYPES = PvPLookup.CONST.ABILITY_SUB_TYPES
local SEVERITY = PvPLookup.CONST.PVP_SEVERITY

---@class PvPLookup.AbilityData.UpgradeInfo
---@field spellID number
---@field abilityType PvPLookup.AbilityTypes
---@field subType? PvPLookup.AbilitySubTypes
---@field duration? number
---@field severity PvPLookup.PVPSeverity

---@class PvPLookup.AbilityData
---@field spellID number
---@field abilityType PvPLookup.AbilityTypes
---@field subType PvPLookup.AbilitySubTypes
---@field duration? number
---@field talentUpgrades? PvPLookup.AbilityData.UpgradeInfo[] -- spellID list of potential talent upgrades including severity and subType
---@field passive? boolean
---@field severity PvPLookup.PVPSeverity

---@type table<ClassFile, table<PvPLookup.SpecIDs|ClassFile, PvPLookup.AbilityData[]>>
PvPLookup.ABILITY_DATA = {
    WARRIOR = {
        WARRIOR = {
            {
                spellID = 23920, -- Spell Reflect
                abilityType = TYPES.DEF,
                subType = SUB_TYPES.REFLECT,
                duration = 5,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 100, -- Charge
                abilityType = TYPES.CC,
                subType = SUB_TYPES.ROOT,
                duration = 1,
                severity = SEVERITY.LOW,
            },
            {
                spellID = 46968, -- Shockwave
                abilityType = TYPES.CC,
                subType = SUB_TYPES.STUN,
                duration = 2,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 107570, -- Stormbolt
                abilityType = TYPES.CC,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 12323, -- Piercing Howl
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SLOW,
                duration = 8,
                severity = SEVERITY.LOW,
            },
            {
                spellID = 396719, -- Thunderclap
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SLOW,
                duration = 10,
                severity = SEVERITY.LOW,
                talentUpgrades = {
                    {
                        spellID = 275339, -- Crackling Thunder
                        abilityType = TYPES.CC,
                        subType = SUB_TYPES.SLOW,
                        severity = SEVERITY.LOW
                    },
                },
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
                abilityType = TYPES.CC,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 853, -- Hammer of Justice
                abilityType = TYPES.CC,
                subType = SUB_TYPES.STUN,
                duration = 3,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 115750, -- Blinding Light
                abilityType = TYPES.CC,
                subType = SUB_TYPES.DISORIENT,
                duration = 4,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 410126, -- Searing Glare (PvP Talent)
                abilityType = TYPES.CC,
                subType = SUB_TYPES.DISORIENT,
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
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SILENCE,
                duration = 3,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 228049, -- Guardian of the Forgotten Queen (PvP Talent)
                abilityType = TYPES.DEF,
                subType = SUB_TYPES.IMMUNITY,
                duration = 10,
                severity = SEVERITY.HIGH,
            }
        },
    },
    DEATHKNIGHT = {
        DEATHKNIGHT = {
            {
                spellID = 383269, -- Abomination Limn
                abilityType = TYPES.CC,
                subType = SUB_TYPES.GRIP,
                duration = 12,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 221562, -- Asphyxiate
                abilityType = TYPES.CC,
                subType = SUB_TYPES.STUN,
                duration = 5,
                severity = SEVERITY.HIGH,
            },
            {
                spellID = 49576, -- Death Grip
                abilityType = TYPES.CC,
                subType = SUB_TYPES.GRIP,
                duration = 1,
                severity = SEVERITY.HIGH,
                talentUpgrades = {
                    {
                        spellID = 202731, -- walking dead
                        abilityType = TYPES.CC,
                        subType = SUB_TYPES.SLOW,
                        severity = SEVERITY.MEDIUM,
                        duration = 8,
                    },
                    {
                        spellID = 389679, -- clenching grasp
                        abilityType = TYPES.CC,
                        subType = SUB_TYPES.SLOW,
                        severity = SEVERITY.MEDIUM,
                        duration = 6,
                    }
                }
            },
            {
                spellID = 45524, -- Chains of Ice
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SLOW,
                duration = 8,
                severity = SEVERITY.LOW
            },
            {
                spellID = 207167, -- Blinding Sleet
                abilityType = TYPES.CC,
                subType = SUB_TYPES.DISORIENT,
                duration = 5,
                severity = SEVERITY.HIGH
            },
        },
        [SPECS.BLOOD] = {
            {
                spellID = 108199, -- Mass Grip
                abilityType = TYPES.CC,
                subType = SUB_TYPES.GRIP,
                duration = 1,
                severity = SEVERITY.MEDIUM
            },
        },
        [SPECS.FROST] = {
            {
                spellID = 279302, -- Frostwyrms Fury
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SLOW,
                duration = 10,
                severity = SEVERITY.MEDIUM,
                talentUpgrades = {
                    {
                        spellID = 377047, -- Absolute Zero
                        abilityType = TYPES.CC,
                        subType = SUB_TYPES.ROOT,
                        severity = SEVERITY.LOW,
                        duration = 3
                    }
                }
            },
            {
                spellID = 196770, -- Dead of Winter (PvP Talent)
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SLOW,
                duration = 2,
                passive = true,
                severity = SEVERITY.LOW,
                talentUpgrades = {
                    {
                        spellID = 287250,
                        abilityType = TYPES.CC,
                        subType = SUB_TYPES.STUN,
                        severity = SEVERITY.HIGH,
                        duration = 4,
                    },
                },
            },
        },
        [SPECS.UNHOLY] = {
            {
                spellID = 77606, -- Dark Simulacrum (PvP Talent)
                abilityType = TYPES.DEF,
                subType = SUB_TYPES.REFLECT,
                duration = 12,
                severity = SEVERITY.MEDIUM
            },
            {
                spellID = 47476, -- Strangulate (PvP Talent)
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SILENCE,
                duration = 4,
                severity = SEVERITY.MEDIUM
            },
            {
                spellID = 356512, -- Doomburst (PvP Talent)
                abilityType = TYPES.CC,
                subType = SUB_TYPES.SLOW,
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
                abilityType = TYPES.CC,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.MEDIUM,
            },
            {
                spellID = 187650, -- Freezing Trap
                abilityType = TYPES.CC,
                subType = SUB_TYPES.INCAPACITATE,
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
