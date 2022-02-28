--[[
    Created by iThorgrim

        Parangon with Interface

 You are going to use a script shared by myself (iThorgrim) so i would ask you to respect my work and not to assign this work to you.
 If you want to learn more about World of Warcraft development.

 (Only for French speaking people.)
 Open-Wow -> https://open-wow.eu
 Discord -> https://discord.gg/JUYgbNMwQu

 If you wish to thank me for my work you can make a small donation.
 Paypal ->

 Thank you for using my script, if you have a suggestion or a problem with it please make a topic about it:
 Issues -> https://github.com/iThorgrim-Hub/lua-aio-parangon/issues

 See you soon for a next script.
]]--

local AIO = AIO or require("AIO");
if AIO.AddAddon() then
  return
end

local parangon = {}
local parangon_addon = AIO.AddHandlers("AIO_Parangon", {})

parangon.mainWindow = CreateFrame("Frame", parangon.mainWindow, UIParent)
  parangon.mainWindow:SetSize(300, 500)
  parangon.mainWindow:SetMovable(false)
  parangon.mainWindow:EnableMouse(true)
  parangon.mainWindow:RegisterForDrag("Right_Button")
  parangon.mainWindow:SetPoint("CENTER", 0, 50)
  parangon.mainWindow:Hide()

parangon.mainWindowTexture = parangon.mainWindow:CreateTexture()
  parangon.mainWindowTexture:SetAllPoints(parangon.mainWindow)
  parangon.mainWindowTexture:SetTexture("interface/parangon/parangon_frame")
  parangon.mainWindowTexture:SetTexCoord(0.58154296875, 0.96435546875, 0.04052734375, 0.81201171875)

parangon.mainTitle = CreateFrame("Frame", parangon.mainTitle, parangon.mainWindow)
  parangon.mainTitle:SetSize(150, 45)
  parangon.mainTitle:SetPoint("TOP", 0, 20)
  parangon.mainTitle:SetFrameLevel(parangon.mainWindow:GetFrameLevel() + 1)

parangon.mainTitleTexture = parangon.mainWindow:CreateTexture()
  parangon.mainTitleTexture:SetAllPoints(parangon.mainTitle)
  parangon.mainTitleTexture:SetTexture("interface/parangon/parangon_frame")
  parangon.mainTitleTexture:SetParent(parangon.mainTitle)
  parangon.mainTitleTexture:SetTexCoord(0.23486328125, 0.48779296875, 0.33251953125, 0.40966796875)

parangon.mainTitleText = parangon.mainTitle:CreateFontString(parangon.mainTitleText)
  parangon.mainTitleText:SetFont("Fonts\\FRIZQT__.TTF", 13)
  parangon.mainTitleText:SetSize(190, 5)
  parangon.mainTitleText:SetPoint("CENTER", 0, 3)
  parangon.mainTitleText:SetText("|CFF000000Parangon|r")

parangon.mainWindowArt = CreateFrame("Button", parangon.mainWindowArt, parangon.mainWindow)
  parangon.mainWindowArt:SetSize(140, 100)
  parangon.mainWindowArt:SetPoint("TOP", -70, -80)
  parangon.mainWindowArt:SetFrameLevel(1)
  parangon.mainWindowArt:SetAlpha(0.4)
  parangon.mainWindowArt:SetFrameLevel(2)

parangon.mainWindowArtTexture = parangon.mainWindowArt:CreateTexture()
  parangon.mainWindowArtTexture:SetAllPoints(parangon.mainWindowArt)
  parangon.mainWindowArtTexture:SetTexture("interface/parangon/parangon_frame")
  parangon.mainWindowArtTexture:SetTexCoord(0.00048828125, 0.35009765625, 0.00048828125, 0.21435546875)

parangon.levelWindow = CreateFrame("Frame", parangon.levelWindow, parangon.mainWindow)
  parangon.levelWindow:SetSize(95, 90)
  parangon.levelWindow:SetPoint("TOP", 0, -30)
  parangon.levelWindow:SetFrameLevel(2)

parangon.levelWindowTexture = parangon.levelWindow:CreateTexture()
  parangon.levelWindowTexture:SetAllPoints(parangon.levelWindow)
  parangon.levelWindowTexture:SetTexture("interface/parangon/parangon_frame")
  parangon.levelWindowTexture:SetTexCoord(0.05419921875, 0.17431640625, 0.31201171875, 0.42724609375)

parangon.levelText = parangon.levelWindow:CreateFontString(parangon.levelText)
  parangon.levelText:SetFont("Fonts\\FRIZQT__.TTF", 18)
  parangon.levelText:SetSize(190, 3)
  parangon.levelText:SetPoint("CENTER", -2, 1)
  parangon.levelText:SetShadowColor(0.156, 0.2, 0.2)
  parangon.levelText:SetShadowOffset(0.5, 0)

parangon.closeButton = CreateFrame("Button", parangon.closeButton, parangon.mainWindow, "UIPanelCloseButton")
  parangon.closeButton:SetPoint("TOPRIGHT", 1.5, 3)
  parangon.closeButton:EnableMouse(true)
  parangon.closeButton:SetSize(26, 26)
  parangon.closeButton:SetFrameLevel(2)

parangon.expIcon = CreateFrame("Frame", parangon.expIcon, parangon.mainWindow)
  parangon.expIcon:SetSize(39, 39)
  parangon.expIcon:SetBackdrop({
    bgFile = "Interface/Icons/garr_currencyicon-xp",
    insets = { left = 0, right = 0, top = 0, bottom = 0 }
  })
  parangon.expIcon:SetPoint("TOP", 0, -115)
  parangon.expIcon:SetFrameLevel(6)


parangon.expText = parangon.mainWindow:CreateFontString(parangon.expText)
  parangon.expText:SetFont("Fonts\\FRIZQT__.TTF", 13)
  parangon.expText:SetSize(190, 3)
  parangon.expText:SetPoint("TOP", 0, -155)
  parangon.expText:SetShadowColor(0.156, 0.2, 0.2)
  parangon.expText:SetShadowOffset(0.5, 0)


parangon.buttonsCoords = {
  global = {
    pos_y = 50
  }
}

parangon.leftButtons = {}
parangon.leftButtonsTexture = {}

parangon.leftButtonsArt = {}

parangon.centerButtons = {}
parangon.centerText = {}

parangon.rightButtons = {}
parangon.rightButtonsTexture = {}
parangon.rightText = {}

parangon.spellsList = {
  [7464] = {name = 'Strength', icon = '_D3mantraofconviction'},
  [7471] = {name = 'Agility', icon = '_D3mantraofevasion'},
  [7477] = {name = 'Stamina', icon = '_D3mantraofretribution'},
  [7468] = {name = 'Intellect', icon = '_D3mantraofhealing'},
}

for id, subtable in pairs(parangon.spellsList) do
  parangon.leftButtons[id] = CreateFrame("Frame", parangon.leftButtons[id], parangon.mainWindow)
    parangon.leftButtons[id]:SetSize(50, 50)
    parangon.leftButtons[id]:SetPoint("LEFT", 20, parangon.buttonsCoords.global.pos_y)
    parangon.leftButtons[id]:SetFrameLevel(1000)
    parangon.leftButtons[id]:SetFrameLevel(3)

  parangon.leftButtonsTexture[id] = parangon.leftButtons[id]:CreateTexture()
    parangon.leftButtonsTexture[id]:SetAllPoints(parangon.leftButtons[id])
    parangon.leftButtonsTexture[id]:SetTexture("Interface/parangon/ButtonBorder")

  parangon.leftButtonsArt[id] = CreateFrame("Frame", parangon.leftButtonsArt[id], parangon.leftButtons[id], nil)
  parangon.leftButtonsArt[id]:SetSize(35, 35)
  parangon.leftButtonsArt[id]:SetBackdrop(
    {
      bgFile = "Interface/Icons/"..subtable.icon,
      insets = {left = 0, right = 0, top = 0, bottom = 0}
    }
  )
  parangon.leftButtonsArt[id]:SetPoint("CENTER", 0, 0)
  parangon.leftButtonsArt[id]:SetFrameLevel(2)

  parangon.centerButtons[id] = CreateFrame("Button", parangon.centerButtons[id], parangon.mainWindow, nil)
    parangon.centerButtons[id]:SetSize(170, 55)
    parangon.centerButtons[id]:SetPoint("CENTER", 0, parangon.buttonsCoords.global.pos_y)
    parangon.centerButtons[id]:SetNormalTexture("Interface/Parangon/LargeButtonBorder")
    parangon.centerButtons[id]:SetHighlightTexture("Interface/Parangon/LargeButtonBorder_Hover")
    parangon.centerButtons[id]:SetPushedTexture("Interface/Parangon/LargeButtonBorder_Push")
    parangon.centerButtons[id]:EnableMouseWheel(1)
    parangon.centerButtons[id]:SetFrameLevel(3)

  parangon.centerButtons[id]:SetScript("OnMouseUp", function(self, button, down)
    if (button == "LeftButton") then
      AIO.Handle("AIO_Parangon", "setStatsInformation", id, 1, true)
    elseif (button == "RightButton") then
      AIO.Handle("AIO_Parangon", "setStatsInformation", id, 1, false)
    elseif (button == "MiddleButton") then
      AIO.Handle("AIO_Parangon", "setStatsInformation", id, 10, true)
    end
  end)

  parangon.centerButtons[id]:SetScript("OnMouseWheel", function(self, value)
    if (value > 0) then
      AIO.Handle("AIO_Parangon", "setStatsInformation", id, 1, true)
    else
      AIO.Handle("AIO_Parangon", "setStatsInformation", id, 1, false)
    end
  end)

  parangon.centerText[id] = parangon.centerButtons[id]:CreateFontString(parangon.centerText[id])
    parangon.centerText[id]:SetFont("Interface/Fonts/MARCELLUS.TTF", 14)
    parangon.centerText[id]:SetSize(190, 3)
    parangon.centerText[id]:SetPoint("CENTER", -1, 1)
    parangon.centerText[id]:SetText("|CFFFFFFFF"..subtable.name.."|r")
    parangon.centerText[id]:SetShadowColor(0, 0, 0)
    parangon.centerText[id]:SetShadowOffset(0.5, 0.5)

  parangon.rightButtons[id] = CreateFrame("Frame", parangon.rightButtons[id], parangon.mainWindow)
    parangon.rightButtons[id]:SetSize(50, 50)
    parangon.rightButtons[id]:SetPoint("Right", -20, parangon.buttonsCoords.global.pos_y)
    parangon.rightButtons[id]:SetFrameLevel(1000)
    parangon.rightButtons[id]:SetFrameLevel(3)

  parangon.rightText[id] = parangon.rightButtons[id]:CreateFontString(parangon.rightText[id])
    parangon.rightText[id]:SetFont("Fonts/FRIZQT__.TTF", 14)
    parangon.rightText[id]:SetSize(190, 3)
    parangon.rightText[id]:SetPoint("CENTER", 0.5, 0)
    parangon.rightText[id]:SetShadowColor(0, 0, 0)
    parangon.rightText[id]:SetShadowOffset(0.5, 0)

  parangon.rightButtonsTexture[id] = parangon.rightButtons[id]:CreateTexture()
    parangon.rightButtonsTexture[id]:SetAllPoints(parangon.rightButtons[id])
    parangon.rightButtonsTexture[id]:SetTexture("Interface/parangon/ButtonBorder")

  parangon.buttonsCoords.global.pos_y = parangon.buttonsCoords.global.pos_y - 60
end

parangon.pointsLeft = parangon.mainWindow:CreateFontString(parangon.pointsLeft)
  parangon.pointsLeft:SetFont("Fonts/FRIZQT__.TTF", 12)
  parangon.pointsLeft:SetSize(999, 3)
  parangon.pointsLeft:SetPoint("BOTTOM", 0, 75)
  parangon.pointsLeft:SetShadowColor(0, 0, 0)
  parangon.pointsLeft:SetShadowOffset(1, 1)

parangon.saveButton = CreateFrame("Button", parangon.saveButton, parangon.mainWindow)
  parangon.saveButton:SetSize(150, 35)
  parangon.saveButton:SetNormalTexture("Interface/buttons/ui-dialogbox-button-gold-up")
  parangon.saveButton:SetHighlightTexture("Interface/buttons/ui-dialogbox-button-highlight")
  parangon.saveButton:SetPushedTexture("Interface/buttons/ui-dialogbox-button-gold-down")
  parangon.saveButton:SetPoint("BOTTOM", 0, 20)
  parangon.saveButton:SetFrameLevel(2)

parangon.saveButton:SetScript("OnMouseUp", function(self, button, down)
  if (button == "LeftButton") then
    parangon.mainWindow:Hide()
    AIO.Handle("AIO_Parangon", "setStats")
  end
end)

parangon.saveButtonText = parangon.saveButton:CreateFontString(parangon.saveButtonText)
  parangon.saveButtonText:SetFont("Fonts/FRIZQT__.TTF", 12)
  parangon.saveButtonText:SetSize(180, 3)
  parangon.saveButtonText:SetPoint("CENTER", 0, 6)
  parangon.saveButtonText:SetText("|CFFFFFFFFAccept changes|r")
  parangon.saveButtonText:SetShadowColor(0, 0, 0)
  parangon.saveButtonText:SetShadowOffset(0.5, 0.5)

parangon.characterFrameContainer = CreateFrame("Frame", parangon.characterFrameContainer, CharacterFrame);
  parangon.characterFrameContainer:SetSize(55, 55)
  parangon.characterFrameContainer:RegisterForDrag("LeftButton")
  parangon.characterFrameContainer:SetPoint("TOP", 181, -32)
  parangon.characterFrameContainer:SetBackdrop({
    bgFile = "Interface/bankframe/bank-background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    edgeSize = 20,
    insets = { left = 5, right = 5, top = 5, bottom = 5 }
  })
  parangon.characterFrameContainer:SetFrameLevel(5)
  parangon.characterFrameContainer:SetMovable(false)
  parangon.characterFrameContainer:EnableMouse(true)
  parangon.characterFrameContainer:SetClampedToScreen(true)
  parangon.characterFrameContainer:SetScript("OnDragStart", parangon.characterFrameContainer.StartMoving)
  parangon.characterFrameContainer:SetScript("OnHide", parangon.characterFrameContainer.StopMovingOrSizing)
  parangon.characterFrameContainer:SetScript("OnDragStop", parangon.characterFrameContainer.StopMovingOrSizing)

parangon.characterFrameBorder = CreateFrame("Button", parangon.characterFrameBorder, parangon.characterFrameContainer)
  parangon.characterFrameBorder:SetSize(50, 50)
  parangon.characterFrameBorder:SetNormalTexture("Interface/parangon/ButtonBorder")
  parangon.characterFrameBorder:SetHighlightTexture("Interface/parangon/ButtonBorder_Hover")
  parangon.characterFrameBorder:SetPushedTexture("Interface/parangon/ButtonBorder_Push")
  parangon.characterFrameBorder:SetPoint("CENTER", 0, 0)
  parangon.characterFrameBorder:EnableMouseWheel(1)
  parangon.characterFrameBorder:SetFrameLevel(1000)
  parangon.characterFrameBorder:SetFrameLevel(7)


  parangon.characterFrameBorder:SetScript("OnEnter", function(self, button, down)
    GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR", 1, 5)
    GameTooltip:AddLine("Paragon Infos", 1, 1, 1)
    GameTooltip:AddLine("Displays/hides the Paragon points allocation window.\n"..parangon.pointsLeft:GetText().."\n")

    for spellid, subtable in pairs(parangon.spellsList) do
      GameTooltip:AddLine("|CFFFFFFFF+ "..parangon.rightText[spellid]:GetText().."|CFFFFFFFF "..subtable.name.."|r");
    end
    GameTooltip:AddLine("\n|CFFFFFFFF"..parangon.expText:GetText().."|r");

    GameTooltip:Show()
  end)

  parangon.characterFrameBorder:SetScript("OnLeave", function (self, button, down)
    GameTooltip:Hide()
  end)

  parangon.characterFrameBorder:SetScript("OnMouseUp", function (self, button, down)
    if(parangon.mainWindow:IsShown())then
      parangon.mainWindow:Hide()
    else
      parangon.mainWindow:Show()
    end
  end)

parangon.characterFrameBackground = CreateFrame("Frame", parangon.characterFrameBackground, parangon.characterFrameBorder)
  parangon.characterFrameBackground:SetSize(39, 39)
  parangon.characterFrameBackground:SetBackdrop({
    bgFile = "Interface/Icons/_LDAKnowledge",
    insets = { left = 0, right = 0, top = 0, bottom = 0 }
  })
  parangon.characterFrameBackground:SetPoint("CENTER", 0, 0)
  parangon.characterFrameBackground:SetFrameLevel(6)

function parangon_addon.setInfo(player, stats, level, points, exps)
  for statid, value in pairs(stats) do
    parangon.rightText[statid]:SetText("|CFF00CE00" .. value)
  end

  parangon.levelText:SetText("|CFFFFFFFF" .. level)
  parangon.pointsLeft:SetText("You still have |CFF00CE00" .. points .. "|r left to spend.")

  parangon.expText:SetText("|CFFC758FE(".. exps.exp .. " / " .. exps.exp_max .. ")")
end
