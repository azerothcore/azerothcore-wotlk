local UnitEntry = 600031

local function T9_Vendor(event, player, creature)
    player:GossipSetText(string.format("                         |TInterface\\icons\\Spell_misc_warsongfocus:55:55:30:0|t\n\nAtravés desse NPC, você pode adquirir os seguintes equipamentos: \n"))
	if (player:GetTeam() == 1) then
	player:GossipMenuAddItem(1,"|TInterface\\icons\\Inv_helmet_86:30|t S7 PvE Gear", 0, 1)
    else
	player:GossipMenuAddItem(1,"|TInterface\\icons\\Inv_helmet_86:30|t S7 PvE Gear", 0, 2)
    end    
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_shirt_red_01:30|t S7 PvE Off-Set", 0, 3)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\Inv_mace_36:30|t S7 PvE Weapons ", 0, 4)	
    player:GossipMenuAddItem(1,"|TInterface\\icons\\Inv_jewelry_necklace_15:30|t S7 PvE Necklance", 0, 5)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_misc_cape_18:30|t S7 PvE Cloaks", 0, 6)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\Inv_jewelry_ring_04:30|t S7 PvE Rings", 0, 7)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\Inv_jewelry_talisman_09:30|t S7 PvE Trinkets", 0, 8)	
    player:GossipMenuAddItem(2,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:30:30:0:0|t |cFF8B0000Sair",0,500)		
    player:GossipSendMenu(600031, creature, 0)
end

RegisterCreatureGossipEvent(UnitEntry, 1, T9_Vendor)

local function T9_Vendor_Select(event, player, creature, sender, intid, code)
    
	if(intid == 1) then
        player:SendListInventory(creature, 500134)	
	end
	
	if(intid == 2) then
        player:SendListInventory(creature, 500087)		
	end
	
	if(intid == 3) then
        player:SendListInventory(creature, 400019)		
	end

	if(intid == 4) then
        player:SendListInventory(creature, 400020)		
	end	

	if(intid == 5) then
        player:SendListInventory(creature, 400021)		
	end	

	if(intid == 6) then
        player:SendListInventory(creature, 400022)		
	end	

	if(intid == 7) then
        player:SendListInventory(creature, 400023)		
	end		
	
	if(intid == 8) then
        player:SendListInventory(creature, 400024)		
	end		

    if (intid == 500) then
        player:GossipComplete()	
    end			
end

RegisterCreatureGossipEvent(UnitEntry, 2, T9_Vendor_Select) 