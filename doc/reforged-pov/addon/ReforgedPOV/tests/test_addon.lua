-- Run with a Lua 5.1-compatible runtime from the addon directory.
local frames, sent, now = {}, {}, 0
local methods = {}
function methods:SetScript(event, callback) self.scripts[event] = callback end
function methods:Show() self.shown = true end
function methods:Hide() self.shown = false end
function methods:IsShown() return self.shown end
function methods:SetText(text) self.text = text end
function methods:GetText() return self.text or "" end
function methods:Enable() self.enabled = true end
function methods:Disable() self.enabled = false end
function methods:SetValue(value) self.value = value end
function methods:SetMinMaxValues(low, high) self.low, self.high = low, high end
local function frame(name, parent)
    local f = setmetatable({shown = true, scripts = {}, parent = parent}, {
        __index = function(_, key) return methods[key] or function() end end
    })
    frames[#frames + 1] = f
    if name then _G[name] = f end
    return f
end
function methods:CreateFontString() return frame(nil, self) end
function methods:CreateTexture() return frame(nil, self) end
function CreateFrame(_, name, parent) return frame(name, parent) end
UIParent, PlayerFrame, MainMenuBar = frame(), frame(), frame()
UISpecialFrames, SlashCmdList = {}, {}
function GetTime() return now end
function InCombatLockdown() return false end
function UnitName() return "Observer" end
function GetSpellInfo() return "Fireball" end
function SendChatMessage(message, channel) sent[#sent + 1] = {message, channel} end

dofile("ReforgedPOV.lua")
local events
for _, f in ipairs(frames) do
    if f.scripts.OnEvent then events = f end
end
assert(events, "addon registered event handlers")
local function message(payload, sender)
    events.scripts.OnEvent(events, "CHAT_MSG_ADDON", "RPOV", payload, "WHISPER", sender or "")
end
local state = "STATE|Alice|75|100|0|50|100|Wolf|20|60|133|500|2000|12|Casting"

SlashCmdList.REFORGEDPOV("")
assert(ReforgedPOVPicker:IsShown() and sent[#sent][1] == ".pov list 0")
message("BEGIN|0")
message("PLAYER|Alice|10|8|12")
message("END|1")
local row
for _, f in ipairs(frames) do
    if rawget(f, "playerName") == "Alice" then row = f end
end
assert(row, "online player rendered")
row.scripts.OnClick(row)
assert(sent[#sent][1] == ".pov watch Alice", "row selects player")
message(state, "AnotherPlayer")
assert(not ReforgedPOVHUD:IsShown(), "forged data ignored")
message("WATCH|Alice")
message(state)
assert(ReforgedPOVHUD:IsShown() and not PlayerFrame:IsShown(), "live HUD replaces observer HUD")
local castFound = false
for _, f in ipairs(frames) do
    if rawget(f, "value") == 1500 and rawget(f, "high") == 2000 then castFound = true end
end
assert(castFound, "cast progress uses server timing")
SlashCmdList.REFORGEDPOV("")
message(state)
assert(ReforgedPOVPicker:IsShown(), "live snapshots do not close reopened picker")
message("STOP")
assert(not ReforgedPOVHUD:IsShown() and PlayerFrame:IsShown() and MainMenuBar:IsShown(), "stop restores UI")
message("STATE|Bot|0|0|3|0|0||0|0|0|0|0|12|Dead")
assert(ReforgedPOVHUD:IsShown(), "state resumes HUD after a UI reload without WATCH")
now = 6
events.scripts.OnUpdate()
local stale = false
for _, f in ipairs(frames) do
    if rawget(f, "text") == "Waiting for live data… You can still stop watching." then stale = true end
end
assert(stale, "stale feed is visibly marked")
SlashCmdList.REFORGEDPOV("stop")
assert(sent[#sent][1] == ".pov stop", "stop remains usable without fresh telemetry")
message("STOP")
local count = #sent
SlashCmdList.REFORGEDPOV("Alice\n.gm on")
assert(#sent == count, "invalid character input rejected")
SlashCmdList.REFORGEDPOV("")
now = 17
events.scripts.OnUpdate()
local timeout = false
for _, f in ipairs(frames) do
    if rawget(f, "text") == "No reply. Check that the server extension is installed and you have GM access." then timeout = true end
end
assert(timeout, "missing server extension is explained")
print("PASS: picker, selection, sender validation, live HUD, casts, stop/restore, reload recovery, stale data, input and timeout")
