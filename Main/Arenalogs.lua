local ArenalogsName = select(1, ...)
---@class Arenalogs
local Arenalogs = select(2, ...)

local GUTIL = Arenalogs.GUTIL
local GGUI = Arenalogs.GGUI
local f = GUTIL:GetFormatter()
local debug = Arenalogs.DEBUG:GetDebugPrint()

ArenalogsGGUIConfig = ArenalogsGGUIConfig or {}

---@class Arenalogs.Main : Frame
Arenalogs.MAIN = GUTIL:CreateRegistreeForEvents({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD",
	"PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_COMPLETE" })

Arenalogs.MAIN.FRAMES = {}

Arenalogs.MAIN.enableCombatLog = false

function Arenalogs:InitializeMinimapButton()
	local LibIcon = LibStub("LibDBIcon-1.0")
	local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("ARENALOGS", {
		type = "data source",
		label = "Arenalogs",
		tocname = "Arenalogs",
		icon = "Interface\\Addons\\Arenalogs\\Media\\Images\\logo1024",
		OnClick = function()
			local mainFrame = GGUI:GetFrame(Arenalogs.MAIN.FRAMES, Arenalogs.CONST.FRAMES.MAIN_FRAME)
			if mainFrame then
				mainFrame:SetVisible(not mainFrame:IsVisible())
			end
		end,
	})

	function ldb.OnTooltipShow(tt)
		tt:AddLine(GUTIL:ColorizeText("Arenalogs\n", GUTIL.COLORS.LEGENDARY))
		tt:AddLine(GUTIL:ColorizeText("Click to Open!", GUTIL.COLORS.WHITE))
	end

	ArenalogsLibIconDB = ArenalogsLibIconDB or {}

	LibIcon:Register("Arenalogs", ldb, ArenalogsLibIconDB)
end

function Arenalogs.MAIN:Init()
	Arenalogs.DB:Init()

	Arenalogs.MAIN:InitializeSlashCommands()
	Arenalogs.OPTIONS:Init()
	Arenalogs.MAIN_FRAME.FRAMES:Init()
	Arenalogs.MAIN_FRAME:InitMatchHistoryTooltipFrame()
	Arenalogs.PVPINFO.FRAMES:Init()
	Arenalogs.ARENA_GUIDE.FRAMES:Init()
	Arenalogs:InitializeMinimapButton()
	Arenalogs.PLAYER_TOOLTIP:Init()
	Arenalogs.SPELL_TOOLTIP:Init()

	-- restore frame positions
	Arenalogs.MAIN_FRAME.frame:RestoreSavedConfig(UIParent)
	Arenalogs.ARENA_GUIDE.frame:RestoreSavedConfig(UIParent)
end

function Arenalogs.MAIN:InitializeSlashCommands()
	SLASH_ARENALOGS1 = "/arenalogs"
	SLASH_ARENALOGS2 = "/al"
	SlashCmdList["ARENALOGS"] = function(input)
		input = SecureCmdOptionParse(input)
		if not input then return end

		local command, rest = input:match("^(%S*)%s*(.-)$")
		command = command and command:lower()
		rest = (rest and rest ~= "") and rest:trim() or nil

		if command == "config" then
			InterfaceOptionsFrame_OpenToCategory(Arenalogs.OPTIONS.optionsPanel)
		end

		if command == "history" and rest == "clear" then
			print(f.l("Arenalogs") .. ": Match History Cleared")
			Arenalogs.DB.MATCH_HISTORY:Clear()
			Arenalogs.MAIN_FRAME.FRAMES:UpdateMatchHistory()
		end

		if command == "tooltips" and rest == "clear" then
			print(f.l("Arenalogs ") .. ": Player Tooltip Data Cleared")
			Arenalogs.DB.PLAYER_DATA:Clear()
		end

		if command == "guide" then
			if C_PvP.IsArena() then
				Arenalogs.ARENA_GUIDE.frame:Show()
				Arenalogs.ARENA_GUIDE.FRAMES:UpdateDisplay()
			else
				print(f.l("Arenalogs ") .. ": Arena Guide is only available in Arena Matches")
			end
		end

		if command == "debug" then
			ArenalogsOptions.enableDebug = not ArenalogsOptions.enableDebug
			print(f.l("Arenalogs ") .. ": Toggle Debug Mode " .. tostring(ArenalogsOptions.enableDebug))
		end

		if command == "" then
			Arenalogs.MAIN_FRAME.frame:Show()
		end
	end
end

function Arenalogs.MAIN:ADDON_LOADED(addon_name)
	if addon_name ~= ArenalogsName then
		return
	end
	Arenalogs.MAIN:Init()
end

function Arenalogs.MAIN:PLAYER_ENTERING_WORLD()
	Arenalogs.SPEC_LOOKUP:Init()

	Arenalogs.PVPINFO.FRAMES:UpdateDisplay()

	Arenalogs.MAIN_FRAME.FRAMES:UpdateMatchHistory()

	Arenalogs.MAIN.enableCombatLog = false
end

---@class SpecializationInfo
---@field id number
---@field name string
---@field description string
---@field icon string
---@field role string
---@field class ClassFile

function Arenalogs.MAIN:PLAYER_JOINED_PVP_MATCH()
	if not Arenalogs.MAIN.enableCombatLog then
		debug("Arenalogs: Joined PvP Match")
		debug("LoggingCombat: " .. tostring(LoggingCombat(true)))

		Arenalogs.MAIN.enableCombatLog = true
	end
end

function Arenalogs.MAIN:PVP_MATCH_COMPLETE()
	debug("Arenalogs: PvP Match Completed")
	debug("LoggingCombat: " .. tostring(LoggingCombat(false)))

	debug("Arenalogs: Saving Match Data...")
	local matchHistory = Arenalogs.MatchHistory:CreateFromEndScreen()
	Arenalogs.DB.MATCH_HISTORY:Save(matchHistory)

	Arenalogs.MAIN_FRAME.FRAMES:UpdateMatchHistory()
end
