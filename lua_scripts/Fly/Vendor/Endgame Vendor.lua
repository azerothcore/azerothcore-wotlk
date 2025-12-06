local UnitEntry = 600030

local function Wrathful_Vendor(event, player, creature)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_helmet_164:30|t S8 PvP Gear", 0, 1)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_sword_116:30|t S8 PvP Weapons T1", 0, 2)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_sword_157:30|t S8 PvP Weapons T2", 0, 3)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_axe_113:30|t S8 PvE Weapons Heroic", 0, 4)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_axe_120:30|t S8 PvE Weapons Normal", 0, 5)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_helmet_158:30|t S8 PvE Offset Heroic", 0, 6)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_misc_desecrated_leatherhelm:30|t S8 PvE Offset Normal", 0, 7)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelry_ring_83:30|t S8 PvE Jewelry Heroic", 0, 8)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelry_ring_84:30|t S8 PvE Jewelry Normal", 0, 9)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_shoulder_116black:30|t S8 PvE Offparts Heroic", 0, 10)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_shoulder_116purple:30|t S8 PvE Offparts Normal", 0, 11)
    player:GossipSendMenu(1, creature)
end

local function Wrathful_Vendor_Select(event, player, creature, sender, intid)
    local itemList = {
        [1] = 700121,
        [2] = 700122,
        [3] = 700123,
        [4] = 700120,
        [5] = 700119,
        [6] = 700117,
        [7] = 700118,
        [8] = 700115,
        [9] = 700124,
        [10] = 700127,
        [11] = 700116,
    }

    if intid == 500 then
        player:GossipComplete()
    elseif itemList[intid] then
        player:SendListInventory(creature, itemList[intid])
    end
end

RegisterCreatureGossipEvent(UnitEntry, 1, Wrathful_Vendor)
RegisterCreatureGossipEvent(UnitEntry, 2, Wrathful_Vendor_Select)
