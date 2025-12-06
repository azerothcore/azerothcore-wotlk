local UnitEntry = 700110

local function Relentless_Vendor(event, player, creature)
    player:GossipSetText(string.format("                        |TInterface\\icons\\inv_helmet_130.png:55:55:30:0|t\n\nAtravés desse NPC, você encontra ás seguintes opções: \n\n                     |cFFFF00FF• |cFF000000Season 7 - Gear\n                     |cFFFF00FF• |cFF000000Season 7 - OffSet\n                     |cFFFF00FF• |cFF000000Season 7 - Weapons\n                     |cFFFF00FF• |cFF000000Season 7 - Relics"))
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_helmet_98:30|t S7 PvP Gear", 0, 1)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_belt_48c:30|t S7 PvP Off-Set", 0, 2)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_sword_149:30|t S7 PvP Weapons", 0, 3)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\ability_wintergrasp_rank1:30|t Wintergrasp QuarterMaster", 0, 4)	
	player:GossipMenuAddItem(2,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:32:30:0:0|t |cFF8B0000Sair",0,500)			
    player:GossipSendMenu(700110, creature, 0)
end

RegisterCreatureGossipEvent(UnitEntry, 1, Relentless_Vendor)

local function Relentless_Vendor_Select(event, player, creature, sender, intid, code)
    
	if(intid == 1) then
        player:SendListInventory(creature, 500010)	
	end
	
	if(intid == 2) then
        player:SendListInventory(creature, 700113)		
	end
	
	if(intid == 3) then
        player:SendListInventory(creature, 700112)		
	end

	if(intid == 4) then
        player:SendListInventory(creature, 700114)		
	end
	
    if (intid == 500) then
        player:GossipComplete()	
    end			
end

RegisterCreatureGossipEvent(UnitEntry, 2, Relentless_Vendor_Select) 