local PvpAssistantName = select(1, ...)
---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GUTIL = PvpAssistant.GUTIL
local GGUI = PvpAssistant.GGUI
local f = GUTIL:GetFormatter()
local debug = PvpAssistant.DEBUG:GetDebugPrint()

PvpAssistantGGUIConfig = PvpAssistantGGUIConfig or {}

---@class PvpAssistant.Main : Frame
PvpAssistant.MAIN = GUTIL:CreateRegistreeForEvents({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD",
	"PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_COMPLETE" })

PvpAssistant.MAIN.FRAMES = {}

PvpAssistant.MAIN.enableCombatLog = false

function PvpAssistant:InitializeMinimapButton()
	local LibIcon = LibStub("LibDBIcon-1.0")
	local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("PvpAssistant", {
		type = "data source",
		label = "PvpAssistant",
		tocname = "PvpAssistant",
		icon = "Interface\\Addons\\PvpAssistant\\Media\\Images\\logo1024",
		OnClick = function()
			local mainFrame = GGUI:GetFrame(PvpAssistant.MAIN.FRAMES, PvpAssistant.CONST.FRAMES.MAIN_FRAME)
			if mainFrame then
				mainFrame:SetVisible(not mainFrame:IsVisible())
			end
		end,
	})

	function ldb.OnTooltipShow(tt)
		tt:AddLine(GUTIL:ColorizeText("PvpAssistant\n", GUTIL.COLORS.LEGENDARY))
		tt:AddLine(GUTIL:ColorizeText("Click to Open!", GUTIL.COLORS.WHITE))
	end

	PvpAssistantLibIconDB = PvpAssistantLibIconDB or {}

	LibIcon:Register("PvpAssistant", ldb, PvpAssistantLibIconDB)
end

function PvpAssistant.MAIN:Init()
	PvpAssistant.DB:Init()

	PvpAssistant.MAIN:InitializeSlashCommands()
	PvpAssistant.OPTIONS:Init()
	PvpAssistant.MAIN_FRAME.FRAMES:Init()
	PvpAssistant.MAIN_FRAME:InitMatchHistoryTooltipFrame()
	PvpAssistant.PVPINFO.FRAMES:Init()
	PvpAssistant.ARENA_GUIDE.FRAMES:Init()
	PvpAssistant:InitializeMinimapButton()
	PvpAssistant.PLAYER_TOOLTIP:Init()
	PvpAssistant.SPELL_TOOLTIP:Init()

	-- restore frame positions
	PvpAssistant.MAIN_FRAME.frame:RestoreSavedConfig(UIParent)
	PvpAssistant.ARENA_GUIDE.frame:RestoreSavedConfig(UIParent)
end

function PvpAssistant.MAIN:InitializeSlashCommands()
	SLASH_PvpAssistant1 = "/PvpAssistant"
	SLASH_PvpAssistant2 = "/al"
	SlashCmdList["PvpAssistant"] = function(input)
		input = SecureCmdOptionParse(input)
		if not input then return end

		local command, rest = input:match("^(%S*)%s*(.-)$")
		command = command and command:lower()
		rest = (rest and rest ~= "") and rest:trim() or nil

		if command == "config" then
			InterfaceOptionsFrame_OpenToCategory(PvpAssistant.OPTIONS.optionsPanel)
		end

		if command == "history" and rest == "clear" then
			print(f.l("PvpAssistant") .. ": Match History Cleared")
			PvpAssistant.DB.MATCH_HISTORY:Clear()
			PvpAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()
		end

		if command == "tooltips" and rest == "clear" then
			print(f.l("PvpAssistant ") .. ": Player Tooltip Data Cleared")
			PvpAssistant.DB.PLAYER_DATA:Clear()
		end

		if command == "guide" then
			if C_PvP.IsArena() then
				PvpAssistant.ARENA_GUIDE.frame:Show()
				PvpAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
			else
				print(f.l("PvpAssistant ") .. ": Arena Guide is only available in Arena Matches")
			end
		end

		if command == "debug" then
			PvpAssistantOptions.enableDebug = not PvpAssistantOptions.enableDebug
			print(f.l("PvpAssistant ") .. ": Toggle Debug Mode " .. tostring(PvpAssistantOptions.enableDebug))
		end

		if command == "" then
			PvpAssistant.MAIN_FRAME.frame:Show()
		end
	end
end

function PvpAssistant.MAIN:ADDON_LOADED(addon_name)
	if addon_name ~= PvpAssistantName then
		return
	end
	PvpAssistant.MAIN:Init()
end

function PvpAssistant.MAIN:PLAYER_ENTERING_WORLD()
	PvpAssistant.SPEC_LOOKUP:Init()

	PvpAssistant.PVPINFO.FRAMES:UpdateDisplay()

	PvpAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()

	PvpAssistant.MAIN.enableCombatLog = false
end

---@class SpecializationInfo
---@field id number
---@field name string
---@field description string
---@field icon string
---@field role string
---@field class ClassFile

function PvpAssistant.MAIN:PLAYER_JOINED_PVP_MATCH()
	if not PvpAssistant.MAIN.enableCombatLog then
		debug("PvpAssistant: Joined PvP Match")
		debug("LoggingCombat: " .. tostring(LoggingCombat(true)))

		PvpAssistant.MAIN.enableCombatLog = true
	end
end

function PvpAssistant.MAIN:PVP_MATCH_COMPLETE()
	debug("PvpAssistant: PvP Match Completed")
	debug("LoggingCombat: " .. tostring(LoggingCombat(false)))

	debug("PvpAssistant: Saving Match Data...")
	local matchHistory = PvpAssistant.MatchHistory:CreateFromEndScreen()
	PvpAssistant.DB.MATCH_HISTORY:Save(matchHistory)

	PvpAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()
end
