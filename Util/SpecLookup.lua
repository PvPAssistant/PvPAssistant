---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.SPEC_LOOKUP
PvPLookup.SPEC_LOOKUP = {}
PvPLookup.SPEC_LOOKUP.lookupTable = {}

function PvPLookup.SPEC_LOOKUP:Init()
    wipe(PvPLookup.SPEC_LOOKUP.lookupTable)

    for _, specID in ipairs(PvPLookup.CONST.SPEC_IDS) do
        local specNameM = select(2, GetSpecializationInfoForSpecID(specID, 2)) -- 2 = Male
        local specNameF = select(2, GetSpecializationInfoForSpecID(specID, 3)) -- 3 = Female
        local className = select(7, GetSpecializationInfoByID(specID))

        PvPLookup.SPEC_LOOKUP.lookupTable[specNameM .. " " .. className] = specID
        PvPLookup.SPEC_LOOKUP.lookupTable[specNameF .. " " .. className] = specID -- if its the same its just overwriting
    end
end

---@param specDescriptor string -- 'LocalizedSpecName LocalizedClassName'
---@return number? specializationID
function PvPLookup.SPEC_LOOKUP:LookUp(specDescriptor)
    return self.lookupTable[specDescriptor]
end
