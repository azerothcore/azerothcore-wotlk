local NPC_ID = 600021
local PVP_ZONE_MAP_ID = 530

local PVP_ZONE_COORDS = {
    {x = 13018.72, y = -6841.9146, z = 5.418259, o = 3.665839},
    {x = 12606.105, y = -6919.0854, z = 4.6011095, o = 0.77712584},
    {x = 12711.138, y = -6886.229, z = 12.493998, o = 2.3453188}
}

local SPELL_ID1 = 8611
local SPELL_ID2 = 2479

local MAPA_SAIDA = 571
local X_SAIDA, Y_SAIDA, Z_SAIDA, O_SAIDA = 5805.6196, 641.6034, 609.886, 4.1022134

local function TeleportPlayerToPvPZone(player)
    local coord = PVP_ZONE_COORDS[math.random(1, #PVP_ZONE_COORDS)]
    player:Teleport(PVP_ZONE_MAP_ID, coord.x, coord.y, coord.z, coord.o)
    player:CastSpell(player, SPELL_ID1, true)
    player:CastSpell(player, SPELL_ID2, true)
end

local function TeleportarParaSaida(player)
    player:Teleport(MAPA_SAIDA, X_SAIDA, Y_SAIDA, Z_SAIDA, O_SAIDA)
    player:SendBroadcastMessage("Você saiu da PvP Zone.")
end

local function OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(2, "Teletransportar meu grupo para o campo de batalha", 1, 1)
    player:GossipMenuAddItem(2, "Sair", 1, 2)
    player:GossipSendMenu(600021, creature)  -- <- Aqui foi alterado
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        TeleportPlayerToPvPZone(player)
    elseif intid == 2 then
        TeleportarParaSaida(player)
    end
    player:GossipComplete()
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)
