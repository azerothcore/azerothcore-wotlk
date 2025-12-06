--[[    How to add new locations!
               
                Example:
               
                The first line will be the main menu ID (Here [1],
                increment this for each main menu option!),
                the main menu gossip title (Here "Horde Cities"),
                as well as which faction can use the said menu (Here 1 (Horde)).
                0 = Alliance, 1 = Horde, 2 = Both
               
                The second line is the name of the main menu's sub menus,
                separated by name (Here "Orgrimmar") and teleport coordinates
                using Map, X, Y, Z, O (Here 1, 1503, -4415.5, 22, 0)
               
                [1] = { "Horde Cities", 1,      --  
                        {"Orgrimmar", 1, 1503, -4415.5, 22, 0},
                },
               
                You can copy paste the above into the script and change the values as informed.
]]
 
 
local UnitEntry = 60002
 
local T = {
        [1] = { "|TInterface\\icons\\spell_arcane_teleportdalaran:30:30:|t Dalaran Mall|r", 2,
                {"|TInterface\\icons\\spell_arcane_teleportdalaran:30:30:-23|t Dalaran Mall|r", 571, 5805.6196, 641.6034, 609.886, 4.1022134},
		},		
        [2] = { "|TInterface\\icons\\achievement_pvp_h_h:30:30:|t Horde Cities|r", 1,
                {"|TInterface\\icons\\achievement_zone_durotar:30:30:-23|t|cff610B0BOrgrimmar|r", 1, 1477.742065, -4416.811035, 25.462341, 3.305330},
                {"|TInterface\\icons\\achievement_zone_tirisfalglades_01:30:30:-23|t|cff610B0BUndercity|r", 0, 1831, 238.5, 61.6, 0},
                {"|TInterface\\icons\\achievement_zone_mulgore_01:30:30:-23|t|cff610B0BThunderbluff|r", 1, -1278, 122, 132, 0},
        },
        [3] = { "|TInterface\\icons\\achievement_pvp_a_a:30:30:|t Alliance Cities|r", 0,
                {"|TInterface\\icons\\achievement_zone_elwynnforest:30:30:-23|t|cff0101DFStormwind|r", 0, -8987.007812, 494.778778, 96.511070, 3.841737},
                {"|TInterface\\icons\\achievement_zone_ashenvale_01:30:30:-23|t|cff0101DFDarnassus|r", 1, 9952, 2280.5, 1342, 1.6},
                {"|TInterface\\icons\\achievement_zone_zangarmarsh:30:30:-23|t|cff0101DFThe Exodar|r", 530, -3863, -11736, -106, 2},
        },
        [4] = { "|TInterface\\icons\\achievement_arena_2v2_2:30:30:|t PvP Locations|r", 2,
		        {"|TInterface\\icons\\inv_wand_22:30:30:-23|t|cffC41F3BGurubashi Arena|r", 0, -13233.189453, 219.459229, 31.936506, 1.0},
		        {"|TInterface\\icons\\achievement_boss_princemalchezaar_02:30:30:-23|t|cffC41F3BThe Ring of Trials|r", 530, -1987.045898, 6565.432617, 14.572348, 2.321682},
		        {"|TInterface\\icons\\achievement_boss_princetaldaram:30:30:-23|t|cffC41F3BCircle of Blood Arena|r", 530, 2888.852783, 5903.285156, 26.166666, 2.392375},
		        {"|TInterface\\icons\\achievement_zone_durotar:30:30:-23|t|cffC41F3BDurotar PVP|r", 1, 1126.863037, -4415.391113, 23.217884, 0.118357},
		        {"|TInterface\\icons\\achievement_zone_elwynnforest:30:30:-23|t|cffC41F3BElwynn Forest PVP|r", 0, -9288.512695, 123.512215, 69.557625, 0.919214},
		},
		[5] = { "|TInterface\\icons\\spell_arcane_teleportshattrath:30:30:|t Neutral Cities|r", 2,
                {"|TInterface\\icons\\achievement_reputation_kirintor:30:30:-23|t|cff642EFEDalaran|r", 571, 5807.794922, 588.387268, 660.937134, 1.6},
                {"|TInterface\\icons\\achievement_reputation_wyrmresttemple:30:30:-23|t|cff642EFEShattrath|r", 530, -1806.164307, 5323.119141, -12.428000, 2.1},	
		},
        [6] = { "|TInterface\\icons\\inv_bannerpvp_01:30:30:|t World PVP|r", 2,
                {"|TInterface\\icons\\inv_bannerpvp_01:30:30:-23|t World PVP|r", 0, -6629.724, -1236.7904, 209.80719, 1.7561712},

		},
		[7] = { "|TInterface\\icons\\inv_misc_ahnqirajtrinket_01:30:30:|t Ahn'Qiraj Mall|r", 2,
                {"|TInterface\\icons\\inv_misc_ahnqirajtrinket_01:30:30:-23|t Ahn'Qiraj Mall|r", 1, -8539.225586, 2007.897339, 100.720596, 0.409076},
				
		},	
		[8] = { "|TInterface\\icons\\achievement_zone_tanaris_01:30:30:|t VIP Island|r", 2,
                {"|TInterface\\icons\\achievement_zone_tanaris_01:30:30:-23|t VIP Island|r", 1, -11819.989, -4756.2163, 6.8229485, 0.8183743},					
		},
	    [9] = { "|TInterface\\icons\\achievement_arena_2v2_7:30:30:|t Duel Zone|r", 2,				
                {"|TInterface\\icons\\achievement_arena_2v2_7:30:30:-23|t Duel Zone|r", 0, -1850.036, -4247.596, 2.913405, 1.0554905},	
		},
	    [10] = { "|TInterface\\icons\\inv_misc_head_dragon_01:30:30:|t Raids|r", 2,				
                {"|TInterface\\icons\\achievement_boss_ragnaros:30:30:-23|t|cffFE2EF7Molten Core|r", 230, 1128.672852, -455.090454, -101.864014, 3.779808},	
				{"|TInterface\\icons\\spell_arcane_teleportundercity:30:30:-23|t|cffFE2EF7Black temple|r", 530, -3638.457275, 303.723694, 36.953709, 1.348490},
				{"|TInterface\\icons\\achievement_zone_icecrown_01:30:30:-23|t|cffFE2EF7Icecrown Citadel|r", 571, 5865.099609, 2106.666016, 637.864197, 3.540565},
				--{"|TInterface\\icons\\spell_shadow_demonicfortitude:30:30:-23|t|cffFE2EF7Sunwell Plateau|r", 530, 12584.703125, -6775.264160, 15.090400, 3.126099},
				{"|TInterface\\icons\\achievement_reputation_argentcrusader:30:30:-23|t|cffFE2EF7Trial of the Crusader|r", 571, 8516.164062, 677.628662, 558.247986, 1.549586},
				{"|TInterface\\icons\\achievement_zone_winterspring:30:30:-23|t|cffFE2EF7The Ruby Sanctum|r", 571, 3588.458740, 215.508240, -120.055649, 5.339889},
				{"|TInterface\\icons\\achievement_dungeon_ulduarraid_misc_03:30:30:-23|t|cffFE2EF7Ulduar|r", 571, 9058.540039, -1227.070312, 1058.398071, 5.384766},
				{"|TInterface\\icons\\inv_essenceofwintergrasp:30:30:-23|t|cffFE2EF7vault of archavon|r", 571, 5391.443359, 2834.854492, 418.675537, 4.770347},
				{"|TInterface\\icons\\inv_essenceofwintergrasp:30:30:-23|t|cffFE2EF7vault of archavon|r", 571, 5472.567871, 2840.523926, 418.675598, 6.276631},
		},

};             

 
--[[ CODE STUFFS! DO NOT EDIT BELOW ]]--
--[[ UNLESS YOU KNOW WHAT YOU'RE DOING! ]]--
 
function Teleporter_Gossip(event, player, unit)
        if (#T <= 10) and (player:IsInCombat()~=true) then
                for i, v in ipairs(T) do
                        if(v[2] == 2 or v[2] == player:GetTeam()) then
                                player:GossipMenuAddItem(2, v[1], 0, i)
                        end
                end
                player:GossipSendMenu(1, unit)
        elseif (#T >= 10) and player:IsInCombat() ~= true then
                print("This teleporter only supports 10 different menus.")
		elseif (#T <= 10) and player:IsInCombat() == true then
			player:SendAreaTriggerMessage("|TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t |cffffff00 Não é possível usar este serviço em Combate! |TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t")
        end
end    
 
function Teleporter_Event(event, player, unit, sender, intid, code)
        if(intid == 0) then
                Teleporter_Gossip(event, player, unit)
        elseif(intid <= 10) then
                for i, v in ipairs(T[intid]) do
                        if (i > 2) then
                                player:GossipMenuAddItem(2, v[1], 0, intid..i)
                        end
                end
                player:GossipMenuAddItem(2, "Voltar", 0, 0)
                player:GossipSendMenu(1, unit)
        elseif(intid > 10) then
                for i = 1, #T do
                        for j, v in ipairs(T[i]) do
                                if(intid == tonumber(i..j)) then
                                        player:GossipComplete()
                                        player:Teleport(v[2], v[3], v[4], v[5], v[6])
                                end
                        end
                end
        end
end
 
RegisterCreatureGossipEvent(UnitEntry, 1, Teleporter_Gossip)
RegisterCreatureGossipEvent(UnitEntry, 2, Teleporter_Event)