local PREFIX = "CMUI"

local L = {
    title = "Choose your path",
    subtitle = "One mode per character. It cannot be changed later.",
    hint = "Select a mode to read the full rules. Scroll to see every line.",
    accept = "Accept this mode",
    back = "< Back",
    selected = "Selected",
    confirm = "This mode cannot be turned off. Continue?",
    needSelect = "Select a mode first.",
    rules = "Rules",
    reward = "Rewards",
    titleLabel = "Title",
    complete = "Completes at level %s.",
    oneMode = "Only one mode per character.",
    announced = "The realm announces when you accept, fall or finish.",
    rewardTitle = "Title",
    rewardItem = "Item",
    rewardGold = "Gold",
    rewardHonor = "Honor",
    rewardAchievement = "Achievement",
    rewardTalents = "Talent points",
    rewardNone = "No extra item, gold, honor or achievement in the config.",
    rewardWaiting = "Loading rewards from the server...",
    rewardAt = "At level %s",
    goldLabel = "%s gold",
    silverLabel = "%s silver",
    copperLabel = "%s copper",
    rates = "Rates: XP x%s / Gold x%s / Honor x%s / Rep x%s",
    normalName = "Normal",
    normalTitle = "Adventurer",
    normalDesc = "Classic play with no extra rules.",
}

if GetLocale() == "esES" or GetLocale() == "esMX" then
    L.title = "Elige tu camino"
    L.subtitle = "Un solo modo por personaje. No se puede cambiar despues."
    L.hint = "Selecciona un modo para leer las reglas. Baja con la rueda para ver todo."
    L.accept = "Aceptar este modo"
    L.back = "< Atras"
    L.selected = "Seleccionado"
    L.confirm = "Este modo no se puede desactivar. ¿Continuar?"
    L.needSelect = "Primero elige un modo."
    L.rules = "Reglas"
    L.reward = "Recompensas"
    L.titleLabel = "Titulo"
    L.complete = "Se completa al nivel %s."
    L.oneMode = "Solo un modo por personaje."
    L.announced = "El reino anuncia cuando aceptas, caes o terminas."
    L.rewardTitle = "Titulo"
    L.rewardItem = "Objeto"
    L.rewardGold = "Oro"
    L.rewardHonor = "Honor"
    L.rewardAchievement = "Logro"
    L.rewardTalents = "Puntos de talento"
    L.rewardNone = "Sin objeto, oro, honor ni logro extra en el conf."
    L.rewardWaiting = "Cargando recompensas del servidor..."
    L.rewardAt = "Al nivel %s"
    L.goldLabel = "%s oro"
    L.silverLabel = "%s plata"
    L.copperLabel = "%s cobre"
    L.rates = "Rates: XP x%s / Oro x%s / Honor x%s / Reputacion x%s"
    L.normalName = "Modo normal"
    L.normalTitle = "Aventurero"
    L.normalDesc = "Juego clasico, sin reglas extra."
end

local function T(en, es)
    return { en = en, es = es }
end

local MODES = {
    { id = 0, icon = "Interface\\Icons\\Spell_Shadow_DeathPact", warn = true,
        name = T("Hardcore", "Hardcore"),
        title = T("the Undying", "el Imperecedero"),
        short = T("One life. Death leaves you a ghost forever.",
            "Una sola vida. Si mueres, quedas fantasma para siempre."),
        rules = {
            T("One life only. Death to a mob, a player or spirit release is permanent.",
                "Una sola vida. Morir por un monstruo, un jugador o al liberar el espiritu es permanente."),
            T("You stay a ghost forever: no graveyard, no resurrection spells.",
                "Quedas como fantasma para siempre: ni cementerio ni hechizos de resurreccion."),
            T("The realm announces your fall to everyone online.",
                "El reino anuncia tu caida a todos los conectados."),
            T("Finish by reaching level 80 without dying.",
                "Completas el reto al llegar a nivel 80 sin morir."),
            T("Cannot be turned off. This is the only mode this character can have.",
                "No se puede desactivar. Es el unico modo que puede tener este personaje."),
        },
        reward = T("Grants and equips the title the Undying.",
            "Otorga y equipa el titulo el Imperecedero.") },
    { id = 1, icon = "Interface\\Icons\\INV_Misc_Coin_02",
        name = T("Semi-Hardcore", "Semi-Hardcore"),
        title = T("of the Nightfall", "de la Caida Nocturna"),
        short = T("Death destroys worn gear and all carried gold.",
            "Si mueres pierdes el equipo puesto y todo el oro."),
        rules = {
            T("You may die and resurrect as usual.",
                "Puedes morir y resucitar con normalidad."),
            T("Each death strips ALL worn equipment.",
                "Cada muerte te despoja de TODO el equipo puesto."),
            T("Each death also takes ALL gold you are carrying. Bags and bank stay.",
                "Cada muerte tambien te quita TODO el oro que lleves. Bolsas y banco se quedan."),
            T("High risk without deleting the character.",
                "Alto riesgo sin perder el personaje."),
            T("Complete the run by reaching level 80.",
                "Completas el reto al llegar a nivel 80."),
        },
        reward = T("Grants and equips the title of the Nightfall.",
            "Otorga y equipa el titulo de la Caida Nocturna.") },
    { id = 2, icon = "Interface\\Icons\\INV_Hammer_20",
        name = T("Self-Crafted", "Solo fabricado"),
        title = T("the Supreme", "el Supremo"),
        short = T("Equip only items you crafted yourself.",
            "Solo puedes equipar lo que fabricaste tu."),
        rules = {
            T("You may only equip items YOU crafted. The item creator must be this character.",
                "Solo puedes equipar objetos que TU hayas fabricado. El creador debe ser este personaje."),
            T("No loot, auction house, gifts or boss drops as equipment.",
                "No vale loot, casa de subastas, regalos ni drops de jefes como equipo."),
            T("Armor and weapons must come from your professions.",
                "Armaduras y armas tienen que salir de tus profesiones."),
            T("Complete the run at level 80.",
                "Completas el reto al nivel 80."),
        },
        reward = T("Grants and equips the title the Supreme.",
            "Otorga y equipa el titulo el Supremo.") },
    { id = 3, icon = "Interface\\Icons\\INV_Shirt_Grey_01",
        name = T("Item Quality", "Calidad baja"),
        title = T("Jenkins", "Jenkins"),
        short = T("Poor or Common gear only.",
            "Solo equipo pobre o comun."),
        rules = {
            T("You may only equip Poor (grey) or Common (white) items.",
                "Solo puedes equipar objetos pobres (gris) o comunes (blanco)."),
            T("No green, blue, epic or legendary gear from quests, dungeons or the auction house.",
                "Nada de verdes, azules, epicos ni legendarios: ni misiones, ni mazmorras, ni AH."),
            T("Bags and items you cannot equip are allowed.",
                "Las bolsas y objetos no equipables estan permitidos."),
            T("Complete the run at level 80.",
                "Completas el reto al nivel 80."),
        },
        reward = T("Grants and equips the title Jenkins.",
            "Otorga y equipa el titulo Jenkins.") },
    { id = 4, icon = "Interface\\Icons\\Spell_Nature_Sleep",
        name = T("Slow XP", "XP lenta"),
        title = T("the Patient", "el Paciente"),
        short = T("You receive half experience.",
            "Recibes la mitad de experiencia."),
        rules = {
            T("You receive half experience from kills, quests and exploration.",
                "Recibes la mitad de experiencia de muertes, misiones y exploracion."),
            T("Leveling takes twice as long.",
                "Subir de nivel tarda el doble."),
            T("Normal gear is allowed.",
                "Puedes usar equipo normal."),
            T("Cannot be combined with Very Slow XP. Complete at level 80.",
                "No se combina con XP muy lenta. Completas el reto al nivel 80."),
        },
        reward = T("Grants and equips the title the Patient.",
            "Otorga y equipa el titulo el Paciente.") },
    { id = 5, icon = "Interface\\Icons\\Spell_Frost_Stun",
        name = T("Very Slow XP", "XP muy lenta"),
        title = T("the Explorer", "el Explorador"),
        short = T("You receive a quarter of experience.",
            "Recibes un cuarto de experiencia."),
        rules = {
            T("You receive 25% of normal experience. Each level costs four times as much.",
                "Recibes un 25% de la experiencia normal. Cada nivel cuesta cuatro veces mas."),
            T("The harshest leveling pace.",
                "El ritmo de subida mas exigente."),
            T("Gear is unrestricted.",
                "El equipo es libre."),
            T("Cannot be combined with Slow XP. Complete at level 80.",
                "No se combina con XP lenta. Completas el reto al nivel 80."),
        },
        reward = T("Grants and equips the title the Explorer.",
            "Otorga y equipa el titulo el Explorador.") },
    { id = 6, icon = "Interface\\Icons\\INV_Misc_Book_11",
        name = T("Quest XP Only", "Solo XP de misiones"),
        title = T("Loremaster", "Maestro Cultural"),
        short = T("Only quests grant experience.",
            "Solo las misiones dan experiencia."),
        rules = {
            T("Kills, exploration and battlegrounds grant no experience.",
                "Las muertes, la exploracion y los campos de batalla no dan experiencia."),
            T("Only quests level you. Your pet can still gain kill XP.",
                "Solo las misiones te suben de nivel. Tu mascota si puede ganar XP de asesinatos."),
            T("Gear is unrestricted.",
                "El equipo es libre."),
            T("Complete the run at level 80.",
                "Completas el reto al nivel 80."),
        },
        reward = T("Grants and equips the title Loremaster.",
            "Otorga y equipa el titulo Maestro Cultural.") },
    { id = 7, icon = "Interface\\Icons\\INV_Helmet_25", warn = true,
        name = T("Iron Man", "Hombre de Hierro"),
        title = T("the Insane", "el Demente"),
        short = T("No res, talents, rare gear, pots, enchants or groups.",
            "Sin resucitar, talentos, raros, pociones, encantos ni grupos."),
        rules = {
            T("You cannot resurrect. Death ends the spirit of the run.",
                "No puedes resucitar. Una muerte termina el espiritu de la run."),
            T("You gain no talent points. The server zeroes them and blocks learning.",
                "No ganas puntos de talento. El servidor los anula y bloquea aprenderlos."),
            T("Poor or Common gear only. No enchants.",
                "Solo equipo pobre o comun. Sin encantamientos."),
            T("No potions, elixirs, flasks or food buffs.",
                "Sin pociones, elixires, frascos ni comida con buff."),
            T("No extra professions and no groups.",
                "Sin profesiones extra y sin grupos."),
            T("The realm announces your death. Complete at level 80.",
                "El reino anuncia tu muerte. Completas el reto al nivel 80."),
        },
        reward = T("Grants and equips the title the Insane.",
            "Otorga y equipa el titulo el Demente.") },
    { id = "normal", icon = "Interface\\Icons\\Achievement_General",
        name = T(L.normalName, L.normalName),
        title = T(L.normalTitle, L.normalTitle),
        short = T(L.normalDesc, L.normalDesc),
        rules = {
            T("Classic World of Warcraft. No extra restrictions.",
                "World of Warcraft clasico. Sin restricciones extra."),
            T("Talents, groups, gear and resurrection work as usual.",
                "Talentos, grupos, equipo y resurreccion funcionan con normalidad."),
            T("No challenge title and no realm announce.",
                "Sin titulo de desafio y sin anuncio al reino."),
            T("You can still talk to the Keeper later if you have not chosen yet. After this, the choice is locked.",
                "Puedes hablar con el Guardian mas tarde si aun no has elegido. Despues de esto, la eleccion queda fija."),
        },
        reward = T("No extra rewards. Play the game as designed.",
            "Sin recompensas extra. Juega el juego tal como es.") },
}

local locale = (GetLocale() == "esES" or GetLocale() == "esMX") and "es" or "en"
local selectedMode
local cards = {}
local serverRewards = {}

local function Loc(entry)
    if type(entry) == "table" then
        return entry[locale] or entry.en or ""
    end
    return entry or ""
end

local function Send(payload)
    local name = UnitName("player")
    if name then
        SendAddonMessage(PREFIX, payload, "WHISPER", name)
    end
end

local function FindMode(id)
    for _, mode in ipairs(MODES) do
        if mode.id == id then
            return mode
        end
    end
end

local BACKDROP_FRAME = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
}

local BACKDROP_CARD = {
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
}

local BACKDROP_PANEL = {
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

local function SetReadableFont(fs, size)
    local font = GameFontHighlight:GetFont()
    if font then
        fs:SetFont(font, size, "")
    end
end

local frame = CreateFrame("Frame", "ChallengeModePickerFrame", UIParent)
frame:SetWidth(680)
frame:SetHeight(640)
frame:SetPoint("CENTER")
frame:SetFrameStrata("DIALOG")
frame:SetToplevel(true)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetBackdrop(BACKDROP_FRAME)
frame:SetBackdropColor(0.05, 0.04, 0.03, 0.96)
frame:Hide()

local header = frame:CreateTexture(nil, "ARTWORK")
header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
header:SetWidth(420)
header:SetHeight(64)
header:SetPoint("TOP", 0, 14)

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOP", header, "TOP", 0, -13)
title:SetText(L.title)

local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", -4, -4)
close:SetScript("OnClick", function()
    frame:Hide()
    PlaySound("igMainMenuClose")
end)

local listPanel = CreateFrame("Frame", nil, frame)
listPanel:SetPoint("TOPLEFT", 16, -42)
listPanel:SetPoint("BOTTOMRIGHT", -16, 16)

local subtitle = listPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
subtitle:SetPoint("TOP", listPanel, "TOP", 0, -2)
subtitle:SetWidth(620)
subtitle:SetJustifyH("CENTER")
subtitle:SetText(L.subtitle)

local hint = listPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
hint:SetPoint("TOP", subtitle, "BOTTOM", 0, -6)
hint:SetWidth(620)
hint:SetJustifyH("CENTER")
hint:SetTextColor(1, 0.82, 0.2)
hint:SetText(L.hint)

local function SetCardLook(card, state)
    if state == "selected" then
        card:SetBackdropBorderColor(1, 0.82, 0, 1)
        card:SetBackdropColor(0.28, 0.2, 0.04, 0.95)
    elseif state == "hover" then
        card:SetBackdropBorderColor(0.95, 0.78, 0.28, 1)
        card:SetBackdropColor(0.16, 0.13, 0.05, 0.92)
    elseif state == "danger" then
        card:SetBackdropBorderColor(0.75, 0.22, 0.18, 0.95)
        card:SetBackdropColor(0.12, 0.05, 0.04, 0.9)
    else
        card:SetBackdropBorderColor(0.45, 0.38, 0.22, 0.9)
        card:SetBackdropColor(0.07, 0.06, 0.04, 0.88)
    end
end

local detailPanel = CreateFrame("Frame", nil, frame)
detailPanel:SetPoint("TOPLEFT", 22, -48)
detailPanel:SetPoint("BOTTOMRIGHT", -22, 18)
detailPanel:SetBackdrop(BACKDROP_PANEL)
detailPanel:SetBackdropColor(0.04, 0.04, 0.05, 0.97)
detailPanel:SetBackdropBorderColor(0.9, 0.75, 0.25, 1)
detailPanel:Hide()

local detailIconBorder = detailPanel:CreateTexture(nil, "ARTWORK")
detailIconBorder:SetTexture("Interface\\Buttons\\UI-Quickslot2")
detailIconBorder:SetWidth(84)
detailIconBorder:SetHeight(84)
detailIconBorder:SetPoint("TOPLEFT", 18, -22)

local detailIcon = detailPanel:CreateTexture(nil, "OVERLAY")
detailIcon:SetWidth(52)
detailIcon:SetHeight(52)
detailIcon:SetPoint("CENTER", detailIconBorder, "CENTER", 0, 0)

local detailName = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
detailName:SetPoint("TOPLEFT", detailIconBorder, "TOPRIGHT", 8, -10)
detailName:SetPoint("RIGHT", detailPanel, "RIGHT", -20, 0)
detailName:SetJustifyH("LEFT")
SetReadableFont(detailName, 20)
detailName:SetTextColor(1, 0.92, 0.55)

local detailTitle = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
detailTitle:SetPoint("TOPLEFT", detailName, "BOTTOMLEFT", 0, -8)
detailTitle:SetPoint("RIGHT", detailPanel, "RIGHT", -20, 0)
detailTitle:SetJustifyH("LEFT")
SetReadableFont(detailTitle, 16)
detailTitle:SetTextColor(1, 0.86, 0.3)

local detailDivider = detailPanel:CreateTexture(nil, "ARTWORK")
detailDivider:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-OnlineDivider")
detailDivider:SetHeight(8)
detailDivider:SetPoint("TOPLEFT", 22, -108)
detailDivider:SetPoint("RIGHT", detailPanel, "RIGHT", -22, 0)

local detailRulesHeader = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
detailRulesHeader:SetPoint("TOPLEFT", 24, -122)
detailRulesHeader:SetText(L.rules)
SetReadableFont(detailRulesHeader, 17)
detailRulesHeader:SetTextColor(1, 0.82, 0)

local detailRewardHeader = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
detailRewardHeader:SetPoint("BOTTOMLEFT", 24, 186)
detailRewardHeader:SetText(L.reward)
SetReadableFont(detailRewardHeader, 17)
detailRewardHeader:SetTextColor(1, 0.82, 0)

local RULE_WIDTH = 560
local rulesScroll = CreateFrame("ScrollFrame", "ChallengeModeRulesScroll", detailPanel, "UIPanelScrollFrameTemplate")
rulesScroll:SetPoint("TOPLEFT", detailRulesHeader, "BOTTOMLEFT", 0, -8)
rulesScroll:SetPoint("BOTTOMLEFT", detailRewardHeader, "TOPLEFT", 0, 12)
rulesScroll:SetPoint("RIGHT", detailPanel, "RIGHT", -36, 0)
rulesScroll:EnableMouse(true)
rulesScroll:EnableMouseWheel(true)
rulesScroll:SetScript("OnMouseWheel", function(self, delta)
    local step = 32
    local current = self:GetVerticalScroll()
    local maxScroll = self:GetVerticalScrollRange()
    if delta > 0 then
        self:SetVerticalScroll(math.max(0, current - step))
    else
        self:SetVerticalScroll(math.min(maxScroll, current + step))
    end
end)

local rulesChild = CreateFrame("Frame", nil, rulesScroll)
rulesChild:SetWidth(RULE_WIDTH)
rulesScroll:SetScrollChild(rulesChild)

local rulesBody = rulesChild:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
rulesBody:SetPoint("TOPLEFT", 0, 0)
rulesBody:SetWidth(RULE_WIDTH)
rulesBody:SetJustifyH("LEFT")
rulesBody:SetJustifyV("TOP")
rulesBody:SetNonSpaceWrap(true)
SetReadableFont(rulesBody, 15)
rulesBody:SetTextColor(1, 0.96, 0.88)

local rewardLines = {}
for i = 1, 10 do
    local fs = detailPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    if i == 1 then
        fs:SetPoint("TOPLEFT", detailRewardHeader, "BOTTOMLEFT", 0, -8)
    else
        fs:SetPoint("TOPLEFT", rewardLines[i - 1], "BOTTOMLEFT", 0, -5)
    end
    fs:SetWidth(560)
    fs:SetJustifyH("LEFT")
    fs:SetJustifyV("TOP")
    fs:SetNonSpaceWrap(true)
    SetReadableFont(fs, 14)
    fs:SetTextColor(0.95, 0.9, 0.72)
    table.insert(rewardLines, fs)
end

local backBtn = CreateFrame("Button", nil, detailPanel, "UIPanelButtonTemplate")
backBtn:SetWidth(110)
backBtn:SetHeight(24)
backBtn:SetPoint("BOTTOMLEFT", 18, 16)
backBtn:SetText(L.back)

local acceptBtn = CreateFrame("Button", nil, detailPanel, "UIPanelButtonTemplate")
acceptBtn:SetWidth(180)
acceptBtn:SetHeight(24)
acceptBtn:SetPoint("BOTTOMRIGHT", -18, 16)
acceptBtn:SetText(L.accept)

local function FormatMoney(copper)
    copper = tonumber(copper) or 0
    if copper <= 0 then
        return nil
    end
    local g = math.floor(copper / 10000)
    local s = math.floor((copper % 10000) / 100)
    local c = copper % 100
    local parts = {}
    if g > 0 then
        table.insert(parts, string.format(L.goldLabel, g))
    end
    if s > 0 then
        table.insert(parts, string.format(L.silverLabel, s))
    end
    if c > 0 or #parts == 0 then
        table.insert(parts, string.format(L.copperLabel, c))
    end
    return table.concat(parts, ", ")
end

local function BuildRewardLines(mode)
    local lines = {}
    if mode.id == "normal" then
        table.insert(lines, Loc(mode.reward))
        table.insert(lines, L.oneMode)
        return lines
    end

    local r = serverRewards[mode.id]
    if not r then
        table.insert(lines, L.rewardWaiting)
        table.insert(lines, "|cffffd100" .. L.rewardTitle .. ":|r " .. Loc(mode.title))
        table.insert(lines, string.format(L.complete, "80"))
        return lines
    end

    table.insert(lines, "|cffffd100" .. string.format(L.complete, tostring(r.level or 80)) .. "|r")
    if r.title and r.title ~= "" then
        table.insert(lines, "|cffffd100" .. L.rewardTitle .. ":|r " .. r.title)
    else
        table.insert(lines, "|cffffd100" .. L.rewardTitle .. ":|r " .. Loc(mode.title))
    end
    if r.xp or r.goldRate or r.honorRate or r.repRate then
        table.insert(lines, string.format(L.rates,
            tostring(r.xp or "1"), tostring(r.goldRate or "1"),
            tostring(r.honorRate or "1"), tostring(r.repRate or "1")))
    end

    local hasExtra = false
    if r.itemId and r.itemId > 0 then
        local name = r.itemName
        if not name or name == "" then
            name = GetItemInfo(r.itemId) or ("#" .. r.itemId)
        end
        local count = (r.itemCount and r.itemCount > 1) and (" x" .. r.itemCount) or ""
        table.insert(lines, "|cff00ff00" .. L.rewardItem .. ":|r " .. name .. count)
        hasExtra = true
    end
    local money = FormatMoney(r.gold)
    if money then
        table.insert(lines, "|cffffd100" .. L.rewardGold .. ":|r " .. money)
        hasExtra = true
    end
    if r.honor and r.honor > 0 then
        table.insert(lines, "|cff80c0ff" .. L.rewardHonor .. ":|r " .. r.honor)
        hasExtra = true
    end
    if r.achId and r.achId > 0 then
        local name = r.achName
        if not name or name == "" then
            name = "#" .. r.achId
        end
        table.insert(lines, "|cff00ccff" .. L.rewardAchievement .. ":|r " .. name)
        hasExtra = true
    end
    if r.talents and r.talents > 0 then
        table.insert(lines, "|cffa335ee" .. L.rewardTalents .. ":|r " .. r.talents)
        hasExtra = true
    end
    if r.extras then
        for _, extra in ipairs(r.extras) do
            local prefix = string.format(L.rewardAt, tostring(extra.level or "?"))
            if extra.kind == "item" then
                local count = (extra.count and extra.count > 1) and (" x" .. extra.count) or ""
                table.insert(lines, prefix .. " — " .. L.rewardItem .. ": " .. (extra.name or "") .. count)
            elseif extra.kind == "title" then
                table.insert(lines, prefix .. " — " .. L.rewardTitle .. ": " .. (extra.name or ""))
            elseif extra.kind == "ach" then
                table.insert(lines, prefix .. " — " .. L.rewardAchievement .. ": " .. (extra.name or ""))
            elseif extra.kind == "talent" then
                table.insert(lines, prefix .. " — " .. L.rewardTalents .. ": " .. tostring(extra.count or extra.id or ""))
            end
            hasExtra = true
        end
    end
    if not hasExtra then
        table.insert(lines, L.rewardNone)
    end
    table.insert(lines, L.oneMode)
    return lines
end

local function ShowList()
    selectedMode = nil
    detailPanel:Hide()
    listPanel:Show()
    title:SetText(L.title)
end

local function LayoutRules(mode)
    local parts = {}
    for _, rule in ipairs(mode.rules or {}) do
        table.insert(parts, "|cffffd100•|r  " .. Loc(rule))
    end
    rulesBody:SetWidth(RULE_WIDTH)
    rulesBody:SetText(table.concat(parts, "\n\n"))
    local height = rulesBody:GetStringHeight() or 40
    if height < 40 then
        height = 40
    end
    rulesBody:SetHeight(height + 8)
    rulesChild:SetHeight(height + 16)
    rulesScroll:SetVerticalScroll(0)
    if ChallengeModeRulesScrollScrollBar then
        ChallengeModeRulesScrollScrollBar:SetValue(0)
    end
end

local function FillDetail(mode)
    selectedMode = mode
    detailIcon:SetTexture(mode.icon)
    detailName:SetText(Loc(mode.name))
    local r = serverRewards[mode.id]
    local honorific = (r and r.title and r.title ~= "") and r.title or Loc(mode.title)
    detailTitle:SetText("|cffffd100" .. L.titleLabel .. ":|r " .. honorific)
    local rewards = BuildRewardLines(mode)
    for i, fs in ipairs(rewardLines) do
        if rewards[i] then
            fs:SetWidth(560)
            fs:SetText(rewards[i])
            fs:Show()
        else
            fs:SetText("")
            fs:Hide()
        end
    end
    title:SetText(Loc(mode.name))
    listPanel:Hide()
    detailPanel:Show()
    LayoutRules(mode)
end

local CARD_COLS = 3
local CARD_ROWS = 3
local CARD_PAD = 8
local CARD_GAP = 8
local CARD_TOP = 50
local CARD_WIDTH = 208
local CARD_HEIGHT = 172

local function CreateCard(parent, mode, index)
    local col = (index - 1) % CARD_COLS
    local row = math.floor((index - 1) / CARD_COLS)
    local card = CreateFrame("Button", nil, parent)
    card:SetWidth(CARD_WIDTH)
    card:SetHeight(CARD_HEIGHT)
    card:SetPoint("TOPLEFT", CARD_PAD + col * (CARD_WIDTH + CARD_GAP),
        -CARD_TOP - row * (CARD_HEIGHT + CARD_GAP))
    card:SetBackdrop(BACKDROP_CARD)
    SetCardLook(card, mode.warn and "danger" or "idle")
    card.mode = mode

    local icon = card:CreateTexture(nil, "ARTWORK")
    icon:SetWidth(48)
    icon:SetHeight(48)
    icon:SetPoint("TOPLEFT", 12, -12)
    icon:SetTexture(mode.icon)

    local nameFS = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameFS:SetPoint("TOPLEFT", icon, "TOPRIGHT", 10, -2)
    nameFS:SetPoint("RIGHT", card, "RIGHT", -10, 0)
    nameFS:SetJustifyH("LEFT")
    SetReadableFont(nameFS, 16)
    nameFS:SetText(Loc(mode.name))
    card.nameFS = nameFS

    local titleFS = card:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    titleFS:SetPoint("TOPLEFT", nameFS, "BOTTOMLEFT", 0, -4)
    titleFS:SetPoint("RIGHT", card, "RIGHT", -10, 0)
    titleFS:SetJustifyH("LEFT")
    SetReadableFont(titleFS, 14)
    titleFS:SetTextColor(1, 0.82, 0)
    titleFS:SetText(Loc(mode.title))
    card.titleFS = titleFS

    local descFS = card:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    descFS:SetPoint("TOPLEFT", icon, "BOTTOMLEFT", 0, -10)
    descFS:SetPoint("RIGHT", card, "RIGHT", -12, 0)
    descFS:SetPoint("BOTTOM", card, "BOTTOM", 0, 12)
    descFS:SetJustifyH("LEFT")
    descFS:SetJustifyV("TOP")
    descFS:SetNonSpaceWrap(true)
    SetReadableFont(descFS, 13)
    descFS:SetText(Loc(mode.short))
    card.descFS = descFS

    card:SetScript("OnClick", function()
        PlaySound("igMainMenuOptionCheckBoxOn")
        FillDetail(mode)
    end)
    card:SetScript("OnEnter", function(self)
        SetCardLook(self, "hover")
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(Loc(mode.name), 1, 0.82, 0)
        GameTooltip:AddLine(Loc(mode.title), 0.9, 0.8, 0.4, true)
        GameTooltip:AddLine(Loc(mode.short), 1, 1, 1, true)
        GameTooltip:AddLine(L.hint, 0.6, 0.8, 1, true)
        GameTooltip:Show()
    end)
    card:SetScript("OnLeave", function(self)
        SetCardLook(self, mode.warn and "danger" or "idle")
        GameTooltip:Hide()
    end)

    table.insert(cards, card)
    return card
end

for i, mode in ipairs(MODES) do
    CreateCard(listPanel, mode, i)
end

local function RefreshCardTexts()
    for _, card in ipairs(cards) do
        local mode = card.mode
        card.nameFS:SetText(Loc(mode.name))
        card.titleFS:SetText(Loc(mode.title))
        card.descFS:SetText(Loc(mode.short))
    end
    subtitle:SetText(L.subtitle)
    hint:SetText(L.hint)
    title:SetText(L.title)
    detailRulesHeader:SetText(L.rules)
    detailRewardHeader:SetText(L.reward)
    backBtn:SetText(L.back)
    acceptBtn:SetText(L.accept)
end

local function DoAccept()
    if not selectedMode then
        UIErrorsFrame:AddMessage(L.needSelect, 1, 0.2, 0.2, 1)
        return
    end
    if selectedMode.id == "normal" then
        Send("NORMAL")
    else
        Send("SELECT\t" .. tostring(selectedMode.id))
    end
    frame:Hide()
    PlaySound("igMainMenuOption")
end

backBtn:SetScript("OnClick", function()
    PlaySound("igMainMenuOptionCheckBoxOff")
    ShowList()
end)

acceptBtn:SetScript("OnClick", function()
    if not selectedMode then
        UIErrorsFrame:AddMessage(L.needSelect, 1, 0.2, 0.2, 1)
        return
    end
    if selectedMode.warn then
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
    ShowList()
    PlaySound("igCharacterInfoOpen")
end)

local function ShowPicker(enabledFlags)
    if CloseGossip then
        CloseGossip()
    end
    RefreshCardTexts()
    for _, card in ipairs(cards) do
        local mode = card.mode
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
    ShowList()
    frame:Show()
end

local listener = CreateFrame("Frame")
listener:RegisterEvent("CHAT_MSG_ADDON")
listener:RegisterEvent("PLAYER_ENTERING_WORLD")
local function StoreReward(message)
    local _, mode, level, titleName, itemId, itemCount, itemName, gold, honor, achId, achName, talents =
        strsplit("\t", message or "")
    mode = tonumber(mode)
    if not mode then
        return
    end
    serverRewards[mode] = {
        level = tonumber(level) or 80,
        title = titleName or "",
        itemId = tonumber(itemId) or 0,
        itemCount = tonumber(itemCount) or 1,
        itemName = itemName or "",
        gold = tonumber(gold) or 0,
        honor = tonumber(honor) or 0,
        achId = tonumber(achId) or 0,
        achName = achName or "",
        talents = tonumber(talents) or 0,
        extras = {},
    }
    if selectedMode and selectedMode.id == mode then
        FillDetail(selectedMode)
    end
end

local function StoreRates(message)
    local _, mode, xp, gold, honor, rep = strsplit("\t", message or "")
    mode = tonumber(mode)
    if not mode then
        return
    end
    serverRewards[mode] = serverRewards[mode] or { extras = {} }
    serverRewards[mode].xp = xp or "1"
    serverRewards[mode].goldRate = gold or "1"
    serverRewards[mode].honorRate = honor or "1"
    serverRewards[mode].repRate = rep or "1"
    if selectedMode and selectedMode.id == mode then
        FillDetail(selectedMode)
    end
end

local function StoreExtra(message)
    local _, mode, kind, level, id, name, count = strsplit("\t", message or "")
    mode = tonumber(mode)
    if not mode or not kind then
        return
    end
    serverRewards[mode] = serverRewards[mode] or { extras = {} }
    serverRewards[mode].extras = serverRewards[mode].extras or {}
    table.insert(serverRewards[mode].extras, {
        kind = kind,
        level = tonumber(level),
        id = tonumber(id),
        name = name or "",
        count = tonumber(count) or 1,
    })
    if selectedMode and selectedMode.id == mode then
        FillDetail(selectedMode)
    end
end

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
        elseif cmd == "REWARD" then
            StoreReward(message)
        elseif cmd == "RATES" then
            StoreRates(message)
        elseif cmd == "EXTRA" then
            StoreExtra(message)
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        if not listener.greeted then
            listener.greeted = true
            Send("HELLO")
        end
    end
end)

SLASH_CHALLENGEMODE1 = "/cmui"
SLASH_CHALLENGEMODE2 = "/desafio"
SlashCmdList["CHALLENGEMODE"] = function()
    Send("SYNC")
    ShowPicker()
end
