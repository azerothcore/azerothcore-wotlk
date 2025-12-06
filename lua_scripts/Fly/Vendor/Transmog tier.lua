local UnitEntry = 190012

local function Tier_Transmog_H(event, player, creature)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_09.png:25:25:0:0|t |cFF0000FFT1 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 1)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_71.png:25:25:0:0|t |cFF0000FFT2 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 2)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_58.png:25:25:0:0|t |cFF0000FFT3 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 3)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_07.png:25:25:0:0|t |cFF0000FFT4 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 4)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_22.png:25:25:0:0|t |cFF0000FFT5 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 5)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_98.png:25:25:0:0|t |cFF0000FFT6 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 6)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_08.png:25:25:0:0|t |cFF0000FFT7 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 7)
    player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_helmet_23.png:25:25:0:0|t |cFF0000FFT8 |cffff0000PvE |cFF000000Armor - |cFFFF00FF[Comprar]", 0, 8)
    player:GossipMenuAddItem(3, "|TInterface\\RaidFrame\\ReadyCheck-NotReady:25:25:0:0|t |cFF8B0000Sair", 0, 500)
    player:GossipSendMenu(1, creature)
end

local function Tier_Transmog_S(event, player, creature, sender, intid)
    local itemList = {
        [1] = 500075,
        [2] = 500076,
        [3] = 500077,
        [4] = 500078,
        [5] = 500079,
        [6] = 500080,
        [7] = 500081,
        [8] = 500083,
    }

    if intid == 500 then
        player:GossipComplete()
    elseif itemList[intid] then
        player:SendListInventory(creature, itemList[intid])
    end
end

RegisterCreatureGossipEvent(UnitEntry, 1, Tier_Transmog_H)
RegisterCreatureGossipEvent(UnitEntry, 2, Tier_Transmog_S)


