---@type PvPAssistant
local PvPAssistant = select(2, ...)

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

local PVPUI_ADDON_NAME = "Blizzard_PVPUI"

local GameTooltip = GameTooltip
local NewTicker = C_Timer.NewTicker
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local InCombatLockdown = InCombatLockdown
local UnitAffectingCombat = UnitAffectingCombat
local IsControlKeyDown = IsControlKeyDown
local IsAltKeyDown = IsAltKeyDown

local function InCombat()
    return InCombatLockdown() or UnitAffectingCombat("player")
end

local function GetGroupSizeButton()
    local numMembers = GetNumSubgroupMembers(1)
    if numMembers == 0 then
        return ConquestFrame.RatedSoloShuffle
    elseif numMembers == 1 then
        return ConquestFrame.Arena2v2
    elseif numMembers == 2 then
        return ConquestFrame.Arena3v3
    elseif numMembers == CONQUEST_SIZES[4] - 1 then
        return ConquestFrame.RatedBG
    end
end

local function GetSelectedBracketName(selectedBracketButton)
    if selectedBracketButton == ConquestFrame.RatedSoloShuffle then
        return PVP_RATED_SOLO_SHUFFLE
    elseif selectedBracketButton == ConquestFrame.Arena2v2 then
        return ARENA_2V2
    elseif selectedBracketButton == ConquestFrame.Arena3v3 then
        return ARENA_3V3
    elseif selectedBracketButton == ConquestFrame.RatedBG then
        return BATTLEGROUND_10V10
    end
end

local function ShowTooltipStateInfo(self, selectedBracketButton)
    GameTooltip:ClearLines()

    if not self:IsActivated() then
        GameTooltip:AddLine("Activate the quick join button by opening the PvP UI once.")
    else
        local isFrameVisible = PVEFrame:IsVisible()
        local groupSizeButton = GetGroupSizeButton()
    
        if (IsControlKeyDown() or IsAltKeyDown()) and not isFrameVisible then
            if IsControlKeyDown() then
                GameTooltip:AddLine("Open PvP Rated tab.")
            elseif IsAltKeyDown() then
                GameTooltip:AddLine("Open the PvP Quick Match tab.")
            end
        elseif isFrameVisible then
            GameTooltip:AddLine(("Close the %s frame."):format(DUNGEONS_BUTTON))
        elseif groupSizeButton ~= selectedBracketButton then
            if ConquestJoinButton:IsEnabled() then
                GameTooltip:AddLine(RED_FONT_COLOR:WrapTextInColorCode(
                    "Click to open the PvP Rated tab, \nto select a bracket that matches your group size."))
            else
                GameTooltip:AddLine(RED_FONT_COLOR:WrapTextInColorCode(("Cannot join the selected bracket. The %s button is disabled.")
                    :format(BATTLEFIELD_JOIN)))
            end
        else
            local bracketName = GetSelectedBracketName(selectedBracketButton)
            if bracketName then
                GameTooltip:AddLine(GREEN_FONT_COLOR:WrapTextInColorCode(("Click to queue to %s."):format(BLUE_FONT_COLOR
                    :WrapTextInColorCode(bracketName))))
            end
        end
    end

    GameTooltip:Show()
end

local joinMacroButton, configureMacroButton, selectedBracketButton, eventsRegistered
frame:SetScript("OnEvent", function(_, eventName, ...)
    if eventName == "PLAYER_LOGIN" then
        do
            local parent = PvPAssistant.MAIN_FRAME:GetParentFrame()
            
            joinMacroButton = CreateFrame("Button", "PvPAssistant_ArenaQuickJoinMacroButton", parent,
                "SecureActionButtonTemplate, SecureHandlerStateTemplate, ActionButtonTemplate")

            local function RegisterEvents()
                frame:RegisterEvent("ADDON_LOADED")
                frame:RegisterEvent("PLAYER_REGEN_DISABLED")
                frame:RegisterEvent("PLAYER_REGEN_ENABLED")
                frame:RegisterEvent("GROUP_ROSTER_UPDATE")
                frame:RegisterEvent("MODIFIER_STATE_CHANGED")
                eventsRegistered = true
            end
        
            local function UnregisterEvents()
                frame:UnregisterEvent("ADDON_LOADED")
                frame:UnregisterEvent("PLAYER_REGEN_DISABLED")
                frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
                frame:UnregisterEvent("GROUP_ROSTER_UPDATE")
                frame:UnregisterEvent("MODIFIER_STATE_CHANGED")
                eventsRegistered = false
            end

            function joinMacroButton:Active(style)
                if style == "show" then
                    self:SetAlpha(1)
                elseif style == "normal" then
                    -- NOTE: Can't be called during combat.
                    self:RegisterForClicks('AnyUp', 'AnyDown')
                    self.icon:SetDesaturated(false)
                else
                    -- NOTE: Can't be called during combat.
                    self:Show()
                    local _, isLoaded = IsAddOnLoaded(PVPUI_ADDON_NAME)
                    if isLoaded then
                        self:Active("normal")
                    end
                    if not eventsRegistered then
                        RegisterEvents()
                    end
                end
            end

            function joinMacroButton:Inactive(style)
                if style == "hide" then
                    self:SetAlpha(0)
                elseif style == "grayout" then
                    -- NOTE: Can't be called during combat.
                    -- NOTE: We're using RegisterForClicks as opposed to Disable because when it's truly disabled OnEnter and OnLeave aren't fired.
                    self:RegisterForClicks()
                    self.icon:SetDesaturated(true)
                else
                    -- NOTE: Can't be called during combat.
                    self:Hide()
                    self:Inactive("grayout")
                    UnregisterEvents()
                end
            end

            function joinMacroButton:IsActivated()
                local _, isLoaded = IsAddOnLoaded(PVPUI_ADDON_NAME)
                return isLoaded and self:IsVisible()
            end

            function joinMacroButton:SetTexture(texture)
                self.icon:SetTexture("Interface\\Icons\\" .. texture)
            end

            joinMacroButton:SetPoint("TOP", parent, "TOP", 275, -35)
            joinMacroButton:SetSize(45, 45)
            joinMacroButton:SetScale(.6)
            joinMacroButton:SetTexture("achievement_bg_killxenemies_generalsroom")
            joinMacroButton:SetAttribute("type", "macro")
            joinMacroButton:Inactive()
        end

        do
            local tooltipHandle

            local tooltip = function()
                ShowTooltipStateInfo(joinMacroButton, selectedBracketButton)
            end

            local showAndUpdateTooltip = function()
                tooltipHandle = NewTicker(0, tooltip)
            end

            local hideTooltip = function()
                if tooltipHandle then
                    tooltipHandle:Cancel()
                end
                GameTooltip:Hide()
            end

            joinMacroButton:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 0)
                showAndUpdateTooltip()
            end)

            joinMacroButton:SetScript("OnLeave", hideTooltip)
        end
    elseif eventName == "ADDON_LOADED" then
        local arg1 = ...

        if arg1 ~= PVPUI_ADDON_NAME then
            return
        end

        configureMacroButton = function(self)
            self:Active()
            
            self:SetFrameRef("PVEFrame", PVEFrame)
            self:SetFrameRef("GroupSizeButton", GetGroupSizeButton())
            self:SetFrameRef("ConquestJoinButton", ConquestJoinButton)

            do
                local NO_OP_BUTTON = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
                hooksecurefunc("ConquestFrame_SelectButton", function(frameSelectedButton)
                    if InCombat() then return end
                    if ConquestJoinButton:IsEnabled() then
                        selectedBracketButton = frameSelectedButton
                        self:SetFrameRef("SelectedButton", frameSelectedButton)
                    else
                        selectedBracketButton = NO_OP_BUTTON
                        self:SetFrameRef("SelectedButton", NO_OP_BUTTON)
                    end
                end)
            end

            SecureHandlerWrapScript(self, "OnClick", self, [[
                local PVEFrame = self:GetFrameRef("PVEFrame")
                local SelectedButton = self:GetFrameRef("SelectedButton")
                local GroupSizeButton = self:GetFrameRef("GroupSizeButton")

                if PVEFrame:IsVisible() then
                    self:SetAttribute("macrotext", "/click LFDMicroButton")
                elseif IsAltKeyDown() then
                    self:SetAttribute("macrotext", "/click LFDMicroButton\n/click PVEFrameTab2\n/click PVPQueueFrameCategoryButton1")
                elseif GroupSizeButton ~= SelectedButton or IsControlKeyDown() then
                    self:SetAttribute("macrotext", "/click LFDMicroButton\n/click PVEFrameTab2\n/click PVPQueueFrameCategoryButton2")
                else
                    self:SetAttribute("macrotext", "/click ConquestJoinButton")
                end
            ]])

            frame:UnregisterEvent("ADDON_LOADED")
            configureMacroButton = nil
        end

        if not InCombat() then
            configureMacroButton(joinMacroButton)
        end
    elseif joinMacroButton:IsActivated() then
        if eventName == "GROUP_ROSTER_UPDATE" then
            joinMacroButton:SetFrameRef("GroupSizeButton", GetGroupSizeButton())
        elseif eventName == "PLAYER_REGEN_DISABLED" then
            joinMacroButton:Inactive("grayout")
        elseif eventName == "PLAYER_REGEN_ENABLED" then
            if configureMacroButton then
                configureMacroButton(joinMacroButton)
            end
            joinMacroButton:Active("normal")
        elseif eventName == "MODIFIER_STATE_CHANGED" then
            local key, down = ...
            if down == 1 and (key == "LALT" or key == "RALT") then
                joinMacroButton:SetTexture("achievement_bg_winwsg")
            else
                joinMacroButton:SetTexture("achievement_bg_killxenemies_generalsroom")
            end
        end
    end
end)
