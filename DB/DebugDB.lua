---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.DEBUG
PvPAssistant.DB.DEBUG = {}

function PvPAssistant.DB.DEBUG:Init()
    if not PvPAssistantDB.debugData then
        PvPAssistantDB.debugData = {
            version = 3,
            ---@type any
            data = {}
        }
    end
end

---@param data table
function PvPAssistant.DB.DEBUG:Save(data)
    tinsert(PvPAssistantDB.debugData.data, data)
end

---@return table[]
function PvPAssistant.DB.DEBUG:Get()
    return PvPAssistantDB.debugData.data
end

function PvPAssistant.DB.DEBUG:Migrate()
    -- <= 3 -> 4 wipe data
    if PvPAssistantDB.debugData.version <= 3 then
        wipe(PvPAssistantDB.debugData.data)
        PvPAssistantDB.debugData.version = 4
    end
end

function PvPAssistant.DB.DEBUG:Clear()
    wipe(PvPAssistantDB.debugData.data)
end
