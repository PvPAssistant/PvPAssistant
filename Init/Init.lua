local PvPAssistantName = select(1, ...)
---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local GGUI = PvPAssistant.GGUI
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

PvPAssistantGGUIConfig = PvPAssistantGGUIConfig or {}

---@class PvPAssistant.INIT : Frame
PvPAssistant.INIT = GUTIL:CreateRegistreeForEvents({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD" })

function PvPAssistant.INIT:Init()
    PvPAssistant.DB:Init()

    PvPAssistant.SLASH:Init()
    PvPAssistant.OPTIONS:Init()
    PvPAssistant.ARENA_GUIDE.FRAMES:Init()
    PvPAssistant.ARENA_GUIDE:Init()
    PvPAssistant.MINIMAP:Init()
    PvPAssistant.PLAYER_TOOLTIP:Init()
    PvPAssistant.SPELL_TOOLTIP:Init()
    PvPAssistant.MAIN_FRAME.FRAMES:Init()
    PvPAssistant.MATCH_HISTORY.FRAMES:InitTooltipFrame()

    GGUI:InitializePopup {
        backdropOptions = PvPAssistant.CONST.MAIN_FRAME_BACKDROP,
        sizeX = 150, sizeY = 100,
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        buttonFontOptions = {
            fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
        },
        hideCloseButton = true,
    }

    -- restore frame positions
    PvPAssistant.ARENA_GUIDE.frame:RestoreSavedConfig(UIParent)
end

function PvPAssistant.INIT:ADDON_LOADED(addon_name)
    if addon_name ~= PvPAssistantName then
        return
    end
    PvPAssistant.INIT:Init()
end

function PvPAssistant.INIT:PLAYER_ENTERING_WORLD()
    PvPAssistant.DB.CHARACTERS:InitData()
    PvPAssistant.MAIN_FRAME.frame:RestoreSavedConfig(UIParent)

    PvPAssistant.SPEC_LOOKUP:Init()

    PvPAssistant.MATCH_HISTORY:InitMatchHistoryDropdownData()
    PvPAssistant.MATCH_HISTORY.FRAMES:UpdateMatchHistory()

    PvPAssistant.DATA_COLLECTION.enableCombatLog = false
end
