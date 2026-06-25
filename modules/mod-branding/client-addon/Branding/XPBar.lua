--[[
  Branding -- Mastery XP bar (issue #54).

  Renders the ACTIVE brand's proficiency progression on (over) the native XP bar, the way reputation
  can be watched there -- but driven entirely by the server's own numbers (the XPB push; see §19.2).
  The server owns the §7.4 curve and sends the decomposed position (level + xpInto/xpFor + prestige);
  this surface only draws fill = xpInto/xpFor and a label, tinted by the brand's school (cosmetic).

  It is a PLAIN, UNPROTECTED overlay: it never touches the secure Blizzard XP frame internals and
  never calls MainMenuExpBar_Update, so there is no taint (same discipline as the talent-frame dock).
  By default it sits over the MainMenuExpBar region; it is movable and remembers its position.
]]

local ADDON, ns = ...

local function CreateXPBar()
    if ns.xpbar then return end

    local f = CreateFrame("Frame", "BrandingXPBar", UIParent)
    f:SetFrameStrata("HIGH")
    f:SetWidth(MainMenuExpBar and MainMenuExpBar:GetWidth() or 480)
    f:SetHeight(12)
    -- Default: hug the native XP bar. A saved drag position overrides this.
    if ns.db.xpbarPoint then
        f:SetPoint(ns.db.xpbarPoint, UIParent, ns.db.xpbarRel or ns.db.xpbarPoint,
            ns.db.xpbarX or 0, ns.db.xpbarY or 0)
    elseif MainMenuExpBar then
        f:SetPoint("BOTTOM", MainMenuExpBar, "TOP", 0, 1)
    else
        f:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 12)
    end

    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, rel, x, y = self:GetPoint()
        ns.db.xpbarPoint, ns.db.xpbarRel, ns.db.xpbarX, ns.db.xpbarY = point, rel, x, y
    end)

    local bar = CreateFrame("StatusBar", nil, f)
    bar:SetAllPoints(f)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    f.bar = bar

    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture(0, 0, 0, 0.6)

    f.label = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.label:SetPoint("CENTER")

    ns.xpbar = f
    ns.RefreshXPBar()
    if ns.db.xpbarHidden then f:Hide() end
end

-- Compact integer label (e.g. 12345 -> "12.3k") so the bar text stays readable.
local function short(n)
    n = n or 0
    if n >= 1000000 then return string.format("%.1fm", n / 1000000) end
    if n >= 1000 then return string.format("%.1fk", n / 1000) end
    return string.format("%d", n)
end

function ns.RefreshXPBar()
    local f = ns.xpbar
    if not f then return end

    local xp = ns.state.xp
    if not xp then
        f.bar:SetValue(0)
        f.bar:SetStatusBarColor(0.4, 0.4, 0.4)
        f.label:SetText("|cff888888No active brand|r")
        return
    end

    local c = ns.SchoolColor[xp.brand] or { 0.4, 0.6, 0.9 }
    f.bar:SetStatusBarColor(c[1], c[2], c[3])

    local name = ns.BrandName[xp.brand] or "Brand"
    if xp.prestige then
        -- Graduated (§14.13.4): full bar, no remaining span.
        f.bar:SetValue(1)
        f.label:SetText(string.format("%s -- |cffffd700Prestige|r (Lv %d)", name, xp.level))
    else
        local frac = (xp.xpFor > 0) and (xp.xpInto / xp.xpFor) or 0
        f.bar:SetValue(frac)
        f.label:SetText(string.format("%s  Lv %d   %s / %s  (%.0f%%)",
            name, xp.level, short(xp.xpInto), short(xp.xpFor), frac * 100))
    end
end

function ns.ToggleXPBar()
    if not ns.xpbar then return end
    if ns.xpbar:IsShown() then
        ns.xpbar:Hide()
        ns.db.xpbarHidden = true
    else
        ns.xpbar:Show()
        ns.db.xpbarHidden = false
    end
end

ns.CreateXPBar = CreateXPBar
ns:On("xp", function() ns.RefreshXPBar() end)
