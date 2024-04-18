---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.OPTIONS
PvPAssistant.OPTIONS = PvPAssistant.OPTIONS

---@class PvPAssistant.OPTIONS.FRAMES
PvPAssistant.OPTIONS.FRAMES = {}

---@return PvPAssistant.OPTIONS.OPTIONS_TAB optionsTab
function PvPAssistant.OPTIONS.FRAMES:InitOptionsTab()
    ---@class PvPAssistant.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = PvPAssistant.MAIN_FRAME.frame

    ---@class PvPAssistant.OPTIONS.OPTIONS_TAB : GGUI.Tab
    frame.content.optionsTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = PvPAssistant.MAIN_FRAME.tabContentSizeX, sizeY = PvPAssistant.MAIN_FRAME.tabContentSizeY, offsetY = PvPAssistant.MAIN_FRAME.tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = PvPAssistant.MEDIA:GetAsTextIcon(PvPAssistant.MEDIA.IMAGES.OPTIONS_ICON, 0.35, 0, 0),
            anchorPoints = { {
                anchorParent = frame.content.utilButtonFrame.frame,
                anchorA = "BOTTOMRIGHT",
                anchorB = "BOTTOMRIGHT",
                offsetY = 0,
            } },
            hideBackground = true,
            parent = frame.content,
            sizeX = PvPAssistant.MAIN_FRAME.utilButtonSizeX, sizeY = PvPAssistant.MAIN_FRAME.utilButtonSizeY,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.OPTIONS_BUTTON,
        }
    }

    local tabSizeX = 710
    local tabSizeY = 450
    local tabContentOffsetY = -130

    local optionsTab = PvPAssistant.MAIN_FRAME.frame.content.optionsTab
    ---@class PvPAssistant.OPTIONS.OPTIONS_TAB.CONTENT
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
                    offsetX = 25,
                    offsetY = -103,
                }
            },
            sizeX = PvPAssistant.MAIN_FRAME.tabButtonSizeX,
            sizeY = PvPAssistant.MAIN_FRAME.tabButtonSizeY,
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
                    offsetX = 3,
                }
            },
            sizeX = PvPAssistant.MAIN_FRAME.tabButtonSizeX,
            sizeY = PvPAssistant.MAIN_FRAME.tabButtonSizeY,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    ---@class PvPAssistant.OPTIONS.QuickJoinTab : GGUI.Tab
    optionsTab.content.quickJoinTab = GGUI.Tab {
        parent = optionsTab.content, anchorParent = optionsTab.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = tabSizeX, sizeY = tabSizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        backdropOptions = PvPAssistant.CONST.BACKDROPS.OPTIONS_TAB,
        buttonOptions = {
            label = GUTIL:ColorizeText("Quick Join", GUTIL.COLORS.WHITE),
            parent = optionsTab.content,
            anchorPoints =
            {
                {
                    anchorParent = optionsTab.content.tooltipsTab.button.frame,
                    anchorA = "LEFT",
                    anchorB = "RIGHT",
                    offsetX = 3,
                }
            },
            sizeX = PvPAssistant.MAIN_FRAME.tabButtonSizeX,
            sizeY = PvPAssistant.MAIN_FRAME.tabButtonSizeY,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    local arenaGuideTab = optionsTab.content.arenaGuideTab
    local quickJoinTab = optionsTab.content.quickJoinTab
    local tooltipsTab = optionsTab.content.tooltipsTab

    GGUI.TabSystem { arenaGuideTab, quickJoinTab, tooltipsTab }

    PvPAssistant.OPTIONS.FRAMES:InitArenaGuideTab(arenaGuideTab)
    PvPAssistant.OPTIONS.FRAMES:InitQuickJoinTab(quickJoinTab)
    PvPAssistant.OPTIONS.FRAMES:InitTooltipsTab(tooltipsTab)

    return optionsTab
end

---@param arenaGuideTab PvPAssistant.OPTIONS.ArenaGuideTab
function PvPAssistant.OPTIONS.FRAMES:InitArenaGuideTab(arenaGuideTab)
    ---@class PvPAssistant.OPTIONS.ArenaGuideTab.Content : Frame
    local content = arenaGuideTab.content

    content.enableArenaGuideCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 10, offsetY = -10,
        labelOptions = {
            text = f.white("Enable the " .. f.e("Arena Quick Guide")),
        },
        tooltip = f.white("If enabled, the " .. f.l("PvPAssistant ") .. f.e("\nArena Quick Guide") .. " will appear in arena matches to give you useful information and hints"),
        initialValue = PvPAssistant.DB.GENERAL_OPTIONS:Get("ARENA_GUIDE_ENABLED"),
        clickCallback = function(_, checked)
            PvPAssistant.DB.GENERAL_OPTIONS:Save("ARENA_GUIDE_ENABLED", checked)
        end
    }
end

---@param quickJoinTab PvPAssistant.OPTIONS.QuickJoinTab
function PvPAssistant.OPTIONS.FRAMES:InitQuickJoinTab(quickJoinTab)
    ---@class PvPAssistant.OPTIONS.QuickJoinTab.Content : Frame
    local content = quickJoinTab.content

    content.enableQuickJoinCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 10, offsetY = -10,
        labelOptions = {
            text = f.white("Enable the " .. f.e("Arena Quick Join Button")),
        },
        tooltip = f.white("If enabled, a button will be shown to quickly queue for arena matches"),
        initialValue = PvPAssistant.DB.GENERAL_OPTIONS:Get("ARENA_QUICK_JOIN_ENABLED"),
        clickCallback = function(_, checked)
            PvPAssistant.DB.GENERAL_OPTIONS:Save("ARENA_QUICK_JOIN_ENABLED", checked)

            PvPAssistant.ARENA_QUICK_JOIN:UpdateVisibility()
        end
    }

    content.enableButtonLabelCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content.enableQuickJoinCheckbox.frame, anchorA = "TOPLEFT", anchorB = "BOTTOMLEFT",
        labelOptions = {
            text = f.white("Show Button Label"),
        },
        tooltip = f.white("If enabled, the button will be labeled"),
        initialValue = PvPAssistant.DB.GENERAL_OPTIONS:Get("ARENA_QUICK_JOIN_BUTTON_LABEL_ENABLED"),
        clickCallback = function(_, checked)
            PvPAssistant.DB.GENERAL_OPTIONS:Save("ARENA_QUICK_JOIN_BUTTON_LABEL_ENABLED", checked)

            PvPAssistant.ARENA_QUICK_JOIN:UpdateVisibility()
        end
    }

    content.enablePositionAnchorCheckbox = GGUI.Checkbox {
        parent = content, anchorParent = content.enableButtonLabelCheckbox.frame, anchorA = "TOPLEFT", anchorB = "BOTTOMLEFT",
        labelOptions = {
            text = f.white("Show Button Position Anchor"),
        },
        tooltip = f.white("If enabled, displays the position anchor that can be dragged to move the button"),
        initialValue = PvPAssistant.DB.GENERAL_OPTIONS:Get("ARENA_QUICK_JOIN_MOVE_ENABLED"),
        clickCallback = function(_, checked)
            PvPAssistant.DB.GENERAL_OPTIONS:Save("ARENA_QUICK_JOIN_MOVE_ENABLED", checked)

            PvPAssistant.ARENA_QUICK_JOIN:UpdateVisibility()
        end
    }

    content.resetPositionButton = GGUI.Button {
        parent = content, anchorPoints = { { anchorParent = content.enablePositionAnchorCheckbox.frame, anchorA = "TOPLEFT", anchorB = "BOTTOMLEFT" } },
        label = f.white(PvPAssistant.MEDIA:GetAsTextIcon(PvPAssistant.MEDIA.IMAGES.REVERT, 0.2) .. " Reset Button Position"),
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        sizeX = 15,
        adjustWidth = true,
        tooltipOptions = {
            anchor = "ANCHOR_CURSOR_RIGHT",
            text = f.white("Resets the Button to the middle of the screen")
        },
        clickCallback = function()
            PvPAssistant.ARENA_QUICK_JOIN.positionAnchor:ResetPosition()
        end
    }
end

---@param tooltipsTab PvPAssistant.OPTIONS.TooltipsTab
function PvPAssistant.OPTIONS.FRAMES:InitTooltipsTab(tooltipsTab)
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
