---@class PvPLookup
local PvPLookup = select(2, ...)

PvPLookup.MEDIA = {}

PvPLookup.MEDIA.BASE_PATH = "Interface/Addons/PvPLookup/Media/Images/"

function PvPLookup.MEDIA:GetAsTextIcon(image, scale)
    if tContains(PvPLookup.MEDIA.IMAGES, image) then
        scale = scale or 1
        local width = image.dimensions.x * scale
        local height = image.dimensions.y * scale

        return PvPLookup.GUTIL:IconToText(PvPLookup.MEDIA.BASE_PATH .. image.file, height, width)
    else
        return "<ImageNotFound>"
    end
end

PvPLookup.MEDIA.IMAGES = {
    LOGO_1024 = {file="logo1024.blp", dimensions={x=1024,y=1024}},
    RANK1 = {file="rank1.blp", dimensions={x=256,y=256}},
    RANK2 = {file="rank2.blp", dimensions={x=256,y=256}},
    COMBATANT = {file="rank3.blp", dimensions={x=256,y=256}},
    CHALLENGER = {file="rank4.blp", dimensions={x=256,y=256}},
    RIVAL = {file="rank5.blp", dimensions={x=256,y=256}},
    DUELIST = {file="rank6.blp", dimensions={x=256,y=256}},
    GLADIATOR = {file="rank7.blp", dimensions={x=256,y=256}},
}