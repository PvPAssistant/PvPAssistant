---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GGUI = PvpAssistant.GGUI
local GUTIL = PvpAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvpAssistant.Options
PvpAssistant.OPTIONS = {}

PvpAssistantOptions = PvpAssistantOptions or {
    enableDebug = false,

    -- Arena Guide
    arenaGuideEnable = true,
}

---@param optionName string
---@param value any
function PvpAssistant.OPTIONS:InitDefaultValue(optionName, value)
    if PvpAssistantOptions[optionName] == nil then
        PvpAssistantOptions[optionName] = value
    end
end

function PvpAssistant.OPTIONS:Init()
    self:HandleOptionsUpdates()
    PvpAssistant.OPTIONS.optionsPanel = CreateFrame("Frame", "PvpAssistantOptionsPanel")
    PvpAssistant.OPTIONS.optionsPanel.name = "PvpAssistant"

    InterfaceOptions_AddCategory(self.optionsPanel)
end

function PvpAssistant.OPTIONS:HandleOptionsUpdates()
    if PvpAssistantOptions then
        PvpAssistant.OPTIONS:InitDefaultValue("enableDebug", false)
        PvpAssistant.OPTIONS:InitDefaultValue("arenaGuideEnable", true)
    end
end

function PvpAssistant.OPTIONS:InitOptionsTab()
    local tabSizeX = 650
    local tabSizeY = 450
    local tabContentOffsetY = -80

    local optionsTab = PvpAssistant.MAIN_FRAME.frame.content.optionsTab
    ---@class PvpAssistant.MAIN_FRAME.OPTIONS_TAB.CONTENT
    optionsTab.content = optionsTab.content

    optionsTab.content.header = GGUI.Text {
        parent = optionsTab.content, anchorPoints = { { anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP", offsetY = -20 } },
        scale = 1.5, text = f.white("Options")
    }

    ---@class PvpAssistant.OPTIONS.ArenaGuideTab : GGUI.Tab
    optionsTab.content.arenaGuideTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = PvpAssistant.CONST.BACKDROPS.OPTIONS_TAB,
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
            buttonTextureOptions = PvpAssistant.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = PvpAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    ---@class PvpAssistant.OPTIONS.TooltipsTab : GGUI.Tab
    optionsTab.content.tooltipsTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = PvpAssistant.CONST.BACKDROPS.OPTIONS_TAB,
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
            buttonTextureOptions = PvpAssistant.CONST.ASSETS.BUTTONS.TAB_BUTTON,
            fontOptions = {
                fontFile = PvpAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    local arenaGuideTab = optionsTab.content.arenaGuideTab
    local tooltipsTab = optionsTab.content.tooltipsTab

    GGUI.TabSystem { arenaGuideTab, tooltipsTab }

    PvpAssistant.OPTIONS:InitArenaGuideTab(arenaGuideTab)
    PvpAssistant.OPTIONS:InitTooltipsTab(tooltipsTab)
end

---@param arenaGuideTab PvpAssistant.OPTIONS.ArenaGuideTab
function PvpAssistant.OPTIONS:InitArenaGuideTab(arenaGuideTab)
    ---@class PvpAssistant.OPTIONS.ArenaGuideTab.Content : Frame
    local content = arenaGuideTab.content

    content.enableArenaGuideCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 10, offsetY = -10,
        labelOptions = {
            text = f.white("Enable the " .. f.e("Arena Quick Guide")),
        },
        tooltip = f.white("If enabled, the " .. f.l("PvpAssistant ") .. f.e("\nArena Quick Guide") .. " will appear in arena matches to give you useful information and hints"),
        initialValue = PvpAssistantOptions.arenaGuideEnable,
        clickCallback = function(_, checked)
            PvpAssistantOptions.arenaGuideEnable = checked
        end
    }
end

---@param tooltipsTab PvpAssistant.OPTIONS.TooltipsTab
function PvpAssistant.OPTIONS:InitTooltipsTab(tooltipsTab)
    ---@class PvpAssistant.OPTIONS.TooltipsTab.Content : Frame
    local content = tooltipsTab.content

    content.playerTooltipFrame = GGUI.TooltipOptionsFrame {
        frameOptions = {
            title = "Player Tooltip",
            parent = content, anchorParent = content,
            sizeX = 150, sizeY = 200,
            anchorA = "TOPLEFT", anchorB = "TOPLEFT",
            offsetX = 20, offsetY = -20
        },
        optionsTable = PvpAssistantDB.tooltipOptions.data.playerTooltip,
        lines = {
            {
                label = f.l("Enable"),
                disabledLabel = f.grey("Enable"),
                isEnablerLine = true,
            },
            {
                label = f.white("2v2"),
                disabledLabel = f.grey("2v2"),
                optionsKey = PvpAssistant.CONST.PVP_MODES.TWOS,
            },
            {
                label = f.white("3v3"),
                disabledLabel = f.grey("3v3"),
                optionsKey = PvpAssistant.CONST.PVP_MODES.THREES,
            },
            {
                label = f.white("Shuffle"),
                disabledLabel = f.grey("Shuffle"),
                optionsKey = PvpAssistant.CONST.PVP_MODES.SOLO_SHUFFLE,
            },
            {
                label = f.white("BG"),
                disabledLabel = f.grey("BG"),
                optionsKey = PvpAssistant.CONST.PVP_MODES.BATTLEGROUND,
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
        optionsTable = PvpAssistantDB.tooltipOptions.data.spellTooltip,
        lines = {
            {
                label = f.l("Enable"),
                disabledLabel = f.grey("Enable"),
                isEnablerLine = true,
            },
            {
                label = f.white("Type"),
                disabledLabel = f.grey("Type"),
                optionsKey = PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.TYPE,
            },
            {
                label = f.white("Subtype"),
                disabledLabel = f.grey("Subtype"),
                optionsKey = PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.SUBTYPE,
            },
            {
                label = f.white("PvP Severity"),
                disabledLabel = f.grey("PvP Severity"),
                optionsKey = PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_SEVERITY,
            },
            {
                label = f.white("PvP Duration"),
                disabledLabel = f.grey("PvP Duration"),
                optionsKey = PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.PVP_DURATION,
            },
            {
                label = f.white("Additional Data"),
                disabledLabel = f.grey("Additional Data"),
                optionsKey = PvpAssistant.CONST.SPELL_TOOLTIP_OPTIONS.ADDITIONAL_DATA,
            },
        },
    }
end
