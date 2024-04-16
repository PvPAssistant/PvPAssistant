---@class PvPAssistant
local PvPAssistant = select(2, ...)

PvPAssistant.MEDIA = {}

PvPAssistant.MEDIA.BASE_PATH = "Interface/Addons/PvPAssistant/Media/"

function PvPAssistant.MEDIA:GetAsTextIcon(image, scale, offX, offY)
    if tContains(PvPAssistant.MEDIA.IMAGES, image) then
        scale = scale or 1
        local width = image.dimensions.x * scale
        local height = image.dimensions.y * scale

        return PvPAssistant.GUTIL:IconToText(PvPAssistant.MEDIA.BASE_PATH .. image.file, height, width, offX, offY)
    else
        return "<ImageNotFound>"
    end
end

PvPAssistant.MEDIA.IMAGES = {
    LOGO = { file = "Images/Icon512.tga", dimensions = { x = 512, y = 512 } },
    RANK1 = { file = "Images/rank1.blp", dimensions = { x = 256, y = 256 } },
    RANK2 = { file = "Images/rank2.blp", dimensions = { x = 256, y = 256 } },
    COMBATANT = { file = "Images/rank3.blp", dimensions = { x = 256, y = 256 } },
    CHALLENGER = { file = "Images/rank4.blp", dimensions = { x = 256, y = 256 } },
    RIVAL = { file = "Images/rank5.blp", dimensions = { x = 256, y = 256 } },
    DUELIST = { file = "Images/rank6.blp", dimensions = { x = 256, y = 256 } },
    GLADIATOR = { file = "Images/rank7.blp", dimensions = { x = 256, y = 256 } },
    OPTIONS_ICON = { file = "Buttons/OptionsButton/OptionsIcon.blp", dimensions = { x = 64, y = 64 } },
    DISCORD_TRANSPARENT = { file = "Buttons/DiscordButton/DiscordTransparent.blp", dimensions = { x = 64, y = 64 } },
    CLOSE_X = { file = "Buttons/CloseButton/CloseX.blp", dimensions = { x = 64, y = 64 } },
    REVERT = { file = "Buttons/RevertButton/Revert.blp", dimensions = { x = 64, y = 64 } },
}
