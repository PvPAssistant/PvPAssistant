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
        sizeX = sizeX, sizeY = sizeY, frameConfigTable = PvPAssistantGGUIConfig, frameTable = PvPAssistant.MAIN.FRAMES,
        backdropOptions = PvPAssistant.CONST.MAIN_FRAME_BACKDROP, globalName = PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME
    }

    PvPAssistant.MAIN_FRAME.frame = frame

    -- makes it closeable on Esc
    tinsert(UISpecialFrames, PvPAssistant.CONST.PVP_LOOKUP_FRAME_GLOBAL_NAME)

    frame.content.titleLogo = PvPAssistant.UTIL:CreateLogo(frame.content,
        {
            {
                anchorParent = frame.content,
                anchorA = "TOPLEFT",
                anchorB = "TOPLEFT",
                offsetX = 30,
                offsetY = -15,
            }
        })

    frame.content.updateText = GGUI.Text {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.titleLogo.frame, anchorA = "BOTTOMRIGHT", anchorB = "TOPRIGHT", offsetY = 5 } },
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
    frame.content.optionsTab = PvPAssistant.OPTIONS.FRAMES:InitOptionsTab()

    GGUI.TabSystem { frame.content.matchHistoryTab, frame.content.abilitiesTab, frame.content.gearGuideTab, frame.content.optionsTab }

    frame.content.discordButton = GGUI.Button {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.optionsTab.button.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -6, } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DISCORD_BUTTON,
        cleanTemplate = true,
        sizeX = 20, sizeY = 20,
        clickCallback = function()
            GGUI:ShowPopup {
                copyText = PvPAssistant.CONST.DISCORD_INVITE,
                parent = frame.content, anchorParent = frame.content.discordButton.frame,
                title = "Join our Discord! (CTRL+C to Copy)", sizeX = 280, sizeY = 100,
                okButtonLabel = f.white("Ok"),
            }
        end
    }

    frame.content.DONATE_BUTTON = GGUI.Button {
        parent = frame.content, anchorPoints = { { anchorParent = frame.content.optionsTab.button.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -30, } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DONATE_BUTTON, -- Updated to use the new DonateButton textures
        cleanTemplate = true,
        sizeX = 20, sizeY = 20,
        clickCallback = function()
            GGUI:ShowPopup {
                copyText = PvPAssistant.CONST.DONATE_URL,
                parent = frame.content, anchorParent = frame.content.DONATE_BUTTON.frame, -- Ensure this references the correct button
                title = "Kofi donation page! (CTRL+C to Copy)", sizeX = 280, sizeY = 100,
                okButtonLabel = f.white("Ok"),
            }
        end
    }

    frame.content.closeButton = GGUI.Button {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT",
        offsetX = -8, offsetY = -8,
        label = f.white("X"),
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        fontOptions = {
            fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = 20,
        sizeY = 20,
        clickCallback = function()
            frame:Hide()
        end
    }

    frame:Hide()
end
