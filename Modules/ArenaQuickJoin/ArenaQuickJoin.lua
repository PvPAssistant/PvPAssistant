---@type PvPAssistant
local PvPAssistant = select(2, ...)

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")

local PVPUI_ADDON_NAME = "Blizzard_PVPUI"

local GameTooltip = GameTooltip
local NewTicker = C_Timer.NewTicker
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local UIParentLoadAddOn = UIParentLoadAddOn
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

local function ShowTooltipStateInfo(selectedBracketButton)
    GameTooltip:ClearLines()

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

    GameTooltip:Show()
end

local joinMacroButton, configureMacroButton, selectedBracketButton
frame:SetScript("OnEvent", function(_, eventName, ...)
    if eventName == "PLAYER_LOGIN" then
        do
            local parent = PvPAssistant.MAIN_FRAME:GetParentFrame()

            joinMacroButton = CreateFrame("Button", "PvPAssistant_ArenaQuickJoinMacroButton", parent,
                "SecureActionButtonTemplate, SecureHandlerStateTemplate, ActionButtonTemplate")

            function joinMacroButton:Active(style)
                if style == "show" then
                    self:SetAlpha(1)
                elseif style == "normal" then
                    -- NOTE: Can't be called during combat
                    self:Enable()
                    self.icon:SetDesaturated(false)
                else
                    -- NOTE: Can't be called during combat
                    frame:RegisterEvent("ADDON_LOADED")
                    frame:RegisterEvent("PLAYER_REGEN_DISABLED")
                    frame:RegisterEvent("PLAYER_REGEN_ENABLED")
                    frame:RegisterEvent("GROUP_ROSTER_UPDATE")
                    frame:RegisterEvent("MODIFIER_STATE_CHANGED")
                    local _, isLoaded = IsAddOnLoaded(PVPUI_ADDON_NAME)
                    if not isLoaded then
                        UIParentLoadAddOn(PVPUI_ADDON_NAME)
                    end
                    self:Show()
                end
            end

            function joinMacroButton:Inactive(style)
                if style == "hide" then
                    self:SetAlpha(0)
                elseif style == "grayout" then
                    -- NOTE: Can't be called during combat
                    self:Disable()
                    self.icon:SetDesaturated(true)
                else
                    -- NOTE: Can't be called during combat
                    self:Hide()
                    self:Inactive("grayout")
                    frame:UnregisterEvent("ADDON_LOADED")
                    frame:UnregisterEvent("PLAYER_REGEN_DISABLED")
                    frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
                    frame:UnregisterEvent("GROUP_ROSTER_UPDATE")
                    frame:UnregisterEvent("MODIFIER_STATE_CHANGED")
                end
            end

            function joinMacroButton:CanBeActivated()
                return not InCombat()
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
            joinMacroButton:RegisterForClicks('AnyUp', 'AnyDown')
            joinMacroButton:SetTexture("achievement_bg_killxenemies_generalsroom")
            joinMacroButton:SetAttribute("type", "macro")
            joinMacroButton:Inactive()
        end

        do
            local tooltipHandle

            local tooltip = function()
                ShowTooltipStateInfo(selectedBracketButton)
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
            self:Active("normal")

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

            configureMacroButton = nil
        end

        if not InCombat() then
            configureMacroButton(joinMacroButton)
        end
    elseif eventName == "GROUP_ROSTER_UPDATE" then
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
end)
