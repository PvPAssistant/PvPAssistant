---@diagnostic disable: inject-field
---@class PvPAssistant
local PvPAssistant = select(2, ...)
local addonName = ...

local GGUI = PvPAssistant.GGUI
local GUTIL = PvPAssistant.GUTIL
local f = GUTIL:GetFormatter()

---@class PvPAssistant.PLAYERRECOMMENDATION
PvPAssistant.PLAYERRECOMMENDATION = PvPAssistant.PLAYERRECOMMENDATION

---@class PvPAssistant.PLAYERRECOMMENDATION.Frames
PvPAssistant.PLAYERRECOMMENDATION.FRAMES = {}

function PvPAssistant.PLAYERRECOMMENDATION.FRAMES:Init()
    local frame = GGUI.Frame {
        moveable = true,
        sizeX = 225,
        sizeY = 200,
        backdropOptions = PvPAssistant.CONST.PVPINFO_BACKDROP,
        title = "Rate Participant",
        closeable = true,
    }
    local initialData, labels = {}, { "Bad", "Decent", "Good", "Great", "Amazing!" }
    for i = 1, 5 do
        local label = string.format("|A:Professions-ChatIcon-Quality-Tier%d:16:16|a |c%s%s|r", i,
            select(4, C_Item.GetItemQualityColor(i)), labels[i])
        tinsert(initialData, { value = i, label = label })
    end
    frame.content.playerList = GGUI.CustomDropdown {
        parent = frame.content, anchorParent = frame.title.frame,
        anchorA = "TOP", anchorB = "BOTTOM", width = 140, offsetY = -10,
        buttonOptions = {
            parent = frame.content,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = 20,
            scale = 1,
        },
        clickCallback = function(_, _, selectionGUID)
            local selectionData = PvPAssistant.DB.RECOMMENDATION_DATA:Get(selectionGUID)
            local rating, note = 1, ""
            if selectionData then
                rating = selectionData.rating or 1
                note = selectionData.note or ""
            end
            frame.content.ratingList.button:SetText(initialData[rating].label)
            frame.content.ratingList.selectedValue = rating
            frame.content.noteInput:SetText(note)
        end,
        arrowOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPAssistant.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = 1,
        }
    }
    frame.content.ratingList = GGUI.CustomDropdown {
        parent = frame.content, anchorParent = frame.title.frame,
        anchorA = "TOP", anchorB = "BOTTOM", width = 140, offsetY = -35,
        buttonOptions = {
            parent = frame.content,
            buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN,
            fontOptions = {
                fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
            },
            sizeY = 20,
            scale = 1,
        },
        arrowOptions = PvPAssistant.CONST.ASSETS.BUTTONS.DROPDOWN_ARROW_OPTIONS,
        selectionFrameOptions = {
            backdropOptions = PvPAssistant.CONST.DROPDOWN_SELECTION_FRAME_BACKDROP,
            scale = 1,
        },
        initialData = initialData
    }

    frame.content.inputLabel = GGUI.Text({
        parent = frame.content,
        anchorParent = frame.title.frame,
        text = "Short Note:",
        offsetY = -65,
        anchorA = "TOP",
        anchorB = "BOTTOM",
    })

    frame.content.noteInput = GGUI.TextInput {
        parent = frame.content, anchorParent = frame.title.frame,
        anchorA = "TOP", anchorB = "BOTTOM", sizeX = 140, offsetY = -80,
    }
    frame.content.saveButton = GGUI.Button({
        parent = frame.content,
        buttonTextureOptions = PvPAssistant.CONST.ASSETS.BUTTONS.MAIN_BUTTON,
        fontOptions = {
            fontFile = PvPAssistant.CONST.FONT_FILES.ROBOTO,
        },
        anchorParent = frame.title.frame,
        anchorA = "TOP",
        anchorB = "BOTTOM",
        offsetY = -115,
        label = "Save",
        sizeX = 140,
        sizeY = 20,
        clickCallback = function()
            local unitGUID = frame.content.playerList.selectedValue
            if not unitGUID then return end
            local unitName = frame.content.playerList.button.frame:GetText()
            local rating = frame.content.ratingList.selectedValue
            local note = frame.content.noteInput:GetText()
            PvPAssistant.DB.RECOMMENDATION_DATA:Save(unitGUID, { rating = rating, note = note })
            print(string.format("%s: Saved data for %s", f.bb(addonName), unitName))
        end,
    })
    frame:Hide()
    self.RecommendationFrame = frame
end

function PvPAssistant.PLAYERRECOMMENDATION.FRAMES:OpenFrame(units)
    local unitDropdown = {}
    for _, unitInfo in ipairs(units) do
        local nameStr = ("|A:classicon-%s:16:16|a |c%s%s"):format(unitInfo.classToken:lower(),
            select(4, GetClassColor(unitInfo.classToken)), unitInfo.name:match("([^-]+)"))
        tinsert(unitDropdown, { value = unitInfo.guid, label = nameStr })
    end
    self.RecommendationFrame.content.playerList:SetData({
        data = unitDropdown,
        initialLabel = "Select a Player"
    })
    self.RecommendationFrame:Show()
end
