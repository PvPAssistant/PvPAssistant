---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.GENERAL_OPTIONS : PvPAssistant.DB.Repository
PvPAssistant.DB.GENERAL_OPTIONS = PvPAssistant.DB:RegisterRepository()

function PvPAssistant.DB.GENERAL_OPTIONS:Init()
    if not PvPAssistantDB.generalOptions then
        PvPAssistantDB.generalOptions = {
            version = 0,
            ---@type table<PvPAssistant.GENERAL_OPTION, any>
            data = {}
        }
    end
end

function PvPAssistant.DB.GENERAL_OPTIONS:ClearAll()
    wipe(PvPAssistantDB.generalOptions.data)
end

function PvPAssistant.DB.GENERAL_OPTIONS:Migrate()
    -- 0 -> 1
    if PvPAssistantDB.generalOptions.version == 0 then
        if _G["PvPAssistantOptions"] then
            -- move options from PvPAssistantOptions
            self:Save(PvPAssistant.CONST.GENERAL_OPTION.DEBUG, _G["PvPAssistantOptions"].enableDebug or false)
            self:Save(PvPAssistant.CONST.GENERAL_OPTION.ARENA_GUIDE_ENABLED,
                _G["PvPAssistantOptions"].arenaGuideEnable or true)
        end
        PvPAssistantDB.generalOptions.version = 1
    end

    -- 1 -> 2
    if PvPAssistantDB.generalOptions.version == 1 then
        PvPAssistantDB.generalOptions.data["DEBUG"] = nil
        PvPAssistantDB.generalOptions.version = 2
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

function PvPAssistant.DB.GENERAL_OPTIONS:CleanUp()
    if _G["PvPAssistantOptions"] then
        _G["PvPAssistantOptions"] = nil
    end
end
