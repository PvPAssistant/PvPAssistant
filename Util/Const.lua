---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.Const
PvPAssistant.CONST = {}

local f = PvPAssistant.GUTIL:GetFormatter()

PvPAssistant.CONST.NEWS =
    f.l("Patch Notes:\n") ..
    f.white("- Ability Catalogue: Added Ability Types and Class Role Filters\n") ..
    f.white("- Arena Guide: Changed the Sort Order of Enemy Abilities\n") ..
    f.white("- Introduced new Icons (Work in Progress)")

PvPAssistant.CONST.DISCORD_INVITE = "https://discord.gg/BvZzctWZZ3"
PvPAssistant.CONST.DONATE_URL = "https://ko-fi.com/arenlogs"

---@enum PvPAssistant.Const.DebugIDs
PvPAssistant.CONST.DEBUG_IDS = {
    PLAYER_TOOLTIP = "PLAYER_TOOLTIP",
}

---@enum PvPAssistant.Const.Frames
PvPAssistant.CONST.FRAMES = {
    NEWS = "NEWS",
    MAIN_FRAME = "MAIN_FRAME",
    PVPINFO = "PVPINFO",
    ARENA_GUIDE = "ARENA_GUIDE",
    ARENA_QUICK_JOIN_BUTTON_BOX = "ARENA_QUICK_JOIN_BUTTON_BOX",
}

---@enum PvPAssistant.Const.DisplayTeams
PvPAssistant.CONST.DISPLAY_TEAMS = {
    PLAYER_TEAM = "PLAYER_TEAM",
    ENEMY_TEAM = "ENEMY_TEAM",
}

PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME = "PvPAssistantFrame"

---@enum PvPAssistant.Const.PVPModes
PvPAssistant.CONST.PVP_MODES = {
    TWOS = "TWOS",
    THREES = "THREES",
    BATTLEGROUND = "BATTLEGROUND",
    SOLO_SHUFFLE = "SOLO_SHUFFLE",
}
---@type table<PvPAssistant.Const.PVPModes, string>
PvPAssistant.CONST.PVP_MODES_NAMES = {
    SOLO_SHUFFLE = "Shuffle",
    TWOS = "2v2",
    THREES = "3v3",
    BATTLEGROUND = "RBG",
}

PvPAssistant.CONST.PVP_MODES_BRACKET_IDS = {
    SOLO_SHUFFLE = 7,
    TWOS = 1,
    THREES = 2,
    BATTLEGROUND = 4,
}

--- 2v2,3v3,rbg,shuffle-1,shuffle-2,shuffle-3,shuffle-4 (shuffles are per spec of that player)
PvPAssistant.CONST.PVP_DATA_BRACKET_ORDER = {
    "TWOS",
    "THREES",
    "BATTLEGROUND",
    "SOLO_SHUFFLE_1",
    "SOLO_SHUFFLE_2",
    "SOLO_SHUFFLE_3",
    "SOLO_SHUFFLE_4",
}

PvPAssistant.CONST.FRAME_LIST_HOVER_RGBA = { 1, 1, 1, 0.1 }

---@type table<string, GGUI.BackdropOptions>
PvPAssistant.CONST.BACKDROPS = {
    OPTIONS_TAB = {
        backdropInfo = {
            bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024",
        },
        backdropRGBA = {
            0.176,
            0.176,
            0.176,
            1,
        },
    },
    TOOLTIP_PREVIEW = {
        backdropInfo = {
            bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 16,
            insets = { left = 0, right = 0, top = 0, bottom = 0 },
        },
        backdropRGBA = {
            0,
            0,
            0.7,
            0.2,
        },
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.PVPINFO_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/Buttons/WHITE8x8",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    },
    backdropRGBA = {
        0,
        0,
        0.05,
        0.5,
    }
}
---@type GGUI.BackdropOptions
PvPAssistant.CONST.ARENA_GUIDE_BACKDROP = {
    backdropInfo = {
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024",
    },
    backdropRGBA = {
        0.2, 0.2, 0.2, 1
    }
}
---@type GGUI.BackdropOptions
PvPAssistant.CONST.MAIN_FRAME_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    },
    backdropRGBA = {
        0.2, 0.2, 0.2, 1
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.ARENA_QUICK_JOIN_BUTTON_BOX_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 12,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    },
    backdropRGBA = {
        0.3,
        0.3,
        0.32,
        1,
    },
}
---@type GGUI.BackdropOptions
PvPAssistant.CONST.TOOLTIP_FRAME_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
    },
    backdropRGBA = {
        0.816, 0.863, 0.961, 0.08
    },
}
---@type GGUI.BackdropOptions
PvPAssistant.CONST.TOOLTIP_FRAME_ROW_BACKDROP_A = {
    backdropInfo = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
    },
    backdropRGBA = {
        0.816, 0.863, 0.961, 0.08
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024",
        insets = {
            top = 0,
            bottom = 0,
            left = 0,
            right = 0,
        },
    },
    backdropRGBA = {
        0.3,
        0.3,
        0.32,
        1,
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.HISTORY_FRAME_INNER_BORDER_BACKDROP = {
    backdropInfo = {
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
    },
    backdropRGBA = {
        0, 0, 0, 0,
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.FILTER_FRAME_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024x128",
    },
    backdropRGBA = {
        0.176,
        0.176,
        0.184,
        1,
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.SUB_FILTER_FRAME_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024x128",
    },
    backdropRGBA = {
        0.3,
        0.3,
        0.32,
        1,
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.STRAGETY_TEXT_BACKDROP = {
    backdropInfo = {
        bgFile = "Interface/addons/PvPAssistant/Media/Backgrounds/bgRoundedWhite1024x128",
    },
    backdropRGBA = {
        0.176,
        0.176,
        0.184,
        1,
    },
}

---@type GGUI.BackdropOptions
PvPAssistant.CONST.HISTORY_TITLE_BACKDROP = {
    backdropInfo = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        bgFile = "Interface\\Buttons\\WHITE8X8",
        tile = true,
        tileSize = 32,
    },
    borderRGBA = { 1, 1, 1, 1 },
    backdropRGBA = { 0, 0, 0, 0.8 },
}
---@type GGUI.BackdropOptions
PvPAssistant.CONST.HISTORY_COLUMN_BACKDROP_B = {
    backdropInfo = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
    },
    backdropRGBA = {
        0.816,
        0.863,
        0.961,
        0.08,
    },
}
PvPAssistant.CONST.HISTORY_COLUMN_BACKDROP_A = {
    backdropInfo = {
        bgFile = "Interface\\Buttons\\WHITE8X8",
    },
    backdropRGBA = {
        0.2,
        0.2,
        0.2,
        1,
    },
}

PvPAssistant.CONST.RATING_ICON_MAP = {
    {
        icon = "Interface\\addons\\PvPAssistant\\Media\\Images\\rank1",
        rating = 0
    },
    {
        icon = "Interface\\addons\\PvPAssistant\\Media\\Images\\rank2",
        rating = 1000
    },
    {
        icon = "Interface\\addons\\PvPAssistant\\Media\\Images\\rank3",
        rating = 1400
    },
    {
        icon = "Interface\\addons\\PvPAssistant\\Media\\Images\\rank4",
        rating = 1600
    },
    {
        icon = "Interface\\addons\\PvPAssistant\\Media\\Images\\rank5",
        rating = 1800
    },
    {
        icon = "Interface\\addons\\PvPAssistant\\Media\\Images\\rank6",
        rating = 2100
    },
}

---@class PvPAssistant.Assets
PvPAssistant.CONST.ASSETS = {

    BUTTONS = {
        ---@type GGUI.ButtonTextureOptions
        DISCORD_BUTTON = {
            normal = 'Interface/addons/PvPAssistant/Media/Buttons/DiscordButton/Discordgray',
            disabled = 'Interface/addons/PvPAssistant/Media/Buttons/DiscordButton/Discordgray',
            highlight = 'Interface/addons/PvPAssistant/Media/Buttons/DiscordButton/Discordgray',
            pushed = 'Interface/addons/PvPAssistant/Media/Buttons/DiscordButton/Discordgray',
            isAtlas = false,
        },
        ---@type GGUI.ButtonTextureOptions
        MAIN_BUTTON = {
            normal = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonNormal',
            disabled = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonDisabled',
            highlight = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonHighlighted',
            pushed = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonDisabled',
        },
        ---@type GGUI.ButtonTextureOptions
        OPTIONS_BUTTON = {
            normal = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonNormal',
            disabled = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonHighlighted',
            highlight = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonHighlighted',
            pushed = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonDisabled',
        },
        ---@type GGUI.ButtonTextureOptions
        DROPDOWN = {
            normal = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonNormal',
            disabled = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonDisabled',
            highlight = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonHighlighted',
            pushed = 'Interface/addons/PvPAssistant/Media/Buttons/TabButton/TabButtonDisabled',
            isAtlas = false,
        },
        ---@type GGUI.CustomDropdown.ArrowOptions
        DROPDOWN_ARROW_OPTIONS = {
            isAtlas = false,
            normal = "Interface/addons/PvPAssistant/Media/Buttons/Dropdown/DropdownArrowPushed",
            pushed = "Interface/addons/PvPAssistant/Media/Buttons/Dropdown/DropdownArrowPushed",
            sizeX = 15,
            sizeY = 15,
            offsetX = -5,
            offsetY = 0,
        }
    },
}

PvPAssistant.CONST.FONT_FILES = {
    ROBOTO = 'Interface/addons/PvPAssistant/Media/Fonts/Roboto-Regular.ttf',
    MONOSPACE = 'Interface/addons/PvPAssistant/Media/Fonts/SpaceMono-Regular.ttf',
}

PvPAssistant.CONST.ATLAS = {
    TOOLTIP_SWORD = "pvptalents-warmode-swords",
    LEFT_MOUSE_BUTTON = "newplayertutorial-icon-mouse-leftbutton",
    RIGHT_MOUSE_BUTTON = "newplayertutorial-icon-mouse-rightbutton",
    MIDDLE_MOUSE_BUTTON = "newplayertutorial-icon-mouse-middlebutton",
    OPTIONS_ICON = "mechagon-projects",
    CHECKMARK = "common-icon-checkmark",
    CROSS = "common-icon-redx",
}

PvPAssistant.CONST.SPEC_ID_LIST = {
    250,
    251,
    252,
    577,
    581,
    102,
    103,
    104,
    105,
    1467,
    1468,
    1473,
    253,
    254,
    255,
    62,
    63,
    64,
    268,
    270,
    269,
    65,
    66,
    70,
    256,
    257,
    258,
    259,
    260,
    261,
    262,
    263,
    264,
    265,
    266,
    267,
    71,
    72,
    73,
}

---@enum PvPAssistant.SpecIDs
PvPAssistant.CONST.SPEC_IDS = {
    BLOOD = 250,
    FROST_DK = 251,
    UNHOLY = 252,
    HAVOC = 577,
    VENGEANCE = 581,
    BALANCE = 102,
    FERAL = 103,
    GUARDIAN = 104,
    RESTORATION_DRUID = 105,
    DEVASTATION = 1467,
    PRESERVATION = 1468,
    AUGMENTATION = 1473,
    BEAST_MASTERY = 253,
    MARKSMANSHIP = 254,
    SURVIVAL = 255,
    ARCANE = 62,
    FIRE = 63,
    FROST = 64,
    BREWMASTER = 268,
    MISTWEAVER = 270,
    WINDWALKER = 269,
    HOLY_PALADIN = 65,
    PROTECTION_PALADIN = 66,
    RETRIBUTION = 70,
    DISCIPLINE = 256,
    HOLY = 257,
    SHADOW = 258,
    ASSASSINATION = 259,
    OUTLAW = 260,
    SUBTLETY = 261,
    ELEMENTAL = 262,
    ENHANCEMENT = 263,
    RESTORATION = 264,
    AFFLICTION = 265,
    DEMONOLOGY = 266,
    DESTRUCTION = 267,
    ARMS = 71,
    FURY = 72,
    PROTECTION = 73,
}
---@enum PvPAssistant.SpecRole
PvPAssistant.CONST.SPEC_ROLE = {
    TANK = "TANK",
    HEALER = "HEALER",
    RANGED_DAMAGE = "RANGED_DAMAGE",
    MELEE_DAMAGE = "MELEE_DAMAGE",
}

---@type table<PvPAssistant.SpecRole, number>
PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY = {
    HEALER = 4,
    TANK = 3,
    RANGED_DAMAGE = 2,
    MELEE_DAMAGE = 1,
}

---@type table<number, PvPAssistant.SpecRole>
PvPAssistant.CONST.SPEC_ROLE_MAP = {
    [250] = PvPAssistant.CONST.SPEC_ROLE.TANK,           -- BLOOD
    [251] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- FROST_DK
    [252] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- UNHOLY
    [577] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- HAVOC
    [581] = PvPAssistant.CONST.SPEC_ROLE.TANK,           -- VENGEANCE
    [102] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- BALANCE
    [103] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- FERAL
    [104] = PvPAssistant.CONST.SPEC_ROLE.TANK,           -- GUARDIAN
    [105] = PvPAssistant.CONST.SPEC_ROLE.HEALER,         -- RESTORATION_DRUID
    [1467] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE, -- DEVASTATION
    [1468] = PvPAssistant.CONST.SPEC_ROLE.HEALER,        -- PRESERVATION
    [1473] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE, -- AUGMENTATION
    [253] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- BEAST_MASTERY
    [254] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- MARKSMANSHIP
    [255] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- SURVIVAL
    [62] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,   -- ARCANE
    [63] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,   -- FIRE
    [64] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,   -- FROST
    [268] = PvPAssistant.CONST.SPEC_ROLE.TANK,           -- BREWMASTER
    [270] = PvPAssistant.CONST.SPEC_ROLE.HEALER,         -- MISTWEAVER
    [269] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- WINDWALKER
    [65] = PvPAssistant.CONST.SPEC_ROLE.HEALER,          -- HOLY_PALADIN
    [66] = PvPAssistant.CONST.SPEC_ROLE.TANK,            -- PROTECTION_PALADIN
    [70] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,    -- RETRIBUTION
    [256] = PvPAssistant.CONST.SPEC_ROLE.HEALER,         -- DISCIPLINE
    [257] = PvPAssistant.CONST.SPEC_ROLE.HEALER,         -- HOLY
    [258] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- SHADOW
    [259] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- ASSASSINATION
    [260] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- OUTLAW
    [261] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- SUBTLETY
    [262] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- ELEMENTAL
    [263] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,   -- ENHANCEMENT
    [264] = PvPAssistant.CONST.SPEC_ROLE.HEALER,         -- RESTORATION
    [265] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- AFFLICTION
    [266] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- DEMONOLOGY
    [267] = PvPAssistant.CONST.SPEC_ROLE.RANGED_DAMAGE,  -- DESTRUCTION
    [71] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,    -- ARMS
    [72] = PvPAssistant.CONST.SPEC_ROLE.MELEE_DAMAGE,    -- FURY
    [73] = PvPAssistant.CONST.SPEC_ROLE.TANK,            -- PROTECTION
}

---@enum PvPAssistant.AbilitySubTypes
PvPAssistant.CONST.ABILITY_SUB_TYPES = {
    STUN = "STUN",
    FEAR = "FEAR",
    ROOT = "ROOT",
    SLOW = "SLOW",
    MIND_CONTROL = "MIND_CONTROL",
    DISORIENT = "DISORIENT",
    DISARM = "DISARM",
    REFLECT = "REFLECT",
    GRIP = "GRIP",
    IMMUNITY = "IMMUNITY",
    SILENCE = "SILENCE",
    INTERRUPT = "INTERRUPT",
    INVISIBILITY = "INVISIBILITY",
    POLYMORPH = "POLYMORPH",
    INCAPACITATE = "INCAPACITATE",
    KNOCKBACK = "KNOCKBACK",
    DISPEL = "DISPEL",
    BUFF = "BUFF",
    DEFENSIVE = "DEFENSIVE", -- TODO: Remove Placeholder for subtypes like "IMMUNITY" on def spells
    OFFENSIVE = "OFFENSIVE"  -- TODO: Remove Placeholder for subtypes like "BURST" on def spells
}

---@enum PvPAssistant.AbilityTypes
PvPAssistant.CONST.ABILITY_TYPES = {
    CC = "CC",
    DEFENSIVE = "DEFENSIVE",
    OFFENSIVE = "OFFENSIVE",
}

---@enum PvPAssistant.PVPSeverity
PvPAssistant.CONST.PVP_SEVERITY = {
    LOW = "LOW",
    MEDIUM = "MEDIUM",
    HIGH = "HIGH",
}

PvPAssistant.CONST.PVP_SEVERITY_RANK = {
    LOW = 1,
    MEDIUM = 2,
    HIGH = 3,
}

---@type table<PvPAssistant.AbilityTypes, number>
PvPAssistant.CONST.PVP_ABILITY_SORT_RANK = {
    CC = 3,
    DEFENSIVE = 2,
    OFFENSIVE = 1,
}

PvPAssistant.CONST.MAP_ABBREVIATIONS = {

}

---@enum PvPAssistant.OPTIONS.SPELL_TOOLTIP.KEYS
PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS = {
    TYPE = "TYPE",
    SUBTYPE = "SUBTYPE",
    PVP_SEVERITY = "PVP_SEVERITY",
    PVP_DURATION = "PVP_DURATION",
    ADDITIONAL_DATA = "ADDITIONAL_DATA",
}

---@enum PvPAssistant.GENERAL_OPTION
PvPAssistant.CONST.GENERAL_OPTION = {
    DEBUG = "DEBUG",
    ARENA_GUIDE_ENABLED = "ARENA_GUIDE_ENABLED",
    ARENA_QUICK_JOIN_ENABLED = "ARENA_QUICK_JOIN_ENABLED",
    ARENA_QUICK_JOIN_BUTTON_LABEL_ENABLED = "ARENA_QUICK_JOIN_BUTTON_LABEL_ENABLED",
    ARENA_QUICK_JOIN_MOVE_ENABLED = "ARENA_QUICK_JOIN_MOVE_ENABLED",
}

---@type table<ClassFile, number>
PvPAssistant.CONST.CLASS_ID = {
    WARRIOR = 1,
    PALADIN = 2,
    HUNTER = 3,
    ROGUE = 4,
    PRIEST = 5,
    DEATHKNIGHT = 6,
    SHAMAN = 7,
    MAGE = 8,
    WARLOCK = 9,
    MONK = 10,
    DRUID = 11,
    DEMONHUNTER = 12,
    EVOKER = 13,
}

PvPAssistant.CONST.RACE_ICON_MAP = {
    ["Human"] = "raceicon128-human-male",
    ["Dwarf"] = "raceicon128-dwarf-male",
    ["Gnome"] = "raceicon128-gnome-male",
    ["NightElf"] = "raceicon128-nightelf-male",
    ["Tauren"] = "raceicon128-tauren-male",
    ["Scourge"] = "raceicon128-undead-male",
    ["Troll"] = "raceicon128-troll-male",
    ["Orc"] = "raceicon128-orc-male",
    ["BloodElf"] = "raceicon128-bloodelf-male",
    ["Draenei"] = "raceicon128-draenei-male",
    ["Goblin"] = "raceicon128-goblin-male",
    ["Worgen"] = "raceicon128-worgen-male",
    ["Pandaren"] = "raceicon128-pandaren-male",
    ["Nightborne"] = "raceicon128-nightborne-male",
    ["HighmountainTauren"] = "raceicon128-highmountain-male",
    ["VoidElf"] = "raceicon128-voidelf-male",
    ["LightforgedDraenei"] = "raceicon128-lightforged-male",
    ["DarkIronDwarf"] = "raceicon128-darkirondwarf-male",
    ["MagharOrc"] = "raceicon128-magharorc-male",
    ["ZandalariTroll"] = "raceicon128-zandalari-male",
    ["KulTiran"] = "raceicon128-kultiran-male",
    ["Vulpera"] = "raceicon128-vulpera-male",
    ["Mechagnome"] = "raceicon128-mechagnome-male",
    ["Dracthyr"] = "raceicon128-dracthyr-male",
}
