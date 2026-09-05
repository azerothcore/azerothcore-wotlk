local prefix = "RPOV"
local players, rows, hidden = {}, {}, {}
local page, more, lastState, pending, active = 0, false, 0, nil, false
local classNames = {"Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Death Knight", "Shaman", "Mage", "Warlock", "", "Druid"}
local powerNames = {[0] = "Mana", [1] = "Rage", [2] = "Focus", [3] = "Energy", [6] = "Runic power"}
local powerColors = {[0] = {0.15, 0.4, 1}, [1] = {0.9, 0.15, 0.1}, [2] = {1, 0.5, 0.2}, [3] = {1, 0.85, 0.1}, [6] = {0, 0.8, 1}}

local function panel(name, width, height)
    local f = CreateFrame("Frame", name, UIParent)
    f:SetSize(width, height)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = {left = 11, right = 12, top = 12, bottom = 11}})
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    return f
end

local function label(parent, x, y, text, font)
    local l = parent:CreateFontString(nil, "OVERLAY", font or "GameFontHighlightSmall")
    l:SetPoint("TOPLEFT", x, y)
    l:SetText(text)
    return l
end

local function button(parent, text, x, y, width, click)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(width, 24)
    b:SetPoint("TOPLEFT", x, y)
    b:SetText(text)
    b:SetScript("OnClick", click)
    return b
end

local picker = panel("ReforgedPOVPicker", 440, 470)
picker:Hide()
table.insert(UISpecialFrames, "ReforgedPOVPicker")
label(picker, 22, -22, "Reforged — Live spectator", "GameFontNormalLarge")
label(picker, 22, -48, "Choose an online character, including simulated players.")
local status = label(picker, 22, -405, "Requires the server extension and a GM account.")
status:SetWidth(390)
status:SetJustifyH("LEFT")
local close = CreateFrame("Button", nil, picker, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", -4, -4)
close:SetScript("OnClick", function() picker:Hide() end)

local nameBox = CreateFrame("EditBox", nil, picker, "InputBoxTemplate")
nameBox:SetSize(235, 24)
nameBox:SetPoint("TOPLEFT", 28, -75)
nameBox:SetAutoFocus(false)
nameBox:SetMaxLetters(24)

local hud = panel("ReforgedPOVHUD", 420, 216)
hud:ClearAllPoints()
hud:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 65)
hud:Hide()
local title = label(hud, 22, -22, "Live spectator", "GameFontNormalLarge")
local activity = label(hud, 22, -47, "Connecting…")

local function bar(y, r, g, b)
    local f = CreateFrame("StatusBar", nil, hud)
    f:SetSize(376, 18)
    f:SetPoint("TOPLEFT", 22, y)
    f:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    f:SetStatusBarColor(r, g, b)
    local bg = f:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture(0.12, 0.12, 0.12, 0.9)
    f.text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.text:SetPoint("CENTER")
    return f
end
local health, power, targetBar, castBar = bar(-67, 0.1, 0.7, 0.2), bar(-89, 0.15, 0.4, 1), bar(-111, 0.65, 0.2, 0.2), bar(-133, 1, 0.7, 0.1)

local function setBar(f, value, maximum, text)
    maximum = math.max(tonumber(maximum) or 0, 1)
    f:SetMinMaxValues(0, maximum)
    f:SetValue(math.min(tonumber(value) or 0, maximum))
    f.text:SetText(text)
end

local function command(text)
    SendChatMessage(".pov " .. text, "SAY")
    pending = GetTime()
end

local function refresh()
    status:SetText("Loading online players…")
    command("list " .. page)
end

local function watch(name)
    name = (name or ""):match("^%s*(.-)%s*$")
    if name == "" or name:find("[%s%c|]") then
        status:SetText("Enter a character name or choose one below.")
        return
    end
    status:SetText("Connecting to " .. name .. "…")
    command("watch " .. name)
end

button(picker, "Watch", 280, -75, 130, function() watch(nameBox:GetText()) end)
nameBox:SetScript("OnEnterPressed", function(self) self:ClearFocus(); watch(self:GetText()) end)
nameBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
button(picker, "Refresh", 22, -434, 105, refresh)
local prev = button(picker, "Previous", 168, -434, 105, function() page = math.max(0, page - 1); refresh() end)
local nextPage = button(picker, "Next", 305, -434, 105, function() if more then page = page + 1; refresh() end end)
prev:Disable()
nextPage:Disable()
button(hud, "Choose player", 22, -172, 170, function() picker:Show(); refresh() end)
button(hud, "Stop watching", 224, -172, 174, function() command("stop"); activity:SetText("Returning to your character…") end)

local scroll = CreateFrame("ScrollFrame", "ReforgedPOVScroll", picker, "UIPanelScrollFrameTemplate")
scroll:SetPoint("TOPLEFT", 22, -111)
scroll:SetSize(374, 282)
local content = CreateFrame("Frame", nil, scroll)
content:SetSize(374, 1)
scroll:SetScrollChild(content)

local function render()
    for _, row in ipairs(rows) do row:Hide() end
    for i, p in ipairs(players) do
        local row = rows[i]
        if not row then
            row = CreateFrame("Button", nil, content)
            row:SetSize(374, 27)
            row:SetPoint("TOPLEFT", 0, -(i - 1) * 28)
            row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
            row.text = label(row, 5, -6, "")
            row:SetScript("OnClick", function(self) watch(self.playerName) end)
            rows[i] = row
        end
        row.playerName = p[2]
        row.text:SetText(p[2] .. "  —  " .. p[3] .. " " .. (classNames[tonumber(p[4])] or ""))
        row:Show()
    end
    content:SetHeight(math.max(1, #players * 28))
    scroll:SetVerticalScroll(0)
end

local normalFrames = {"PlayerFrame", "TargetFrame", "FocusFrame", "MainMenuBar", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarLeft", "MultiBarRight", "PetActionBarFrame", "CastingBarFrame", "MinimapCluster", "QuestWatchFrame"}
local function hideObserverUI()
    if InCombatLockdown() then return end
    for _, name in ipairs(normalFrames) do
        local f = _G[name]
        if f and f:IsShown() then hidden[f] = true; f:Hide() end
    end
end

local function restoreUI()
    if InCombatLockdown() then return end
    for f in pairs(hidden) do f:Show() end
    hidden = {}
end

local function split(text)
    local result = {}
    for field in (text .. "|"):gmatch("(.-)|") do result[#result + 1] = field end
    return result
end

local events = CreateFrame("Frame")
events:RegisterEvent("CHAT_MSG_ADDON")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(self, event, incomingPrefix, message, channel, sender)
    if event == "PLAYER_REGEN_ENABLED" then
        if active then hideObserverUI() else restoreUI() end
        return
    end
    if incomingPrefix ~= prefix or channel ~= "WHISPER" then return end
    -- Server packets have no sender GUID. Never accept another player's HUD data.
    if sender and sender ~= "" and sender ~= UnitName("player") then return end
    local data = split(message)
    local kind = data[1]
    if kind == "BEGIN" then
        players = {}
        page = tonumber(data[2]) or 0
    elseif kind == "PLAYER" and #data >= 5 then
        players[#players + 1] = data
    elseif kind == "END" then
        pending = nil
        more = data[2] == "1"
        if page > 0 then prev:Enable() else prev:Disable() end
        if more then nextPage:Enable() else nextPage:Disable() end
        render()
        status:SetText(#players == 0 and "No observable players on this page. Try Refresh." or ("Page " .. (page + 1) .. " — click a character to watch."))
    elseif kind == "WATCH" then
        title:SetText("Watching " .. (data[2] or "player"))
        activity:SetText("Loading the player's view…")
        lastState = GetTime()
        hud:Show()
        picker:Hide()
    elseif kind == "STATE" and #data >= 15 then
        if not active then picker:Hide() end
        pending, active, lastState = nil, true, GetTime()
        hideObserverUI()
        hud:Show()
        title:SetText("Watching " .. data[2])
        activity:SetText("LIVE  •  " .. data[15])
        setBar(health, data[3], data[4], "Health  " .. data[3] .. " / " .. data[4])
        local color = powerColors[tonumber(data[5])] or {0.6, 0.6, 0.6}
        power:SetStatusBarColor(unpack(color))
        setBar(power, data[6], data[7], (powerNames[tonumber(data[5])] or "Power") .. "  " .. data[6] .. " / " .. data[7])
        setBar(targetBar, data[9], data[10], data[8] ~= "" and ("Target: " .. data[8] .. "  " .. data[9] .. " / " .. data[10]) or "No target")
        local spell, remaining, total = tonumber(data[11]) or 0, tonumber(data[12]) or 0, tonumber(data[13]) or 0
        setBar(castBar, math.max(0, total - remaining), total, spell > 0 and ((GetSpellInfo(spell) or "Casting") .. string.format("  %.1fs", remaining / 1000)) or "No active cast")
    elseif kind == "STOP" then
        active, pending = false, nil
        restoreUI()
        hud:Hide()
        status:SetText("Stopped watching. Choose a player to start again.")
    elseif kind == "ERROR" then
        pending = nil
        status:SetText(data[2] or "Spectator request failed.")
        activity:SetText(data[2] or "Spectator request failed.")
    end
end)

events:SetScript("OnUpdate", function()
    if pending and GetTime() - pending > 10 then
        pending = nil
        status:SetText("No reply. Check that the server extension is installed and you have GM access.")
    end
    if hud:IsShown() and GetTime() - lastState > 5 then
        activity:SetText("Waiting for live data… You can still stop watching.")
    end
end)

SLASH_REFORGEDPOV1 = "/pov"
SlashCmdList.REFORGEDPOV = function(text)
    text = (text or ""):match("^%s*(.-)%s*$")
    if text == "stop" then command("stop")
    elseif text ~= "" then watch(text)
    else picker:Show(); refresh() end
end
