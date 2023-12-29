local PvPLookupName = select(1, ...)
---@class PvPLookup
local PvPLookup = select(2, ...)

local GUTIL = PvPLookup.GUTIL
local GGUI = PvPLookup.GGUI

---@class PvPLookup.Main : Frame
PvPLookup.MAIN = GUTIL:CreateRegistreeForEvents({"ADDON_LOADED", "PLAYER_ENTERING_WORLD"})

PvPLookup.MAIN.FRAMES = {}

function PvPLookup:InitializeMinimapButton()
	local LibIcon = LibStub("LibDBIcon-1.0")
	local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("Bunnies!", {
		type = "data source",
		--tooltip = "PvPLookup",
		label = "PvPLookup",
		tocname = "PvPLookup",
		icon = "Interface\\Addons\\PvPLookup\\Media\\Images\\logo1024",
		OnClick = function() 
			local historyFrame = GGUI:GetFrame(PvPLookup.MAIN.FRAMES, PvPLookup.CONST.FRAMES.HISTORY_FRAME)
			if historyFrame then
				historyFrame:SetVisible(not historyFrame:IsVisible())
			end
		end,
		})

		PvPLookupLibIconDB = PvPLookupLibIconDB or {}
	
		LibIcon:Register("PvPLookup", ldb, PvPLookupLibIconDB)
end

function PvPLookup.MAIN:Init()
	PvPLookup.NEWS:Init()
	PvPLookup.MAIN:InitializeSlashCommands()
	PvPLookup.OPTIONS:Init()
	PvPLookup.HISTORY.FRAMES:Init()	
	PvPLookup:InitializeMinimapButton()
	

	-- restore frame positions
	---@type GGUI.Frame
	local historyFrame = PvPLookup.GGUI:GetFrame(PvPLookup.MAIN.FRAMES, PvPLookup.CONST.FRAMES.HISTORY_FRAME)
	historyFrame:RestoreSavedConfig(UIParent)
	---@type GGUI.Frame
	local newsFrame = PvPLookup.GGUI:GetFrame(PvPLookup.MAIN.FRAMES, PvPLookup.CONST.FRAMES.NEWS)
	newsFrame:RestoreSavedConfig(UIParent)

	-- show news
	--PvPLookup.NEWS:ShowNews() -- TODO: necessary or scrap?
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

		if command == "news" then
			PvPLookup.NEWS:ShowNews(true)
		end

		if command == "" then
			local historyFrame = GGUI:GetFrame(PvPLookup.MAIN.FRAMES, PvPLookup.CONST.FRAMES.HISTORY_FRAME)

			if historyFrame then
				historyFrame:Show()
			end
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
	PvPLookup.HISTORY:UpdateHistory()
end
