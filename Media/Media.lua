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
}