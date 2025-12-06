local ZONA_PVP_ID = 4080
local LIMITE_GRUPO = 3
local MAPA_TELEPORT = 0
local X, Y, Z, O = -6629.073, -1237.807, 209.80545, 1.7326136

local function EstaNaZonaPvP(player)
    return player:GetZoneId() == ZONA_PVP_ID
end

local function VerificarGrupoNaZona(player)
    local group = player:GetGroup()
    if not group then return end

    local membrosNaZona = {}

    for _, membro in pairs(group:GetMembers()) do
        if membro:IsInWorld() and EstaNaZonaPvP(membro) then
            table.insert(membrosNaZona, membro)
        end
    end

    if #membrosNaZona > LIMITE_GRUPO then
        for i = LIMITE_GRUPO + 1, #membrosNaZona do
            local excedente = membrosNaZona[i]
            excedente:SendBroadcastMessage("Você excedeu o limite de " .. LIMITE_GRUPO .. " jogadores por grupo nesta zona PvP.")
            excedente:Teleport(MAPA_TELEPORT, X, Y, Z, O)
        end
    end
end

function OnZoneChanged(event, player, newZone, newArea)
    if newZone == ZONA_PVP_ID then
        VerificarGrupoNaZona(player)
    end
end

function OnUpdate(eventId)
    for _, player in pairs(GetPlayersInWorld()) do
        if player:IsInWorld() and EstaNaZonaPvP(player) then
            VerificarGrupoNaZona(player)
        end
    end
end

RegisterPlayerEvent(27, OnZoneChanged)       -- EVENT_ON_ZONE_UPDATE
CreateLuaEvent(OnUpdate, 5000, 0)            -- Checa a cada 5 segundos
