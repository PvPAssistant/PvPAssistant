---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.Options
PvPAssistant.OPTIONS = {}

PvPAssistantOptions = PvPAssistantOptions or {
    enableDebug = false,

    -- Arena Guide
    arenaGuideEnable = true,
}

---@param optionName string
---@param value any
function PvPAssistant.OPTIONS:InitDefaultValue(optionName, value)
    if PvPAssistantOptions[optionName] == nil then
        PvPAssistantOptions[optionName] = value
    end
end

function PvPAssistant.OPTIONS:Init()
    self:HandleOptionsUpdates()
    PvPAssistant.OPTIONS.optionsPanel = CreateFrame("Frame", "PvPAssistantOptionsPanel")
    PvPAssistant.OPTIONS.optionsPanel.name = "PvPAssistant"

    InterfaceOptions_AddCategory(self.optionsPanel)
end

function PvPAssistant.OPTIONS:HandleOptionsUpdates()
    if PvPAssistantOptions then
        PvPAssistant.OPTIONS:InitDefaultValue("enableDebug", false)
        PvPAssistant.OPTIONS:InitDefaultValue("arenaGuideEnable", true)
    end
end

function PvPAssistant.OPTIONS:InitOptionsTab()
    local tabSizeX = 650
    local tabSizeY = 450
    local tabContentOffsetY = -80

    local optionsTab = PvPAssistant.MAIN_FRAME.frame.content.optionsTab
    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB.CONTENT
    optionsTab.content = optionsTab.content

    optionsTab.content.header = GGUI.Text {
        parent = optionsTab.content, anchorPoints = { { anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP", offsetY = -20 } },
        scale = 1.5, text = f.white("Options")
    }

    ---@class PvPAssistant.OPTIONS.ArenaGuideTab : GGUI.Tab
    optionsTab.content.arenaGuideTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = PvPAssistant.CONST.BACKDROPS.OPTIONS_TAB,
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
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    ---@class PvPAssistant.OPTIONS.TooltipsTab : GGUI.Tab
    optionsTab.content.tooltipsTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = PvPAssistant.CONST.BACKDROPS.OPTIONS_TAB,
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
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    local arenaGuideTab = optionsTab.content.arenaGuideTab
    local tooltipsTab = optionsTab.content.tooltipsTab

    GGUI.TabSystem { arenaGuideTab, tooltipsTab }

    PvPAssistant.OPTIONS:InitArenaGuideTab(arenaGuideTab)
    PvPAssistant.OPTIONS:InitTooltipsTab(tooltipsTab)
end

---@param arenaGuideTab PvPAssistant.OPTIONS.ArenaGuideTab
function PvPAssistant.OPTIONS:InitArenaGuideTab(arenaGuideTab)
    ---@class PvPAssistant.OPTIONS.ArenaGuideTab.Content : Frame
    local content = arenaGuideTab.content

    content.enableArenaGuideCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 10, offsetY = -10,
        labelOptions = {
            text = f.white("Enable the " .. f.e("Arena Quick Guide")),
        },
        tooltip = f.white("If enabled, the " .. f.l("PvPAssistant ") .. f.e("\nArena Quick Guide") .. " will appear in arena matches to give you useful information and hints"),
        initialValue = PvPAssistantOptions.arenaGuideEnable,
        clickCallback = function(_, checked)
            PvPAssistantOptions.arenaGuideEnable = checked
        end
    }
end

---@param tooltipsTab PvPAssistant.OPTIONS.TooltipsTab
function PvPAssistant.OPTIONS:InitTooltipsTab(tooltipsTab)
    ---@class PvPAssistant.OPTIONS.TooltipsTab.Content : Frame
    local content = tooltipsTab.content

    content.playerTooltipFrame = GGUI.TooltipOptionsFrame {
        frameOptions = {
            title = "Player Tooltip",
            parent = content, anchorParent = content,
            sizeX = 150, sizeY = 200,
            anchorA = "TOPLEFT", anchorB = "TOPLEFT",
            offsetX = 20, offsetY = -20
        },
        optionsTable = PvPAssistantDB.tooltipOptions.data.playerTooltip,
        lines = {
            {
                label = f.l("Enable"),
                disabledLabel = f.grey("Enable"),
                isEnablerLine = true,
            },
            {
                label = f.white("2v2"),
                disabledLabel = f.grey("2v2"),
                optionsKey = PvPAssistant.CONST.PVP_MODES.TWOS,
            },
            {
                label = f.white("3v3"),
                disabledLabel = f.grey("3v3"),
                optionsKey = PvPAssistant.CONST.PVP_MODES.THREES,
            },
            {
                label = f.white("Shuffle"),
                disabledLabel = f.grey("Shuffle"),
                optionsKey = PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE,
            },
            {
                label = f.white("RBG"),
                disabledLabel = f.grey("RBG"),
                optionsKey = PvPAssistant.CONST.PVP_MODES.BATTLEGROUND,
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
        optionsTable = PvPAssistantDB.tooltipOptions.data.spellTooltip,
        lines = {
            {
                label = f.l("Enable"),
                disabledLabel = f.grey("Enable"),
                isEnablerLine = true,
            },
            {
                label = f.white("Type"),
                disabledLabel = f.grey("Type"),
                optionsKey = PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE,
            },
            {
                label = f.white("Subtype"),
                disabledLabel = f.grey("Subtype"),
                optionsKey = PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE,
            },
            {
                label = f.white("PvP Severity"),
                disabledLabel = f.grey("PvP Severity"),
                optionsKey = PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY,
            },
            {
                label = f.white("PvP Duration"),
                disabledLabel = f.grey("PvP Duration"),
                optionsKey = PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION,
            },
            {
                label = f.white("Additional Data"),
                disabledLabel = f.grey("Additional Data"),
                optionsKey = PvPAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA,
            },
        },
    }
end
