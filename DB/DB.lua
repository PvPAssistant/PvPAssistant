---@class PvPAssistant
local PvPAssistant = select(2, ...)

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

function PvPAssistant.DB:Init()
    self.MATCH_HISTORY:Init()
    self.DEBUG:Init()
    self.CHARACTERS:Init()
    self.TOOLTIP_OPTIONS:Init()
    self.GENERAL_OPTIONS:Init()
    self.RECOMMENDATION_DATA:Init()

    PvPAssistant.DB:Migrate()
    PvPAssistant.DB:CleanUp()
end

function PvPAssistant.DB:Migrate()
    self.MATCH_HISTORY:Migrate()
    self.DEBUG:Migrate()
    self.CHARACTERS:Migrate()
    self.TOOLTIP_OPTIONS:Migrate()
    self.GENERAL_OPTIONS:Migrate()
    self.RECOMMENDATION_DATA:Migrate()
end

--- Cleanup old unused DBs / Saved Variables
function PvPAssistant.DB:CleanUp()
    if PvPAssistantDB.playerData then
        PvPAssistantDB.playerData = nil
    end

    if PvPAssistantOptions then
        PvPAssistantOptions = nil
    end
end
