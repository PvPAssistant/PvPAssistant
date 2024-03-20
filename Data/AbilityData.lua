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
        [SPECS.FROST_DK] = {
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
        {   -- Psychic Horror
            spellID = 64044,
            subType = SUB_TYPES.STUN,
            duration = 4,
            severity = SEVERITY.HIGH,
            abilityType = TYPES.CC,
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
DEATHKNIGHT = {
    DEATHKNIGHT = {
        { -- Anti-Magic Shell
            spellID = 48707,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Icebound Fortitude
            spellID = 48792,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Abomination Limb
            spellID = 383269,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Empower Rune Weapon
            spellID = 47568,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.UNHOLY] = {
        { -- Apocalypse
            spellID = 275699,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Army of dead
            spellID = 42650,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Dark Transformation
            spellID = 63560,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Summon Gargoyle
            spellID = 49206,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Unholy Assault
            spellID = 207289,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.FROST] = {
        { -- Pillar of frost
            spellID = 51271,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}

DEMONHUNTER = {
    [SPECS.HAVOC] = {
        { -- Netherwalk
            spellID = 196555,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Blur
            spellID = 198589,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Eye Beam
            spellID = 198013,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Essence Break
            spellID = 258860,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Metamorphosis
            spellID = 187827,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    DEMONHUNTER = {
        { -- The Hunt
            spellID = 370965,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Darkness
            spellID = 196718,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
    },
}

DRUID = {
    DRUID = {
        { -- Barkskin
            spellID = 22812,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Frenzied Regeneration
            spellID = 22842,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Renewal
            spellID = 108238,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Convoke of the spirits
            spellID = 391528,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.RESTORATION] = {
        { -- Tranquility
            spellID = 740,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Incarnation: tree of life
            spellID = 33891,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.FERAL] = {
        { -- Berserk
            spellID = 106951,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Feral Frenzy
            spellID = 274837,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Incarnation Feral
            spellID = 102543,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Tiger´s Fury
            spellID = 5217,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.BALANCE] = {
        { -- Fury of elune
            spellID = 202770,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Incarnation boomi
            spellID = 102560,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- New moon
            spellID = 274281,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Warrior of elune
            spellID = 202425,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
EVOKER = {
    [SPECS.AUGMENTATION] = {
        { -- Blistering scales
            spellID = 360827,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Defy Fate
            spellID = 404381,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Breath of Eons
            spellID = 403631,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Ebon Might
            spellID = 395152,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.PRESERVATION] = {
        { -- Emerald Communion
            spellID = 370960,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Rewind
            spellID = 363534,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
    },
    [SPECS.DEVASTATION] = {
        { -- Time stop
            spellID = 378441,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Deep Breath
            spellID = 357210,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Dragonrage
            spellID = 375087,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Eternity Surge
            spellID = 359073,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Fire breath
            spellID = 382266,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Shattering Star
            spellID = 370452,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    EVOKER = {
        { -- Obsidian Scales
            spellID = 363916,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Renewing Blaze
            spellID = 374348,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Tip of the scales
            spellID = 370553,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
HUNTER = {
    HUNTER = {
        { -- Aspect of the turtle
            spellID = 186265,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Exhilaration
            spellID = 109304,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Roar of sacrifice
            spellID = 53480,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Survival of the fittest
            spellID = 264735,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Death Chakram
            spellID = 375891,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Explosive Shot
            spellID = 212431,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.BEAST_MASTERY] = {
        { -- Bestial Wrath
            spellID = 19574,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Bloodshed
            spellID = 321530,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Call of the Wild
            spellID = 359844,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.SURVIVAL] = {
        { -- Coordinated Assault
            spellID = 360952,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Flanking Strike
            spellID = 269751,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Fury of the eagle
            spellID = 203415,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Spearhead
            spellID = 360966,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.MARKSMANSHIP] = {
        { -- Rapid Fire
            spellID = 257044,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Salvo
            spellID = 400456,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Trueshot
            spellID = 288613,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Volley
            spellID = 260243,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
MAGE = {
    MAGE = {
        { -- Ice block
            spellID = 45438,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Alter time
            spellID = 432245,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Greater Invisibility
            spellID = 110959,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Mass barrier
            spellID = 414660,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Mirror Image
            spellID = 55342,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
    },
    [SPECS.FIRE] = {
        { -- Blazing Barrier
            spellID = 235313,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Cauterize
            spellID = 86949,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Combustion
            spellID = 190319,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.FROST] = {
        { -- Cold snap
            spellID = 235219,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Ice Barrier
            spellID = 11426,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Icy Veins
            spellID = 12472,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Ray of Frost
            spellID = 205021,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.ARCANE] = {
        { -- Temporal Shield
            spellID = 198111,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Prismatic Barrier
            spellID = 235450,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Arcane Surge
            spellID = 365350,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,

        },
        { -- Presence of Mind
            spellID = 205025,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    }
}
MONK = {
    MONK = {
        { -- dampen harm
            spellID = 122278,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Diffuse Magic
            spellID = 122783,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Fortifying Brew
            spellID = 115203,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
    },
    [SPECS.MISTWEAVER] = {
        { -- Life cocoon
            spellID = 116849,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Restoral
            spellID = 388615,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Revival
            spellID = 115310,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Ivoke Xuen, The white tiger
            spellID = 322118,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Thunder focus tea
            spellID = 116680,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.WINDWALKER] = {
        { -- Ivoke Xuen, The white tiger
            spellID = 123904,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Serenity
            spellID = 152173,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Strike of the windloard
            spellID = 392983,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Storm, Earth, And fire
            spellID = 137639,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
PALADIN = {
    PALADIN = {
        { -- Divine Shield
            spellID = 642,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Blessing of protection
            spellID = 1022,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Blessing of sacrifce
            spellID = 6940,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Divine Protection
            spellID = 498,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Lay on Hands
            spellID = 633,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Avenging Wrath
            spellID = 31884,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Divine Toll
            spellID = 375576,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.RETRIBUTION] = {
        { -- Shield of Vengeance
            spellID = 184662,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Crusade
            spellID = 231895,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Execution Sentence
            spellID = 343527,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Final Reckoning
            spellID = 343721,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Wake of ashes
            spellID = 255937,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.HOLY] = {
        { -- Aura Mastery
            spellID = 31821,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Avenging Crusader
            spellID = 216331,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Tyr´s Deliverance
            spellID = 200652,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
PRIEST = {
    PRIEST = {
        { -- Desperate Prayer
            spellID = 19236,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Vampiric Embrace
            spellID = 15286,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Void Shift
            spellID = 108968,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Mindgames
            spellID = 375901,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Power infusion
            spellID = 10060,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.HOLY] = {
        { -- Guardian Spirit
            spellID = 47788,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Ray of hope
            spellID = 197268,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Apotheosis
            spellID = 200183,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Mindbender
            spellID = 123040,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Shadowfiend
            spellID = 34433,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.DISCIPLINE] = {
        { -- Pain suppression
            spellID = 33206,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Ultimate Penitence
            spellID = 421453,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Power World: Barrier
            spellID = 62618,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Mindbender
            spellID = 123040,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Rapture
            spellID = 47536,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Shadowfiend
            spellID = 34433,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.SHADOW] = {
        { -- Dispersion
            spellID = 47585,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Dark Ascension
            spellID = 391109,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Mindbender
            spellID = 200174,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Psyfiend
            spellID = 211522,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Void Eruption
            spellID = 228260,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Void Torrent
            spellID = 263165,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
ROGUE = {
    ROGUE = {
        { -- Cheat death
            spellID = 31230,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Cloak of shadows
            spellID = 31224,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Evasion
            spellID = 5277,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Vanish
            spellID = 1856,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- feint
            spellID = 1966,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Thistle tea
            spellID = 381623,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.OUTLAW] = {
        { -- Adrenaline Rush
            spellID = 13750,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.SUBTLETY] = {
        { -- Cold Blood
            spellID = 382245,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Secret technique
            spellID = 280719,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Shadow Dance
            spellID = 185313,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Shadow Blades
            spellID = 121471,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Symbols of death
            spellID = 212283,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Shuriken tornado
            spellID = 277925,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.ASSASSINATION] = {
        { -- Deathmark
            spellID = 360194,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Kingsbane
            spellID = 385627,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
SHAMAN = {
    SHAMAN = {
        { -- Burrow
            spellID = 409293,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Ancestral Guidance
            spellID = 108281,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Astral Shift
            spellID = 108271,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Nature´s Guardian
            spellID = 30884,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Stormkeeper
            spellID = 383009,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.RESTORATION] = {
        { -- Earthen wall totem
            spellID = 198838,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Healing tide totem
            spellID = 108280,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Spirit Link totem
            spellID = 98008,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Ascendance
            spellID = 114052,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Primordial wave (Note: Listed twice, potentially for different contexts or an error)
            spellID = 428332,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Primordial wave
            spellID = 375982,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.ELEMENTAL] = {
        { -- Ascendance
            spellID = 114050,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Fire Elemental
            spellID = 198067,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Stormkeeper
            spellID = 191634,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.ENHANCEMENT] = {
        { -- Ascendance
            spellID = 114051,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Bloodlust
            spellID = 2825,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Doom winds
            spellID = 384352,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Feral spirit
            spellID = 51533,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
WARLOCK = {
    WARLOCK = {
        { -- Mortal Coil
            spellID = 6789,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Dark Pact
            spellID = 108416,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Unending Resolve
            spellID = 104773,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Healthstone
            spellID = 5512,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Call Observer
            spellID = 201996,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.DESTRUCTION] = {
        { -- Dimensional Rift
            spellID = 387976,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Summon Infernal
            spellID = 1122,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.DEMONOLOGY] = {
        { -- Demonic Strength
            spellID = 267171,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Fel Obelisk
            spellID = 353601,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Summon demonic Tyrant
            spellID = 265187,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.AFFLICTION] = {
        { -- Summon Darkglare
            spellID = 205180,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Oblivion
            spellID = 417537,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}

WARRIOR = {
    WARRIOR = {
        { -- Impending Victory
            spellID = 202168,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Rallying Cry
            spellID = 97462,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Thunderous Roar
            spellID = 384318,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Recklessness
            spellID = 1719,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.ARMS] = {
        { -- Die By the Sword
            spellID = 118038,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Bladestorm
            spellID = 227847,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Duel
            spellID = 236273,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Colossus Smash
            spellID = 167105,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Warbreaker
            spellID = 262161,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
        { -- Sharpen Blade
            spellID = 198817,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
    [SPECS.FURY] = {
        { -- Duel (Note: Listed under both Arms and Fury)
            spellID = 236273,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Enraged Regeneration
            spellID = 184364,
            subType = SUB_TYPES.DEFENSIVE,
            abilityType = TYPES.DEFENSIVE,
        },
        { -- Odyn´s Fury
            spellID = 385059,
            subType = SUB_TYPES.OFFENSIVE,
            abilityType = TYPES.OFFENSIVE,
        },
    },
}
