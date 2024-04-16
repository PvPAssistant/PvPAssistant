---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.GEAR_GUIDE
PvPAssistant.GEAR_GUIDE = PvPAssistant.GEAR_GUIDE

---@class PvPAssistant.GEAR_GUIDE.FRAMES
PvPAssistant.GEAR_GUIDE.FRAMES = {}

---@return PvPAssistant.GEAR_GUIDE.GEAR_GUIDE_TAB gearGuideTab
function PvPAssistant.GEAR_GUIDE.FRAMES:InitGearGuideTab()
    ---@class PvPAssistant.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = PvPAssistant.MAIN_FRAME.frame

    ---@class PvPAssistant.GEAR_GUIDE.GEAR_GUIDE_TAB : GGUI.Tab
    frame.content.gearGuideTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = PvPAssistant.MAIN_FRAME.tabContentSizeX, sizeY = PvPAssistant.MAIN_FRAME.tabContentSizeY, offsetY = PvPAssistant.MAIN_FRAME.tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Gear Guide", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.abilitiesTab.button.frame,
            anchorA = "TOPLEFT",
            anchorB = "BOTTOMLEFT",
            sizeX = PvPAssistant.MAIN_FRAME.tabButtonSizeX,
            sizeY = PvPAssistant.MAIN_FRAME.tabButtonSizeY,
            offsetX = 0, offsetY = -5,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    PvPAssistant.GEAR_GUIDE.gearGuideTab = frame.content.gearGuideTab

    local gearGuideTab = PvPAssistant.GEAR_GUIDE.gearGuideTab
    ---@class PvPAssistant.GEAR_GUIDE.GEAR_GUIDE_TAB.CONTENT : Frame
    gearGuideTab.content = gearGuideTab.content

    gearGuideTab.content.wip = GGUI.Text {
        parent = gearGuideTab.content, anchorPoints = { { anchorParent = gearGuideTab.content, offsetY = 60 } },
        text = f.l("WORK IN PROGRESS")
    }

    return gearGuideTab
end
