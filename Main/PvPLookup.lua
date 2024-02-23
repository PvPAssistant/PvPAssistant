local PvPLookupName = select(1, ...)
---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL
local GGUI = PvPLookup.GGUI

---@class PvPLookup.Main : Frame
PvPLookup.MAIN = GUTIL:CreateRegistreeForEvents({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD", "UPDATE_BATTLEFIELD_SCORE",
	"PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_COMPLETE" })

PvPLookup.MAIN.FRAMES = {}

PvPLookup.MAIN.enableCombatLog = false

function PvPLookup:InitializeMinimapButton()
	local LibIcon = LibStub("LibDBIcon-1.0")
	local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("PVPLOOKUP", {
		type = "data source",
		label = "PvPLookup",
		tocname = "PvPLookup",
		icon = "Interface\\Addons\\PvPLookup\\Media\\Images\\logo1024",
		OnClick = function()
			local mainFrame = GGUI:GetFrame(PvPLookup.MAIN.FRAMES, PvPLookup.CONST.FRAMES.MAIN_FRAME)
			if mainFrame then
				mainFrame:SetVisible(not mainFrame:IsVisible())
			end
		end,
	})

	function ldb.OnTooltipShow(tt)
		tt:AddLine(GUTIL:ColorizeText("PvPLookup\n", GUTIL.COLORS.LEGENDARY))
		tt:AddLine(GUTIL:ColorizeText("Click to Open!", GUTIL.COLORS.WHITE))
	end

	PvPLookupLibIconDB = PvPLookupLibIconDB or {}

	LibIcon:Register("PvPLookup", ldb, PvPLookupLibIconDB)
end

function PvPLookup.MAIN:Init()
	PvPLookup.DB:Init()

	PvPLookup.MAIN:InitializeSlashCommands()
	PvPLookup.OPTIONS:Init()
	PvPLookup.MAIN_FRAME.FRAMES:Init()
	PvPLookup.PVPINFO.FRAMES:Init()
	PvPLookup:InitializeMinimapButton()
	PvPLookup.PLAYER_TOOLTIP:Init()

	-- restore frame positions
	PvPLookup.MAIN_FRAME.frame:RestoreSavedConfig(UIParent)
end

function PvPLookup.MAIN:InitializeSlashCommands()
	SLASH_PVPLOOKUP1 = "/pvplookup"
	SLASH_PVPLOOKUP2 = "/plu"
	SlashCmdList["PVPLOOKUP"] = function(input)
		input = SecureCmdOptionParse(input)
		if not input then return end

		local command, rest = input:match("^(%S*)%s*(.-)$")
		command = command and command:lower()
		rest = (rest and rest ~= "") and rest:trim() or nil

		if command == "config" then
			InterfaceOptionsFrame_OpenToCategory(PvPLookup.OPTIONS.optionsPanel)
		end

		if command == "" then
			PvPLookup.MAIN_FRAME.frame:Show()
		end
	end
end

function PvPLookup.MAIN:ADDON_LOADED(addon_name)
	if addon_name ~= PvPLookupName then
		return
	end
	PvPLookup.MAIN:Init()
end

function PvPLookup.MAIN:PLAYER_ENTERING_WORLD()
	PvPLookup.SPEC_LOOKUP:Init()

	--- DEBUG Dummy Data
	-- PvPLookup.DEBUG:CreateHistoryDummyData()
	PvPLookup.DEBUG:CreatePlayerDummyData()

	PvPLookup.MAIN_FRAME:UpdateHistory()

	PvPLookup.MAIN.enableCombatLog = false
end

function PvPLookup.MAIN:UPDATE_BATTLEFIELD_SCORE()
	-- print("PVPLOOKUP: UPDATE_BATTLEFIELD_SCORE")
end

--- works!
function PvPLookup.MAIN:PLAYER_JOINED_PVP_MATCH()
	if not PvPLookup.MAIN.enableCombatLog then
		print("PvPLookup: Joined PvP Match")
		print("LoggingCombat: " .. tostring(LoggingCombat(true)))

		PvPLookup.MAIN.enableCombatLog = true
	end
end

function PvPLookup.MAIN:PVP_MATCH_COMPLETE()
	print("PvPLookup: PvP Match Completed")
	print("LoggingCombat: " .. tostring(LoggingCombat(false)))

	print("PvPLookup: Saving Match Data...")
	local matchHistory = PvPLookup.MatchHistory:CreateFromEndScreen()
	PvPLookup.DB.MATCH_HISTORY:Save(matchHistory)
end
