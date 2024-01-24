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
    bgFile = "Interface/addons/PvPLookup/Media/Backgrounds/bgRoundedWhite1024",
    colorR = 0.2,
    colorG = 0.2,
    colorB = 0.2,
    colorA = 1,
}

---@type GGUI.BackdropOptions
PvPLookup.CONST.HISTORY_FRAME_INNER_BORDER_BACKDROP = {
    borderOptions = {
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
    },
    colorR = 0,
    colorG = 0,
    colorB = 0,
    colorA = 0,
}

---@type GGUI.BackdropOptions
PvPLookup.CONST.CLASS_FILTER_FRAME_BACKDROP = {
    bgFile = "Interface/addons/PvPLookup/Media/Backgrounds/bgRoundedWhite1024x128",
    colorR = 0.176,
    colorG = 0.176,
    colorB = 0.184,
    colorA = 1,
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
PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_B = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    colorR = 0.443,
    colorG = 0.435,
    colorB = 0.447,
    colorA = 1,
}
PvPLookup.CONST.HISTORY_COLUMN_BACKDROP_A = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    colorR = 0.157,
    colorG = 0.157,
    colorB = 0.157,
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

PvPLookup.CONST.RATING_ICON_MAP = {
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank1",
        rating = 0
    },
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank2",
        rating = 1000
    },
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank3",
        rating = 1400
    },
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank4",
        rating = 1600
    },
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank5",
        rating = 1800
    },
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank6",
        rating = 2100
    },
    {
        icon = "Interface\\addons\\PvPLookup\\Media\\Images\\rank7",
        rating = 2400
    },
}

---@class PvPLookup.Assets
---@field BUTTONS table<string, GGUI.ButtonTextureOptions>
PvPLookup.CONST.ASSETS = {
    BUTTONS = {
        TAB_BUTTON = {
            normal = 'Interface/addons/PvPLookup/Media/Buttons/TabButton/TabButtonNormal',
            disabled = 'Interface/addons/PvPLookup/Media/Buttons/TabButton/TabButtonDisabled',
            highlight = 'Interface/addons/PvPLookup/Media/Buttons/TabButton/TabButtonHighlighted',
            pushed = 'Interface/addons/PvPLookup/Media/Buttons/TabButton/TabButtonDisabled',
            highlightBlendmode = "ADD",
        }
    },
}

PvPLookup.CONST.FONT_FILES = {
    ROBOTO = 'Interface/addons/PvPLookup/Media/Fonts/Roboto-Regular.ttf'
}
