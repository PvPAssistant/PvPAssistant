---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.Abilities
PvPAssistant.ABILITIES = {}

---@param specIDs number[]
---@return table<number, PvPAssistant.AbilityData[]>
function PvPAssistant.ABILITIES:GetAbilitiesForSpecs(specIDs)
    local abilities = {}
    for classFile, specList in pairs(PvPAssistant.ABILITY_DATA) do
        for specID, spellList in pairs(specList) do
            if tContains(specIDs, specID) then
                abilities[specID] = GUTIL:Concat({ spellList, specList[classFile] })
            end
        end
    end
    return abilities
end

function PvPAssistant.ABILITIES:GetSpellByID(spellID)
    for _, specList in pairs(PvPAssistant.ABILITY_DATA) do
        for _, spellList in pairs(specList) do
            for _, abilityData in ipairs(spellList) do
                if abilityData.spellID == spellID then
                    return abilityData
                end
            end
        end
    end
end

local SPECS = PvPAssistant.CONST.SPEC_IDS
local TYPES = PvPAssistant.CONST.ABILITY_TYPES
local SUB_TYPES = PvPAssistant.CONST.ABILITY_SUB_TYPES
local SEVERITY = PvPAssistant.CONST.PVP_SEVERITY

---@class PvPAssistant.AbilityData.UpgradeInfo
---@field spellID number
---@field abilityType PvPAssistant.AbilityTypes
---@field subType? PvPAssistant.AbilitySubTypes
---@field duration? number
---@field severity PvPAssistant.PVPSeverity

---@class PvPAssistant.AbilityData
---@field spellID number
---@field abilityType PvPAssistant.AbilityTypes
---@field subType PvPAssistant.AbilitySubTypes
---@field duration? number
---@field talentUpgrades? PvPAssistant.AbilityData.UpgradeInfo[] -- spellID list of potential talent upgrades including severity and subType
---@field passive? boolean
---@field severity PvPAssistant.PVPSeverity
---@field additionalData? table<string, string>

---@type table<ClassFile, table<PvPAssistant.SpecIDs|ClassFile, PvPAssistant.AbilityData[]>>
PvPAssistant.ABILITY_DATA = {
    WARRIOR = {
        WARRIOR = {
            { -- Thunderstruck
                spellID = 199045,
                subType = SUB_TYPES.ROOT,
                duration = 1,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
                passive = true,
            },
            { -- Intimidating Shout
                spellID = 5246,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 23920, -- Spell Reflect
                abilityType = TYPES.DEF,
                subType = SUB_TYPES.REFLECT,
                duration = 5,
                severity = SEVERITY.HIGH,
                additionalData = {
                    ["PvP Damage Reduction"] = f.g("50%")
                },
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
                severity = SEVERITY.HIGH,
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
            { -- Disarm
                spellID = 236077,
                subType = SUB_TYPES.DISARM,
                duration = 6,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
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
                duration = 6,
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
            { -- Turn Evil
                spellID = 10326,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
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
            { -- Asphyxiate
                spellID = 221562,
                subType = SUB_TYPES.STUN,
                duration = 5,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Gnaw (Ghoul)
                spellID = 91800,
                subType = SUB_TYPES.STUN,
                duration = 1,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Reanimation
                spellID = 210128,
                subType = SUB_TYPES.STUN,
                duration = 3,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Monstrous Blow
                spellID = 91797,
                subType = SUB_TYPES.STUN,
                duration = 2,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Strangulate
                spellID = 47476,
                subType = SUB_TYPES.SILENCE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 383269, -- Abomination Limb
                abilityType = TYPES.CC,
                subType = SUB_TYPES.GRIP,
                duration = 12,
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
            {
                spellID = 77606, -- Dark Simulacrum (PvP Talent)
                abilityType = TYPES.DEF,
                subType = SUB_TYPES.REFLECT,
                duration = 12,
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
            { -- Dead of Winter
                spellID = 287250,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Deathchill
                spellID = 204080,
                subType = SUB_TYPES.ROOT,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Frozen Center
                spellID = 204135,
                subType = SUB_TYPES.ROOT,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.UNHOLY] = {
            { -- Shambling Rush
                spellID = 91802,
                subType = SUB_TYPES.ROOT,
                duration = 2,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
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
            { -- Freezing Trap
                spellID = 187650,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Scare Beast
                spellID = 1513,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Spider Sting
                spellID = 202914,
                subType = SUB_TYPES.SILENCE,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Binding Shot
                spellID = 109248,
                subType = SUB_TYPES.ROOT,
                duration = 3,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.MARKSMANSHIP] = {
            { -- (Marksmanship) Scatter Shot
                spellID = 213691,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.BEAST_MASTERY] = {
            { -- Intimidation
                spellID = 19577,
                subType = SUB_TYPES.STUN,
                duration = 3,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },

        },
        [SPECS.SURVIVAL] = {
            { -- Intimidation
                spellID = 19577,
                subType = SUB_TYPES.STUN,
                duration = 3,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- (Survival) Harpoon
                spellID = 190925,
                subType = SUB_TYPES.ROOT,
                duration = 3,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- (Survival) Steel Trap
                spellID = 162480,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- (Survival) Tracker's Net
                spellID = 212638,
                subType = SUB_TYPES.ROOT,
                duration = 6,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
    },
    MAGE = {
        MAGE = {
            { -- Ice Nova
                spellID = 157997,
                subType = SUB_TYPES.ROOT,
                duration = 2,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Polymorph
                spellID = 118,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Ring of Frost
                spellID = 113724,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Freeze
                spellID = 33395,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Frost Nova
                spellID = 122,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.ARCANE] = {
        },
        [SPECS.FIRE] = {
            { -- (Fire) Dragon's Breath
                spellID = 31661,
                subType = SUB_TYPES.DISORIENT,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.FROST] = {
            { -- (Frost) Frostbite
                spellID = 198120,
                subType = SUB_TYPES.ROOT,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- (Frost) Glacial Spike
                spellID = 199786,
                subType = SUB_TYPES.ROOT,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
    },
    ROGUE = {
        ROGUE = {
            { -- Dismantle
                spellID = 207777,
                subType = SUB_TYPES.DISARM,
                duration = 6,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Gouge
                spellID = 1776,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Sap
                spellID = 6770,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Blind
                spellID = 2094,
                subType = SUB_TYPES.DISORIENT,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Cheap Shot
                spellID = 1833,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Kidney Shot
                spellID = 408,
                subType = SUB_TYPES.STUN,
                duration = 6,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.ASSASSINATION] = {
            { -- (Assassination) Garrote
                spellID = 703,
                subType = SUB_TYPES.SILENCE,
                duration = 3,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.OUTLAW] = {

        },
        [SPECS.SUBTLETY] = {

        },
    },
    DEMONHUNTER = {
        DEMONHUNTER = {
            {
                spellID = 323639,
                subType = SUB_TYPES.ROOT,
                duration = 1.5,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 217832,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 3,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 205596,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 207684,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 211881,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 179057,
                subType = SUB_TYPES.STUN,
                duration = 5,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            {
                spellID = 205630,
                subType = SUB_TYPES.STUN,
                duration = 6,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.HAVOC] = {

        },
    },
    MONK = {
        MONK = {
            { -- Paralysis
                spellID = 115078,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 4,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Leg Sweep
                spellID = 119381,
                subType = SUB_TYPES.STUN,
                duration = 5,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Grapple Weapon
                spellID = 233759,
                subType = SUB_TYPES.DISARM,
                duration = 6,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.BREWMASTER] = {
            { -- (Brewmaster) Clash
                spellID = 324312,
                subType = SUB_TYPES.ROOT,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- (Brewmaster) Incendiary Breath
                spellID = 202272,
                subType = SUB_TYPES.DISORIENT,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.MISTWEAVER] = {
            { -- (Mistweaver) Song of Chi-ji
                spellID = 198898,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- (Windwalker) Disable
                spellID = 116095,
                subType = SUB_TYPES.ROOT,
                duration = 3,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.WINDWALKER] = {

        },
    },
    PRIEST = {
        PRIEST = {
            { -- Shackle Undead
                spellID = 9484,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Mind control
                spellID = 605,
                subType = SUB_TYPES.MIND_CONTROL,
                duration = 8,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Censure
                spellID = 200199,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
                passive = true,
            },
            { -- Psychic Horror
                spellID = 64044,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Psychic Scream
                spellID = 8122,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.DISCIPLINE] = {

        },
        [SPECS.HOLY] = {
            { -- (Holy) Holy Word: Chastise
                spellID = 88625,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.SHADOW] = {
            { -- (Shadow) Silence
                spellID = 15487,
                subType = SUB_TYPES.SILENCE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
    },
    SHAMAN = {
        SHAMAN = {
            { -- Earthgrab Totem
                spellID = 51485,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Surge of Power
                spellID = 262303,
                subType = SUB_TYPES.ROOT,
                duration = 6,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Hex
                spellID = 51514,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Sundering
                spellID = 197214,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 2,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Capacitor Totem
                spellID = 192058,
                subType = SUB_TYPES.STUN,
                duration = 3,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Lightning Lasso
                spellID = 204437,
                subType = SUB_TYPES.STUN,
                duration = 5,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
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
            { -- Entrenched Flame
                spellID = 233581,
                subType = SUB_TYPES.ROOT,
                duration = 3,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
                passive = true,
            },
            { -- Banish
                spellID = 710,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Mortal Coil
                spellID = 6789,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 3,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Fear
                spellID = 5782,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Howl of Terror
                spellID = 5484,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.AFFLICTION] = {

        },
        [SPECS.DEMONOLOGY] = {
            { -- (Demonology) Axe Toss
                spellID = 89766,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.DESTRUCTION] = {
            { -- (Destruction) Summon Infernal
                spellID = 1122,
                subType = SUB_TYPES.STUN,
                duration = 2,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
        },
    },
    EVOKER = {
        EVOKER = {

        },
        [SPECS.DEVASTATION] = {
        },
    },
    DRUID = {
        DRUID = {
            { -- Hibernate
                spellID = 2637,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 8,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Cyclone
                spellID = 33786,
                subType = SUB_TYPES.DISORIENT,
                duration = 6,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Rake
                spellID = 1822,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Entangling Roots
                spellID = 339,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.LOW,
                abilityType = TYPES.CC,
            },
            { -- Mass Entanglement
                spellID = 102359,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Wild Charge
                spellID = 61685,
                subType = SUB_TYPES.ROOT,
                duration = 1,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.BALANCE] = {
            { -- Solar Beam
                spellID = 78675,
                subType = SUB_TYPES.SILENCE,
                duration = 8,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.FERAL] = {
            { --  Maim
                spellID = 22570,
                subType = SUB_TYPES.STUN,
                duration = 5,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.GUARDIAN] = {
            { -- Incapacitating Roar
                spellID = 99,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 3,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
        [SPECS.RESTORATION_DRUID] = {
            { -- Nature's Grasp
                spellID = 247563,
                subType = SUB_TYPES.ROOT,
                duration = 8,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
        },
    },









}
