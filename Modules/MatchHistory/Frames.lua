---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MATCH_HISTORY
PvPAssistant.MATCH_HISTORY = PvPAssistant.MATCH_HISTORY

---@class PvPAssistant.MATCH_HISTORY.FRAMES
PvPAssistant.MATCH_HISTORY.FRAMES = {}

---@type PvPAssistant.MATCH_HISTORY.MATCH_HISTORY_TAB
PvPAssistant.MATCH_HISTORY.matchHistoryTab = nil

function PvPAssistant.MATCH_HISTORY.FRAMES:InitTooltipFrame()
    local tooltipFrameX = 275
    local tooltipFrameY = 40
    local frameScale = 0.95
    PvPAssistant.MATCH_HISTORY.tooltipFrame = CreateFrame("Frame", nil, nil, "BackdropTemplate")
    PvPAssistant.MATCH_HISTORY.tooltipFrame:SetSize(tooltipFrameX - 10, tooltipFrameY)
    PvPAssistant.MATCH_HISTORY.tooltipFrame.contentFrame = GGUI.Frame {
        parent = PvPAssistant.MATCH_HISTORY.tooltipFrame, anchorParent = PvPAssistant.MATCH_HISTORY.tooltipFrame,
        anchorA = "TOP", anchorB = "TOP", sizeX = tooltipFrameX, sizeY = tooltipFrameY, scale = frameScale,
    }

    -- Make the GGUI.Frame Visibility dependent on the tooltip frame visibility
    PvPAssistant.MATCH_HISTORY.tooltipFrame:HookScript("OnShow", function()
        PvPAssistant.MATCH_HISTORY.tooltipFrame.contentFrame:Show()
    end)
    PvPAssistant.MATCH_HISTORY.tooltipFrame:HookScript("OnHide", function()
        PvPAssistant.MATCH_HISTORY.tooltipFrame.contentFrame:Hide()
    end)

    PvPAssistant.MATCH_HISTORY.tooltipFrame.content = PvPAssistant.MATCH_HISTORY.tooltipFrame
        .contentFrame
        .content

    ---@class PvPAssistant.MAIN_FRAME.TooltipFrame.Content : BackdropTemplate, Frame
    local content = PvPAssistant.MATCH_HISTORY.tooltipFrame.content
    content.modeText = GGUI.Text {
        parent = content,
        anchorPoints = { { anchorParent = content, anchorA = "TOPLEFT", anchorB = "TOPLEFT", } },
        text = "<Mode>",
    }

    content.winText = GGUI.Text {
        parent = content,
        anchorPoints = { { anchorParent = content, anchorA = "TOPRIGHT", anchorB = "TOPRIGHT", } },
        text = "<Win>", offsetY = -3,
    }

    content.mapText = GGUI.Text {
        parent = content,
        anchorPoints = { { anchorParent = content, anchorA = "TOP", anchorB = "TOP", } },
        text = "<Map>", offsetY = 1,
    }

    local frameListOffsetY = -40
    content.playerList = GGUI.FrameList {
        columnOptions = {
            {
                label = f.grey("Player"),
                width = 90,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                label = f.grey("Dmg"),
                width = 60,
                justifyOptions = { type = "H", align = "LEFT" },
            },
            {
                label = f.grey("Heal"),
                width = 60,
                justifyOptions = { type = "H", align = "CENTER" },
            },
            {
                label = f.grey("Kills"),
                width = 60,
                justifyOptions = { type = "H", align = "CENTER" },
            }
        },
        rowConstructor = function(columns)
            local playerColumn = columns[1]
            local DmgColumn = columns[2]
            local healColumn = columns[3]
            local killColumn = columns[4]

            playerColumn.text = GGUI.Text {
                parent = playerColumn, anchorParent = playerColumn,
                text = "", anchorA = "LEFT", anchorB = "LEFT", offsetX = 5,
                justifyOptions = { type = "H", align = "LEFT" },
            }
            DmgColumn.text = GGUI.Text {
                parent = DmgColumn, anchorParent = DmgColumn,
                anchorA = "LEFT", anchorB = "LEFT",
                text = "", justifyOptions = { type = "H", align = "LEFT" },
            }
            healColumn.text = GGUI.Text {
                parent = healColumn, anchorParent = healColumn,
                text = "",
            }
            killColumn.text = GGUI.Text {
                parent = killColumn, anchorParent = killColumn, offsetX = 5,
                text = "", justifyOptions = { type = "H", align = "CENTER" },
            }
        end,
        disableScrolling = true,
        parent = content, anchorParent = content,
        hideScrollbar = true, autoAdjustHeight = true, anchorA = "TOPLEFT", anchorB = "TOPLEFT", offsetY = frameListOffsetY, offsetX = -4,
        rowHeight = 20,
        autoAdjustHeightCallback = function(newHeight)
            PvPAssistant.MATCH_HISTORY.tooltipFrame:SetSize(tooltipFrameX, newHeight + -frameListOffsetY + 0)
            PvPAssistant.MATCH_HISTORY.tooltipFrame.contentFrame:SetSize(tooltipFrameX,
                newHeight + -frameListOffsetY)
        end,
        rowBackdrops = { PvPAssistant.CONST.TOOLTIP_FRAME_ROW_BACKDROP_A, {} }
    }

    PvPAssistant.MATCH_HISTORY.tooltipFrame:Hide()
end

---@return PvPAssistant.MATCH_HISTORY.MATCH_HISTORY_TAB matchHistoryTab
function PvPAssistant.MATCH_HISTORY.FRAMES:InitMatchHistoryTab()
    ---@class PvPAssistant.MAIN_FRAME.FRAME : GGUI.Frame
    local frame = PvPAssistant.MAIN_FRAME.frame

    ---@class PvPAssistant.MATCH_HISTORY.MATCH_HISTORY_TAB : GGUI.Tab
    frame.content.matchHistoryTab = GGUI.Tab {
        parent = frame.content, anchorParent = frame.content, anchorA = "TOP", anchorB = "TOP",
        sizeX = PvPAssistant.MAIN_FRAME.tabContentSizeX, sizeY = PvPAssistant.MAIN_FRAME.tabContentSizeY, offsetY = PvPAssistant.MAIN_FRAME.tabContentOffsetY, canBeEnabled = true,
        buttonOptions = {
            label = GUTIL:ColorizeText("Match History", GUTIL.COLORS.WHITE),
            parent = frame.content,
            anchorParent = frame.content.titleLogo.frame,
            offsetY = 1,
            offsetX = 27,
            anchorA = "LEFT",
            anchorB = "RIGHT",
            adjustWidth = true,
            sizeX = 15,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
        }
    }

    PvPAssistant.MATCH_HISTORY.matchHistoryTab = frame.content.matchHistoryTab

    ---@class PvPAssistant.MATCH_HISTORY.MATCH_HISTORY_TAB : GGUI.Tab
    local matchHistoryTab = PvPAssistant.MAIN_FRAME.frame.content.matchHistoryTab
    ---@class PvPAssistant.MATCH_HISTORY.MATCH_HISTORY_TAB.CONTENT : Frame
    matchHistoryTab.content = matchHistoryTab.content

    matchHistoryTab.content.matchHistoryTitle = GGUI.Text {
        parent = matchHistoryTab.content, anchorPoints = { { anchorParent = matchHistoryTab.content, anchorA = "TOP", anchorB = "TOP", offsetY = -20 } },
        scale = 1.5, text = f.white("Match History")
    }

    ---@type GGUI.FrameList.ColumnOption[]
    local columnOptions = {
        {
            label = f.grey("Date"),
            width = 135,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Map"),
            width = 65,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Players"),
            width = 200,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Win(s)"),
            width = 120,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Mmr"),
            width = 80,
            justifyOptions = { type = "H", align = "CENTER" },
        },
        {
            label = f.grey("Rating"),
            width = 110,
            justifyOptions = { type = "H", align = "CENTER" },
        },
    }
    local listScale = 0.997
    matchHistoryTab.content.matchHistoryList = GGUI.FrameList {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content.matchHistoryTitle.frame, offsetX = -10, hideScrollbar = false,
        anchorA = "TOP", anchorB = "BOTTOM", scale = listScale, offsetY = -70, rowHeight = 30,
        rowBackdrops = { PvPAssistant.CONST.HISTORY_COLUMN_BACKDROP_A, PvPAssistant.CONST.HISTORY_COLUMN_BACKDROP_B },
        selectionOptions = { noSelectionColor = true, hoverRGBA = PvPAssistant.CONST.FRAME_LIST_HOVER_RGBA },
        sizeY = 470, columnOptions = columnOptions, rowConstructor = function(columns)
        local dateColumn = columns[1]
        local mapColumn = columns[2]
        local playersColumn = columns[3]
        local winColumn = columns[4]
        local mmrColumn = columns[5]
        local ratingColumn = columns[6]

        winColumn.text = GGUI.Text {
            parent = winColumn, anchorPoints = { { anchorParent = winColumn } },
        }
        winColumn.textShuffle = GGUI.Text {
            parent = winColumn, anchorPoints = { { anchorParent = winColumn, anchorA = "LEFT", anchorB = "LEFT" } },
        }
        local winIconSize = 20
        function winColumn:SetWin(win, shuffleWins)
            if not shuffleWins then
                if win then
                    winColumn.text:SetText(CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.CHECKMARK, winIconSize, winIconSize,
                        0.5))
                else
                    winColumn.text:SetText(CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.CROSS, winIconSize, winIconSize,
                        0.5))
                end

                winColumn.textShuffle:SetText("")
            else
                local shuffleWinText = ""
                for i = 1, 6 do
                    if i <= shuffleWins then
                        shuffleWinText = shuffleWinText ..
                            CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.CHECKMARK, winIconSize, winIconSize, 0.5)
                    else
                        shuffleWinText = shuffleWinText ..
                            CreateAtlasMarkup(PvPAssistant.CONST.ATLAS.CROSS, winIconSize, winIconSize, 0.5)
                    end
                end

                winColumn.textShuffle:SetText(shuffleWinText)
                winColumn.text:SetText("")
            end
        end

        dateColumn.text = GGUI.Text {
            parent = dateColumn, anchorParent = dateColumn, justifyOptions = { type = "H", align = "LEFT" }
        }
        mapColumn.text = GGUI.Text {
            parent = mapColumn, anchorParent = mapColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        local iconSpacingX = 5
        playersColumn.vs = GGUI.Text {
            parent = playersColumn, anchorPoints = { { anchorParent = playersColumn } },
            text = f.r("vs")
        }
        local iconSize = 20
        playersColumn.iconP1 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.vs.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -iconSpacingX,
            initialClass = "WARLOCK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconP2 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconP1.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -iconSpacingX,
            initialClass = "WARRIOR", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconP3 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconP2.frame, anchorA = "RIGHT", anchorB = "LEFT", offsetX = -iconSpacingX,
            initialClass = "MONK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }

        playersColumn.iconE1 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.vs.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "WARLOCK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconE2 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconE1.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "WARRIOR", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconE3 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconE2.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "MONK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }

        local shuffleIconsOffsetX = 25
        playersColumn.iconSS1 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn, anchorA = "LEFT", anchorB = "LEFT", offsetX = shuffleIconsOffsetX,
            initialClass = "WARLOCK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconSS2 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconSS1.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "WARRIOR", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconSS3 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconSS2.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "MONK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconSS4 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconSS3.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "WARLOCK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconSS5 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconSS4.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "WARRIOR", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }
        playersColumn.iconSS6 = GGUI.ClassIcon {
            parent = playersColumn, anchorParent = playersColumn.iconSS5.frame, anchorA = "LEFT", anchorB = "RIGHT", offsetX = iconSpacingX,
            initialClass = "MONK", sizeX = iconSize, sizeY = iconSize,
            showTooltip = true,
        }

        playersColumn.iconsSoloShuffle = { playersColumn.iconSS1, playersColumn.iconSS2, playersColumn.iconSS3,
            playersColumn.iconSS4,
            playersColumn.iconSS5, playersColumn.iconSS6 }
        playersColumn.iconsP = { playersColumn.iconP1, playersColumn.iconP2, playersColumn.iconP3 }
        playersColumn.iconsE = { playersColumn.iconE1, playersColumn.iconE2, playersColumn.iconE3 }

        ---@param matchHistory PvPAssistant.MatchHistory
        playersColumn.SetPlayers = function(self, matchHistory)
            self.vs:SetVisible(not matchHistory.isSoloShuffle)
            local playerTeam = matchHistory.playerTeam
            local enemyTeam = matchHistory.enemyTeam

            for _, icon in pairs(GUTIL:Concat { playersColumn.iconsP, playersColumn.iconsE, playersColumn.iconsSoloShuffle }) do
                icon:Hide()
            end

            if matchHistory.isSoloShuffle then
                local sortedPlayers = GUTIL:Sort(GUTIL:Concat { playerTeam.players, enemyTeam.players },
                    PvPAssistant.MATCH_HISTORY.SortPlayerBySpecRole)
                for i, player in pairs(sortedPlayers) do
                    local icon = playersColumn.iconsSoloShuffle[i]
                    icon:Show()
                    icon:SetClass(player.specID)
                end
            else
                local sortedPlayerTeam = GUTIL:Sort(playerTeam.players, PvPAssistant.MATCH_HISTORY.SortPlayerBySpecRole)
                local sortedEnemyTeam = GUTIL:Sort(enemyTeam.players, PvPAssistant.MATCH_HISTORY.SortPlayerBySpecRole)
                for i, player in ipairs(sortedPlayerTeam) do
                    local icon = playersColumn.iconsP[i]
                    icon:Show()
                    icon:SetClass(player.specID)
                end
                for i, player in ipairs(sortedEnemyTeam) do
                    local icon = playersColumn.iconsE[i]
                    icon:Show()
                    icon:SetClass(player.specID)
                end
            end
        end
        mmrColumn.text = GGUI.Text {
            parent = mmrColumn, anchorParent = mmrColumn, justifyOptions = { type = "H", align = "CENTER" }
        }
        ratingColumn.text = GGUI.Text {
            parent = ratingColumn, anchorParent = ratingColumn, justifyOptions = { type = "H", align = "CENTER" },
            offsetX = 10,
        }
        local ratingIconSize = 20
        ratingColumn.texture = GGUI.Texture {
            parent = ratingColumn, anchorParent = ratingColumn.text.frame, anchorA = "RIGHT", anchorB = "LEFT",
            sizeX = ratingIconSize, sizeY = ratingIconSize,
        }

        ratingColumn.SetIconByRating = function(self, playerRating)
            if not playerRating then
                ratingColumn.texture:Hide()
                return
            else
                ratingColumn.texture:Show()
            end
            local rankingIcon = PvPAssistant.UTIL:GetIconByRating(playerRating)
            if rankingIcon then
                ratingColumn.texture:SetTexture(rankingIcon)
            end
        end
    end
    }

    local dropdownSizeY = 25
    local dropdownScale = 1

    matchHistoryTab.content.characterDropdown = GGUI.CustomDropdown {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content.matchHistoryList.frame,
        anchorA = "BOTTOMLEFT", anchorB = "TOPLEFT", width = 110, offsetX = 25, offsetY = 30,
        clickCallback = function(self, label, value)
            PvPAssistant.MATCH_HISTORY.FRAMES:UpdateMatchHistory()
        end,
        buttonOptions = {
            parent = matchHistoryTab.content,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale
        },
        arrowOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPAssistant.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = dropdownScale,
        }
    }

    matchHistoryTab.content.specDropdown = GGUI.CustomDropdown {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content.characterDropdown.frame.frame,
        anchorA = "LEFT", anchorB = "RIGHT", width = 55, offsetX = 10,
        clickCallback = function(self, label, value)
            PvPAssistant.MATCH_HISTORY.FRAMES:UpdateMatchHistory()
        end,
        buttonOptions = {
            parent = matchHistoryTab.content,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale,
        },
        arrowOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPAssistant.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = dropdownScale,
        }
    }

    matchHistoryTab.content.pvpModeDropdown = GGUI.CustomDropdown {
        parent = matchHistoryTab.content, anchorParent = matchHistoryTab.content.specDropdown.frame.frame,
        anchorA = "LEFT", anchorB = "RIGHT", width = 70, offsetX = 10,
        initialData = {
            {
                label = GUTIL:ColorizeText("All", GUTIL.COLORS.WHITE),
                value = nil,
            },
            {
                label = GUTIL:ColorizeText("Solo", GUTIL.COLORS.WHITE),
                value = PvPAssistant.CONST.PVP_MODES.SOLO_SHUFFLE,
            },
            {
                label = GUTIL:ColorizeText("2v2", GUTIL.COLORS.WHITE),
                value = PvPAssistant.CONST.PVP_MODES.TWOS,
            },
            {
                label = GUTIL:ColorizeText("3v3", GUTIL.COLORS.WHITE),
                value = PvPAssistant.CONST.PVP_MODES.THREES,
            },
            {
                label = GUTIL:ColorizeText("RBG", GUTIL.COLORS.WHITE),
                value = PvPAssistant.CONST.PVP_MODES.BATTLEGROUND,
            },
        },
        initialLabel = GUTIL:ColorizeText("All", GUTIL.COLORS.WHITE),
        initialValue = nil,
        clickCallback = function(self, label, value)
            PvPAssistant.MATCH_HISTORY.FRAMES:UpdateMatchHistory()
        end,
        buttonOptions = {
            parent = matchHistoryTab.content,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = dropdownSizeY,
            scale = dropdownScale,
        },
        arrowOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPAssistant.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = dropdownScale,
        }
    }

    return matchHistoryTab
end

function PvPAssistant.MATCH_HISTORY.FRAMES:UpdateMatchHistory()
    local matchHistoryTab = PvPAssistant.MATCH_HISTORY.matchHistoryTab
    local matchHistoryList = matchHistoryTab.content.matchHistoryList

    matchHistoryTab.content.matchHistoryList:Remove()

    local pvpModeFilter = PvPAssistant.MATCH_HISTORY:GetSelectedModeFilter()
    local selectedCharacterUID = PvPAssistant.MATCH_HISTORY:GetSelectedCharacterUID()

    local playerUID = PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    local matchHistories = PvPAssistant.DB.MATCH_HISTORY:Get(playerUID)

    local filteredHistory = GUTIL:Filter(matchHistories or {},
        function(matchHistory)
            local isSelectedCharacter = (matchHistory.player.name .. "-" .. matchHistory.player.realm) ==
                selectedCharacterUID
            local isSelectedMode = pvpModeFilter == nil or matchHistory.pvpMode == pvpModeFilter
            return isSelectedCharacter and isSelectedMode
        end)

    local filteredHistory = GUTIL:Sort(filteredHistory, function(a, b)
        return a.timestamp > b.timestamp
    end)


    for _, matchHistory in pairs(filteredHistory) do
        matchHistoryList:Add(function(row)
            local columns = row.columns
            local dateColumn = columns[1]
            local mapColumn = columns[2]
            local playersColumn = columns[3]
            local winColumn = columns[4]
            local mmrColumn = columns[5]
            local ratingColumn = columns[6]

            local matchHistory = PvPAssistant.MatchHistory:Deserialize(matchHistory)

            local date = date("!*t", matchHistory.timestamp / 1000) -- use ! because it is already localized time and divide by 1000 because date constructor needs seconds
            local formattedDate = string.format("%02d.%02d.%d %02d:%02d", date.day, date.month, date.year, date.hour,
                date.min)
            dateColumn.text:SetText(formattedDate)
            local mapAbbreviation = PvPAssistant.UTIL:GetMapAbbreviation(matchHistory.mapInfo.name)
            mapColumn.text:SetText(f.r(mapAbbreviation))

            playersColumn:SetPlayers(matchHistory)
            if matchHistory.isRated then
                mmrColumn.text:SetText(matchHistory.playerTeam.ratingInfo.ratingMMR)
            else
                mmrColumn.text:SetText(f.grey("-"))
            end

            if matchHistory.isRated then
                -- colorize ratingChange by value
                local ratingChange = matchHistory.player.scoreData.ratingChange or 0
                local ratingChangeText
                if ratingChange > 0 then
                    ratingChangeText = f.g(FormatValueWithSign(matchHistory.player.scoreData.ratingChange))
                elseif ratingChange < 0 then
                    ratingChangeText = f.r(FormatValueWithSign(matchHistory.player.scoreData.ratingChange))
                else
                    ratingChangeText = f.white(FormatValueWithSign(matchHistory.player.scoreData.ratingChange))
                end
                ratingColumn.text:SetText(matchHistory.player.scoreData.rating .. " (" .. ratingChangeText .. ")")
                ratingColumn:SetIconByRating(matchHistory.player.scoreData.rating)
            else
                ratingColumn.text:SetText(f.grey("-"))
                ratingColumn:SetIconByRating(nil)
            end

            if matchHistory.isSoloShuffle then
                local shuffleWins = (matchHistory.player.scoreData.stats and matchHistory.player.scoreData.stats[1].pvpStatValue) or
                    0
                winColumn:SetWin(matchHistory.win, shuffleWins)
            else
                winColumn:SetWin(matchHistory.win)
            end

            row.tooltipOptions = {
                anchor = "ANCHOR_CURSOR",
                owner = row.frame,
                frame = PvPAssistant.MATCH_HISTORY.tooltipFrame,
                frameUpdateCallback = function(tooltipFrame)
                    matchHistory:UpdateTooltipFrame(tooltipFrame)
                end
            }
        end)
    end

    matchHistoryList:UpdateDisplay()
end

function PvPAssistant.MATCH_HISTORY.FRAMES:UpdateSpecializationDropdown()
    local specDropdown = PvPAssistant.MATCH_HISTORY.matchHistoryTab.content.specDropdown

    local selectedCharacterUID = PvPAssistant.MATCH_HISTORY:GetSelectedCharacterUID()
    local isCharacter = selectedCharacterUID == PvPAssistant.UTIL:GetPlayerUIDByUnit("player")

    local specIconSize = 20
    local specIconOffsetY = -1

    ---@type GGUI.CustomDropdownData[]
    local dropdownData = {}

    local classID = PvPAssistant.DB.CHARACTERS:GetClassID(selectedCharacterUID)
    for i = 1, 4 do
        local specID = GetSpecializationInfoForClassID(classID, i)

        if specID then
            local specInfo = { GetSpecializationInfoByID(specID) }
            local specName = specInfo[2]
            local specIcon = specInfo[4]
            local class = specInfo[6]
            ---@type GGUI.CustomDropdownData
            local data = {
                label = GUTIL:IconToText(specIcon, specIconSize, specIconSize, 0, specIconOffsetY),
                value = specID,
                tooltipOptions = {
                    text = f.class(specName, class),
                    anchor = "ANCHOR_CURSOR",
                },
            }
            tinsert(dropdownData, data)
        end
    end

    if isCharacter then
        local specID = PvPAssistant.UTIL:GetSpecializationIDByUnit("player")
        local specInfo = { GetSpecializationInfoByID(specID) }
        local specIcon = specInfo[4]
        specDropdown:SetData({
            data = dropdownData,
            initialLabel = GUTIL:IconToText(specIcon, specIconSize, specIconSize, 0, specIconOffsetY),
            initialValue = specID
        })
    else
        specDropdown:SetData({
            data = dropdownData,
            initialLabel = dropdownData[1].label,
            initialValue = dropdownData[1].value
        })
    end
end
