---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.MATCH_HISTORY
PvPAssistant.MATCH_HISTORY = {}

---@type Frame
PvPAssistant.MATCH_HISTORY.matchHistoryTooltipFrame = nil

function PvPAssistant.MATCH_HISTORY:InitMatchHistoryDropdownData()
    local matchHistoryTab = PvPAssistant.MAIN_FRAME.frame.content.matchHistoryTab
    local characterDropdown = matchHistoryTab.content.characterDropdown

    local characterDropdownData = PvPAssistant.MATCH_HISTORY:GetCharacterDropdownData()

    local playerDropdownData = GUTIL:Find(characterDropdownData, function(dropdownData)
        return dropdownData.value == PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    end)

    characterDropdown:SetData({
        data = characterDropdownData,
        initialLabel = playerDropdownData.label,
        initialValue = playerDropdownData.value
    })

    self.FRAMES:UpdateSpecializationDropdown()
    self.FRAMES:UpdateMapDropdown()
end

---@return GGUI.CustomDropdownData[] dropdownData
function PvPAssistant.MATCH_HISTORY:GetCharacterDropdownData()
    return GUTIL:Map(PvPAssistant.DB.CHARACTERS:GetAll(), function(characterData, characterUID)
        return {
            label = f.class(characterData.name, characterData.class),
            value = characterUID,
        }
    end)
end

---@return GGUI.CustomDropdownData[] dropdownData
function PvPAssistant.MATCH_HISTORY:GetMapDropdownData()
    local selectedCharacterUID = self:GetSelectedCharacterUID()
    local matchHistories = PvPAssistant.DB.MATCH_HISTORY:Get(selectedCharacterUID)

    ---@type GGUI.CustomDropdownData[]
    local dropdownData = {
        {
            label = f.white("All"),
            value = nil
        }
    }

    local mappedIDs = {}

    for _, matchHistory in ipairs(matchHistories) do
        local instanceID = matchHistory.mapInfo.instanceID

        if not mappedIDs[instanceID] then
            local mapAbbreviation = PvPAssistant.UTIL:GetMapAbbreviation(matchHistory.mapInfo.name)

            ---@type GGUI.CustomDropdownData
            local dData = {
                label = f.r(mapAbbreviation),
                value = instanceID,
                tooltipOptions = {
                    anchor = "ANCHOR_CURSOR_RIGHT",
                    text = f.r(matchHistory.mapInfo.name)
                }
            }

            tinsert(dropdownData, dData)

            mappedIDs[instanceID] = true
        end
    end

    return dropdownData
end

---@param a PvPAssistant.Player
---@param b PvPAssistant.Player
function PvPAssistant.MATCH_HISTORY.SortPlayerBySpecRole(a, b)
    local prioA = PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY[PvPAssistant.CONST.SPEC_ROLE_MAP[a.specID]]
    local prioB = PvPAssistant.CONST.SPEC_ROLE_SORT_PRIORITY[PvPAssistant.CONST.SPEC_ROLE_MAP[b.specID]]

    return prioA > prioB
end

---@return PvPAssistant.Const.PVPModes? pvpMode
function PvPAssistant.MATCH_HISTORY:GetSelectedModeFilter()
    local mainFrame = PvPAssistant.MAIN_FRAME.frame
    if not mainFrame then
        error("PvPAssistant Error: MainFrame not found")
    end

    return self.matchHistoryTab.content.pvpModeDropdown.selectedValue
end

---@return PlayerUID selectedCharacterUID?
function PvPAssistant.MATCH_HISTORY:GetSelectedCharacterUID()
    return self.matchHistoryTab.content.characterDropdown.selectedValue
end

---@return number specID?
function PvPAssistant.MATCH_HISTORY:GetSelectedSpecID()
    return self.matchHistoryTab.content.specDropdown.selectedValue
end

---@return number instanceID?
function PvPAssistant.MATCH_HISTORY:GetSelectedMapInstanceID()
    return self.matchHistoryTab.content.mapDropdown.selectedValue
end

---@param tFrame Frame
---@param matchHistory PvPAssistant.MatchHistory
function PvPAssistant.MATCH_HISTORY:UpdateTooltipFrame(tFrame, matchHistory)
    local tooltipFrame = tFrame.contentFrame --[[@as GGUI.Frame]]
    local content = tooltipFrame.content --[[@as PvPAssistant.MAIN_FRAME.TooltipFrame.Content]]

    local playerList = content.playerList

    playerList:Remove()

    content.modeText:SetText(f.white(PvPAssistant.CONST.PVP_MODES_NAMES[matchHistory.pvpMode] or "<?>"))
    content.mapText:SetText(f.bb(matchHistory.mapInfo.name))
    if matchHistory.isSoloShuffle then
        local wins = matchHistory.player.scoreData.stats[1] and matchHistory.player.scoreData.stats[1].pvpStatValue
        if wins and wins > 0 then
            content.winText:SetText(f.g(wins .. " Wins"))
        else
            content.winText:SetText(f.r("0 Wins"))
        end
        if matchHistory.soloShuffleMatches and #matchHistory.soloShuffleMatches > 0 then
            content.expandHint:Show()
        end
    else
        content.expandHint:Hide()
        if matchHistory.win then
            content.winText:SetText(f.g("Win"))
        else
            content.winText:SetText(f.r("Loss"))
        end
    end

    local playerTeamSize = #matchHistory.playerTeam.players
    for playerIndex, player in ipairs(GUTIL:Concat { matchHistory.playerTeam.players, matchHistory.enemyTeam.players }) do
        playerList:Add(function(row, columns)
            local playerColumn = columns[1]
            local dmgColumn = columns[2]
            local healColumn = columns[3]
            local killColumn = columns[4]
            local ratingColumn = columns[5]

            -- If i am the last player in my team show the separator line, otherwise hide
            row:SetSeparatorLine(playerIndex == playerTeamSize and not matchHistory.isSoloShuffle)

            local iconSize = 18

            local specIcon = GUTIL:IconToText(select(4, GetSpecializationInfoByID(player.specID)), iconSize)
            local raceIcon = CreateAtlasMarkup(PvPAssistant.RACE_LOOKUP:GetIcon(player.scoreData.raceName), iconSize,
                iconSize)

            playerColumn.text:SetText(raceIcon .. " " .. specIcon .. "  " .. f.class(player.name, player.class))
            dmgColumn.text:SetText(PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.damageDone))
            healColumn.text:SetText(PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.healingDone))
            killColumn.text:SetText(PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.killingBlows))
            local ratingText = ratingColumn.text --[[@as GGUI.Text]]
            if matchHistory.isRated then
                if player.scoreData.ratingChange > 0 then
                    ratingText:SetText(PvPAssistant.UTIL:ColorByRating(tostring(player.scoreData.rating),
                            player.scoreData.rating) ..
                        " (" .. f.g(FormatValueWithSign(player.scoreData.ratingChange)) .. ")")
                else
                    ratingText:SetText(PvPAssistant.UTIL:ColorByRating(tostring(player.scoreData.rating),
                            player.scoreData.rating) ..
                        " (" .. f.r(FormatValueWithSign(player.scoreData.ratingChange)) .. ")")
                end
                ratingText.text:SetJustifyH("LEFT")
            else
                ratingText.text:SetJustifyH("CENTER")
                ratingText:SetText(f.grey("-"))
            end
        end)
    end

    playerList:UpdateDisplay()
end
