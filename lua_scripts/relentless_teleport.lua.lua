local TELEPORT_MAP = 571
local TELEPORT_X = 5793.1143
local TELEPORT_Y = 649.81085
local TELEPORT_Z = 609.8858
local TELEPORT_O = 2.5844748

local function HasBeenTeleported(guid)
    local result = CharDBQuery("SELECT 1 FROM character_teleport_status WHERE guid = " .. guid .. " LIMIT 1;")
    return result ~= nil
end

local function SetTeleported(guid)
    CharDBExecute("INSERT INTO character_teleport_status (guid) VALUES (" .. guid .. ");")
end

local function TeleportIfRelentless(player)
    if not player or not player:IsInWorld() then return end

    local guid = player:GetGUIDLow()
    if HasBeenTeleported(guid) then return end

    for slot = 0, 18 do
        local item = player:GetEquippedItemBySlot(slot)
        if item then
            local name = item:GetItemLink()
            if name and name:find("Relentless Gladiator") then
                player:SendBroadcastMessage("Relentless item detectado. Teleportando...")
                player:Teleport(TELEPORT_MAP, TELEPORT_X, TELEPORT_Y, TELEPORT_Z, TELEPORT_O)
                SetTeleported(guid)
                return
            end
        end
    end
end

local function OnLogin(event, player)
    player:RegisterEvent(function(_, _, _, p)
        TeleportIfRelentless(p)
    end, 3000, 1)
end

local function OnEquipItem(event, player, item, bag, slot)
    TeleportIfRelentless(player)
end

RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(29, OnEquipItem)
