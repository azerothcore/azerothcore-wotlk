local SPELL_ID = 51916
local SOURCE_MAP_ID = 530 -- Isle of Quel'Danas
local DEST_MAP_ID = 0 -- Eastern Kingdoms
local DEST_X, DEST_Y, DEST_Z, DEST_O = -6630.497, -1239.6503, 209.80531, 1.680771 -- Coordenadas do teleporte

function OnKilledByPlayer(event, killer, killed)
    if killed:GetMapId() == SOURCE_MAP_ID then
        killed:ResurrectPlayer() -- Ressuscita o jogador
        killed:CastSpell(killed, SPELL_ID, true) -- Lança o feitiço no jogador
        killed:Teleport(DEST_MAP_ID, DEST_X, DEST_Y, DEST_Z, DEST_O) -- Teleporta o jogador
    end
end

RegisterPlayerEvent(6, OnKilledByPlayer) -- Evento para mortes por outro jogador