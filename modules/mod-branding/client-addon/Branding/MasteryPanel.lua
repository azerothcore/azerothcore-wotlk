--[[
  Branding -- Mastery panel (issue #32, §14 / §19).

  A STANDALONE frame showing the §14 Mastery lattice: all 7 standard WoW damage schools x 3 trees
  (Def / Off / Support). Each cell shows its archetype/expression family, earned mastery level, and
  the per-axis
  point-buy allocation (§14.10: ppm / duration / magnitude / reach -- only the axes the cell exposes),
  plus a respec button.

  WHY A STANDALONE FRAME (not a native talent-frame tab): wiring into PlayerTalentFrame natively would
  need client DBC + secure-frame edits and would taint the protected talent frame. Instead this addon
  ships inside a custom patch-MPQ and DOCKS a button onto PlayerTalentFrame (see Dock() below) that
  merely TOGGLES this separate, unprotected frame. The talent frame itself is never modified, so no
  taint. (Decision recorded in the client-addon README.)

  SERVER-AUTHORITATIVE: this is a renderer. It displays the MAST snapshot the server pushes and sends
  allocation / archetype / respec REQUESTS over the §19 transport. The server validates and applies;
  the addon never mutates state locally. Request sending is gated behind ns.CanSend() because 3.3.5a
  has no guaranteed solo client->server addon hook (see Comms.lua) -- the wire grammar is defined and
  mirrored here so the path lights up the moment the server enables a client->server channel.

  MULTI-MASTERY forward-compat: ns.state.mastery.cells is a LIST and each cell carries its own
  `active` flag. The model and layout never assume a single active mastery -- the frame renders the
  full lattice and highlights ALL active cells, so running multiple masteries at once needs no
  structural change here (only more cells flagged active by the server).
]]

local ADDON, ns = ...

-- §14.1 lattice axes. Schools are BrandId ordinals; trees are MasteryTree ordinals.
-- All 7 standard WoW damage schools (issue #32): the full BrandId set, in §14.4 authoring order
-- (Fire, Nature, Shadow, Frost, Arcane, Holy, Physical). Arcane/Holy now render too -- the server
-- pages the lattice one frame per school (§19.2) and Comms.lua merges, so all 7 arrive.
local SCHOOLS = { 0, 2, 3, 1, 4, 5, 6 }      -- Fire, Nature, Shadow, Frost, Arcane, Holy, Physical
local TREES = { 0, 1, 2 }                    -- Def, Off, Support
ns.TreeName = { [0] = "Def", [1] = "Off", [2] = "Support" }
ns.AxisName = { [0] = "PPM", [1] = "Dur", [2] = "Mag", [3] = "Reach" }

-- §14.4.2: how the Reach axis renders for a cell -- a field-shaped radius (yards) vs a spread/cleave
-- target count. Drives the tooltip label so "Reach" reads as "hits N targets" or "N yd radius".
ns.ReachModeName = { [1] = "Reach (yd radius)", [2] = "Reach (targets hit)" }
local function reachAxisLabel(c, axis)
  if axis == 3 and c.reachMode and ns.ReachModeName[c.reachMode] then
    return ns.ReachModeName[c.reachMode]
  end
  return ns.AxisName[axis]
end
ns.KindName = { [0] = "Spike", [1] = "Window", [2] = "Transform" }

-- Bit per axis in a cell's applicable-axis mask (mirrors core AxisBit / ProcAxis order).
local function axisApplies(mask, axis)
  return bit.band(mask or 0, bit.lshift(1, axis)) ~= 0
end

-- Index the pushed lattice by (school, tree) for O(1) cell lookup during render.
local function cellAt(school, tree)
  local m = ns.state.mastery
  if not m then return nil end
  for _, c in ipairs(m.cells) do
    if c.school == school and c.tree == tree then
      return c
    end
  end
  return nil
end

-- ---- One cell button on the lattice grid ----
local function cellTooltip(c)
  if not c then return end
  GameTooltip:SetOwner(MasteryPanelGrid, "ANCHOR_RIGHT")
  GameTooltip:AddLine(string.format("%s -- %s",
    ns.BrandName[c.school] or "?", ns.TreeName[c.tree] or "?"), 1, 0.82, 0)
  local tags = ns.KindName[c.kind] or "?"
  if c.sustained then tags = tags .. ", sustained aura" end
  if c.situational then tags = tags .. ", situational (school-matched)" end
  GameTooltip:AddLine(tags, 0.7, 0.7, 0.7)
  GameTooltip:AddLine("Earned level: " .. (c.level or 0), 1, 1, 1)
  if c.active then GameTooltip:AddLine("|cff55ff55ACTIVE|r") end
  GameTooltip:AddLine(" ")
  for axis = 0, 3 do
    if axisApplies(c.axisMask, axis) then
      GameTooltip:AddLine(string.format("  %-18s %d pts", reachAxisLabel(c, axis), c.alloc[axis + 1] or 0), 0.9, 0.9, 0.9)
    end
  end
  GameTooltip:AddLine(" ")
  GameTooltip:AddLine("|cff888888Left-click a cell to select it, then spend points below.|r")
  GameTooltip:Show()
end

local function refreshCellButton(btn)
  local c = cellAt(btn.school, btn.tree)
  btn.cell = c
  if not c then
    btn.label:SetText("|cff555555--|r")
    btn:SetBackdropBorderColor(0.3, 0.3, 0.3)
    return
  end
  -- Sum of spent points across the applicable axes -> a quick "investment" readout.
  local spent = 0
  for axis = 0, 3 do
    if axisApplies(c.axisMask, axis) then spent = spent + (c.alloc[axis + 1] or 0) end
  end
  btn.label:SetText(string.format("L%d\n%dp", c.level or 0, spent))
  if c.active then
    btn:SetBackdropBorderColor(0.3, 1, 0.3)         -- active cell: green
  elseif spent > 0 then
    btn:SetBackdropBorderColor(0.9, 0.78, 0)        -- invested: gold
  else
    btn:SetBackdropBorderColor(0.5, 0.5, 0.5)
  end
  if ns.mastery and ns.mastery.selected
     and ns.mastery.selected.school == c.school and ns.mastery.selected.tree == c.tree then
    btn:SetBackdropBorderColor(0.4, 0.7, 1)         -- selected cell: blue
  end
end

-- ---- Axis point-buy row (below the grid, for the selected cell) ----
local function refreshAxes()
  local f = ns.mastery
  if not f then return end
  local sel = f.selected
  local c = sel and cellAt(sel.school, sel.tree)

  if not c then
    f.selTitle:SetText("|cff888888Select a cell above.|r")
    for axis = 0, 3 do f.axisRows[axis]:Hide() end
    f.respec:Disable()
    return
  end

  f.selTitle:SetText(string.format("|cffffd100%s -- %s|r  (earned level %d)%s",
    ns.BrandName[c.school] or "?", ns.TreeName[c.tree] or "?", c.level or 0,
    c.active and "  |cff55ff55[ACTIVE]|r" or ""))

  for axis = 0, 3 do
    local row = f.axisRows[axis]
    if axisApplies(c.axisMask, axis) then
      row.text:SetText(string.format("%-6s  %d pts", ns.AxisName[axis], c.alloc[axis + 1] or 0))
      row:Show()
    else
      row:Hide()
    end
  end

  if ns.CanSend() then f.respec:Enable() else f.respec:Disable() end
end

-- Send a point allocation request (server validates the §14.10 budget + caps).
local function sendAlloc(school, tree, axis, points)
  ns:SendAlloc(school, tree, axis, points)
end

local function CreateMasteryPanel()
  if ns.mastery then return end

  local f = CreateFrame("Frame", "BrandingMasteryPanel", UIParent)
  f:SetWidth(520)
  f:SetHeight(520)          -- tall enough for all 7 schools (issue #32) + the detail/point-buy area
  f:SetPoint(ns.db.masteryPoint or "CENTER", UIParent, ns.db.masteryRel or "CENTER",
    ns.db.masteryX or 0, ns.db.masteryY or 0)
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
    ns.db.masteryPoint, ns.db.masteryRel, ns.db.masteryX, ns.db.masteryY = point, rel, x, y
  end)
  f:SetFrameStrata("HIGH")
  f:Hide()

  local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", 0, -16)
  title:SetText("Mastery")

  local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", -6, -6)
  close:SetScript("OnClick", function() f:Hide() end)

  -- Unspent-points + respec-cost readout.
  f.budget = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  f.budget:SetPoint("TOP", 0, -40)

  -- The 7x3 lattice grid (all standard damage schools). A container frame so the tooltip anchors to it.
  local grid = CreateFrame("Frame", "MasteryPanelGrid", f)
  grid:SetPoint("TOPLEFT", 24, -60)
  grid:SetWidth(470)
  grid:SetHeight(286)       -- 7 rows x 38px pitch + header (issue #32)
  f.grid = grid

  -- Column headers (trees).
  for ti, tree in ipairs(TREES) do
    local h = grid:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    h:SetPoint("TOPLEFT", 70 + (ti - 1) * 128, 0)
    h:SetWidth(120)
    h:SetText(ns.TreeName[tree])
  end

  f.cellButtons = {}
  for si, school in ipairs(SCHOOLS) do
    -- Row header (school).
    local rh = grid:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    rh:SetPoint("TOPLEFT", 0, -16 - (si - 1) * 38)
    rh:SetWidth(64)
    rh:SetJustifyH("LEFT")
    rh:SetText(ns.BrandName[school] or "?")

    for ti, tree in ipairs(TREES) do
      local btn = CreateFrame("Button", nil, grid)
      btn:SetWidth(118)
      btn:SetHeight(34)
      btn:SetPoint("TOPLEFT", 70 + (ti - 1) * 128, -14 - (si - 1) * 38)
      btn:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 8, edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
      })
      btn:SetBackdropColor(0.08, 0.08, 0.12, 0.9)
      btn.school = school
      btn.tree = tree
      btn.label = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
      btn.label:SetAllPoints()
      btn:SetScript("OnEnter", function(self) cellTooltip(self.cell) end)
      btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
      btn:SetScript("OnClick", function(self)
        ns.mastery.selected = { school = self.school, tree = self.tree }
        ns.RenderMastery()
      end)
      f.cellButtons[#f.cellButtons + 1] = btn
    end
  end

  -- Selected-cell detail + point-buy area.
  f.selTitle = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  f.selTitle:SetPoint("TOPLEFT", 24, -360)
  f.selTitle:SetPoint("TOPRIGHT", -24, -360)
  f.selTitle:SetJustifyH("LEFT")

  f.axisRows = {}
  for axis = 0, 3 do
    local row = CreateFrame("Frame", nil, f)
    row:SetWidth(470)
    row:SetHeight(24)
    row:SetPoint("TOPLEFT", 28, -382 - axis * 26)

    row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.text:SetPoint("LEFT", 0, 0)
    row.text:SetWidth(180)
    row.text:SetJustifyH("LEFT")

    local minus = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
    minus:SetWidth(24); minus:SetHeight(20)
    minus:SetPoint("LEFT", 188, 0)
    minus:SetText("-")
    minus:SetScript("OnClick", function()
      local c = ns.mastery.selected and cellAt(ns.mastery.selected.school, ns.mastery.selected.tree)
      if not c then return end
      local cur = c.alloc[axis + 1] or 0
      if cur > 0 then sendAlloc(c.school, c.tree, axis, cur - 1) end
    end)

    local plus = CreateFrame("Button", nil, row, "UIPanelButtonTemplate")
    plus:SetWidth(24); plus:SetHeight(20)
    plus:SetPoint("LEFT", 216, 0)
    plus:SetText("+")
    plus:SetScript("OnClick", function()
      local c = ns.mastery.selected and cellAt(ns.mastery.selected.school, ns.mastery.selected.tree)
      if not c then return end
      sendAlloc(c.school, c.tree, axis, (c.alloc[axis + 1] or 0) + 1)
    end)

    row.minus, row.plus = minus, plus
    row:Hide()
    f.axisRows[axis] = row
  end

  -- Respec the selected cell (charges the §14.5 token server-side).
  f.respec = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
  f.respec:SetWidth(120); f.respec:SetHeight(22)
  f.respec:SetPoint("BOTTOMRIGHT", -24, 20)
  f.respec:SetText("Respec cell")
  f.respec:SetScript("OnClick", function()
    local sel = ns.mastery.selected
    if sel then ns:SendRespec(sel.school, sel.tree) end
  end)

  f.hint = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  f.hint:SetPoint("BOTTOMLEFT", 24, 22)
  f.hint:SetJustifyH("LEFT")

  ns.mastery = f
  ns.RenderMastery()
end

function ns.RenderMastery()
  local f = ns.mastery
  if not f then return end

  local m = ns.state.mastery
  if m then
    f.budget:SetText(string.format("Unspent points: |cffffd100%d|r    Respec cost: |cffff8888%d|r token(s)",
      m.pointsAvailable or 0, m.respecCost or 0))
  else
    f.budget:SetText("|cff888888Waiting for server mastery data...|r")
  end

  for _, btn in ipairs(f.cellButtons) do
    refreshCellButton(btn)
  end
  refreshAxes()

  if ns.CanSend() then
    f.hint:SetText("|cff888888Point changes are server-validated (§14.10 budget + caps).|r")
  else
    f.hint:SetText("|cff888888Display-only on this realm: a client->server channel is not enabled,\nso allocate via the server's branding commands. The lattice reflects server state.|r")
  end
end

function ns.ToggleMastery()
  if not ns.mastery then return end
  if ns.mastery:IsShown() then
    ns.mastery:Hide()
  else
    -- Ask the server for a fresh lattice on open (no-op if client->server is unavailable).
    ns:RequestMastery()
    ns.mastery:Show()
    ns.RenderMastery()
  end
end

-- ---- Dock a toggle button onto PlayerTalentFrame (safe: opens a SEPARATE frame, no taint) ----
local function Dock()
  if ns.masteryDock or not PlayerTalentFrame then return end
  local b = CreateFrame("Button", "BrandingMasteryDockButton", PlayerTalentFrame, "UIPanelButtonTemplate")
  b:SetWidth(90); b:SetHeight(22)
  -- Anchor to the talent frame's own region; we only PARENT to it, never modify its protected guts.
  b:SetPoint("BOTTOMRIGHT", PlayerTalentFrame, "BOTTOMRIGHT", -40, 80)
  b:SetText("Mastery")
  b:SetFrameStrata("HIGH")
  b:SetScript("OnClick", function() ns.ToggleMastery() end)
  ns.masteryDock = b
end

-- PlayerTalentFrame is created lazily by Blizzard_TalentUI; hook its load so we dock once it exists.
local function HookTalentFrame()
  if PlayerTalentFrame then
    Dock()
    return
  end
  -- Load-on-demand: dock right after the talent UI addon loads.
  local watcher = CreateFrame("Frame")
  watcher:RegisterEvent("ADDON_LOADED")
  watcher:SetScript("OnEvent", function(self, _, name)
    if name == "Blizzard_TalentUI" or PlayerTalentFrame then
      Dock()
      if PlayerTalentFrame then self:UnregisterAllEvents() end
    end
  end)
end

ns.CreateMastery = CreateMasteryPanel
ns.HookMasteryDock = HookTalentFrame

-- Re-render on the server's MAST push if the frame is open.
ns:On("mastery", function() if ns.mastery and ns.mastery:IsShown() then ns.RenderMastery() end end)
