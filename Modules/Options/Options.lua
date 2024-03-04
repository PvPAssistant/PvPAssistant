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

    local arenaGuideTab = optionsTab.content.arenaGuideTab

    GGUI.TabSystem { arenaGuideTab }

    Arenalogs.OPTIONS:InitArenaGuideTab()
end

function Arenalogs.OPTIONS:InitArenaGuideTab()
    ---@class Arenalogs.OPTIONS.ArenaGuideTab.Content : Frame
    local content = Arenalogs.MAIN_FRAME.frame.content.optionsTab.content.arenaGuideTab.content

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
