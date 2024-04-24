---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB.Repository
---@field Init function
---@field Migrate function
---@field CleanUp function
---@field ClearAll function

---@class PvPAssistantDB.Database
---@field version number
---@field data table

---@class PvPAssistant.DB
PvPAssistant.DB = {}

---@class PvPAssistantDB
---@field matchHistory PvPAssistantDB.Database
---@field debugData PvPAssistantDB.Database
---@field tooltipOptions PvPAssistantDB.Database
---@field characterData PvPAssistantDB.Database
---@field generalOptions PvPAssistantDB.Database
---@field recommendationData PvPAssistantDB.Database
PvPAssistantDB = PvPAssistantDB or {}

---@type PvPAssistant.DB.Repository[]
PvPAssistant.DB.repositories = {}

---@return PvPAssistant.DB.Repository repository
function PvPAssistant.DB:RegisterRepository()
    ---@type PvPAssistant.DB.Repository
    local repository = {
        Init = function() end,
        Migrate = function() end,
        CleanUp = function() end,
        ClearAll = function() end,
    }
    return repository
end

function PvPAssistant.DB:Init()
    for _, repository in ipairs(self.repositories) do
        repository:Init()
        repository:Migrate()
        repository:CleanUp()
    end
end
