---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.DEBUG_IDS : PvPAssistant.DB.Repository
PvPAssistant.DB.DEBUG_IDS = PvPAssistant.DB:RegisterRepository()

function PvPAssistant.DB.DEBUG_IDS:Init()
    if not PvPAssistantDB.debugIDsDB then
        PvPAssistantDB.debugIDsDB = {
            version = 1,
            ---@type table<PvPAssistant.Const.DebugIDs, boolean>
            data = {}
        }
    end
end

---@param debugID PvPAssistant.Const.DebugIDs
---@param value boolean
function PvPAssistant.DB.DEBUG_IDS:Save(debugID, value)
    PvPAssistantDB.debugIDsDB.data[debugID] = value
end

---@param debugID PvPAssistant.Const.DebugIDs
---@return boolean
function PvPAssistant.DB.DEBUG_IDS:Get(debugID)
    return PvPAssistantDB.debugIDsDB.data[debugID]
end

function PvPAssistant.DB.DEBUG_IDS:Migrate()

end

function PvPAssistant.DB.DEBUG_IDS:Clear()
    wipe(PvPAssistantDB.debugIDsDB.data)
end
