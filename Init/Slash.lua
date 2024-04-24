---@class PvPAssistant
local PvPAssistant = select(2, ...)

local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()
local debug = PvPAssistant.DEBUG:GetDebugPrint()

---@class PvPAssistant.Init : Frame
PvPAssistant.SLASH = {}

function PvPAssistant.SLASH:Init()
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
            PvPAssistant.DB.MATCH_HISTORY:ClearAll()
            PvPAssistant.MATCH_HISTORY.FRAMES:UpdateMatchHistory()
        end

        if command == "characters" and rest == "clear" then
            print(f.l("PvPAssistant ") .. ": Character Data Cleared")
            PvPAssistant.DB.CHARACTERS:Clear()
        end

        if command == "arenaguide" then
            if C_PvP.IsArena() or PvPAssistant.ARENA_GUIDE.debug then
                PvPAssistant.ARENA_GUIDE.frame:Show()
                PvPAssistant.ARENA_GUIDE.FRAMES:UpdateDisplay()
            else
                print(f.l("PvPAssistant ") .. ": Arena Guide is only available in Arena Matches")
            end
        end
        if command == "debug" and rest == "clear" then
            PvPAssistant.DB.DEBUG:Clear()
            print(f.l("PvPAssistant ") .. ": DebugDB cleared!")
        elseif command == "debug" then
            local debugEnabled = PvPAssistant.DB.GENERAL_OPTIONS:Get("DEBUG")
            PvPAssistant.DB.GENERAL_OPTIONS:Save("DEBUG", not debugEnabled)
            print(f.l("PvPAssistant ") .. ": Toggle Debug Mode " .. tostring(debugEnabled))
        end



        if command == "" then
            PvPAssistant.MAIN_FRAME.frame:Show()
        end
    end
end
