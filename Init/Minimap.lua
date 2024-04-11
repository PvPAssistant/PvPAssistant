---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local GGUI = PvPAssistant.GGUI
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

PvPAssistantGGUIConfig = PvPAssistantGGUIConfig or {}

---@class PvPAssistant.MINIMAP : Frame
PvPAssistant.MINIMAP = {}

function PvPAssistant.MINIMAP:Init()
    local LibIcon = LibStub("LibDBIcon-1.0")
    local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("PvPAssistant", {
        type = "data source",
        label = "PvPAssistant",
        tocname = "PvPAssistant",
        icon = "Interface\\Addons\\PvPAssistant\\Media\\Images\\icon1337",
        OnClick = function()
            local mainFrame = PvPAssistant.MAIN_FRAME.frame
            if mainFrame then
                mainFrame:SetVisible(not mainFrame:IsVisible())
            end
        end,
    })

    function ldb.OnTooltipShow(tt)
        tt:AddLine(GUTIL:ColorizeText("PvPAssistant\n", GUTIL.COLORS.LEGENDARY))
        tt:AddLine(GUTIL:ColorizeText("Click to Open!", GUTIL.COLORS.WHITE))
    end

    PvPAssistantLibIconDB = PvPAssistantLibIconDB or {}

    LibIcon:Register("PvPAssistant", ldb, PvPAssistantLibIconDB)
end
