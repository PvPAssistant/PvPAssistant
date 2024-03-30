---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = ...

local GUTIL = PvPAssistant.GUTIL

---@class PvPAssistant.ADDON_UPDATE_NOTIFIER : Frame
PvPAssistant.ADDON_UPDATE_NOTIFIER = GUTIL:CreateRegistreeForEvents({ "PLAYER_ENTERING_WORLD", "CHAT_MSG_ADDON",
    "GROUP_ROSTER_UPDATE" })

PvPAssistant.ADDON_UPDATE_NOTIFIER.ReceivedUpdateNotification = false

PvPAssistant.ADDON_UPDATE_NOTIFIER.MSG_PREFIX = "PVPA_VERCHECK"
PvPAssistant.ADDON_UPDATE_NOTIFIER.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
-- This should maybe be moved to the CONST table as it is used a second time here: https://github.com/derfloh205/PvPAssistant/blob/b087cb9840c13d08a0199cd19ef9d2870892bf2c/Modules/MainFrame/Frames.lua#L41

function PvPAssistant.ADDON_UPDATE_NOTIFIER:SendMessage()
    local channel
    if IsInRaid() then
        channel = (not IsInRaid(LE_PARTY_CATEGORY_HOME) and IsInRaid(LE_PARTY_CATEGORY_INSTANCE)) and "INSTANCE_CHAT" or
            "RAID"
    elseif IsInGroup() then
        channel = (not IsInGroup(LE_PARTY_CATEGORY_HOME) and IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) and "INSTANCE_CHAT" or
            "PARTY"
    elseif IsInGuild() then
        channel = "GUILD"
    end
    if channel then
        C_ChatInfo.SendAddonMessage(self.MSG_PREFIX, self.ADDON_VERSION, channel)
    end
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:CheckVersion(otherVersion)
    local ownVersion = self.ADDON_VERSION:gsub("[^%d]", "")
    otherVersion = otherVersion:gsub("[^%d]", "")
    local updateAvailable = tonumber(otherVersion) > tonumber(ownVersion)

    if not self.ReceivedUpdateNotification and updateAvailable then
        self.ReceivedUpdateNotification = true
        print(string.format("%s: a new version is available!", addonName))
    end
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:Init()
    C_ChatInfo.RegisterAddonMessagePrefix(self.MSG_PREFIX)
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:PLAYER_ENTERING_WORLD()
    self:SendMessage()
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:GROUP_ROSTER_UPDATE()
    self:SendMessage()
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:CHAT_MSG_ADDON(prefix, version)
    if prefix == self.MSG_PREFIX then
        self:CheckVersion(version)
    end
end
