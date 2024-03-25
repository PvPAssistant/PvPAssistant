---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class InstanceInfo
---@field name string
---@field instanceType string
---@field difficultyID number
---@field difficultyName string
---@field maxPlayers number
---@field dynamicDifficulty number
---@field isDynamic boolean
---@field instanceID number
---@field instanceGroupSize number
---@field LfgDungeonID number

---@class PvPAssistant.Player
---@field name string
---@field realm string
---@field class string
---@field specID number
---@field scoreData PVPScoreInfo

---@class PvPAssistant.Team
---@field name? string
---@field players PvPAssistant.Player[]
---@field damage number
---@field healing number
---@field kills number
---@field ratingInfo PVPTeamInfo

---@class PvPAssistant.MatchHistory
---@overload fun(): PvPAssistant.MatchHistory
PvPAssistant.MatchHistory = PvPAssistant.Object:extend()

function PvPAssistant.MatchHistory:new()
    ---@type number
    self.timestamp = nil
    ---@type InstanceInfo
    self.mapInfo = nil
    ---@type boolean
    self.isArena = false
    ---@type boolean
    self.isBattleground = false
    ---@type boolean
    self.isSoloShuffle = false
    ---@type PvPAssistant.Team
    self.playerTeam = nil
    ---@type PvPAssistant.Team
    self.enemyTeam = nil
    ---@type number
    self.duration = nil
    ---@type boolean
    self.isRated = false
    ---@type PvPAssistant.Const.PVPModes
    self.pvpMode = nil
    ---@type boolean
    self.win = nil
    ---@type number
    self.season = nil
    ---@type PvPAssistant.Player
    self.player = nil
end

---@param player PvPAssistant.Player
---@return string
function PvPAssistant.MatchHistory:GetTooltipTextForPlayer(player)
    local tooltipText =
        f.class(player.name .. "-" .. player.realm, player.class)
    if self.isRated then
        local rating = player.scoreData.rating
        local ratingIcon = PvPAssistant.UTIL:GetIconByRating(rating)
        local iconText = GUTIL:IconToText(ratingIcon, 20, 20)
        tooltipText = tooltipText ..
            " " .. iconText .. " " .. rating
    end
    tooltipText = tooltipText ..
        "\n - Damage / Heal: " ..
        PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.damageDone) ..
        " / " .. PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.healingDone) .. "\n"
    if self.isArena then
        tooltipText = tooltipText ..
            " - Kills: " .. player.scoreData.killingBlows .. "\n"
    else
        tooltipText = tooltipText ..
            " - Kills / Deaths: " .. player.scoreData.killingBlows .. " / " .. player.scoreData.deaths .. "\n"
    end

    return tooltipText
end

---@param team PvPAssistant.Team
---@return string
function PvPAssistant.MatchHistory:GetTooltipTextForTeam(team)
    local tooltipText = ""

    for _, player in ipairs(team.players) do
        tooltipText = tooltipText .. self:GetTooltipTextForPlayer(player)
    end

    return tooltipText
end

function PvPAssistant.MatchHistory:GetTooltipText()
    local tooltipText = ""
    if self.isArena then
        tooltipText = tooltipText .. "Arena"
        tooltipText = tooltipText .. " " .. tostring(PvPAssistant.CONST.PVP_MODES_NAMES[self.pvpMode])
        if self.isRated then
            tooltipText = tooltipText .. " - Rated"
        end
    elseif self.isBattleground then
        tooltipText = tooltipText .. "Battleground"
        tooltipText = tooltipText .. " " .. tostring(PvPAssistant.CONST.PVP_MODES_NAMES[self.pvpMode])
        if self.isRated then
            tooltipText = tooltipText .. " - Rated"
        end
    end
    if self.isSoloShuffle then
        local wins = self.player.scoreData.stats[1] and self.player.scoreData.stats[1].pvpStatValue
        if wins and wins > 0 then
            tooltipText = tooltipText .. " ( " .. f.g(wins .. " Wins") .. " )"
        else
            tooltipText = tooltipText .. " ( " .. f.r("0 Wins") .. " )"
        end
    else
        if self.win then
            tooltipText = tooltipText .. " ( " .. f.g("Win") .. " )"
        else
            tooltipText = tooltipText .. " ( " .. f.r("Lost") .. " )"
        end
    end
    tooltipText = tooltipText .. "\nMap: " .. self.mapInfo.name
    tooltipText = tooltipText .. "\n\n"

    if self.isSoloShuffle then
        tooltipText = tooltipText .. f.g("Players:\n") .. self:GetTooltipTextForTeam(self.playerTeam)
    else
        tooltipText = tooltipText .. f.g("Your Team:\n") .. self:GetTooltipTextForTeam(self.playerTeam)
        tooltipText = tooltipText .. f.r("\nEnemy Team:\n") .. self:GetTooltipTextForTeam(self.enemyTeam)
    end

    return tooltipText
end

---@param tFrame Frame
function PvPAssistant.MatchHistory:UpdateTooltipFrame(tFrame)
    local tooltipFrame = tFrame.contentFrame --[[@as GGUI.Frame]]
    local content = tooltipFrame.content --[[@as PvPAssistant.MAIN_FRAME.TooltipFrame.Content]]

    local playerList = content.playerList

    playerList:Remove()

    content.modeText:SetText(f.white(PvPAssistant.CONST.PVP_MODES_NAMES[self.pvpMode] or "<?>"))
    content.mapText:SetText(f.bb(self.mapInfo.name))
    if self.isSoloShuffle then
        local wins = self.player.scoreData.stats[1] and self.player.scoreData.stats[1].pvpStatValue
        if wins and wins > 0 then
            content.winText:SetText(f.g(wins .. " Wins"))
        else
            content.winText:SetText(f.r("0 Wins"))
        end
    else
        if self.win then
            content.winText:SetText(f.g("Win"))
        else
            content.winText:SetText(f.r("Loss"))
        end
    end

    local playerTeamSize = #self.playerTeam.players
    for playerIndex, player in ipairs(GUTIL:Concat { self.playerTeam.players, self.enemyTeam.players }) do
        playerList:Add(function(row, columns)
            local playerColumn = columns[1]
            local dmgColumn = columns[2]
            local healColumn = columns[3]
            local killColumn = columns[4]

            -- If i am the last player in my team show the separator line, otherwise hide
            row:SetSeparatorLine(playerIndex == playerTeamSize and not self.isSoloShuffle)

            playerColumn.text:SetText(f.class(player.name, player.class))
            dmgColumn.text:SetText(PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.damageDone))
            healColumn.text:SetText(PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.healingDone))
            killColumn.text:SetText(PvPAssistant.UTIL:FormatDamageNumber(player.scoreData.killingBlows))
        end)
    end

    playerList:UpdateDisplay()
end

---@class PvPAssistant.MatchHistory.Serialized
---@field timestamp number
---@field mapInfo InstanceInfo
---@field isArena boolean
---@field isBattleground boolean
---@field isSoloShuffle boolean
---@field playerTeam PvPAssistant.Team
---@field enemyTeam PvPAssistant.Team
---@field duration number
---@field isRated boolean
---@field pvpMode PvPAssistant.Const.PVPModes
---@field win boolean
---@field season number
---@field player PvPAssistant.Player

---@return PvPAssistant.MatchHistory.Serialized
function PvPAssistant.MatchHistory:Serialize()
    ---@type PvPAssistant.MatchHistory.Serialized
    local serialized = {
        timestamp = self.timestamp,
        mapInfo = self.mapInfo,
        isArena = self.isArena,
        isBattleground = self.isBattleground,
        isSoloShuffle = self.isSoloShuffle,
        playerTeam = self.playerTeam,
        enemyTeam = self.enemyTeam,
        duration = self.duration,
        isRated = self.isRated,
        pvpMode = self.pvpMode,
        win = self.win,
        season = self.season,
        player = self.player,
    }

    return serialized
end

---@param serializedData PvPAssistant.MatchHistory.Serialized
---@return PvPAssistant.MatchHistory matchHistory
function PvPAssistant.MatchHistory:Deserialize(serializedData)
    local matchHistory = PvPAssistant.MatchHistory()
    matchHistory.timestamp = serializedData.timestamp
    matchHistory.mapInfo = serializedData.mapInfo
    matchHistory.isArena = serializedData.isArena
    matchHistory.isBattleground = serializedData.isBattleground
    matchHistory.isSoloShuffle = serializedData.isSoloShuffle
    matchHistory.playerTeam = serializedData.playerTeam
    matchHistory.enemyTeam = serializedData.enemyTeam
    matchHistory.duration = serializedData.duration
    matchHistory.isRated = serializedData.isRated
    matchHistory.pvpMode = serializedData.pvpMode
    matchHistory.win = serializedData.win
    matchHistory.season = serializedData.season
    matchHistory.player = serializedData.player
    return matchHistory
end
