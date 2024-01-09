---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.Const
PvPLookup.CONST = {}

---@enum PvPLookup.Const.Frames
PvPLookup.CONST.FRAMES = {
    NEWS = "NEWS",
    HISTORY_FRAME = "HISTORY_FRAME",
    PVPINFO = "PVPINFO",
}

---@enum PvPLookup.Const.DisplayTeams
PvPLookup.CONST.DISPLAY_TEAMS = {
    PLAYER_TEAM = "PLAYER_TEAM",
    ENEMY_TEAM = "ENEMY_TEAM",
}

---@enum PvPLookup.Const.PVPModes
PvPLookup.CONST.PVP_MODES = {
    SOLO = "SOLO",
    TWOS = "TWOS",
    THREES = "THREES",
    RGB = "RGB",
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.PVPINFO_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
    },
    bgFile = "Interface\\Buttons\\WHITE8X8",
    tile = true,
    tileSize = 32,
    colorR = 0,
    colorG = 0,
    colorB = 0.1,
    colorA = 0.5,
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
    bgFile = "Interface\\Buttons\\WHITE8X8",
    tile = true,
    tileSize = 32,
    colorR = 0,
    colorG = 0,
    colorB = 0,
    colorA = 0.5,
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_LIST_EDGE_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_FRAME_INNER_BORDER_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
    },
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_TITLE_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 5, right = 5, top = 5, bottom = 5 },
        colorR = 1,
        colorG = 1,
        colorB = 1,
        colorA = 1,
    },
    bgFile = "Interface\\Buttons\\WHITE8X8",
    tile = true,
    tileSize = 32,
    colorR = 0,
    colorG = 0,
    colorB = 0,
    colorA = 0.8,
}
---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    colorR = 0.149,
    colorG = 0.149,
    colorB = 0.149,
    colorA = 1,
}
PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    colorR = 0.098,
    colorG = 0.098,
    colorB = 0.098,
    colorA = 1,
}

PvPLookup.CONST.CLASSES = {
    "WARRIOR",
    "PALADIN",
    "HUNTER",
    "ROGUE",
    "PRIEST",
    "DEATHKNIGHT",
    "SHAMAN",
    "MAGE",
    "WARLOCK",
    "MONK",
    "DRUID",
    "DEMONHUNTER",
    "EVOKER",
}

PvPLookup.CONST.CLASS_NAMES = {
    WARRIOR = "Warrior",
    ARMS = "Arms",
    FURY = "Fury",
    PROTECTION = "Protection",

    PALADIN = "Paladin",
    HOLY = "Holy",
    RETRIBUTION = "Retribution",
    PROTECTION_PALADIN = "Protection",

    HUNTER = "Hunter",
    BEAST_MASTERY = "Beast Mastery",
    MARKSMANSHIP = "Marksmanship",
    SURVIVAL = "Survival",

    ROGUE = "Rogue",
    ASSASSINATION = "Assassination",
    OUTLAW = "Outlaw",
    SUBTLETY = "Subtlety",

    PRIEST = "Priest",
    DISCIPLINE = "Discipline",
    HOLY_PRIEST = "Holy",
    SHADOW = "Shadow",

    DEATHKNIGHT = "Deathknight",
    BLOOD = "Blood",
    FROST = "Frost",
    UNHOLY = "Unholy",

    SHAMAN = "Shaman",
    ELEMENTAL = "Elemental",
    ENHANCEMENT = "Enhancement",
    RESTORATION = "Restoration",

    MAGE = "Mage",
    ARCANE = "Arcane",
    FIRE = "Fire",
    FROST_MAGE = "Frost",

    WARLOCK = "Warlock",
    AFFLICTION = "Affliction",
    DEMONOLOGY = "Demonology",
    DESTRUCTION = "Destruction",

    MONK = "Monk",
    BREWMASTER = "Brewmaster",
    MISTWEAVER = "Mistweaver",
    WINDWALKER = "Windwalker",

    DRUID = "Druid",
    BALANCE = "Balance",
    FERAL = "Feral",
    GUARDIAN = "Guardian",
    RESTORATION_DRUID = "Restoration",

    DEMONHUNTER = "Demonhunter",
    HAVOC = "Havoc",
    VENGEANCE = "Vengeance",

    EVOKER = "Evoker",
    AUGMENTATION = "Augmentation",
    DEVASTATION = "Devastation",
    PRESERVATION = "Preservation",
}

PvPLookup.CONST.RATING_ATLAS_ICON_MAP = {
    [0] = "honorsystem-icon-prestige-1",
    [1000] = "honorsystem-icon-prestige-2",
    [2000] = "honorsystem-icon-prestige-3",
    [3000] = "honorsystem-icon-prestige-4",
    [4000] = "honorsystem-icon-prestige-5",
}