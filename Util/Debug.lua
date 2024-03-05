---@class Arenalogs
local Arenalogs = select(2, ...)

local f = Arenalogs.GUTIL:GetFormatter()

---@class Arenalogs.DEBUG
Arenalogs.DEBUG = {}

ArenalogsDEBUG = Arenalogs.DEBUG

local DevTool = DevTool

function Arenalogs.DEBUG:CreateHistoryDummyData()
	wipe(ArenalogsHistoryDB)
	--- 2v2s
	for _ = 1, 150 do
		local matchHistory = Arenalogs.MatchHistory()
		matchHistory.timestamp = GetServerTime()
		matchHistory.map = "TTP"
		matchHistory.playerTeam = {
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
		}
		matchHistory.enemyTeam = {
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
		}
		matchHistory.playerMMR = 1134
		matchHistory.enemyMMR = 1133
		matchHistory.duration = 200000
		matchHistory.playerDamage = 4000000
		matchHistory.enemyDamage = 3000000
		matchHistory.playerHealing = 2000000
		matchHistory.enemyHealing = 100000
		matchHistory.isRated = true
		matchHistory.isArena = true
		matchHistory.rating = 1478
		matchHistory.ratingChange = 17
		matchHistory.pvpMode = Arenalogs.CONST.PVP_MODES.TWOS
		matchHistory.win = true
		matchHistory.season = GetCurrentArenaSeason() or 0
		table.insert(ArenalogsHistoryDB, matchHistory)
	end
	--- 3v3s
	for _ = 1, 150 do
		local matchHistory = Arenalogs.MatchHistory()
		matchHistory.timestamp = GetServerTime()
		matchHistory.map = "RoL"
		matchHistory.playerTeam = {
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
		}
		matchHistory.enemyTeam = {
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
		}
		matchHistory.playerMMR = 1234
		matchHistory.enemyMMR = 1233
		matchHistory.duration = 200000
		matchHistory.playerDamage = 4000000
		matchHistory.enemyDamage = 3000000
		matchHistory.playerHealing = 2000000
		matchHistory.enemyHealing = 100000
		matchHistory.isRated = true
		matchHistory.isArena = true
		matchHistory.rating = 1478
		matchHistory.ratingChange = -17
		matchHistory.pvpMode = Arenalogs.CONST.PVP_MODES.THREES
		matchHistory.win = false
		matchHistory.season = GetCurrentArenaSeason() or 0
		table.insert(ArenalogsHistoryDB, matchHistory)
	end
end

function Arenalogs.DEBUG:CreatePlayerDummyData()
	Arenalogs.DB.PLAYER_DATA:Clear()

	local playerUID = Arenalogs.UTIL:GetPlayerUIDByUnit("player")

	---@type Arenalogs.PlayerTooltipData
	local playerTooltipData = {
		ratingData = {
			[Arenalogs.CONST.PVP_MODES.TWOS] = {
				rating = 2168,
				win = 190,
				loss = 95,
				exp = 2657,
			},
			[Arenalogs.CONST.PVP_MODES.THREES] = {
				rating = 2568,
				win = 601,
				loss = 95,
				exp = 2895,
			},
			[Arenalogs.CONST.PVP_MODES.BATTLEGROUND] = {
				rating = 2168,
				win = 69,
				loss = 16,
				exp = 3145,
			},
			[Arenalogs.CONST.PVP_MODES.SOLO_SHUFFLE] = {
				rating = 2168,
				win = 567,
				loss = 109,
				exp = 2345,
			},
		},
	}
	Arenalogs.DB.PLAYER_DATA:Save(playerUID, playerTooltipData)
end

---@return Arenalogs
function Arenalogs.DEBUG:RUN()
	return Arenalogs
end

---@param t table
---@param label string?
function Arenalogs.DEBUG:DebugTable(t, label)
	if DevTool and ArenalogsOptions.enableDebug then
		DevTool:AddData(t, label)
	end
end

function Arenalogs.DEBUG:RetrieveMatchData()
	local matchHistory = Arenalogs.MatchHistory:CreateFromEndScreen()
end

function Arenalogs.DEBUG:GetSpecializationIDByUnit(unit)
	return Arenalogs.UTIL:GetSpecializationIDByUnit(unit)
end

function Arenalogs.DEBUG:InspectSpecLookup()
	self:DebugTable(Arenalogs.SPEC_LOOKUP.lookupTable, "SpecLookup")
end

function Arenalogs.DEBUG:UpdateAndInspectArenaSpecs()
	Arenalogs.ARENA_GUIDE:UpdateArenaSpecIDs()
	self:DebugTable(Arenalogs.ARENA_GUIDE.specIDs, "ManualDebugSpecIDs")
end

function Arenalogs.DEBUG:GetDebugPrint()
	return function(text)
		if ArenalogsOptions.enableDebug then
			print(f.l("AL Debug: ") .. tostring(text))
		end
	end
end
