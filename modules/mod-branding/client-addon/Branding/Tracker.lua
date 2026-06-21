--[[
  Branding -- Invasion Tracker HUD.

  A small movable frame showing the current zone's event (type + live containment bar) and your
  contribution (points + tier), plus a compact schedule list of upcoming/active events. Fed entirely
  by server pushes (EVT / YOU / SCH frames). See §19.4.
]]

local ADDON, ns = ...

local function fmtTime(sec)
    sec = math.max(0, math.floor(sec or 0))
    return string.format("%d:%02d", math.floor(sec / 60), sec % 60)
end

-- We only know zone ids on the wire. The current-event zone is the player's zone, so show its real
-- name; other scheduled zones fall back to their id.
local function zoneLabel(zoneId)
    if ns.state.event and ns.state.event.zoneId == zoneId then
        local z = GetRealZoneText()
        if z and z ~= "" then return z end
    end
    return "Zone " .. tostring(zoneId)
end

local SCHED_ROWS = 4

local function CreateTracker()
    if ns.tracker then return end

    local f = CreateFrame("Frame", "BrandingTracker", UIParent)
    f:SetWidth(230)
    f:SetHeight(150)
    f:SetPoint(ns.db.trackerPoint or "CENTER", UIParent, ns.db.trackerRel or "CENTER",
        ns.db.trackerX or 250, ns.db.trackerY or 0)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, rel, x, y = self:GetPoint()
        ns.db.trackerPoint, ns.db.trackerRel, ns.db.trackerX, ns.db.trackerY = point, rel, x, y
    end)

    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", 0, -8)
    title:SetText("Branding")

    f.eventText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.eventText:SetPoint("TOPLEFT", 12, -26)
    f.eventText:SetPoint("TOPRIGHT", -12, -26)
    f.eventText:SetJustifyH("LEFT")

    local bar = CreateFrame("StatusBar", nil, f)
    bar:SetPoint("TOPLEFT", 12, -42)
    bar:SetPoint("TOPRIGHT", -12, -42)
    bar:SetHeight(14)
    bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    bar:SetStatusBarColor(0.2, 0.6, 0.9)
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    local barBg = bar:CreateTexture(nil, "BACKGROUND")
    barBg:SetAllPoints()
    barBg:SetTexture(0, 0, 0, 0.5)
    f.bar = bar
    f.barText = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.barText:SetPoint("CENTER")

    f.youText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.youText:SetPoint("TOPLEFT", 12, -60)

    local schedTitle = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    schedTitle:SetPoint("TOPLEFT", 12, -78)
    schedTitle:SetText("|cffaaaaaaSchedule|r")

    f.rows = {}
    for i = 1, SCHED_ROWS do
        local row = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row:SetPoint("TOPLEFT", 12, -92 - (i - 1) * 13)
        row:SetPoint("TOPRIGHT", -12, -92 - (i - 1) * 13)
        row:SetJustifyH("LEFT")
        f.rows[i] = row
    end

    ns.tracker = f
    ns.RefreshTracker()
    if ns.db.trackerHidden then f:Hide() end
end

function ns.RefreshTracker()
    local f = ns.tracker
    if not f then return end

    local ev = ns.state.event
    if ev and ev.active then
        f.eventText:SetText(string.format("|cff66ccff%s|r in %s", ns.EventName[ev.type] or "Event", zoneLabel(ev.zoneId)))
        f.bar:Show()
        f.bar:SetValue(ev.containment)
        f.barText:SetText(string.format("%.0f%% contained", ev.containment * 100))
    else
        f.eventText:SetText("|cff888888No active event in this zone|r")
        f.bar:SetValue(0)
        f.barText:SetText("--")
    end

    local you = ns.state.you
    if you then
        local tier = ns.TierName[you.tier] or "None"
        local col = ns.TierColor[you.tier] or "ffffffff"
        f.youText:SetText(string.format("You: %d pts  (|c%s%s|r)", you.points, col, tier))
    else
        f.youText:SetText("You: --")
    end

    local entries = ns.state.schedule and ns.state.schedule.entries or {}
    for i = 1, SCHED_ROWS do
        local e = entries[i]
        if e then
            local stateCol = (e.state == 1) and "ff55ff55" or "ffaaaaaa"
            f.rows[i]:SetText(string.format("%s |c%s%s|r %s",
                ns.EventName[e.type] or "?", stateCol, ns.StateName[e.state] or "?", fmtTime(e.sec)))
        else
            f.rows[i]:SetText("")
        end
    end
    if ns.state.schedule and ns.state.schedule.truncated then
        f.rows[SCHED_ROWS]:SetText("|cff888888...more|r")
    end
end

function ns.ToggleTracker()
    if not ns.tracker then return end
    if ns.tracker:IsShown() then
        ns.tracker:Hide()
        ns.db.trackerHidden = true
    else
        ns.tracker:Show()
        ns.db.trackerHidden = false
    end
end

ns.CreateTracker = CreateTracker
ns:On("event", function() ns.RefreshTracker() end)
ns:On("you", function() ns.RefreshTracker() end)
ns:On("schedule", function() ns.RefreshTracker() end)
