---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.CHARACTERS
PvPAssistant.DB.CHARACTERS = {}

---@alias PlayerUID string -- PlayerName-NormalizedServerName

---@class PvPAssistant.CharacterData
---@field name string
---@field realm string
---@field class ClassFile

function PvPAssistant.DB.CHARACTERS:Init()
    if not PvPAssistantDB.characterData then
        PvPAssistantDB.characterData = {
            version = 1,
            ---@type table<PlayerUID, PvPAssistant.CharacterData>
            data = {}
        }
    end
end

function PvPAssistant.DB.CHARACTERS:InitData()
    local playerUID = PvPAssistant.UTIL:GetPlayerUIDByUnit("player")
    local playerClass = select(2, UnitClass("player"))
    local name, realm = strsplit("-", playerUID)

    ---@type PvPAssistant.CharacterData
    local characterData = {
        name = name,
        realm = realm,
        class = playerClass,
    }

    self:Save(playerUID, characterData)
end

function PvPAssistant.DB.CHARACTERS:Clear()
    wipe(PvPAssistantDB.characterData.data)
end

---@return PvPAssistant.CharacterData? characterData
function PvPAssistant.DB.CHARACTERS:Get(characterUID)
    return PvPAssistantDB.characterData.data[characterUID]
end

---@param characterUID PlayerUID
---@param characterData PvPAssistant.CharacterData
function PvPAssistant.DB.CHARACTERS:Save(characterUID, characterData)
    PvPAssistantDB.characterData.data[characterUID] = characterData
end

---@param characterUID PlayerUID
function PvPAssistant.DB.CHARACTERS:GetClass(characterUID)
    local characterData = self:Get(characterUID)
    if characterData then
        return characterData.class
    end
end

---@return number classID
function PvPAssistant.DB.CHARACTERS:GetClassID(characterUID)
    local class = self:GetClass(characterUID)
    if class then
        return PvPAssistant.CONST.CLASS_ID[class]
    end
end

---@return PvPAssistant.CharacterData[]
function PvPAssistant.DB.CHARACTERS:GetAll()
    return PvPAssistantDB.characterData.data
end

function PvPAssistant.DB.CHARACTERS:Migrate() end
