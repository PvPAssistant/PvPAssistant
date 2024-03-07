---@class Arenalogs
local Arenalogs = select(2, ...)

local GGUI = Arenalogs.GGUI
local GUTIL = Arenalogs.GUTIL
local f = GUTIL:GetFormatter()

---@class Arenalogs.Options
Arenalogs.OPTIONS = {}

ArenalogsOptions = ArenalogsOptions or {
    enableDebug = false,

    -- Arena Guide
    arenaGuideEnable = true,
}

---@param optionName string
---@param value any
function Arenalogs.OPTIONS:InitDefaultValue(optionName, value)
    if ArenalogsOptions[optionName] == nil then
        ArenalogsOptions[optionName] = value
    end
end

function Arenalogs.OPTIONS:Init()
    self:HandleOptionsUpdates()
    Arenalogs.OPTIONS.optionsPanel = CreateFrame("Frame", "ArenalogsOptionsPanel")
    Arenalogs.OPTIONS.optionsPanel.name = "Arenalogs"

    InterfaceOptions_AddCategory(self.optionsPanel)
end

function Arenalogs.OPTIONS:HandleOptionsUpdates()
    if ArenalogsOptions then
        Arenalogs.OPTIONS:InitDefaultValue("enableDebug", false)
        Arenalogs.OPTIONS:InitDefaultValue("arenaGuideEnable", true)
    end
end

function Arenalogs.OPTIONS:InitOptionsTab()
    local tabSizeX = 650
    local tabSizeY = 450
    local tabContentOffsetY = -80

    local optionsTab = Arenalogs.MAIN_FRAME.frame.content.optionsTab
    ---@class Arenalogs.MAIN_FRAME.OPTIONS_TAB.CONTENT
    optionsTab.content = optionsTab.content

    optionsTab.content.header = GGUI.Text {
        parent = optionsTab.content, anchorPoints = { { anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP", offsetY = -20 } },
        scale = 1.5, text = f.white("Options")
    }

    ---@class Arenalogs.OPTIONS.ArenaGuideTab : GGUI.Tab
    optionsTab.content.arenaGuideTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = Arenalogs.CONST.BACKDROPS.OPTIONS_TAB,
        buttonOptions = {
            label = GUTIL:ColorizeText("Arena Guide", GUTIL.COLORS.WHITE),
            parent = optionsTab.content,
            anchorPoints =
            {
                {
                    anchorParent = optionsTab.content,
                    anchorA = "TOPLEFT",
                    anchorB = "TOPLEFT",
                    offsetX = 55,
                    offsetY = -53,
                }
            },
            adjustWidth = true,
            sizeX = 15,
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    ---@class Arenalogs.OPTIONS.TooltipsTab : GGUI.Tab
    optionsTab.content.tooltipsTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = Arenalogs.CONST.BACKDROPS.OPTIONS_TAB,
        buttonOptions = {
            label = GUTIL:ColorizeText("Tooltips", GUTIL.COLORS.WHITE),
            parent = optionsTab.content,
            anchorPoints =
            {
                {
                    anchorParent = optionsTab.content.arenaGuideTab.button.frame,
                    anchorA = "LEFT",
                    anchorB = "RIGHT",
                    offsetX = 1,
                }
            },
            adjustWidth = true,
            sizeX = 20,
            buttonTextureOptions = Arenalogs.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = Arenalogs.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    local arenaGuideTab = optionsTab.content.arenaGuideTab
    local tooltipsTab = optionsTab.content.tooltipsTab

    GGUI.TabSystem { arenaGuideTab, tooltipsTab }

    Arenalogs.OPTIONS:InitArenaGuideTab(arenaGuideTab)
    Arenalogs.OPTIONS:InitTooltipsTab(tooltipsTab)
end

---@param arenaGuideTab Arenalogs.OPTIONS.ArenaGuideTab
function Arenalogs.OPTIONS:InitArenaGuideTab(arenaGuideTab)
    ---@class Arenalogs.OPTIONS.ArenaGuideTab.Content : Frame
    local content = arenaGuideTab.content

    content.enableArenaGuideCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 10, offsetY = -10,
        labelOptions = {
            text = f.white("Enable the " .. f.e("Arena Quick Guide")),
        },
        tooltip = f.white("If enabled, the " .. f.l("Arenalogs ") .. f.e("\nArena Quick Guide") .. " will appear in arena matches to give you useful information and hints"),
        initialValue = ArenalogsOptions.arenaGuideEnable,
        clickCallback = function(_, checked)
            ArenalogsOptions.arenaGuideEnable = checked
        end
    }
end

---@param tooltipsTab Arenalogs.OPTIONS.TooltipsTab
function Arenalogs.OPTIONS:InitTooltipsTab(tooltipsTab)
    ---@class Arenalogs.OPTIONS.TooltipsTab.Content : Frame
    local content = tooltipsTab.content

    content.playerTooltipFrame = GGUI.TooltipOptionsFrame {
        frameOptions = {
            title = "Player Tooltip",
            parent = content, anchorParent = content,
            sizeX = 150, sizeY = 200,
            anchorA = "TOPLEFT", anchorB = "TOPLEFT",
            offsetX = 20, offsetY = -20
        },
        optionsTable = ArenalogsDB.tooltipOptions.data.playerTooltip,
        lines = {
            {
                label = f.l("Enable"),
                disabledLabel = f.grey("Enable"),
                isEnablerLine = true,
            },
            {
                label = f.white("2v2"),
                disabledLabel = f.grey("2v2"),
                optionsKey = Arenalogs.CONST.PVP_MODES.TWOS,
            },
            {
                label = f.white("3v3"),
                disabledLabel = f.grey("3v3"),
                optionsKey = Arenalogs.CONST.PVP_MODES.THREES,
            },
            {
                label = f.white("Shuffle"),
                disabledLabel = f.grey("Shuffle"),
                optionsKey = Arenalogs.CONST.PVP_MODES.SOLO_SHUFFLE,
            },
            {
                label = f.white("BG"),
                disabledLabel = f.grey("BG"),
                optionsKey = Arenalogs.CONST.PVP_MODES.BATTLEGROUND,
            },
        },
    }

    content.spellTooltipFrame = GGUI.TooltipOptionsFrame {
        frameOptions = {
            title = "Spell Tooltip",
            parent = content, anchorParent = content.playerTooltipFrame.frame,
            sizeX = 150, sizeY = 200,
            anchorA = "TOPLEFT", anchorB = "TOPRIGHT",
            offsetX = 20,
        },
        optionsTable = ArenalogsDB.tooltipOptions.data.spellTooltip,
        lines = {
            {
                label = f.l("Enable"),
                disabledLabel = f.grey("Enable"),
                isEnablerLine = true,
            },
            {
                label = f.white("Type"),
                disabledLabel = f.grey("Type"),
                optionsKey = Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.TYPE,
            },
            {
                label = f.white("Subtype"),
                disabledLabel = f.grey("Subtype"),
                optionsKey = Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE,
            },
            {
                label = f.white("PvP Severity"),
                disabledLabel = f.grey("PvP Severity"),
                optionsKey = Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY,
            },
            {
                label = f.white("PvP Duration"),
                disabledLabel = f.grey("PvP Duration"),
                optionsKey = Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION,
            },
            {
                label = f.white("Additional Data"),
                disabledLabel = f.grey("Additional Data"),
                optionsKey = Arenalogs.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA,
            },
        },
    }
end
