local UnitEntry = 500074

local function BeastMaster_T(unit, player, creature)
	player:GossipSetText(string.format("                  |TInterface\\icons\\ability_hunter_beastcall:55:55:30:0|t\n\n                   Adote o seu Pet"))
    if  player:GetClass() == 3 then    
	    player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_hunter_pet_wolf:35|t|cffffffff•|r - Todos os Pets|cffff0000[View Pets]",0, 1)
        player:GossipMenuAddItem(3,"|TInterface\\icons\\inv_box_petcarrier_01:35|t|cffffffff•|r - Meus Pets |cffff0000[View My Pets]",0, 2)
        player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_hunter_beasttraining:35|t|cffffffff•|r - Comidas pro Pets |cffff0000[Buy Foods]",0, 3)
        player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_marksmanship:35|t|cffffffff•|r - Resetar Talentos |cffff0000[Reset]",0, 4)
        player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:35|t|cffffffff•|r - Deixa Pra lá", 0, 500)	
        player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
	else
	    player:SendAreaTriggerMessage("|TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t |cffffff00Você não é |cFFFF00FFHunter|cffffff00. As opções deste |cFFFF00FFNPC |cffffff00estão disponíveis apenas para jogadores da classe |cFFFF00FFHunter|cffffff00. |TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t")
	end	
end

RegisterCreatureGossipEvent(UnitEntry, 1, BeastMaster_T)

local function BeastMaster_S(event, player, creature, sender, intid, code)
if (intid == 1) then
        player:GossipSetText(string.format("                     |TInterface\\icons\\ability_druid_supriseattack:55:55:30:0|t\n\nO menu de |cffff0000Pets Exóticos|cFF000000, só aparecerá se o jogador for |cffff0000Beast Mastery|cFF000000.\n\nOs pets são dividos em 3 famílias e 4 tipos de especializações, sendo uma exclusiva para |cffff0000Beast Mastery|cFF000000."))
        if player:HasTalent(53270, 0) then
            player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_hunter_ferociousinspiration:27|t Exotic |cFF000000- |cFFFF00FF[Especialização]",0, 5)
        end
    player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_druid_kingofthejungle:25|t Ferocity |cFF000000- |cFFFF00FF[Especialização]",0, 6)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_druid_demoralizingroar:25|t Tenacity |cFF000000- |cFFFF00FF[Especialização]",0, 7)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_eyeoftheowl:25|t Cunning |cFF000000- |cFFFF00FF[Especialização]",0, 8)
    player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:25:25:0:0|t Voltar",0,499)
    player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:25:25:0:0|t Sair", 0, 500)
    player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
    end

if(intid == 2) then
    if player:HasSpellCooldown(62757) then
        player:ResetSpellCooldown(62757, true)
	else
	    player:CastSpell(player, 62757, true)
		player:GossipComplete()
    end
end

if(intid == 5) then
    player:GossipSetText(string.format("                     |TInterface\\icons\\ability_druid_supriseattack:55:55:30:0|t\n\nO menu de |cffff0000Pets Exóticos|cFF000000, só aparecerá se o jogador for |cffff0000Beast Mastery|cFF000000.\n\nOs pets são dividos em 3 famílias e 4 tipos de especializações, sendo uma exclusiva para |cffff0000Beast Mastery|cFF000000."))
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_corehound:27|t |cff0000ffCore Hounds |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 9)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_devilsaur:27|t |cff0000ffDevilsaurs |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 10)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_druid_primalprecision:27|t |cff0000ffSpirit Beasts |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 11)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\Ability_hunter_pet_rhino:27|t |cff0000ffRhinos |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 12)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_worm:27|t |cff0000ffWorms |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 13)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_chimera:27|t |cff0000ffChimaera |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 14)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_silithid:27|t |cff0000ffSilithid |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 15)
	player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Voltar",0,499)		
	player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:22:22:0:0|t |cFF8B0000Sair",0,500)	
    player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
end

if (intid == 6) then
    player:GossipSetText(string.format("                     |TInterface\\icons\\ability_druid_supriseattack:55:55:30:0|t\n\nO menu de |cffff0000Pets Exóticos|cFF000000, só aparecerá se o jogador for |cffff0000Beast Mastery|cFF000000.\n\nOs pets são dividos em 3 famílias e 4 tipos de especializações, sendo uma exclusiva para |cffff0000Beast Mastery|cFF000000."))
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_vulture:27|t |cff0000ffCarrion Birds |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 16)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_cat:27|t |cff0000ffCats |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 17)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_moth:27|t |cff0000ffMoths |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 18)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_hyena:27|t |cff0000ffHyenas |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 19)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_raptor:27|t |cff0000ffRaptors |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 20)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_tallstrider:27|t |cff0000ffTallstriders |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 21)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_wasp:27|t |cff0000ffWasps |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 22)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_wolf:27|t |cff0000ffWolves |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 23)
	player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Voltar",0,499)		
	player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:22:22:0:0|t |cFF8B0000Sair",0,500)
    player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
end

if (intid == 7) then
    player:GossipSetText(string.format("                     |TInterface\\icons\\ability_druid_supriseattack:55:55:30:0|t\n\nO menu de |cffff0000Pets Exóticos|cFF000000, só aparecerá se o jogador for |cffff0000Beast Mastery|cFF000000.\n\nOs pets são dividos em 3 famílias e 4 tipos de especializações, sendo uma exclusiva para |cffff0000Beast Mastery|cFF000000."))
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_bear:27|t |cff0000ffBears |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 24)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_boar:27|t |cff0000ffBoars |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 25)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_crab:27|t |cff0000ffCrabs |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 26)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_crocolisk:27|t |cff0000ffCrocolisks |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 27)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_gorilla:27|t |cff0000ffGorillas |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 28)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_scorpid:27|t |cff0000ffScorpids |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 29)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_turtle:27|t |cff0000ffTurtles |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 30)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_warpstalker:27|t |cff0000ffWarp Stalker |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 31)
	player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Voltar",0,499)		
	player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:22:22:0:0|t |cFF8B0000Sair",0,500)
    player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
end

if (intid == 8) then
    player:GossipSetText(string.format("                     |TInterface\\icons\\ability_druid_supriseattack:55:55:30:0|t\n\nO menu de |cffff0000Pets Exóticos|cFF000000, só aparecerá se o jogador for |cffff0000Beast Mastery|cFF000000.\n\nOs pets são dividos em 3 famílias e 4 tipos de especializações, sendo uma exclusiva para |cffff0000Beast Mastery|cFF000000."))
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_bat:27|t |cff0000ffBats |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 32)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_owl:27|t |cff0000ffBird of Prey |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 33)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_dragonhawk:27|t |cff0000ffDragonhawk |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 34)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_netherray:27|t |cff0000ffNether Ray |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 35)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_ravager:27|t |cff0000ffRavager |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 36)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\spell_nature_guardianward:27|t |cff0000ffSerpents |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 37)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_spider:27|t |cff0000ffSpiders |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 38)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_sporebat:27|t |cff0000ffSporebats |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 39)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_hunter_pet_windserpent:27|t |cff0000ffWind Serpent |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 40)
	player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Voltar",0,499)		
	player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:22:22:0:0|t |cFF8B0000Sair",0,500)	
    player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
end

if (intid == 11) then
    player:GossipSetText(string.format("                     |TInterface\\icons\\ability_druid_supriseattack:55:55:30:0|t\n\nO menu de |cffff0000Pets Exóticos|cFF000000, só aparecerá se o jogador for |cffff0000Beast Mastery|cFF000000.\n\nOs pets são dividos em 3 famílias e 4 tipos de especializações, sendo uma exclusiva para |cffff0000Beast Mastery|cFF000000."))
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_druid_primalprecision:27|t |cff0000ffArcturis |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 107)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_druid_primalprecision:27|t |cff0000ffLoque'nahak |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 108)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_druid_primalprecision:27|t |cff0000ffGondria |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 109)
    player:GossipMenuAddItem(3,"|TInterface\\icons\\ability_druid_primalprecision:27|t |cff0000ffSkoll |cFF000000- [|cFFFF00FFDomesticar|cFF000000]",0, 110)	
	player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Voltar",0,499)		
	player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:22:22:0:0|t |cFF8B0000Sair",0,500)	
    player:GossipSendMenu(0x7FFFFFFF, creature, menu_id)
end
	

if(intid == 4) then
    if pet then
       player:ResetPetTalents()
	   player:GossipComplete()
    else
	   player:SendNotification("|TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t |cffffff00Você precisa ter um |cFFFF00FFPet|cffffff00, para usar essa opção. |TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t")
	   player:GossipComplete()	   
    end
end
	

if(intid == 3) then
   player:SendListInventory(creature, 300303)
end

if (intid ==9) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 17447, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end
	
if (intid ==10) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 6499, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==12) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 25487, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==13) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 26358, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()			
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==14) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 4031, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==15) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 5454, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==16) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 23206, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==17) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 28097, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==18) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 17349, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==19) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 4689, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==20) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 3637, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==21) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 17372, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==22) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 19632, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==23) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 1766, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==24) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 1129, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==25) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 1125, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==26) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 17216, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==27) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 4841, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==28) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 2521, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==29) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 3125, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==30) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 2408, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==31) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 18465, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==32) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 4539, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==33) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 28004, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==34) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 15650, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==35) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 18880, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==36) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 17525, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==37) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 5224, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==38) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 4263, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==39) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 18128, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==40) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 3630, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
	        player:GossipComplete()				
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end


if (intid ==107) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 38453, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end
if (intid ==108) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 32517, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end

if (intid ==109) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 33776, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end	
	
if (intid ==110) then
 if player:GetPetGUID() == GetPlayerGUID(0) then
    local pet = PerformIngameSpawn(1, 35189, player:GetMapId(), player:GetInstanceId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), false, 5000)
        if pet then
            pet:SetLevel(80)
            pet:SetFaction(35)
            player:CastSpell(pet, 2650, true)
		    player:CastSpell(pet, 24716, true)
        end
    else
            player:SendNotification("Por favor, dispense seu pet ou mova-o para o seu estábulo!.")
	        player:GossipComplete()
        end
    end		


if(intid == 499) then
   BeastMaster_T(unit, player, creature)
   end

if(intid == 500) then
   player:GossipComplete()	
   end
end 	

RegisterCreatureGossipEvent(UnitEntry, 2, BeastMaster_S) 