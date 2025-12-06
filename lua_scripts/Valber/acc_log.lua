-- Script By: ValberDEV (patched for Docker path)
-- Write logs to the container's logs directory, mounted from host
local logFile = "/azerothcore/env/dist/logs/acc_char.log"

local function openForAppend()
    local f = io.open(logFile, "a")
    if not f then
        -- Fallback to current working directory if mounted logs are unavailable
        f = io.open("acc_char.log", "a")
    end
    return f
end

-- Initialize file safely (avoid nil close error)
do
    local f = openForAppend()
    if f then f:close() end
end
local function OnFirstLogin(event, player)
    local accountId = player:GetAccountId()
    local characterName = player:GetName()
    local f = openForAppend()
    if f then
        f:write(string.format("Account ID: %d, Character Name: %s\n", accountId, characterName))
        f:close()
    end
end

RegisterPlayerEvent(30, OnFirstLogin)
