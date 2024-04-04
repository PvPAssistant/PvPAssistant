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
            { -- Impending Victory
                spellID = 202168,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Rallying Cry
                spellID = 97462,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Thunderous Roar
                spellID = 384318,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Recklessness
                spellID = 1719,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.ARMS] = {
            { -- Die By the Sword
                spellID = 118038,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Bladestorm
                spellID = 227847,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Duel
                spellID = 236273,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Colossus Smash
                spellID = 167105,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Warbreaker
                spellID = 262161,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Sharpen Blade
                spellID = 198817,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.FURY] = {
            { -- Duel (Note: Listed under both Arms and Fury)
                spellID = 236273,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Enraged Regeneration
                spellID = 184364,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Odyn´s Fury
                spellID = 385059,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- Divine Shield
                spellID = 642,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Blessing of protection
                spellID = 1022,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Blessing of sacrifce
                spellID = 6940,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Divine Protection
                spellID = 498,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Lay on Hands
                spellID = 633,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Avenging Wrath
                spellID = 31884,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Divine Toll
                spellID = 375576,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.RETRIBUTION] = {
            { -- Shield of Vengeance
                spellID = 184662,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Crusade
                spellID = 231895,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Execution Sentence
                spellID = 343527,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Final Reckoning
                spellID = 343721,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Wake of ashes
                spellID = 255937,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.HOLY] = {
            { -- Aura Mastery
                spellID = 31821,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Avenging Crusader
                spellID = 216331,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Tyr´s Deliverance
                spellID = 200652,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- Anti-Magic Shell
                spellID = 48707,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Icebound Fortitude
                spellID = 48792,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Empower Rune Weapon
                spellID = 47568,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Pillar of frost
                spellID = 51271,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Apocalypse
                spellID = 275699,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Army of dead
                spellID = 42650,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Dark Transformation
                spellID = 63560,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Summon Gargoyle
                spellID = 49206,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Unholy Assault
                spellID = 207289,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Aspect of the turtle
                spellID = 186265,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Exhilaration
                spellID = 109304,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Roar of sacrifice
                spellID = 53480,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Survival of the fittest
                spellID = 264735,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Death Chakram
                spellID = 375891,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Explosive Shot
                spellID = 212431,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Rapid Fire
                spellID = 257044,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Salvo
                spellID = 400456,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Trueshot
                spellID = 288613,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Volley
                spellID = 260243,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Bestial Wrath
                spellID = 19574,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Bloodshed
                spellID = 321530,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Call of the Wild
                spellID = 359844,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Coordinated Assault
                spellID = 360952,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Flanking Strike
                spellID = 269751,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Fury of the eagle
                spellID = 203415,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Spearhead
                spellID = 360966,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Ice block
                spellID = 45438,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Alter time
                spellID = 432245,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Greater Invisibility
                spellID = 110959,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Mass barrier
                spellID = 414660,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Mirror Image
                spellID = 55342,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.ARCANE] = {
            { -- Temporal Shield
                spellID = 198111,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Prismatic Barrier
                spellID = 235450,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Arcane Surge
                spellID = 365350,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,

            },
            { -- Presence of Mind
                spellID = 205025,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.FIRE] = {
            { -- (Fire) Dragon's Breath
                spellID = 31661,
                subType = SUB_TYPES.DISORIENT,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Blazing Barrier
                spellID = 235313,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Cauterize
                spellID = 86949,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Combustion
                spellID = 190319,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Cold snap
                spellID = 235219,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ice Barrier
                spellID = 11426,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Icy Veins
                spellID = 12472,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ray of Frost
                spellID = 205021,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Cheat death
                spellID = 31230,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Cloak of shadows
                spellID = 31224,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Evasion
                spellID = 5277,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Vanish
                spellID = 1856,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- feint
                spellID = 1966,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Thistle tea
                spellID = 381623,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Deathmark
                spellID = 360194,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Kingsbane
                spellID = 385627,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.OUTLAW] = {
            { -- Adrenaline Rush
                spellID = 13750,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.SUBTLETY] = {
            { -- Cold Blood
                spellID = 382245,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Secret technique
                spellID = 280719,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Shadow Dance
                spellID = 185313,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Shadow Blades
                spellID = 121471,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Symbols of death
                spellID = 212283,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Shuriken tornado
                spellID = 277925,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- The Hunt
                spellID = 370965,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Darkness
                spellID = 196718,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.HAVOC] = {
            { -- Netherwalk
                spellID = 196555,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Blur
                spellID = 198589,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Eye Beam
                spellID = 198013,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Essence Break
                spellID = 258860,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Metamorphosis
                spellID = 187827,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- dampen harm
                spellID = 122278,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Diffuse Magic
                spellID = 122783,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Fortifying Brew
                spellID = 115203,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Life cocoon
                spellID = 116849,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Restoral
                spellID = 388615,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Revival
                spellID = 115310,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ivoke Xuen, The white tiger
                spellID = 322118,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Thunder focus tea
                spellID = 116680,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.WINDWALKER] = {
            { -- Ivoke Xuen, The white tiger
                spellID = 123904,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Serenity
                spellID = 152173,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Strike of the windloard
                spellID = 392983,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Storm, Earth, And fire
                spellID = 137639,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- Desperate Prayer
                spellID = 19236,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Vampiric Embrace
                spellID = 15286,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Void Shift
                spellID = 108968,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Mindgames
                spellID = 375901,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Power infusion
                spellID = 10060,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.DISCIPLINE] = {
            { -- Pain suppression
                spellID = 33206,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ultimate Penitence
                spellID = 421453,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Power World: Barrier
                spellID = 62618,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Mindbender
                spellID = 123040,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Rapture
                spellID = 47536,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Shadowfiend
                spellID = 34433,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.HOLY] = {
            { -- (Holy) Holy Word: Chastise
                spellID = 88625,
                subType = SUB_TYPES.INCAPACITATE,
                duration = 4,
                severity = SEVERITY.HIGH,
                abilityType = TYPES.CC,
            },
            { -- Guardian Spirit
                spellID = 47788,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ray of hope
                spellID = 197268,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Apotheosis
                spellID = 200183,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Mindbender
                spellID = 123040,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Shadowfiend
                spellID = 34433,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Dispersion
                spellID = 47585,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Dark Ascension
                spellID = 391109,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Mindbender
                spellID = 200174,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Psyfiend
                spellID = 211522,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Void Eruption
                spellID = 228260,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Void Torrent
                spellID = 263165,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Psychic Horror
                spellID = 64044,
                subType = SUB_TYPES.STUN,
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
            { -- Burrow
                spellID = 409293,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ancestral Guidance
                spellID = 108281,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Astral Shift
                spellID = 108271,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Nature´s Guardian
                spellID = 30884,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Stormkeeper
                spellID = 383009,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.ELEMENTAL] = {
            { -- Ascendance
                spellID = 114050,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Fire Elemental
                spellID = 198067,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Stormkeeper
                spellID = 191634,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.ENHANCEMENT] = {
            { -- Ascendance
                spellID = 114051,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Bloodlust
                spellID = 2825,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Doom winds
                spellID = 384352,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Feral spirit
                spellID = 51533,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.RESTORATION] = {
            { -- Earthen wall totem
                spellID = 198838,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Healing tide totem
                spellID = 108280,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Spirit Link totem
                spellID = 98008,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ascendance
                spellID = 114052,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Primordial wave (Note: Listed twice, potentially for different contexts or an error)
                spellID = 428332,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Primordial wave
                spellID = 375982,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- Mortal Coil
                spellID = 6789,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Dark Pact
                spellID = 108416,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Unending Resolve
                spellID = 104773,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Healthstone
                spellID = 5512,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Call Observer
                spellID = 201996,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.AFFLICTION] = {
            { -- Summon Darkglare
                spellID = 205180,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Oblivion
                spellID = 417537,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.DEMONOLOGY] = {
            { -- (Demonology) Axe Toss
                spellID = 89766,
                subType = SUB_TYPES.STUN,
                duration = 4,
                severity = SEVERITY.MEDIUM,
                abilityType = TYPES.CC,
            },
            { -- Demonic Strength
                spellID = 267171,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Fel Obelisk
                spellID = 353601,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Summon demonic Tyrant
                spellID = 265187,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Dimensional Rift
                spellID = 387976,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Summon Infernal
                spellID = 1122,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
    },
    EVOKER = {
        EVOKER = {
            { -- Obsidian Scales
                spellID = 363916,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Renewing Blaze
                spellID = 374348,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Tip of the scales
                spellID = 370553,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.PRESERVATION] = {
            { -- Emerald Communion
                spellID = 370960,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Rewind
                spellID = 363534,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.DEVASTATION] = {
            { -- Time stop
                spellID = 378441,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Deep Breath
                spellID = 357210,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Dragonrage
                spellID = 375087,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Eternity Surge
                spellID = 359073,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Fire breath
                spellID = 382266,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Shattering Star
                spellID = 370452,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
        [SPECS.AUGMENTATION] = {
            { -- Blistering scales
                spellID = 360827,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Defy Fate
                spellID = 404381,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Breath of Eons
                spellID = 403631,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Ebon Might
                spellID = 395152,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
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
            { -- Barkskin
                spellID = 22812,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Frenzied Regeneration
                spellID = 22842,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Renewal
                spellID = 108238,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Convoke of the spirits
                spellID = 391528,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Fury of elune
                spellID = 202770,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Incarnation boomi
                spellID = 102560,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- New moon
                spellID = 274281,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Warrior of elune
                spellID = 202425,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Berserk
                spellID = 106951,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Feral Frenzy
                spellID = 274837,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Incarnation Feral
                spellID = 102543,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Tiger´s Fury
                spellID = 5217,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
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
            { -- Tranquility
                spellID = 740,
                abilityType = TYPES.DEFENSIVE,
                subType = SUB_TYPES.DEFENSIVE,
                severity = SEVERITY.LOW,
            },
            { -- Incarnation: tree of life
                spellID = 33891,
                subType = SUB_TYPES.OFFENSIVE,
                abilityType = TYPES.OFFENSIVE,
                severity = SEVERITY.LOW,
            },
        },
    },
}
