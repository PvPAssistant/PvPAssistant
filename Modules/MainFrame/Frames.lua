---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = select(1, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MAIN_FRAME
PvPAssistant.MAIN_FRAME = PvPAssistant.MAIN_FRAME

---@class PvPAssistant.MAIN_FRAME.FRAMES
PvPAssistant.MAIN_FRAME.FRAMES = {}

function PvPAssistant.MAIN_FRAME.FRAMES:Init()
    local sizeX = 750
    local sizeY = 650
    ---@class PvPAssistant.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = GGUI.Frame {
        moveable = true, frameID = PvPAssistant.CONST.FRAMES.MAIN_FRAME,
        sizeX = sizeX, sizeY = sizeY, frameConfigTable = PvPAssistantGGUIConfig,
        backdropOptions = PvPAssistant.CONST.MAIN_FRAME_BACKDROP, globalName = PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME
    }

    PvPAssistant.MAIN_FRAME.frame = frame

    -- makes it closeable on Esc
    tinsert(UISpecialFrames, PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME)

    frame.content.title = PvPAssistant.UTIL:CreateLogo(frame.content,
        {
            {
                anchorParent = frame.content,
                anchorA = "TOPLEFT",
                anchorB = "TOPLEFT",
                offsetX = 15,
                offsetY = -15,
            }
        })

    frame.content.updateText = GGUI.Text {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.title.frame, anchorA = "BOTTOMRIGHT", anchorB = "TOPRIGHT", offsetY = 5 } },
        text = f.l("*Update Beta" .. C_AddOns.GetAddOnMetadata(addonName, "version")),
        tooltipOptions = {
            owner = frame.frame,
            anchor = "ANCHOR_TOPLEFT",
            text = PvPAssistant.CONST.NEWS,
        },
    }

    ---@class PvPAssistant.MAIN_FRAME.CONTENT : Frame
    frame.content = frame.content

    frame.content.matchHistoryTab = PvPAssistant.MATCH_HISTORY.FRAMES:InitMatchHistoryTab()
    frame.content.abilitiesTab = PvPAssistant.ABILITY_CATALOGUE.FRAMES:InitAbilitiesCatalogueTab()
    frame.content.gearGuideTab = PvPAssistant.GEAR_GUIDE.FRAMES:InitGearGuideTab()

    frame.content.utilButtonFrame = GGUI.Frame {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT", offsetX = -20, offsetY = -57 } },
        sizeX = 120, sizeY = 70,
    }

    frame.content.discordButton = GGUI.Button {
        parent = frame.content.utilButtonFrame.content,
        anchorPoints = { { anchorParent = frame.content.utilButtonFrame.content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 0, } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        label = PvPAssistant.MEDIA:GetAsTextIcon(PvPAssistant.MEDIA.IMAGES.DISCORD_TRANSPARENT, 0.3, 0, -1),
        sizeX = PvPAssistant.MAIN_FRAME.utilButtonSizeX, sizeY = PvPAssistant.MAIN_FRAME.utilButtonSizeY,
        clickCallback = function()
            GGUI:ShowPopup {
                copyText = PvPAssistant.CONST.DISCORD_INVITE,
                parent = frame.content, anchorParent = frame.content.discordButton.frame,
                title = "Join our Discord! (CTRL+C to Copy)", sizeX = 280, sizeY = 100,
                okButtonLabel = f.white("Ok"),
            }
        end
    }

    frame.content.closeButton = GGUI.Button {
        parent = frame.content.utilButtonFrame.content, anchorPoints = { { anchorParent = frame.content.utilButtonFrame.frame, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT", offsetX = 0, } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        label = PvPAssistant.MEDIA:GetAsTextIcon(PvPAssistant.MEDIA.IMAGES.CLOSE_X, 0.27, 0, -1),
        fontOptions = {
            fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = PvPAssistant.MAIN_FRAME.utilButtonSizeX,
        sizeY = PvPAssistant.MAIN_FRAME.utilButtonSizeY,
        clickCallback = function()
            frame:Hide()
        end
    }

    frame.content.optionsTab = PvPAssistant.OPTIONS.FRAMES:InitOptionsTab()

    GGUI.TabSystem { frame.content.matchHistoryTab, frame.content.abilitiesTab, frame.content.gearGuideTab, frame.content.optionsTab }

    frame:Hide()
end
