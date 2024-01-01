---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.PvPInfo
PvPLookup.PVPINFO = PvPLookup.PVPINFO

---@class PvPLookup.PvPInfo.Frames
PvPLookup.PVPINFO.FRAMES = {}

function PvPLookup.PVPINFO.FRAMES:Init()
    if not PVPUIFrame then
        error("PVPUIFrame not found")
    end
    local sizeX, sizeY = 300, PVPUIFrame:GetHeight()
    PvPLookup.PVPINFO.frame = GGUI.Frame{
        parent=PVPUIFrame, anchorParent=PVPUIFrame,
        anchorA="TOPLEFT", anchorB="TOPRIGHT", offsetX=0, offsetY=0, sizeX=sizeX, sizeY=sizeY,
        moveable=true, frameConfigTable=PvPLookupGGUIConfig, frameID=PvPLookup.CONST.FRAMES.PVPINFO,
        frameTable=PvPLookup.MAIN.FRAMES, 
        backdropOptions=PvPLookup.CONST.PVPINFO_BACKDROP
    }

end