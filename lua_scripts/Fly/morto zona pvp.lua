local PVP_ZONE_MAP_ID = 1  -- ID do mapa da sua zona PvP (Kalimdor)
local PVP_ZONE_ZONE_ID = 15  -- ID da zona (Dustwallow Marsh)
local PVP_ZONE_AREA_IDS = {15, 4049}  -- IDs das áreas (Theramore Isle e Tabetha's Farm)
local PVP_ZONE_COORDS = {
    {x = -3815.637, y = -4372.0225, z = 13.7114725, o = 4.59229114},
    {x = -3765.1162, y = -4548.189, z = 10.188876, o = 2.1065087},
    {x = -3644.3691, y = -4510.1704, z = 9.462614, o = 3.045845}
}  -- Adicione mais coordenadas conforme necessário

local SPELL_ID1 = 8611  -- Substitua pelo ID da primeira magia
local SPELL_ID2 = 2479  -- Substitua pelo ID da segunda magia
local GHOST_SPELL_ID = 8326  -- ID da magia que indica que o jogador está em estado de espírito

-- Função para teleportar jogador para a zona PvP
local function TeleportPlayerToPvPZone(player)
    local coord = PVP_ZONE_COORDS[math.random(1, #PVP_ZONE_COORDS)]
    player:Teleport(PVP_ZONE_MAP_ID, coord.x, coord.y, coord.z, coord.o)
    player:CastSpell(player, SPELL_ID1, true)
    player:CastSpell(player, SPELL_ID2, true)
    player:SendBroadcastMessage("Bem-vindo à Zona PvP! Você está temporariamente invisível e protegido.")
end

-- Função para reviver e reparar itens do jogador
local function ResurrectAndRepairPlayer(player)
    player:ResurrectPlayer(100)  -- Revive o jogador com 100% de vida
    player:DurabilityRepairAll(true, 100)  -- Repara todos os itens do jogador
end

-- Função para verificar se o jogador está em uma das áreas especificadas
local function IsPlayerInPvPArea(player, newZone, newArea)
    if player:GetMapId() == PVP_ZONE_MAP_ID and newZone == PVP_ZONE_ZONE_ID then
        for _, area_id in ipairs(PVP_ZONE_AREA_IDS) do
            if newArea == area_id then
                return true
            end
        end
    end
    return false
end

-- Função para reviver, reparar e teleportar jogador morto para a zona PvP
local function OnPlayerUpdateZone(event, player, newZone, newArea)
    if player:HasAura(GHOST_SPELL_ID) and IsPlayerInPvPArea(player, newZone, newArea) then
        ResurrectAndRepairPlayer(player)
        TeleportPlayerToPvPZone(player)
        player:SendBroadcastMessage("Você foi revivido, seus itens foram reparados, e você voltou à Zona PvP com proteção temporária.")
    end
end

-- Registrar evento de atualização de zona do jogador
RegisterPlayerEvent(27, OnPlayerUpdateZone)  -- Evento de atualização de zona do jogador
