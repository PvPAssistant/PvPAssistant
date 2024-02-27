---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL

---@class PvPLookup.Util
PvPLookup.UTIL = {}

--- also for healing
function PvPLookup.UTIL:FormatDamageNumber(number)
    if number >= 1000000000 then
        return GUTIL:Round(number / 1000000000, 2) .. "B"
    end
    if number >= 1000000 then
        return GUTIL:Round(number / 1000000, 2) .. "M"
    end
    if number >= 1000 then
        return GUTIL:Round(number / 1000, 2) .. "K"
    end

    return tostring(number)
end

---@param unit UnitId
---@return PlayerUID playerUID
function PvPLookup.UTIL:GetPlayerUIDByUnit(unit)
    local playerName, playerRealm = UnitNameUnmodified(unit)
    playerRealm = playerRealm or GetNormalizedRealmName()

    return playerName .. "-" .. playerRealm
end

---@param unit UnitId
---@return number? specializationID
function PvPLookup.UTIL:GetSpecializationIDByUnit(unit)
    local info = C_TooltipInfo.GetUnit(unit)

    for _, line in ipairs(info.lines) do
        local specText = line.leftText
        local specID = PvPLookup.SPEC_LOOKUP:LookUp(specText)
        if specID then
            return specID
        end
    end

    return nil
end

function PvPLookup.UTIL:GetMapAbbreviation(mapName)
    local custom = PvPLookup.CONST.MAP_ABBREVIATIONS[mapName]

    if custom then return custom end

    local words = strsplittable(" ", mapName)

    local firstLetters = GUTIL:Map(words, function(word)
        return word:sub(1, 1):upper()
    end)

    return table.concat(firstLetters, "")
end

---@param rating number
---@return string?
function PvPLookup.UTIL:GetIconByRating(rating)
    local rankingIcon
    for _, ratingData in ipairs(PvPLookup.CONST.RATING_ICON_MAP) do
        if rating >= ratingData.rating then
            rankingIcon = ratingData.icon
        end
    end
    return rankingIcon
end

---@param pvpMode PvPLookup.Const.PVPModes
---@param data table
---@return InspectArenaData inspectArenaData
function PvPLookup.UTIL:ConvertInspectArenaData(pvpMode, data)
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
---@return GGUI.Text, GGUI.Text
function PvPLookup.UTIL:CreateLogo(parent, anchorPoints, scale)
    scale = scale or 1
    parent.titleLogo = GGUI.Text {
        parent = parent,
        anchorPoints = anchorPoints,
        text = GUTIL:ColorizeText(" PVP-LOOKUP", GUTIL.COLORS.LEGENDARY),
        scale = 1.7 * scale,
    }

    parent.logoIcon = GGUI.Text {
        parent = parent,
        anchorPoints = { { anchorParent = parent.titleLogo.frame, anchorA = "RIGHT", anchorB = "LEFT" }, offsetY = 2 },
        text = PvPLookup.MEDIA:GetAsTextIcon(PvPLookup.MEDIA.IMAGES.LOGO_1024, 0.028 * scale)
    }

    return parent.titleLogo, parent.logoIcon
end
