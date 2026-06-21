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

ns.PROTOCOL = 1
ns.PREFIX = "BRND"

-- Latest decoded state. UI reads these; nil/empty until the first push arrives.
ns.state = {
    hello = nil,                 -- { version, enabled }
    event = nil,                 -- { zoneId, type, containment (0..1), active }
    you = nil,                   -- { points, tier }
    schedule = { entries = {}, truncated = false },
    char = nil,                  -- decoded character snapshot (see DecodeChar)
}

-- ---- Display name tables (mirror the server enums) ----
ns.BrandName = { [0] = "Fire", [1] = "Frost", [2] = "Nature", [3] = "Shadow", [4] = "Arcane", [5] = "Holy", [6] = "Physical" }
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
    elseif kind == "CHAR" then
        ns.state.char = ns:DecodeChar(t)
        ns:Fire("char")
    end
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
        if ns.CreateTracker then ns.CreateTracker() end
        if ns.CreatePanel then ns.CreatePanel() end
    end
end)

-- ---- Slash commands ----
SLASH_BRANDING1 = "/branding"
SLASH_BRANDING2 = "/brand"
SlashCmdList["BRANDING"] = function(arg)
    arg = string.lower(arg or "")
    if arg == "tracker" then
        if ns.ToggleTracker then ns.ToggleTracker() end
    else
        if ns.TogglePanel then ns.TogglePanel() end
    end
end
