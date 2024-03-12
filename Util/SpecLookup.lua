---@class PvpAssistant
local PvpAssistant = select(2, ...)

---@class PvpAssistant.SPEC_LOOKUP
PvpAssistant.SPEC_LOOKUP = {}
PvpAssistant.SPEC_LOOKUP.lookupTable = {}

function PvpAssistant.SPEC_LOOKUP:Init()
    wipe(PvpAssistant.SPEC_LOOKUP.lookupTable)

    for _, specID in ipairs(PvpAssistant.CONST.SPEC_ID_LIST) do
        local specNameM = select(2, GetSpecializationInfoForSpecID(specID, 2)) -- 2 = Male
        local specNameF = select(2, GetSpecializationInfoForSpecID(specID, 3)) -- 3 = Female
        local className = select(7, GetSpecializationInfoByID(specID))

        PvpAssistant.SPEC_LOOKUP.lookupTable[specNameM .. " " .. className] = specID
        PvpAssistant.SPEC_LOOKUP.lookupTable[specNameF .. " " .. className] = specID -- if its the same its just overwriting
    end
end

---@param specDescriptor string -- 'LocalizedSpecName LocalizedClassName'
---@return number? specializationID
function PvpAssistant.SPEC_LOOKUP:LookUp(specDescriptor)
    return self.lookupTable[specDescriptor]
end
