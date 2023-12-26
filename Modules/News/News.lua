local PvPLookupName = select(1, ...)

---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI

---@class PvPLookup.News
PvPLookup.NEWS = {}


function PvPLookup.NEWS:Init()
    -- create news frame
    local sizeX = 400
    local sizeY = 100

    local newsFrame = PvPLookup.GGUI.Frame({
        parent=UIParent, anchorParent=UIParent,
        anchorA="TOP", anchorB="TOP", sizeX=sizeX, sizeY=sizeY,
        backdropOptions=PvPLookup.CONST.DEFAULT_BACKDROP_OPTIONS, -- TODO: change
        frameConfigTable=PvPLookupGGUIConfig,
        frameTable=PvPLookup.MAIN.FRAMES, 
        frameID=PvPLookup.CONST.FRAMES.NEWS,
        title=PvPLookup.GUTIL:ColorizeText("PvPLookup " .. C_AddOns.GetAddOnMetadata(PvPLookupName, "Version"), 
            PvPLookup.GUTIL.COLORS.BRIGHT_BLUE),
        collapseable=true,
        closeable=true,
        moveable=true,
    })

    newsFrame:Hide()

    newsFrame.content.info = PvPLookup.GGUI.Text({
        parent=newsFrame.content, anchorParent=newsFrame.content, offsetY=-10,
        text="", justifyOptions={type="H", align="LEFT"}
    })
end

function PvPLookup.NEWS:GET_NEWS()
    local d = PvPLookup.GUTIL:ColorizeText("-", PvPLookup.GUTIL.COLORS.GREEN)
    return string.format(
    [[
        %1$s Hello World!!
    ]], d)
end

function PvPLookup.NEWS:GetChecksum()
    local checksum = 0
    local newsString = PvPLookup.NEWS:GET_NEWS()
    local checkSumBitSize = 256

    -- Iterate through each character in the string
    for i = 1, #newsString do
        checksum = (checksum + string.byte(newsString, i)) % checkSumBitSize
    end

    return checksum
end

---@return string | nil newChecksum newChecksum when news should be shown, otherwise nil
function PvPLookup.NEWS:IsNewsUpdate()
    local newChecksum = PvPLookup.NEWS:GetChecksum()
    local oldChecksum = PvPLookupOptions.newsChecksum
    if newChecksum ~= oldChecksum then
        return newChecksum
    end
    return nil
end

function PvPLookup.NEWS:ShowNews(force)
    local infoText = PvPLookup.NEWS:GET_NEWS()
    local newChecksum = PvPLookup.NEWS:IsNewsUpdate()
    if newChecksum == nil and (not force) then
       return 
    end

    PvPLookupOptions.newsChecksum = newChecksum

    local newsFrame = PvPLookup.GGUI:GetFrame(PvPLookup.MAIN.FRAMES, PvPLookup.CONST.FRAMES.NEWS)
    -- resize
    newsFrame.content.info:SetText(infoText)
    newsFrame:Show()
end