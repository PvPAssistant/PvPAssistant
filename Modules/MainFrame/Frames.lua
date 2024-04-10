---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = select(1, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class MAIN_FRAME
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
    local tabContentOffsetY = -50

    frame.content.matchHistoryTab = PvPAssistant.MATCH_HISTORY.FRAMES:InitMatchHistoryTab()
    frame.content.abilitiesTab = PvPAssistant.ABILITY_CATALOGUE.FRAMES:InitAbilitiesCatalogueTab()

    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE_TAB : GGUI.Tab
    frame.content.gearCatalogueTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Gear Guide", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.abilitiesTab.button.frame,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            offsetX = 10,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            scale = tabButtonScale,
        }
    }
    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE.CONTENT
    frame.content.gearCatalogueTab.content = frame.content.gearCatalogueTab.content
    local gearCatalogueTab = frame.content.gearCatalogueTab
    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE.CONTENT
    gearCatalogueTab.content = gearCatalogueTab.content

    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB : GGUI.Tab
    frame.content.optionsTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = sizeX, sizeY = sizeY, offsetY = tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.OPTIONS_ICON, 18, 18, 0, -1),
            anchorPoints = { {
                anchorParent = frame.content,
                anchorA = "TOPRIGHT",
                anchorB = "TOPRIGHT",
                offsetY = -8,
                offsetX = -35,
            } },
            parent = frame.content,
            sizeX = 20, sizeY = 20,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.OPTIONS_BUTTON,
            scale = tabButtonScale,
        }
    }

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



    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB.CONTENT
    frame.content.optionsTab.content = frame.content.optionsTab.content
    local optionsTab = frame.content.optionsTab
    ---@class PvPAssistant.MAIN_FRAME.OPTIONS_TAB.CONTENT
    optionsTab.content = optionsTab.content

    GGUI.TabSystem { frame.content.matchHistoryTab, frame.content.abilitiesTab, gearCatalogueTab, optionsTab }

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

    PvPAssistant.MAIN_FRAME.FRAMES:InitGearCatalogue()
    PvPAssistant.OPTIONS:InitOptionsTab()

    frame:Hide()
end

function PvPAssistant.MAIN_FRAME.FRAMES:InitGearCatalogue()
    local gearCatalogueTab = PvPAssistant.MAIN_FRAME.frame.content.gearCatalogueTab
    ---@class PvPAssistant.MAIN_FRAME.GEAR_CATALOGUE_TAB.CONTENT
    gearCatalogueTab.content = gearCatalogueTab.content

    gearCatalogueTab.content.wip = GGUI.Text {
        parent = gearCatalogueTab.content, anchorPoints = { { anchorParent = gearCatalogueTab.content, offsetY = 60 } },
        text = f.l("WORK IN PROGRESS")
    }
end
