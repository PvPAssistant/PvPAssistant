---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.DEBUG : PvPAssistant.DB.Repository
PvPAssistant.DB.DEBUG = PvPAssistant.DB:RegisterRepository()

function PvPAssistant.DB.DEBUG:Init()
    if not PvPAssistantDB.debugData then
        PvPAssistantDB.debugData = {
            version = 0,
            ---@type any
            data = {}
        }
    end
end

---@param data table
---@param prefix string?
function PvPAssistant.DB.DEBUG:Save(data, prefix)
    if prefix then
        PvPAssistantDB.debugData.data[prefix .. "_" .. GUTIL:Count(PvPAssistantDB.debugData.data)] = data
    else
        tinsert(PvPAssistantDB.debugData.data, data)
    end
end

---@return table[]
function PvPAssistant.DB.DEBUG:Get()
    return PvPAssistantDB.debugData.data
end

function PvPAssistant.DB.DEBUG:Migrate()
    -- <= 4 -> 5 wipe data
    if PvPAssistantDB.debugData.version <= 4 then
        wipe(PvPAssistantDB.debugData.data)
        PvPAssistantDB.debugData.version = 5
    end
end

function PvPAssistant.DB.DEBUG:Clear()
    wipe(PvPAssistantDB.debugData.data)
end
