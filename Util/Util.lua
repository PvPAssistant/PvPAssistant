---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.Util
PvPLookup.UTIL = {}

--- also for healing
function PvPLookup.UTIL:FormatDamageNumber(number)
    if number >= 1000000000 then
        return number / 1000000000 .. "B" 
    end
    if number >= 1000000 then
        return number / 1000000 .. "M"
    end
    if number >= 1000 then
        return number / 1000 .. "K"
    end

    return tostring(number)
end