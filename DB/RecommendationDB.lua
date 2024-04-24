---@class PvPAssistant
local PvPAssistant = select(2, ...)

---@class PvPAssistant.DB
PvPAssistant.DB = PvPAssistant.DB

---@class PvPAssistant.DB.RECOMMENDATION_DATA : PvPAssistant.DB.Repository
PvPAssistant.DB.RECOMMENDATION_DATA = PvPAssistant.DB:RegisterRepository()

---@alias UnitGUID string
---@class PvPAssistant.RecommendationData
---@field note string
---@field rating number

function PvPAssistant.DB.RECOMMENDATION_DATA:Init()
    if not PvPAssistantDB.recommendationData then
        PvPAssistantDB.recommendationData = {
            version = 1,
            ---@type table<UnitGUID, PvPAssistant.RecommendationData>
            data = {}
        }
    end
end

function PvPAssistant.DB.RECOMMENDATION_DATA:ClearAll()
    wipe(PvPAssistantDB.recommendationData.data)
end

---@return PvPAssistant.RecommendationData? unitData
function PvPAssistant.DB.RECOMMENDATION_DATA:Get(unitGUID)
    return PvPAssistantDB.recommendationData.data[unitGUID]
end

---@param unitData PvPAssistant.RecommendationData
function PvPAssistant.DB.RECOMMENDATION_DATA:Save(unitGUID, unitData)
    PvPAssistantDB.recommendationData.data[unitGUID] = unitData
end

---@return PvPAssistant.RecommendationData[]
function PvPAssistant.DB.RECOMMENDATION_DATA:GetAll()
    return PvPAssistantDB.recommendationData.data
end
