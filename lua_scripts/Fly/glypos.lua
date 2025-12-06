local UnitEntry = 600011

local function Glyphs(unit, player, creature)
	
	--player:GossipSetText(string.format("                                             |cFFFF00FF• |cff0000ffGlyphs\n                      |cFFFF00FF• |cff0000ffConsumables"))
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_alchemy_endlessflask_06:30|t Buy Consumables ",0, 1)
    player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_inscription_tradeskill01:30|t Buy Glyphs ",0, 2)
    --player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_scroll_05:27|t Scrolls |cffff0000Armors - |cFF8B0000[Comprar]",0, 3)
    --player:GossipMenuAddItem(1,"|TInterface\\icons\\inv_scroll_04:27|t Scrolls |cffff0000Weapons - |cFF8B0000[Comprar]",0, 4)	
    player:GossipMenuAddItem(2,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:30:0:0|t |cFF8B0000Sair",0,500)	
	player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
end	

RegisterCreatureGossipEvent(UnitEntry, 1, Glyphs)


local function Glyphs(event, player, creature, sender, intid, code)
    if(intid == 1) then
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_alchemy_endlessflask_06:30|t |cffff0000Consumables - |cFF8B0000[Comprar]",0, 5)
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_gem_pearl_12:27|t |cffff0000Prismatic Gem - |cFF8B0000[Comprar]",0, 6)		
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_jewelcrafting_gem_04:27|t |cffff0000Red Gem - |cFF8B0000[Comprar]",0, 7)
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_jewelcrafting_gem_03:27|t |cffff0000Yellow Gem - |cFF8B0000[Comprar]",0, 8)
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_jewelcrafting_gem_05:27|t |cffff0000Blue Gem - |cFF8B0000[Comprar]",0, 9)
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_jewelcrafting_gem_02:27|t |cffff0000Orange Gem - |cFF8B0000[Comprar]",0, 10)
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_jewelcrafting_gem_06:27|t |cffff0000Purple Gem - |cFF8B0000[Comprar]",0, 11)
	    --player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_jewelcrafting_gem_01:27|t |cffff0000Green Gem - |cFF8B0000[Comprar]",0, 12)
	    --player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:27:27:0:0|t |cFF8B0000Voltar",0,501)		
        --player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Sair",0,500)
		player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
	end
	
    if(intid == 2) then
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorwarrior:27|t |cffff0000Warrior - |cFF8B0000[Comprar]",0, 13)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorpaladin:27|t |cffff0000Paladin - |cFF8B0000[Comprar]",0, 14)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majordeathknight:27|t |cffff0000Dk - |cFF8B0000[Comprar]",0, 15)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majordruid:27|t |cffff0000Druid - |cFF8B0000[Comprar]",0, 16)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorhunter:27|t |cffff0000Hunter - |cFF8B0000[Comprar]",0, 17)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorrogue:27|t |cffff0000Rogue - |cFF8B0000[Comprar]",0, 18)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorpriest:27|t P|cffff0000riest - |cFF8B0000[Comprar]",0, 19)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majormage:27|t |cffff0000Mage - |cFF8B0000[Comprar]",0, 20)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorwarlock:27|t |cffff0000Warlock - |cFF8B0000[Comprar]",0, 21)
	    player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_glyph_majorshaman:27|t |cffff0000Shaman - |cFF8B0000[Comprar]",0, 22)	
	    player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:27:27:0:0|t |cFF8B0000Voltar",0,501)		
        player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Sair",0,500)
		player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
	end

    if(intid == 3) then
	     player:SendListInventory(creature, 400201)

	end

    if(intid == 4) then
        player:SendListInventory(creature, 400200)	
	end

    if(intid == 5) then
        player:SendListInventory(creature, 500035)
    end	
	
	if(intid == 6) then
        player:SendListInventory(creature, 500071)
    end	
	
	if(intid == 7) then
        player:SendListInventory(creature, 500092)
    end	
	
	if(intid == 8) then
        player:SendListInventory(creature, 500112)
    end	
	
	if (intid == 9) then
        player:SendListInventory(creature, 500014)
    end	
	
    if (intid == 10) then
        player:SendListInventory(creature, 500067)
    end	
	
	if (intid == 11) then
        player:SendListInventory(creature, 500073)
    end	
	
	if (intid == 12) then
        player:SendListInventory(creature, 500041)
    end	
	
	if (intid == 13) then
        player:SendListInventory(creature, 500111)
    end	
	
	if (intid == 14) then
        player:SendListInventory(creature, 500068)
    end	
	
	if (intid == 15) then
        player:SendListInventory(creature, 500026)
    end	
	
	if (intid == 16) then
        player:SendListInventory(creature, 500027)
    end	
	
	if (intid == 17) then
        player:SendListInventory(creature, 500046)
    end	
	
	if (intid == 18) then
        player:SendListInventory(creature, 500095)
    end	
	
	if (intid == 19) then
        player:SendListInventory(creature, 500113)
    end	
	
	if (intid == 20) then
        player:SendListInventory(creature, 500057)
    end	
	
	if (intid == 21) then
        player:SendListInventory(creature, 500110)
    end	
   
   	if (intid == 22) then
        player:SendListInventory(creature, 500097)
    end	
   
    if(intid == 500) then
        player:GossipComplete()	
    end
   
    if(intid == 501) then
        Glyphs(unit, player, creature)
   end
end

RegisterCreatureGossipEvent(600011, 2, Glyphs) 	