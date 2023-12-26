---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.Const
PvPLookup.CONST = {}

---@enum PvPLookup.Const.Frames
PvPLookup.CONST.FRAMES = {
    HISTORY_FRAME = "HISTORY_FRAME",
    NEWS = "NEWS",
}

---@enum PvPLookup.Const.PVPModes
PvPLookup.CONST.PVP_MODES = {
    SOLO = "SOLO",
    TWOS = "TWOS",
    THREES = "THREES",
    RGB = "RGB",
}