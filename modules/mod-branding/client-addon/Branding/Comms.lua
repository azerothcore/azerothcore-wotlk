--[[
  Branding -- Comms layer.

  Receives the server's BRND addon-message frames (§19) and decodes them into ns.state, then fires
  named callbacks the UI modules subscribe to. This file mirrors, in Lua, the pure server-side wire
  codec in modules/mod-branding/src/core/addon/Protocol.cpp -- same grammar: tab between fields, ';'
  between list records, ':' between a record's sub-fields, floats carried as permille (x1000).

  Transport is server-push only: the server pushes on login, on zone change, on event start/stop, and
  on a periodic tick. The addon never sends -- it is a pure renderer. (See §19.1.)
]]

local ADDON, ns = ...

ns.PROTOCOL = 2                  -- v2 adds the §14 Mastery (MAST) frame + mastery request grammar
ns.PREFIX = "BRND"

-- Latest decoded state. UI reads these; nil/empty until the first push arrives.
ns.state = {
    hello = nil,                 -- { version, enabled }
    event = nil,                 -- { zoneId, type, containment (0..1), active }
    you = nil,                   -- { points, tier }
    schedule = { entries = {}, truncated = false },
    char = nil,                  -- decoded character snapshot (see DecodeChar)
    mastery = nil,               -- decoded §14 lattice snapshot (see DecodeMastery)
    xp = nil,                    -- active-brand XP-bar progression (XPB, #54)
}

-- ---- Display name tables (mirror the server enums) ----
ns.BrandName = { [0] = "Fire", [1] = "Frost", [2] = "Nature", [3] = "Shadow", [4] = "Arcane", [5] = "Holy", [6] = "Physical" }
-- Per-school bar tint (cosmetic, #54). Keyed by BrandId ordinal; { r, g, b } in 0..1.
ns.SchoolColor = {
    [0] = { 1.00, 0.32, 0.12 },   -- Fire    (orange-red)
    [1] = { 0.40, 0.78, 1.00 },   -- Frost   (ice blue)
    [2] = { 0.30, 0.88, 0.36 },   -- Nature  (green)
    [3] = { 0.55, 0.25, 0.72 },   -- Shadow  (violet)
    [4] = { 0.82, 0.44, 0.92 },   -- Arcane  (magenta)
    [5] = { 1.00, 0.90, 0.45 },   -- Holy    (gold)
    [6] = { 0.80, 0.72, 0.56 },   -- Physical (tan)
}
ns.EventName = { [0] = "Invasion", [1] = "Resource Surge", [2] = "Elite Hunt", [3] = "Profession Anomaly" }
ns.TierName = { [0] = "None", [1] = "Bronze", [2] = "Silver", [3] = "Gold" }
ns.TierColor = { [0] = "ffffffff", [1] = "ffcd7f32", [2] = "ffc0c0c0", [3] = "ffffd700" }
ns.MasteryName = { [0] = "Gathering", [1] = "Crafting" }
ns.AllegianceName = { [0] = "None", [1] = "Fire/Chaos", [2] = "Nature/Wild", [3] = "Shadow/Void", [4] = "Titan/Order" }
ns.StateName = { [0] = "Cooldown", [1] = "Active" }

-- ---- Tiny callback registry: ns:On("event", fn); fired on each decode ----
ns.callbacks = {}
function ns:On(evt, fn)
    self.callbacks[evt] = self.callbacks[evt] or {}
    table.insert(self.callbacks[evt], fn)
end
function ns:Fire(evt)
    local list = self.callbacks[evt]
    if not list then return end
    for _, fn in ipairs(list) do
        local ok, err = pcall(fn)
        if not ok then
            DEFAULT_CHAT_FRAME:AddMessage("|cffff5555Branding error:|r " .. tostring(err))
        end
    end
end

-- ---- Parse helpers ----
local function split(s, sep)
    local out, idx = {}, 1
    while true do
        local p = string.find(s, sep, idx, true)
        if not p then
            out[#out + 1] = string.sub(s, idx)
            break
        end
        out[#out + 1] = string.sub(s, idx, p - 1)
        idx = p + 1
    end
    return out
end
ns.split = split

local function num(s) return tonumber(s) or 0 end
local function permille(s) return num(s) / 1000 end

-- "TAG=payload" character-snapshot section -> payload, or "" on a tag mismatch.
local function section(field, tag)
    local pfx = tag .. "="
    if field and string.sub(field, 1, #pfx) == pfx then
        return string.sub(field, #pfx + 1)
    end
    return ""
end

function ns:DecodeChar(t)
    local c = { brands = {}, masteries = {}, loadout = {}, item = {}, allegiance = {} }

    local brd = section(t[2], "BRD")
    if brd ~= "" then
        for _, rec in ipairs(split(brd, ";")) do
            local f = split(rec, ":")
            c.brands[#c.brands + 1] = { brand = num(f[1]), level = num(f[2]), strength = permille(f[3]) }
        end
    end

    local mst = section(t[3], "MST")
    if mst ~= "" then
        for _, rec in ipairs(split(mst, ";")) do
            local f = split(rec, ":")
            c.masteries[#c.masteries + 1] = { system = num(f[1]), unlocked = (f[2] == "1"), level = num(f[3]), bonus = permille(f[4]) }
        end
    end

    local ldt = split(section(t[4], "LDT"), ":")
    c.loadout = { activeBrand = num(ldt[1]), archetype = num(ldt[2]) }

    local itm = split(section(t[5], "ITM"), ":")
    c.item = { equipped = (itm[1] == "1"), brand = num(itm[2]), step = num(itm[3]), level = num(itm[4]), intensity = permille(itm[5]) }

    local alg = split(section(t[6], "ALG"), ":")
    c.allegiance = { id = num(alg[1]), efficiency = permille(alg[2]) }

    return c
end

-- Decode a §14 Mastery lattice frame and MERGE it into ns.state.mastery. `t` is the tab-split frame;
-- t[1]=="MAST". Mirrors the server's EncodeMastery (Protocol.cpp): t[2]=pointsAvailable,
-- t[3]=respecCost, t[4]=cell records (';'-separated; each ':'-separated as
--   school:tree:kind:situational:sustained:level:archetype:axisMask:a0:a1:a2:a3:active:reachMode),
--   where reachMode (§14.4.2) is 0=None, 1=RadiusYards, 2=TargetCount -- how the reach axis renders.
-- t[5]=truncation marker ("T" if this frame's own cells didn't fit -- a safety net, not the norm).
--
-- PAGED BY SCHOOL: the full 7-school x 3-tree lattice (21 cells) does NOT fit one 255-byte
-- CHAT_MSG_ADDON body, so the server pushes ONE frame PER SCHOOL (§19.2). We therefore MERGE: each
-- frame REPLACES the cells of whatever schools it carries and refreshes points/respec, leaving cells
-- for other schools intact. Keyed by school, so frames may arrive in any order and re-pushing one
-- school updates just that school -- we never assume a single frame is the whole lattice.
-- MULTI-MASTERY: `cells` is a flat list and each cell carries its own `active` flag, so any number
-- of cells may be active at once -- the model never assumes a single active mastery.
function ns:DecodeMastery(t)
    local m = ns.state.mastery
    if not m then
        m = { pointsAvailable = 0, respecCost = 0, cells = {}, truncated = false }
        ns.state.mastery = m
    end
    m.pointsAvailable = num(t[2])
    m.respecCost = num(t[3])
    m.truncated = (t[5] == "T")

    -- Parse this frame's cells; track which schools it covers so we can drop their stale cells.
    local incoming, schoolsSeen = {}, {}
    if t[4] and t[4] ~= "" then
        for _, rec in ipairs(split(t[4], ";")) do
            local f = split(rec, ":")
            local cell = {
                school = num(f[1]), tree = num(f[2]), kind = num(f[3]),
                situational = (f[4] == "1"), sustained = (f[5] == "1"),
                level = num(f[6]), archetype = num(f[7]), axisMask = num(f[8]),
                alloc = { num(f[9]), num(f[10]), num(f[11]), num(f[12]) },
                active = (f[13] == "1"),
                reachMode = num(f[14]),   -- §14.4.2: 0=None, 1=RadiusYards, 2=TargetCount
            }
            incoming[#incoming + 1] = cell
            schoolsSeen[cell.school] = true
        end
    end

    -- Keep cells for schools NOT in this frame, then append this frame's (refreshed) cells.
    local kept = {}
    for _, c in ipairs(m.cells) do
        if not schoolsSeen[c.school] then kept[#kept + 1] = c end
    end
    for _, c in ipairs(incoming) do kept[#kept + 1] = c end
    m.cells = kept
    return m
end

-- `message` is the frame body with the BRND prefix already stripped by the client (so it starts at
-- the KIND token). Unknown kinds are ignored (forward-compat).
local function decode(message)
    local t = split(message, "\t")
    local kind = t[1]

    if kind == "HELLO" then
        ns.state.hello = { version = num(t[2]), enabled = (t[3] == "1") }
        if ns.state.hello.version ~= ns.PROTOCOL then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00Branding:|r server protocol v" .. ns.state.hello.version
                .. " != addon v" .. ns.PROTOCOL .. " -- please update the addon.")
        end
        ns:Fire("hello")
    elseif kind == "EVT" then
        ns.state.event = { zoneId = num(t[2]), type = num(t[3]), containment = permille(t[4]), active = (t[5] == "1") }
        ns:Fire("event")
    elseif kind == "YOU" then
        ns.state.you = { points = num(t[2]), tier = num(t[3]) }
        ns:Fire("you")
    elseif kind == "SCH" then
        local list = {}
        if t[2] and t[2] ~= "" then
            for _, rec in ipairs(split(t[2], ";")) do
                local f = split(rec, ":")
                list[#list + 1] = { zoneId = num(f[1]), type = num(f[2]), state = num(f[3]), sec = num(f[4]) }
            end
        end
        ns.state.schedule = { entries = list, truncated = (t[3] == "T") }
        ns:Fire("schedule")
    elseif kind == "XPB" then
        ns.state.xp = {
            brand = num(t[2]), level = num(t[3]), maxLevel = num(t[4]),
            xpInto = num(t[5]), xpFor = num(t[6]), prestige = (t[7] == "1"),
        }
        ns:Fire("xp")
    elseif kind == "CHAR" then
        ns.state.char = ns:DecodeChar(t)
        ns:Fire("char")
    elseif kind == "MAST" then
        ns:DecodeMastery(t)   -- merges into ns.state.mastery (paged by school, §19.2)
        ns:Fire("mastery")
    end
end

-- ---- Client -> server requests (§14 mastery; §19.3 reserved grammar) ----
--
-- On 3.3.5a there is no guaranteed solo client->server addon hook (see the §19.1 note at the top of
-- this file), so this is OFF unless the server opts a relay in. ns.CanSend() centralises that gate:
-- the addon stays a pure renderer when sending is unavailable, and the Mastery panel falls back to
-- "use the server's branding commands". The wire grammar below MIRRORS the server's request encoders
-- (Protocol.cpp EncodeAlloc/EncodeArchetype/EncodeRespec + the "REQ\tMAST" verb) so the path lights
-- up with no addon change the moment a channel is enabled. Set BrandingDB.sendChannel to one of
-- "GUILD" / "PARTY" / "RAID" / "WHISPER" (whisper target = self) to try it on a realm that relays.
function ns.CanSend()
    return ns.db and ns.db.sendChannel ~= nil
end

-- SendAddonMessage routes by chat type; we use the configured channel (default: none -> no-op).
local function sendFrame(body)
    if not ns.CanSend() then return false end
    local chan = ns.db.sendChannel
    local target = (chan == "WHISPER") and UnitName("player") or nil
    SendAddonMessage(ns.PREFIX, body, chan, target)
    return true
end

function ns:RequestMastery()
    return sendFrame("REQ\tMAST")
end

function ns:SendAlloc(school, tree, axis, points)
    return sendFrame(string.format("ALLOC\t%d\t%d\t%d\t%d", school, tree, axis, points))
end

function ns:SendArchetype(school, tree, archetype)
    return sendFrame(string.format("ARCH\t%d\t%d\t%d", school, tree, archetype))
end

function ns:SendRespec(school, tree)
    return sendFrame(string.format("RESPEC\t%d\t%d", school, tree))
end

-- ---- Event wiring ----
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(_, event, ...)
    if event == "CHAT_MSG_ADDON" then
        local prefix, msg = ...
        if prefix == ns.PREFIX and msg then
            decode(msg)
        end
    elseif event == "PLAYER_LOGIN" then
        BrandingDB = BrandingDB or {}
        ns.db = BrandingDB
        if ns.PREFIX and RegisterAddonMessagePrefix then RegisterAddonMessagePrefix(ns.PREFIX) end
        if ns.CreateTracker then ns.CreateTracker() end
        if ns.CreateXPBar then ns.CreateXPBar() end
        if ns.CreatePanel then ns.CreatePanel() end
        if ns.CreateMastery then ns.CreateMastery() end
        if ns.HookMasteryDock then ns.HookMasteryDock() end
    end
end)

-- ---- Slash commands ----
SLASH_BRANDING1 = "/branding"
SLASH_BRANDING2 = "/brand"
SlashCmdList["BRANDING"] = function(arg)
    arg = string.lower(arg or "")
    if arg == "tracker" then
        if ns.ToggleTracker then ns.ToggleTracker() end
    elseif arg == "xpbar" or arg == "xp" then
        if ns.ToggleXPBar then ns.ToggleXPBar() end
    elseif arg == "mastery" then
        if ns.ToggleMastery then ns.ToggleMastery() end
    else
        if ns.TogglePanel then ns.TogglePanel() end
    end
end
