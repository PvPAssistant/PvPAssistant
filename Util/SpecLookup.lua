---@class Arenalogs
local Arenalogs = select(2, ...)

---@class Arenalogs.SPEC_LOOKUP
Arenalogs.SPEC_LOOKUP = {}
Arenalogs.SPEC_LOOKUP.lookupTable = {}

function Arenalogs.SPEC_LOOKUP:Init()
    wipe(Arenalogs.SPEC_LOOKUP.lookupTable)

    for _, specID in ipairs(Arenalogs.CONST.SPEC_ID_LIST) do
        local specNameM = select(2, GetSpecializationInfoForSpecID(specID, 2)) -- 2 = Male
        local specNameF = select(2, GetSpecializationInfoForSpecID(specID, 3)) -- 3 = Female
        local className = select(7, GetSpecializationInfoByID(specID))

        Arenalogs.SPEC_LOOKUP.lookupTable[specNameM .. " " .. className] = specID
        Arenalogs.SPEC_LOOKUP.lookupTable[specNameF .. " " .. className] = specID -- if its the same its just overwriting
    end
end

---@param specDescriptor string -- 'LocalizedSpecName LocalizedClassName'
---@return number? specializationID
function Arenalogs.SPEC_LOOKUP:LookUp(specDescriptor)
    return self.lookupTable[specDescriptor]
end
