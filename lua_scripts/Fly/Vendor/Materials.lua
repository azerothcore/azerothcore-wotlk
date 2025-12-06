local UnitEntry = 70001

local function Wrathful_Vendor(event, player, creature)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_misc_gem_variety_02:30|t Gems", 0, 1)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_stone_weightstone_05:30|t Metal & Stone", 0, 2)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_misc_food_119_rhinomeat:30|t Cooking", 0, 3)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_misc_leatherscrap_07:30|t Leather", 0, 4)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_inscription_tradeskill01:30|t Inscription", 0, 5)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_misc_herb_11:30|t Herbs", 0, 6)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_enchant_disenchant:30|t Enchanting", 0, 7)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_elemental_eternal_shadow:30|t Elemental", 0, 8)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_fabric_soulcloth:30|t Cloth", 0, 9)
    --player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_chest_plate21:30|t S8 PvE Offparts Heroic", 0, 10)
    --player:GossipMenuAddItem(6, "|TInterface\\icons\\inv_chest_plate20:30|t S8 PvE Offparts Normal", 0, 11)
    player:GossipSendMenu(1, creature)
end

local function Wrathful_Vendor_Select(event, player, creature, sender, intid)
    local itemList = {
        [1] = 500040,
        [2] = 500060,
        [3] = 500058,
        [4] = 500054,
        [5] = 500048,
        [6] = 500043,
        [7] = 500031,
        [8] = 500028,
        [9] = 500018,
        --[10] = 700127,
        --[11] = 700116,
    }

    if intid == 500 then
        player:GossipComplete()
    elseif itemList[intid] then
        player:SendListInventory(creature, itemList[intid])
    end
end

RegisterCreatureGossipEvent(UnitEntry, 1, Wrathful_Vendor)
RegisterCreatureGossipEvent(UnitEntry, 2, Wrathful_Vendor_Select)
