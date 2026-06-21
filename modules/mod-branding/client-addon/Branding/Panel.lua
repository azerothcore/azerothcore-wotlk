--[[
  Branding -- Character panel.

  A tabbed window rendering the CHAR snapshot the server pushes: brand proficiency, mastery,
  loadout, equipped item brand, and allegiance. Display-only (the server owns all selection /
  validation; changes are made with the server's commands). See §19.4.
]]

local ADDON, ns = ...

local TABS = { "Brands", "Mastery", "Loadout", "Item", "Allegiance" }

local function pct(x) return string.format("%.0f%%", (x or 0) * 100) end
local function mul(x) return string.format("x%.2f", x or 0) end

-- Each renderer returns the multi-line body string for its tab from ns.state.char.
local renderers = {}

renderers["Brands"] = function(c)
    if not c or #c.brands == 0 then
        return "|cff888888No brand proficiency earned yet.|r\n\nEarn it through invasions, raids,\ngathering and crafting."
    end
    local lines = { "|cffffd100Brand proficiency|r\n" }
    for _, b in ipairs(c.brands) do
        lines[#lines + 1] = string.format("  %-9s  level %d   effect %s",
            ns.BrandName[b.brand] or "?", b.level, pct(b.strength))
    end
    return table.concat(lines, "\n")
end

renderers["Mastery"] = function(c)
    if not c then return "|cff888888No data.|r" end
    local lines = { "|cffffd100Mastery|r  (dual-key: account unlock x character skill)\n" }
    for _, m in ipairs(c.masteries) do
        local lock = m.unlocked and "|cff55ff55unlocked|r" or "|cffff5555locked|r"
        lines[#lines + 1] = string.format("  %-10s %s   level %d   bonus +%s",
            ns.MasteryName[m.system] or "?", lock, m.level, pct(m.bonus))
    end
    return table.concat(lines, "\n")
end

renderers["Loadout"] = function(c)
    if not c then return "|cff888888No data.|r" end
    return string.format("|cffffd100Active loadout|r\n\n  Brand:          %s\n  Proc archetype: %d\n\n|cff888888Change with the server's branding\ncommands (setbrand / setproc).|r",
        ns.BrandName[c.loadout.activeBrand] or "?", c.loadout.archetype)
end

renderers["Item"] = function(c)
    if not c or not c.item.equipped then
        return "|cff888888No branded weapon equipped.|r"
    end
    local it = c.item
    return string.format("|cffffd100Equipped weapon brand|r\n\n  Brand:     %s\n  Step:      %d\n  Level:     %d\n  Intensity: %s",
        ns.BrandName[it.brand] or "?", it.step, it.level, mul(it.intensity))
end

renderers["Allegiance"] = function(c)
    if not c then return "|cff888888No data.|r" end
    local a = c.allegiance
    if a.id == 0 then
        return "|cff888888No allegiance chosen.|r\n\nPick a side to gain efficiency on\naligned content."
    end
    return string.format("|cffffd100Allegiance|r\n\n  Side:       %s\n  Efficiency: %s on aligned content",
        ns.AllegianceName[a.id] or "?", mul(a.efficiency))
end

local function CreatePanel()
    if ns.panel then return end

    local f = CreateFrame("Frame", "BrandingPanel", UIParent)
    f:SetWidth(380)
    f:SetHeight(280)
    f:SetPoint(ns.db.panelPoint or "CENTER", UIParent, ns.db.panelRel or "CENTER",
        ns.db.panelX or 0, ns.db.panelY or 0)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    })
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, rel, x, y = self:GetPoint()
        ns.db.panelPoint, ns.db.panelRel, ns.db.panelX, ns.db.panelY = point, rel, x, y
    end)
    f:SetFrameStrata("HIGH")
    f:Hide()

    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -14)
    title:SetText("Branding")

    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -6, -6)
    close:SetScript("OnClick", function() f:Hide() end)

    -- Tab buttons across the top.
    f.tabs = {}
    local prev
    for i, name in ipairs(TABS) do
        local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        b:SetWidth(70)
        b:SetHeight(20)
        b:SetText(name)
        if prev then
            b:SetPoint("LEFT", prev, "RIGHT", 2, 0)
        else
            b:SetPoint("TOPLEFT", 14, -36)
        end
        b:SetScript("OnClick", function()
            ns.activeTab = name
            ns.RenderPanel()
        end)
        f.tabs[name] = b
        prev = b
    end

    f.body = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.body:SetPoint("TOPLEFT", 18, -64)
    f.body:SetPoint("BOTTOMRIGHT", -16, 16)
    f.body:SetJustifyH("LEFT")
    f.body:SetJustifyV("TOP")

    ns.panel = f
    ns.activeTab = ns.activeTab or "Brands"
    ns.RenderPanel()
end

function ns.RenderPanel()
    local f = ns.panel
    if not f then return end

    for name, b in pairs(f.tabs) do
        if name == ns.activeTab then
            b:LockHighlight()
        else
            b:UnlockHighlight()
        end
    end

    local render = renderers[ns.activeTab] or renderers["Brands"]
    f.body:SetText(render(ns.state.char))
end

function ns.TogglePanel()
    if not ns.panel then return end
    if ns.panel:IsShown() then
        ns.panel:Hide()
    else
        ns.panel:Show()
        ns.RenderPanel()
    end
end

ns.CreatePanel = CreatePanel
ns:On("char", function() if ns.panel and ns.panel:IsShown() then ns.RenderPanel() end end)
