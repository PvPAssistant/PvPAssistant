---@class PvPLookup
local PvPLookup = select(2, ...)

local GGUI = PvPLookup.GGUI
local GUTIL = PvPLookup.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPLookup.ArenaGuide
PvPLookup.ARENA_GUIDE = PvPLookup.ARENA_GUIDE

---@class PvPLookup.ArenaGuide.Frames
PvPLookup.ARENA_GUIDE.FRAMES = {}

local debug = false

function PvPLookup.ARENA_GUIDE.FRAMES:Init()
    local sizeX = 300
    local sizeY = 400
    PvPLookup.ARENA_GUIDE.frame = GGUI.Frame {
        parent = UIParent, anchorParent = UIParent,
        sizeX = sizeX, sizeY = sizeY,
        frameConfigTable = PvPLookupGGUIConfig, frameID = PvPLookup.CONST.FRAMES.ARENA_GUIDE,
        frameTable = PvPLookup.MAIN.FRAMES,
        backdropOptions = PvPLookup.CONST.ARENA_GUIDE_BACKDROP,
        moveable = true, hide = true,
    }

    local content = PvPLookup.ARENA_GUIDE.frame.content

    content.logo = PvPLookup.UTIL:CreateLogo(content,
        { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -10, } })

    content.title = GGUI.Text {
        parent = content, anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = -35, } },
        text = f.e("Arena Quick Guide"), scale = 1.3,
    }

    content.closeButton = GGUI.Button {
        parent = content, anchorParent = content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT",
        offsetX = -8, offsetY = -8,
        label = f.white("x"),
        buttonTextureOptions = PvPLookup.CONST.ASSETS.BUTTONS.TAB_BUTTON,
        fontOptions = {
            fontFile = PvPLookup.CONST.FONT_FILES.ROBOTO,
        },
        sizeX = 15,
        sizeY = 15,
        clickCallback = function()
            PvPLookup.ARENA_GUIDE.frame:Hide()
        end
    }

    -- icons

    --- TODO: Make a GGUI Util Function or even a Widget
    ---@param parent Frame
    ---@param anchorPoint GGUI.AnchorPoint
    ---@param numIcons number
    local function createClassIconRow(parent, anchorPoint, numIcons, iconSize, spacingX)
        local iconList = {}
        local lastAnchor
        for i = 1, numIcons do
            local offsetX = spacingX
            local offsetY = 0
            local anchorParent = lastAnchor
            local anchorB = "RIGHT"
            local anchorA = "LEFT"
            if i == 1 then
                offsetX = anchorPoint.offsetX
                offsetY = anchorPoint.offsetY
                anchorA = anchorPoint.anchorA
                anchorB = anchorPoint.anchorB
                anchorParent = anchorPoint.anchorParent
            end
            local classIcon = GGUI.ClassIcon {
                debug = true,
                parent = parent, anchorParent = anchorParent,
                anchorA = anchorA, anchorB = anchorB, offsetX = offsetX, offsetY = offsetY, sizeX = iconSize, sizeY = iconSize,
                initialSpecID = PvPLookup.CONST.SPEC_IDS.BEAST_MASTERY, showTooltip = true,
                showBorder = true,
            }
            lastAnchor = classIcon.frame

            classIcon:Hide()

            tinsert(iconList, classIcon)
        end
        return iconList
    end

    local offsetX_2 = -27
    local offsetX_3 = -55
    local offsetY_P = -70
    local offsetY_E = offsetY_P - 80
    local spacingX = 15
    local iconSize = 40

    content.playerTeamIcons2 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_2, offsetY = offsetY_P }, 2,
        iconSize,
        spacingX)
    content.playerTeamIcons3 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_3, offsetY = offsetY_P }, 3,
        iconSize, spacingX)


    content.vsHeader = GGUI.Text {
        parent = content, anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetY = (offsetY_P - 52) / 1.5 } },
        text = f.r("VS"), scale = 1.5
    }
    content.enemyTeamIcons2 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_2, offsetY = offsetY_E }, 2,
        iconSize,
        spacingX)
    content.enemyTeamIcons3 = createClassIconRow(content,
        { anchorParent = content, anchorA = "TOP", anchorB = "TOP", offsetX = offsetX_3, offsetY = offsetY_E }, 3,
        iconSize, spacingX)

    content.strategyBackground = GGUI.Frame {
        parent = content, anchorParent = content, anchorA = "TOP", anchorB = "TOP", sizeX = sizeX - 15, sizeY = 200, offsetY = -195,
        backdropOptions = PvPLookup.CONST.STRAGETY_TEXT_BACKDROP,
    }

    content.strategyBackground.frame:SetFrameLevel(content:GetFrameLevel() + 1)

    content.strategyText = GGUI.Text {
        parent = content.strategyBackground.frame, anchorPoints = { { anchorParent = content.strategyBackground.frame, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetX = 20, offsetY = -20 } },
        justifyOptions = { type = "H", align = "LEFT" }, fixedWidth = sizeX - 55,
        text = f.l("Here be Strategies"),
    }
end

function PvPLookup.ARENA_GUIDE.FRAMES:UpdateDisplay()
    local content = PvPLookup.ARENA_GUIDE.frame.content

    PvPLookup.ARENA_GUIDE:UpdateArenaSpecIDs()

    PvPLookup.DEBUG:DebugTable(PvPLookup.ARENA_GUIDE.specIDs, "Arena Spec IDs")

    if debug then
        PvPLookup.ARENA_GUIDE.specIDs = {
            PLAYER_TEAM = {
                PvPLookup.CONST.SPEC_IDS.FURY, PvPLookup.CONST.SPEC_IDS.RETRIBUTION
            },
            ENEMY_TEAM = {
                PvPLookup.CONST.SPEC_IDS.HOLY_PALADIN, PvPLookup.CONST.SPEC_IDS.ARMS
            },
        }
    end

    local specIDsPlayerTeam = PvPLookup.ARENA_GUIDE.specIDs.PLAYER_TEAM
    local specIDsEnemyTeam = PvPLookup.ARENA_GUIDE.specIDs.ENEMY_TEAM

    table.foreach(content.playerTeamIcons2, function(_, icon) icon:Hide() end)
    table.foreach(content.playerTeamIcons3, function(_, icon) icon:Hide() end)
    table.foreach(content.enemyTeamIcons2, function(_, icon) icon:Hide() end)
    table.foreach(content.enemyTeamIcons3, function(_, icon) icon:Hide() end)

    local playerTeamIcons
    local enemyTeamIcons
    if #specIDsPlayerTeam <= 2 then
        playerTeamIcons = content.playerTeamIcons2
    else
        playerTeamIcons = content.playerTeamIcons3
    end
    if #specIDsEnemyTeam <= 2 then
        enemyTeamIcons = content.enemyTeamIcons2
    else
        enemyTeamIcons = content.enemyTeamIcons3
    end

    for i, icon in ipairs(playerTeamIcons) do
        local specID = specIDsPlayerTeam[i]
        if specID then
            icon:SetClass(specID)
            print("Show Icon P" .. i)
            icon:Show()
        end
    end
    for i, icon in ipairs(enemyTeamIcons) do
        local specID = specIDsEnemyTeam[i]
        if specID then
            icon:SetClass(specID)
            print("Show Icon E" .. i)
            icon:Show()
        end
    end

    local compositionID = table.concat(specIDsEnemyTeam)

    -- fill strategyText
    local strategy = PvPLookup.ARENA_STRATEGIES[compositionID] or
        f.white("Strategy not existing yet for given enemy composition")

    content.strategyText:SetText(strategy)
end
