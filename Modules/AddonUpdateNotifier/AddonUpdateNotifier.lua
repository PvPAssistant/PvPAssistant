---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = ...

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

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

--- Temporary Fix for the Compare till the new Version is in GUTIL
---@param versionA string
---@param versionB string
---@return number result 0 if same 1 if left is greater, -1 if left is smaller
local function compareVersionStrings(versionA, versionB)
    if GUTIL:CompareVersionStrings("1.0.0", "0.0.1") ~= 0 then
        return GUTIL:CompareVersionStrings(versionA, versionB)
    end
    local function getSegments(version)
        local segments = {}
        for segment in version:gmatch("[^.]+") do
            tinsert(segments, tonumber(segment))
        end
        return segments
    end
    local segmentsA, segmentsB = getSegments(versionA), getSegments(versionB)
    for i = 1, math.max(#segmentsA, #segmentsB) do
        local segA, segB = segmentsA[i] or 0, segmentsB[i] or 0
        if segA < segB then return -1
        elseif segA > segB then return 1 end
    end
    return 0
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:CheckVersion(otherVersion)
    local updateAvailable = compareVersionStrings(self.ADDON_VERSION, otherVersion) < 0

    if not self.ReceivedUpdateNotification and updateAvailable then
        self.ReceivedUpdateNotification = true
        print(string.format("%s: New Version available: %s", f.bb(addonName), f.g(otherVersion)))
    end
end

function PvPAssistant.ADDON_UPDATE_NOTIFIER:PLAYER_ENTERING_WORLD()
    C_ChatInfo.RegisterAddonMessagePrefix(self.MSG_PREFIX)
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
