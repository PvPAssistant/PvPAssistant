---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.GENERAL_OPTIONS
PvPAssistant.DB.GENERAL_OPTIONS = {}

function PvPAssistant.DB.GENERAL_OPTIONS:Init()

end

function PvPAssistant.DB.GENERAL_OPTIONS:Clear()
    wipe(PvPAssistantDB.generalOptions.data)
end

function PvPAssistant.DB.GENERAL_OPTIONS:Migrate()
    if not PvPAssistantDB.generalOptions then
        PvPAssistantDB.generalOptions = {
            version = 1,
            ---@type table<PvPAssistant.GENERAL_OPTION, any>
            data = {}
        }

        if PvPAssistantOptions then
            -- move options from PvPAssistantOptions
            self:Save(PvPAssistant.CONST.GENERAL_OPTION.DEBUG, PvPAssistantOptions.enableDebug or false)
            self:Save(PvPAssistant.CONST.GENERAL_OPTION.ARENA_GUIDE_ENABLED,
                PvPAssistantOptions.arenaGuideEnable or true)
        end
    end
end

---@param option PvPAssistant.GENERAL_OPTION
---@param value any
function PvPAssistant.DB.GENERAL_OPTIONS:Save(option, value)
    PvPAssistantDB.generalOptions.data[option] = value
end

---@param option PvPAssistant.GENERAL_OPTION
---@return any? value
function PvPAssistant.DB.GENERAL_OPTIONS:Get(option)
    return PvPAssistantDB.generalOptions.data[option]
end
