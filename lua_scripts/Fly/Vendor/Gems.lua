local UnitEntry = 600008

local function Gem_Vendor(event, player, creature)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_icediamond_02:30|t Meta Gems", 0, 1)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_gem_37:30|t Red Gems", 0, 2)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_gem_38:30|t Yellow Gems", 0, 3)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_gem_42:30|t Blue Gems", 0, 4)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_gem_39:30|t Orange Gems", 0, 5)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_gem_40:30|t Purple Gems", 0, 6)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_jewelcrafting_gem_41:30|t Green Gems", 0, 7)
    player:GossipMenuAddItem(1, "|TInterface\\icons\\inv_misc_gem_pearl_12:30|t Prismatic Gems", 0, 8)
    player:GossipMenuAddItem(1, "|cFF8B0000Sair", 0, 500)
    player:GossipSendMenu(1, creature)
end

local function Gem_Vendor_Select(event, player, creature, sender, intid)
    local itemList = {
        [1] = 60021,
        [2] = 60022,
        [3] = 60023,
        [4] = 60024,
        [5] = 60025,
        [6] = 60026,
        [7] = 60027,
        [8] = 60028,
    }

    if intid == 500 then
        player:GossipComplete()
    elseif itemList[intid] then
        player:SendListInventory(creature, itemList[intid])
    end
end

RegisterCreatureGossipEvent(UnitEntry, 1, Gem_Vendor)
RegisterCreatureGossipEvent(UnitEntry, 2, Gem_Vendor_Select)

