---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.LFG_LEADER_TOOLTIP : Frame
PvPAssistant.LFG_LEADER_TOOLTIP = {}

function PvPAssistant.LFG_LEADER_TOOLTIP:Init()
    hooksecurefunc("LFGListSearchEntry_OnEnter", function(searchEntry)
        if not searchEntry then return end

        local searchResultInfo = C_LFGList.GetSearchResultInfo(searchEntry.resultID)
        local activityInfo = C_LFGList.GetActivityInfoTable(searchResultInfo.activityID)

        if not activityInfo.isPvpActivity then return end

        if searchResultInfo.leaderName then
            local leaderName, leaderRealm = strsplit("-", searchResultInfo.leaderName)
            leaderRealm = leaderRealm or GetNormalizedRealmName()
            local leaderRealm = PvPAssistant.UTIL:CamelCaseToDashSeparated(leaderRealm)
            local pvpData = PvPAssistant.DB.PVP_DATA:Get(leaderName, leaderRealm) -- TODO: If possible forward leader classfile somehow as 2. arg



            if pvpData then
                GameTooltip:AddLine(f.bb("\nPvPAssistant"))
                for mode, rating in pairs(pvpData.ratings) do
                    GameTooltip:AddDoubleLine(f.white(tostring(PvPAssistant.CONST.PVP_MODES_NAMES[mode])),
                        PvPAssistant.UTIL:ColorByRating(tostring(rating), rating))
                end
            else
                GameTooltip:AddLine(f.bb("\nPvPAssistant") .. " - " .. f.white("No Player Data Available"))
            end
            GameTooltip:Show()
        end
    end)
end
