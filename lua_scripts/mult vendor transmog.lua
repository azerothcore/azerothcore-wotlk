local NPC_ID = 60001

local function GetArmorTypeForClass(class)
    local CLASS_ARMOR_TYPE = {
        [1] = "Plate",     -- Warrior
        [2] = "Plate",     -- Paladin
        [3] = "Mail",      -- Hunter
        [4] = "Leather",   -- Rogue
        [5] = "Cloth",     -- Priest
        [6] = "Plate",     -- Death Knight
        [7] = "Mail",      -- Shaman
        [8] = "Cloth",     -- Mage
        [9] = "Cloth",     -- Warlock
        [11] = "Leather",  -- Druid
    }
    return CLASS_ARMOR_TYPE[class] or "Cloth"
end

local function OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(1, "Arena Transmog", 1, 1)
    player:GossipMenuAddItem(1, "Buy Scrolls of Purification", 1, 2)
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    player:GossipClearMenu()

    if intid == 1 then
        local class = player:GetClass()
        local armorType = GetArmorTypeForClass(class)

        player:GossipMenuAddItem(1, "Head (" .. armorType .. ")", 1, 60073)
        player:GossipMenuAddItem(1, "Shoulders (" .. armorType .. ")", 1, 60074)
        player:GossipMenuAddItem(1, "Chest (" .. armorType .. ")", 1, 60075)
        player:GossipMenuAddItem(1, "Waist (" .. armorType .. ")", 1, 60076)
        player:GossipMenuAddItem(1, "Legs (" .. armorType .. ")", 1, 60077)
        player:GossipMenuAddItem(1, "Feet (" .. armorType .. ")", 1, 60078)
        player:GossipMenuAddItem(1, "Wrists (" .. armorType .. ")", 1, 60079)
        player:GossipMenuAddItem(1, "Hands (" .. armorType .. ")", 1, 60080)
        player:GossipMenuAddItem(1, "Back (Cloth)", 1, 60050)
        player:GossipMenuAddItem(1, "Mainhand", 1, 60085)
        player:GossipMenuAddItem(1, "Offhand", 1, 60083)
        player:GossipMenuAddItem(1, "Ranged", 1, 60086)

        player:GossipSendMenu(1, creature)

    elseif intid == 2 then
        player:SendBroadcastMessage("Loja de pergaminhos ainda não está disponível.")
        player:GossipComplete()

    elseif intid >= 60050 and intid <= 60086 then
        player:SendListInventory(creature, intid)
    else
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)
