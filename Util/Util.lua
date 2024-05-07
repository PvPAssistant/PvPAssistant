---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.Util
PvPAssistant.UTIL = {}

--- also for healing
function PvPAssistant.UTIL:FormatDamageNumber(number)
    if number >= 1000000000 then
        return GUTIL:Round(number / 1000000000, 2) .. "B"
    end
    if number >= 1000000 then
        return GUTIL:Round(number / 1000000, 2) .. "M"
    end
    if number >= 1000 then
        return GUTIL:Round(number / 1000) .. "K"
    end

    return tostring(number)
end

---@param text string
---@param rating number
function PvPAssistant.UTIL:ColorByRating(text, rating)
    if rating >= 2200 then
        return f.l(text)
    elseif rating >= 1800 then
        return f.e(text)
    else
        return f.white(text)
    end
end

---@param unit UnitId
---@return PlayerUID playerUID
function PvPAssistant.UTIL:GetPlayerUIDByUnit(unit)
    local playerName, playerRealm = UnitNameUnmodified(unit)
    playerRealm = playerRealm or GetNormalizedRealmName()

    return playerName .. "-" .. playerRealm
end

---@param unit UnitId
---@return number? specializationID
function PvPAssistant.UTIL:GetSpecializationIDByUnit(unit)
    local info = C_TooltipInfo.GetUnit(unit)

    for _, line in ipairs(info.lines) do
        local specText = line.leftText
        local specID = PvPAssistant.SPEC_LOOKUP:LookUp(specText)
        if specID then
            return specID
        end
    end

    return nil
end

function PvPAssistant.UTIL:GetMapAbbreviation(mapName)
    local custom = PvPAssistant.CONST.MAP_ABBREVIATIONS[mapName]

    if custom then return custom end

    local words = strsplittable(" ", mapName)

    local firstLetters = GUTIL:Map(words, function(word)
        return word:sub(1, 1):upper()
    end)

    return table.concat(firstLetters, "")
end

---@param rating number
---@return string?
function PvPAssistant.UTIL:GetIconByRating(rating)
    local rankingIcon
    for _, ratingData in ipairs(PvPAssistant.CONST.RATING_ICON_MAP) do
        if rating >= ratingData.rating then
            rankingIcon = ratingData.icon
        end
    end
    return rankingIcon
end

---@param pvpMode PvPAssistant.Const.PVPModes
---@param data table
---@return InspectArenaData inspectArenaData
function PvPAssistant.UTIL:ConvertInspectArenaData(pvpMode, data)
    ---@type InspectArenaData
    local inspectArenaData = {
        pvpMode = pvpMode,
        rating = data[1],
        seasonPlayed = data[2],
        seasonWon = data[3],
        weeklyPlayed = data[4],
        weeklyWon = data[5],
    }
    return inspectArenaData
end

---@param parent Frame
---@param anchorPoints GGUI.AnchorPoint[]
---@param scale number?
---@return GGUI.Text
function PvPAssistant.UTIL:CreateLogo(parent, anchorPoints, scale)
    scale = scale or 1
    parent.titleLogo = GGUI.Text {
        parent = parent,
        anchorPoints = anchorPoints,
        text = f.bb("PvPAssistant"),
        scale = 1.7 * scale,
    }

    return parent.titleLogo
end

---@class PvPAssistant.ClassFilterFrameOptions
---@field parent Frame
---@field anchorPoint GGUI.AnchorPoint?
---@field clickCallback? fun(ClassFile, boolean)
---@field onRevertCallback? fun()

---@param options PvPAssistant.ClassFilterFrameOptions
---@return GGUI.Frame classFilterFrame
---@return table<ClassFile, boolean> activeClassFiltersTable
function PvPAssistant.UTIL:CreateClassFilterFrame(options)
    local activeClassFiltersTable = {}
    local anchorPoint = options.anchorPoint or {}
    local parent = options.parent

    ---@class PvPAssistant.History.ClassFilterFrame : GGUI.Frame
    local classFilterFrame = GGUI.Frame {
        parent = parent, anchorParent = anchorPoint.anchorParent or parent,
        anchorA = anchorPoint.anchorA or "TOP", anchorB = anchorPoint.anchorB or "TOP", backdropOptions = PvPAssistant.CONST.FILTER_FRAME_BACKDROP,
        sizeX = 430, sizeY = 85, offsetY = anchorPoint.offsetY or 0, offsetX = anchorPoint.offsetX or 0,
        tooltipOptions = {
            anchor = "ANCHOR_CURSOR_RIGHT",
            text = f.white("Toggle Class Filters off and on."
                .. "\nshift+" .. CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.LEFT_MOUSE_BUTTON, 15, 20) .. ": Filter out everything else"
                .. "\nalt+" .. CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.LEFT_MOUSE_BUTTON, 15, 20) .. ": Filter in everything else"),
        },
    }

    classFilterFrame.frame:SetFrameLevel(parent:GetFrameLevel() + 10)

    ---@type GGUI.ClassIcon[]
    classFilterFrame.classFilterButtons = {}

    local classFilterIconSize = 30
    local classFilterIconOffsetXRow1 = 10
    local classFilterIconOffsetYRow1 = 20
    local classFilterIconOffsetXRow2 = 10
    local classFilterIconOffsetYRow2 = -20
    local classFilterIconSpacingX = 14
    local function CreateClassFilterIcon(classFile, anchorParent, offX, offY, anchorA, anchorB)
        local classFilterIcon = GGUI.ClassIcon {
            sizeX = classFilterIconSize, sizeY = classFilterIconSize,
            parent = classFilterFrame.content, anchorParent = anchorParent,
            initialClass = classFile, offsetX = offX, offsetY = offY, anchorA = anchorA, anchorB = anchorB,
            showTooltip = true,
        }

        function classFilterIcon:Revert()
            activeClassFiltersTable[classFile] = false
            classFilterIcon:Saturate()
        end

        classFilterIcon.frame:SetScript("OnClick", function()
            if IsShiftKeyDown() then
                -- if shift clicked -> toggle all off except current class
                for _, classIcon in ipairs(classFilterFrame.classFilterButtons) do
                    if classIcon.class == classFile then
                        classIcon:Saturate()
                        activeClassFiltersTable[classIcon.class] = false
                    else
                        classIcon:Desaturate()
                        activeClassFiltersTable[classIcon.class] = true
                    end
                end
                if options.clickCallback then
                    options.clickCallback(classFile, false)
                end
            elseif IsAltKeyDown() then
                -- if alt clicked -> toggle all on except current class
                for _, classIcon in ipairs(classFilterFrame.classFilterButtons) do
                    if classIcon.class == classFile then
                        classIcon:Desaturate()
                        activeClassFiltersTable[classIcon.class] = true
                    else
                        classIcon:Saturate()
                        activeClassFiltersTable[classIcon.class] = false
                    end
                end
                if options.clickCallback then
                    options.clickCallback(classFile, false)
                end
            else
                if not activeClassFiltersTable[classFile] then
                    activeClassFiltersTable[classFile] = true
                    classFilterIcon:Desaturate()
                    -- reload list with new filters
                    if options.clickCallback then
                        options.clickCallback(classFile, true)
                    end
                else
                    activeClassFiltersTable[classFile] = false
                    classFilterIcon:Saturate()
                    -- reload list with new filters
                    if options.clickCallback then
                        options.clickCallback(classFile, false)
                    end
                end
            end
        end)

        return classFilterIcon
    end
    local t = {}
    FillLocalizedClassList(t)
    local classFiles = GUTIL:Map(t, function(_, classFile)
        -- ignore hidden test class or whatever this is
        if classFile == "Adventurer" then
            return nil
        end
        return classFile
    end)
    local iconsFirstRow = 8
    local currentAnchor = classFilterFrame.frame
    for i, classFile in pairs(classFiles) do
        local anchorB = "RIGHT"
        local offX = classFilterIconSpacingX
        local offY = 0
        if i == 1 then
            anchorB = "LEFT"
            offX = classFilterIconOffsetXRow1
            offY = classFilterIconOffsetYRow1
        end
        if i == iconsFirstRow then
            anchorB = "LEFT"
            offX = classFilterIconOffsetXRow2
            offY = classFilterIconOffsetYRow2
            currentAnchor = classFilterFrame.frame
        end
        local classFilterIcon = CreateClassFilterIcon(classFile, currentAnchor, offX, offY, "LEFT", anchorB)
        tinsert(classFilterFrame.classFilterButtons, classFilterIcon)
        currentAnchor = classFilterIcon.frame
    end

    classFilterFrame.content.revertButton = GGUI.Button {
        parent = classFilterFrame.content,
        anchorPoints = { { anchorParent = currentAnchor, anchorA = "LEFT", anchorB = "RIGHT", offsetX = classFilterIconSpacingX, offsetY = 1 } },
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        label = PvPAssistant.MEDIA:GetAsTextIcon(PvPAssistant.MEDIA.IMAGES.REVERT, 0.3, 0, -1),
        sizeX = classFilterIconSize - 1, sizeY = classFilterIconSize - 1,
        tooltipOptions = {
            anchor = "ANCHOR_CURSOR_RIGHT",
            text = f.l("Revert Filters"),
        },
        clickCallback = function()
            for _, filterButton in ipairs(classFilterFrame.classFilterButtons) do
                filterButton:Revert()
            end
            if options.onRevertCallback then
                options.onRevertCallback()
            end
        end
    }

    return classFilterFrame, activeClassFiltersTable
end

function PvPAssistant.UTIL:CamelCaseToDashSeparated(str)
    local result = ""
    local prevCharWasUpperCase = false

    for i = 1, #str do
        local char = string.sub(str, i, i)
        if char:match("%u") then -- Check if the character is uppercase
            if not prevCharWasUpperCase then
                if i == 1 then
                    result = result .. char:lower()
                else
                    result = result .. "-" .. char:lower()
                end
            else
                result = result .. char:lower()
            end
            prevCharWasUpperCase = true
        else
            result = result .. char
            prevCharWasUpperCase = false
        end
    end

    return result
end
