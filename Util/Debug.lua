---@class PvPLookup
local PvPLookup = select(2, ...)

---@class PvPLookup.DEBUG
PvPLookup.DEBUG = {}

PvPLookup_DEBUG = PvPLookup.DEBUG

local DevTool = DevTool

function PvPLookup.DEBUG:CreateHistoryDummyData()
    PvPLookupHistoryDB = {}
    --- 2v2s
    for _ = 1, 150 do
        table.insert(PvPLookupHistoryDB, PvPLookup.MatchHistory(
            C_DateAndTime.GetServerTimeLocal(),
            "TTP",
            {
                players = {
                    {
                        class = "WARRIOR",
                        spec = "FURY",
                        name = "Player1",
                        server = GetRealmName(),
                    },
                    {
                        class = "ROGUE",
                        spec = "SUBTLETY",
                        name = "Player2",
                        server = GetRealmName(),
                    },
                }
            },
            {
                players = {
                    {
                        class = "MAGE",
                        spec = "FROST_MAGE",
                        name = "Enemy1",
                        server = GetRealmName(),
                    },
                    {
                        class = "DEMONHUNTER",
                        spec = "HAVOC",
                        name = "Enemy2",
                        server = GetRealmName(),
                    },
                }
            },
            1134,
            1133,
            200000,
            4000000,
            3000000,
            2000000,
            100000,
            1478,
            PvPLookup.CONST.PVP_MODES.TWOS,
            true
        ))
    end
    --- 3v3s
    for _ = 1, 150 do
        table.insert(PvPLookupHistoryDB, PvPLookup.MatchHistory(
            C_DateAndTime.GetServerTimeLocal(),
            "RoL",
            {
                players = {
                    {
                        class = "WARRIOR",
                        spec = "FURY",
                        name = "Player1",
                        server = GetRealmName(),
                    },
                    {
                        class = "WARLOCK",
                        spec = "DESTRUCTION",
                        name = "Player2",
                        server = GetRealmName(),
                    },
                    {
                        class = "ROGUE",
                        spec = "SUBTLETY",
                        name = "Player3",
                        server = GetRealmName(),
                    },
                }
            },
            {
                players = {
                    {
                        class = "MAGE",
                        spec = "FROST_MAGE",
                        name = "Enemy1",
                        server = GetRealmName(),
                    },
                    {
                        class = "PALADIN",
                        spec = "HOLY",
                        name = "Enemy2",
                        server = GetRealmName(),
                    },
                    {
                        class = "DEMONHUNTER",
                        spec = "HAVOC",
                        name = "Enemy3",
                        server = GetRealmName(),
                    },
                }
            },
            1234,
            1233,
            300000,
            5000000,
            4000000,
            3000000,
            200000,
            3456,
            PvPLookup.CONST.PVP_MODES.THREES,
            true
        ))
    end
end

---@return PvPLookup
function PvPLookup.DEBUG:RUN()
    return PvPLookup
end

---@param t table
---@param label string?
function PvPLookup.DEBUG:DebugTable(t, label)
    if DevTool then
        print("devtool add data: " .. tostring(t))
        DevTool:AddData(t, label)
    end
end
