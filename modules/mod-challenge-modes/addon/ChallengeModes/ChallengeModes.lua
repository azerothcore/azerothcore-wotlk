local PREFIX = "CMUI"

local L = {
    title = "Choose your path",
    subtitle = "One mode per character. It cannot be changed later.",
    accept = "Accept",
    selected = "Selected",
    confirm = "This mode cannot be turned off. Continue?",
    needSelect = "Select a mode first.",
    normalName = "Normal",
    normalDesc = "Classic play with no extra rules.",
}

if GetLocale() == "esES" or GetLocale() == "esMX" then
    L.title = "Elige tu camino"
    L.subtitle = "Un solo modo por personaje. No se puede cambiar despues."
    L.accept = "Aceptar"
    L.selected = "Seleccionado"
    L.confirm = "Este modo no se puede desactivar. ¿Continuar?"
    L.needSelect = "Primero elige un modo."
    L.normalName = "Modo normal"
    L.normalDesc = "Juego clasico, sin reglas extra."
end

local MODES = {
    { id = 0, icon = "Interface\\Icons\\Spell_Shadow_DeathPact",
        name = { en = "Hardcore", es = "Hardcore" },
        desc = { en = "One life. Death leaves you a ghost forever.",
                 es = "Una sola vida. Si mueres, quedas fantasma para siempre." },
        warn = true },
    { id = 1, icon = "Interface\\Icons\\INV_Misc_Coin_02",
        name = { en = "Semi-Hardcore", es = "Semi-Hardcore" },
        desc = { en = "Death destroys worn gear and all carried gold.",
                 es = "Si mueres pierdes el equipo puesto y todo el oro." } },
    { id = 2, icon = "Interface\\Icons\\INV_Hammer_20",
        name = { en = "Self-Crafted", es = "Solo fabricado" },
        desc = { en = "Equip only items you crafted yourself.",
                 es = "Solo puedes equipar lo que fabricaste tu." } },
    { id = 3, icon = "Interface\\Icons\\INV_Shirt_Grey_01",
        name = { en = "Item Quality", es = "Calidad baja" },
        desc = { en = "Poor or Common gear only.",
                 es = "Solo equipo pobre o comun." } },
    { id = 4, icon = "Interface\\Icons\\Spell_Nature_Sleep",
        name = { en = "Slow XP", es = "XP lenta" },
        desc = { en = "You receive half experience.",
                 es = "Recibes la mitad de experiencia." } },
    { id = 5, icon = "Interface\\Icons\\Spell_Frost_Stun",
        name = { en = "Very Slow XP", es = "XP muy lenta" },
        desc = { en = "You receive a quarter of experience.",
                 es = "Recibes un cuarto de experiencia." } },
    { id = 6, icon = "Interface\\Icons\\INV_Misc_Book_11",
        name = { en = "Quest XP Only", es = "Solo XP de misiones" },
        desc = { en = "Only quests grant experience.",
                 es = "Solo las misiones dan experiencia." } },
    { id = 7, icon = "Interface\\Icons\\INV_Helmet_25",
        name = { en = "Iron Man", es = "Hombre de Hierro" },
        desc = { en = "No res, talents, rare gear, pots, enchants or groups.",
                 es = "Sin resucitar, talentos, raros, pociones, encantos ni grupos." },
        warn = true },
    { id = "normal", icon = "Interface\\Icons\\Achievement_General",
        name = { en = L.normalName, es = L.normalName },
        desc = { en = L.normalDesc, es = L.normalDesc } },
}

local locale = (GetLocale() == "esES" or GetLocale() == "esMX") and "es" or "en"
local selectedId
local cards = {}

local function Send(payload)
    local name = UnitName("player")
    if name then
        SendAddonMessage(PREFIX, payload, "WHISPER", name)
    end
end

local function Text(mode)
    return mode.name[locale], mode.desc[locale]
end

local frame = CreateFrame("Frame", "ChallengeModePickerFrame", UIParent)
frame:SetWidth(560)
frame:SetHeight(520)
frame:SetPoint("CENTER")
frame:SetFrameStrata("DIALOG")
frame:SetToplevel(true)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
frame:SetBackdropColor(0, 0, 0, 0.92)
frame:Hide()

local header = frame:CreateTexture(nil, "ARTWORK")
header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
header:SetWidth(400)
header:SetHeight(64)
header:SetPoint("TOP", 0, 12)

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", header, "TOP", 0, -13)
title:SetText(L.title)

local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("TOP", frame, "TOP", 0, -38)
subtitle:SetWidth(500)
subtitle:SetJustifyH("CENTER")
subtitle:SetText(L.subtitle)

local function SetCardSelected(card, on)
    if on then
        card:SetBackdropBorderColor(1, 0.82, 0, 1)
        card:SetBackdropColor(0.22, 0.18, 0.05, 0.95)
    else
        card:SetBackdropBorderColor(0.4, 0.35, 0.25, 0.9)
        card:SetBackdropColor(0.08, 0.08, 0.08, 0.85)
    end
end

local function SelectCard(id)
    selectedId = id
    for _, card in ipairs(cards) do
        SetCardSelected(card, card.modeId == id)
    end
end

local function CreateCard(parent, mode, index)
    local col = (index - 1) % 3
    local row = math.floor((index - 1) / 3)
    local card = CreateFrame("Button", nil, parent)
    card:SetWidth(168)
    card:SetHeight(118)
    card:SetPoint("TOPLEFT", 22 + col * 176, -62 - row * 126)
    card:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    SetCardSelected(card, false)
    card.modeId = mode.id
    card.warn = mode.warn

    local icon = card:CreateTexture(nil, "ARTWORK")
    icon:SetWidth(36)
    icon:SetHeight(36)
    icon:SetPoint("TOPLEFT", 10, -10)
    icon:SetTexture(mode.icon)

    local name, desc = Text(mode)
    local nameFS = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameFS:SetPoint("TOPLEFT", icon, "TOPRIGHT", 8, -2)
    nameFS:SetPoint("RIGHT", card, "RIGHT", -8, 0)
    nameFS:SetJustifyH("LEFT")
    nameFS:SetText(name)

    local descFS = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    descFS:SetPoint("TOPLEFT", icon, "BOTTOMLEFT", 0, -8)
    descFS:SetPoint("RIGHT", card, "RIGHT", -8, 0)
    descFS:SetJustifyH("LEFT")
    descFS:SetJustifyV("TOP")
    descFS:SetText(desc)

    card:SetScript("OnClick", function()
        SelectCard(mode.id)
        PlaySound("igMainMenuOptionCheckBoxOn")
    end)
    card:SetScript("OnEnter", function(self)
        if selectedId ~= mode.id then
            self:SetBackdropBorderColor(0.8, 0.7, 0.3, 1)
        end
    end)
    card:SetScript("OnLeave", function(self)
        SetCardSelected(self, selectedId == mode.id)
    end)

    table.insert(cards, card)
    return card
end

for i, mode in ipairs(MODES) do
    CreateCard(frame, mode, i)
end

local accept = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
accept:SetWidth(140)
accept:SetHeight(24)
accept:SetPoint("BOTTOM", 0, 18)
accept:SetText(L.accept)

local function DoAccept()
    if selectedId == nil then
        UIErrorsFrame:AddMessage(L.needSelect, 1, 0.2, 0.2, 1)
        return
    end
    if selectedId == "normal" then
        Send("NORMAL")
    else
        Send("SELECT\t" .. tostring(selectedId))
    end
    frame:Hide()
    PlaySound("igMainMenuOption")
end

accept:SetScript("OnClick", function()
    if selectedId == nil then
        UIErrorsFrame:AddMessage(L.needSelect, 1, 0.2, 0.2, 1)
        return
    end
    local warn = false
    for _, card in ipairs(cards) do
        if card.modeId == selectedId and card.warn then
            warn = true
            break
        end
    end
    if warn then
        StaticPopup_Show("CHALLENGE_MODE_CONFIRM")
    else
        DoAccept()
    end
end)

StaticPopupDialogs["CHALLENGE_MODE_CONFIRM"] = {
    text = L.confirm,
    button1 = YES,
    button2 = NO,
    OnAccept = DoAccept,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    preferredIndex = 3,
}

frame:SetScript("OnShow", function()
    SelectCard(nil)
    PlaySound("igCharacterInfoOpen")
end)

local function ShowPicker(enabledFlags)
    if CloseGossip then
        CloseGossip()
    end
    for i, card in ipairs(cards) do
        local mode = MODES[i]
        if mode.id == "normal" then
            card:Show()
        else
            local flag = enabledFlags and enabledFlags[mode.id + 1]
            if flag == nil or flag == 1 then
                card:Show()
            else
                card:Hide()
            end
        end
    end
    frame:Show()
end

local listener = CreateFrame("Frame")
listener:RegisterEvent("CHAT_MSG_ADDON")
listener:RegisterEvent("PLAYER_ENTERING_WORLD")
listener:SetScript("OnEvent", function(_, event, prefix, message)
    if event == "CHAT_MSG_ADDON" then
        if prefix ~= PREFIX then
            return
        end
        local cmd, loc, flags = strsplit("\t", message or "")
        if cmd == "OPEN" then
            if loc == "es" or loc == "en" then
                locale = loc
            end
            local enabled = {}
            if flags then
                for token in string.gmatch(flags, "[^,]+") do
                    table.insert(enabled, tonumber(token) or 1)
                end
            end
            ShowPicker(enabled)
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        Send("HELLO")
    end
end)

SLASH_CHALLENGEMODE1 = "/cmui"
SLASH_CHALLENGEMODE2 = "/desafio"
SlashCmdList["CHALLENGEMODE"] = function()
    ShowPicker()
end
