local PvPAssistantName = select(1, ...)
---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local GGUI = PvPAssistant.GGUI
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

PvPAssistantGGUIConfig = PvPAssistantGGUIConfig or {}

---@class PvPAssistant.Main : Frame
PvPAssistant.MAIN = GUTIL:CreateRegistreeForEvents({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD",
	"PLAYER_JOINED_PVP_MATCH", "PVP_MATCH_COMPLETE" })

PvPAssistant.MAIN.FRAMES = {}

PvPAssistant.MAIN.enableCombatLog = false

function PvPAssistant:InitializeMinimapButton()
	local LibIcon = LibStub("LibDBIcon-1.0")
	local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("PvPAssistant", {
		type = "data source",
		label = "PvPAssistant",
		tocname = "PvPAssistant",
		icon = "Interface\\Addons\\PvPAssistant\\Media\\Images\\logo1024",
		OnClick = function()
			local mainFrame = GGUI:GetFrame(PvPAssistant.MAIN.FRAMES, PvPAssistant.CONST.FRAMES.MAIN_FRAME)
			if mainFrame then
				mainFrame:SetVisible(not mainFrame:IsVisible())
			end
		end,
	})

	function ldb.OnTooltipShow(tt)
		tt:AddLine(GUTIL:ColorizeText("PvPAssistant\n", GUTIL.COLORS.LEGENDARY))
		tt:AddLine(GUTIL:ColorizeText("Click to Open!", GUTIL.COLORS.WHITE))
	end

	PvPAssistantLibIconDB = PvPAssistantLibIconDB or {}

	LibIcon:Register("PvPAssistant", ldb, PvPAssistantLibIconDB)
end

function PvPAssistant.MAIN:Init()
	PvPAssistant.DB:Init()

	PvPAssistant.MAIN:InitializeSlashCommands()
	PvPAssistant.OPTIONS:Init()
	PvPAssistant.ARENA_GUIDE.FRAMES:Init()
	PvPAssistant:InitializeMinimapButton()
	PvPAssistant.PLAYER_TOOLTIP:Init()
	PvPAssistant.SPELL_TOOLTIP:Init()

	PvPAssistant.GGUI:InitializePopup {
		backdropOptions = PvPAssistant.CONST.MAIN_FRAME_BACKDROP,
		sizeX = 150, sizeY = 100,
		buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.TAB_BUTTON,
		buttonFontOptions = {
			fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
		},
		hideCloseButton = true,
	}

	-- restore frame positions
	PvPAssistant.ARENA_GUIDE.frame:RestoreSavedConfig(UIParent)
end

function PvPAssistant.MAIN:InitializeSlashCommands()
	SLASH_PvPAssistant1 = "/PvPAssistant"
	SLASH_PvPAssistant2 = "/pa"
	SlashCmdList["PvPAssistant"] = function(input)
		input = SecureCmdOptionParse(input)
		if not input then return end

		local command, rest = input:match("^(%S*)%s*(.-)$")
		command = command and command:lower()
		rest = (rest and rest ~= "") and rest:trim() or nil

		if command == "config" then
			InterfaceOptionsFrame_OpenToCategory(PvPAssistant.OPTIONS.optionsPanel)
		end

		if command == "history" and rest == "clear" then
			print(f.l("PvPAssistant") .. ": Match History Cleared")
			PvPAssistant.DB.MATCH_HISTORY:Clear()
			PvPAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()
		end

		if command == "tooltips" and rest == "clear" then
			print(f.l("PvPAssistant ") .. ": Player Tooltip Data Cleared")
			PvPAssistant.DB.PLAYER_DATA:Clear()
		end

		if command == "characters" and rest == "clear" then
			print(f.l("PvPAssistant ") .. ": Character Data Cleared")
			PvPAssistant.DB.CHARACTER_DATA:Clear()
		end

		if command == "guide" then
			if C_PvP.IsArena() then
				PvPAssistant.ARENA_GUIDE.frame:Show()
				PvPAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
			else
				print(f.l("PvPAssistant ") .. ": Arena Guide is only available in Arena Matches")
			end
		end

		if command == "debug" then
			PvPAssistantOptions.enableDebug = not PvPAssistantOptions.enableDebug
			print(f.l("PvPAssistant ") .. ": Toggle Debug Mode " .. tostring(PvPAssistantOptions.enableDebug))
		end

		if command == "" then
			PvPAssistant.MAIN_FRAME.frame:Show()
		end
	end
end

function PvPAssistant.MAIN:ADDON_LOADED(addon_name)
	if addon_name ~= PvPAssistantName then
		return
	end
	PvPAssistant.MAIN:Init()
end

function PvPAssistant.MAIN:PLAYER_ENTERING_WORLD()
	PvPAssistant.DB.CHARACTER_DATA:Init() -- on addon load not yet accessible
	PvPAssistant.MAIN_FRAME.FRAMES:Init() -- dep: character data
	PvPAssistant.MAIN_FRAME.FRAMES:InitMatchHistoryTooltipFrame()
	PvPAssistant.MAIN_FRAME.frame:RestoreSavedConfig(UIParent)


	PvPAssistant.SPEC_LOOKUP:Init()

	PvPAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()

	PvPAssistant.MAIN.enableCombatLog = false
end

---@class SpecializationInfo
---@field id number
---@field name string
---@field description string
---@field icon string
---@field role string
---@field class ClassFile

function PvPAssistant.MAIN:PLAYER_JOINED_PVP_MATCH()
	if not PvPAssistant.MAIN.enableCombatLog then
		debug("PvPAssistant: Joined PvP Match")
		debug("LoggingCombat: " .. tostring(LoggingCombat(true)))

		PvPAssistant.MAIN.enableCombatLog = true
	end
end

function PvPAssistant.MAIN:PVP_MATCH_COMPLETE()
	debug("PvPAssistant: PvP Match Completed")
	debug("LoggingCombat: " .. tostring(LoggingCombat(false)))

	debug("PvPAssistant: Saving Match Data...")
	local matchHistory = PvPAssistant.MatchHistory:CreateFromEndScreen()
	PvPAssistant.DB.MATCH_HISTORY:Save(matchHistory)

	PvPAssistant.MAIN_FRAME.FRAMES:UpdateMatchHistory()
end
