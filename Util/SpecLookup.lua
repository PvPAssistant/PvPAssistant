---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.SPEC_LOOKUP
PvPAssistant.SPEC_LOOKUP = {}
PvPAssistant.SPEC_LOOKUP.lookupTable = {}

function PvPAssistant.SPEC_LOOKUP:Init()
    wipe(PvPAssistant.SPEC_LOOKUP.lookupTable)

    for _, specID in ipairs(PvPAssistant.CONST.SPEC_ID_LIST) do
        local specNameM = select(2, GetSpecializationInfoForSpecID(specID, 2)) -- 2 = Male
        local specNameF = select(2, GetSpecializationInfoForSpecID(specID, 3)) -- 3 = Female
        local className = select(7, GetSpecializationInfoByID(specID))

        PvPAssistant.SPEC_LOOKUP.lookupTable[specNameM .. " " .. className] = specID
        PvPAssistant.SPEC_LOOKUP.lookupTable[specNameF .. " " .. className] =
            specID -- if its the same its just overwriting
    end
end

---@param specDescriptor string -- 'LocalizedSpecName LocalizedClassName'
---@return number? specializationID
function PvPAssistant.SPEC_LOOKUP:LookUp(specDescriptor)
    return self.lookupTable[specDescriptor]
end
