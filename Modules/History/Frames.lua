---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.History
PvPLookup.HISTORY = PvPLookup.HISTORY

---@class PvPLookup.History.Frames
PvPLookup.HISTORY.FRAMES = {}

function PvPLookup.HISTORY.FRAMES:Init()
    local sizeX = 1000
    local sizeY = 450
    local offsetX = -10
    local offsetY = 30

    --- @type GGUI.Frame | GGUI.Widget
    local reminderFrame = PvPLookup.GGUI.Frame({
        parent=UIParent, 
        anchorParent=UIParent,
        anchorA="CENTER",anchorB="CENTER",
        sizeX=sizeX,sizeY=sizeY,
        offsetX=offsetX,offsetY=offsetY,
        frameID=PvPLookup.CONST.FRAMES.HISTORY_FRAME, 
        title="PvPLookup",
        closeable=true,
        moveable=true,
        backdropOptions=PvPLookup.CONST.DEFAULT_BACKDROP_OPTIONS, -- TODO Atlas Background
        frameConfigTable=PvPLookupGGUIConfig,
        frameTable=PvPLookup.MAIN.FRAMES,
    })

    local function createContent(reminderFrame)
        reminderFrame:Hide()
    end

    createContent(reminderFrame)
end