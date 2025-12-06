local event_id = 11 -- EVENT_DUEL_END

-- Dalaran (Circle of Wills)
local DALARAN_MAP_ID = 571
local DALARAN_ZONE_ID = 4395
local DALARAN_AREA_ID = 4570

-- Duel Zone (Arathi Highlands)
local DUEL_MAP_ID = 0
local DUEL_ZONE_ID = 45
local DUEL_AREA_ID = 2401

function IsInAllowedZone(player)
    local mapId = player:GetMapId()
    local zoneId = player:GetZoneId()
    local areaId = player:GetAreaId()

    -- Verifica se está no círculo de Dalaran ou na arena de duelo
    return (mapId == DALARAN_MAP_ID and zoneId == DALARAN_ZONE_ID and areaId == DALARAN_AREA_ID)
        or (mapId == DUEL_MAP_ID and zoneId == DUEL_ZONE_ID and areaId == DUEL_AREA_ID)
end

function ResetOnDuelEnd(event, winner, loser, _)
    if not (IsInAllowedZone(winner) and IsInAllowedZone(loser)) then
        return
    end

    winner:ResetAllCooldowns()
    winner:SetHealth(winner:GetMaxHealth())
    winner:SetPower(winner:GetMaxPower(0))

    loser:ResetAllCooldowns()
    loser:SetHealth(loser:GetMaxHealth())
    loser:SetPower(loser:GetMaxPower(0))
end

RegisterPlayerEvent(event_id, ResetOnDuelEnd)
