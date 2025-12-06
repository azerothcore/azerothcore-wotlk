local npcid = 600006
 
local T = {
        ["Menu"] = {
                {"|TInterface\\icons\\inv_helmet_98:30|t Head ", 0},
                {"|TInterface\\icons\\inv_shoulder_62:30|t Shoulder ", 2},
                {"|TInterface\\icons\\inv_misc_cape_20:30|t Back ", 14},
                {"|TInterface\\icons\\inv_chest_plate_23:30|t Chest ", 4},
                {"|TInterface\\icons\\inv_bracer_15:30|t Wrist ", 8},
                {"|TInterface\\icons\\inv_gauntlets_62:30|t Glove ", 9},
				{"|TInterface\\icons\\inv_belt_33:30|t Waist ", 5},
                {"|TInterface\\icons\\inv_pants_plate_27:30|t Leg ", 6},
                {"|TInterface\\icons\\inv_boots_plate_06:30|t Feet ", 7},
                {"|TInterface\\icons\\inv_mace_99:30|t Main-Hand Weapon ", 15},
                {"|TInterface\\icons\\inv_axe_113:30|t Two-Handed ", 151},
                --{"|TInterface\\icons\\Inv_misc_bomb_08.png:32|t Off-Hand ", 16};
				{"|TInterface\\icons\\inv_weapon_bow_55:30|t Ranged Weapon ", 171};
				{"|TInterface\\icons\\inv_shield_74:30|t Shields ", 161};					
        },
       
        [0] = { -- Headpiece
                {"|TInterface\\icons\\spell_fire_masterofelements.png:25|t 30 Spell Power + 20 Critical Rating", 3820, false},
                {"|TInterface\\icons\\ability_warrior_shieldmastery.png:25|t 30 Spell Power + 10 Mp5", 3819, false},
                {"|TInterface\\icons\\ability_warrior_swordandboard.png:25|t 37 Stamina + 20 Defense", 3818, false},
                {"|TInterface\\icons\\ability_warrior_rampage.png:25|t 50 Attack Power + 20 Critical Rating", 3817, false},
                {"|TInterface\\icons\\ability_warrior_shieldmastery.png:25|t 30 Stamina + 25 Resilience", 3842, false},
                {"|TInterface\\icons\\ability_warrior_shieldmastery.png:25|t 50 Attack Power + 20 Resilience Rating", 3795, false},
                {"|TInterface\\icons\\spell_arcane_arcaneresilience.png:25|t 29 Spell Power + 20 Resilience Rating", 3797, false};
        },
 
        [2] = { -- Shoulders
                {"|TInterface\\icons\\spell_holy_weaponmastery.png:25|t 40 Attack power + 15 Resilience Rating", 3793, false},
                {"|TInterface\\icons\\spell_holy_powerinfusion.png:25|t 23 Spell Power + 15 Resilience Rating", 3794, false},
                {"|TInterface\\icons\\inv_shoulder_61.png:25|t 30 Stamina + 15 Resilience", 3852, false},
                {"|TInterface\\icons\\inv_axe_85.png:25|t 40 Attack Power + 15 Critical Rating", 3808, false},
                {"|TInterface\\icons\\spell_arcane_teleportorgrimmar.png:25|t 24 Spell Power + 8 Mp5", 3809, false},
                {"|TInterface\\icons\\spell_holy_divinepurpose.png:25|t 20 Dodge + 15 Defense Rating", 3811, false},
                {"|TInterface\\icons\\spell_nature_lightningoverload.png:25|t 24 Spell Power + 15 Critical Rating", 3810, false},
                --{"|TInterface\\icons\\inv_inscription_tradeskill01.png:25|t Master's Inscription of the Storm", 3838, false},
                --{"|TInterface\\icons\\inv_inscription_tradeskill01.png:25|t Master's Inscription of the Pinnacle", 3837, false},
                --{"|TInterface\\icons\\inv_inscription_tradeskill01.png:25|t Master's Inscription of the Crag", 3836, false},
                --{"|TInterface\\icons\\inv_inscription_tradeskill01.png:25|t Master's Inscription of the Axe", 3835, false};				
        },
 
        [4] = { -- Chest
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +10 All Stats", 3832, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +275 Health", 3297, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +10 Mp5", 2381, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +20 Resilience Rating", 3245, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +22 Defense Rating", 1953, false};
        },
 
        [6] = { -- Legs
                {"|TInterface\\icons\\inv_misc_armorkit_18.png:25|t 40 Resilience + 28 Stamina", 3853, false},
                {"|TInterface\\icons\\inv_misc_armorkit_32.png:25|t 55 Stamina + 22 Agility", 3822, false},
                {"|TInterface\\icons\\inv_misc_armorkit_33.png:25|t 75 Attack Power + 22 Critical Rating", 3823, false},
                {"|TInterface\\icons\\spell_nature_astralrecalgroup.png:25|t 50 Spell Power + 20 Spirit", 3719, false},
                {"|TInterface\\icons\\spell_nature_astralrecalgroup.png:25|t 50 Spell Power + 30 Stamina", 3721, false};
        },     
 
        [7] = { -- Boots
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +32 Attack Power", 1597, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t 15 Stamina + Minor Speed Increased", 3232, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +16 Agility", 983, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +18 Spirit", 1147, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t 7 Mp5 + 5 Health Per Second", 3244, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t 12 Critical + 12 Hit Rating", 3826, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +22 Stamina", 1075, false},
                --{"|TInterface\\icons\\inv_gizmo_rocketbootextreme.png:25|t Nitro Boost", 3606, false};				
        },
 
        [8] = { -- Bracers
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +40 Stamina", 3850, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +30 Spell Power", 2332, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +50 Attack Power", 3845, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +18 Spirit", 1147, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +15 Expertise", 3231, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +6 All Stats", 2661, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +16 Intellect", 1119, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Attack Power", 3756, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Stamina", 3757, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Spell Power", 3758, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Fire Resist", 3759, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Frost Resist", 3760, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Shadow Resist", 3761, false},				
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Nature Resist", 3762, false},
                --{"|TInterface\\icons\\trade_leatherworking.png:25|t Fur Lining - Arcane Resist", 3763, false};					
        },
 
        [9] = { -- Gloves
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +16 Critical Rating", 3249, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +2% Parry Rating", 3253, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +44 Attack Power", 1603, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +20 Agility", 3222, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +20 Hit Rating", 3234, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +15 Expertise Rating", 3231, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +28 Spell Power", 3246, false},
                --{"|TInterface\\icons\\inv_misc_enggizmos_01.png:25|t Hand-Mounted Pyro Rocket", 3603, false},
                --{"|TInterface\\icons\\inv_misc_enggizmos_01.png:25|t yperspeed Accelerators", 3604, false};				
        },
 
         [5] = { -- Waist
                {"|TInterface\\icons\\inv_belt_36:30|t Waist", 8192, false},
				
        },
		
        [14] = { -- Cloak
                {"|TInterface\\icons\\inv_scroll_03.png:25|t Stealth Detection +10 Agility", 3256, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t Reduce Threat +10 Spirit", 3296, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +16 Defense Rating", 1951, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +23 Haste Rating", 3831, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +225 Additional Armor", 3294, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +22 Agility", 1099, false},
                {"|TInterface\\icons\\inv_scroll_03.png:25|t +35 Spell Penetration", 3243, false},
                --{"|TInterface\\icons\\trade_engineering.png:25|t Springy Arachnoweave", 3859, false},				
                --{"|TInterface\\icons\\inv_misc_thread_01.png:25|t Lightweave Embroidery", 3722, false},
                --{"|TInterface\\icons\\inv_misc_thread_01.png:25|t Darkglow Embroidery", 3728, false},
                --{"|TInterface\\icons\\ability_rogue_throwingspecialization.png:25|t Swordguard Embroidery", 3730, false};				
        },
 
        [15] = {
                -- Main Hand
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Titan Guard +50 Stamina", 3851, false},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Accuracy 25 Critical + 25 Hit Rating", 3788, false},
                {"|TInterface\\icons\\spell_nature_strength.png:25|t Berserking +400 Attack Power", 3789, false},
                {"|TInterface\\icons\\spell_shadow_unstableaffliction_1.png:25|t Black Magic +200 Haste Rating", 3790, false},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Mighty Spellpower +63 Spell Power", 3834, false},
                {"|TInterface\\icons\\ability_criticalstrike.png:25|t Superior Potency +65 Attack Power", 3833, false},
                {"|TInterface\\icons\\spell_fire_burnout.png:25|t Ice Breaker", 3239, false},
                {"|TInterface\\icons\\spell_nature_healingway.png:25|t Lifeward", 3241, false},
                {"|TInterface\\icons\\inv_misc_gem_bloodstone_03.png:25|t Blood Draining", 3870, false},
                {"|TInterface\\icons\\inv_sword_121.png:25|t Blade Ward", 3869, false},
                {"|TInterface\\icons\\spell_holy_blessingofagility.png:25|t Exceptional Agility +26 Agility", 1103, false},
                {"|TInterface\\icons\\spell_shadow_burningspirit.png:25|t Exceptional Spirit +45 Spirit", 3844, false},
                {"|TInterface\\icons\\inv_2h_auchindoun_01.png:25|t Executioner +120 Armor Pen", 3225, false},
                {"|TInterface\\icons\\spell_nature_unrelentingstorm.png:25|t Mongoose +120 Agility", 2673, false},
				{"|TInterface\\icons\\spell_frost_wisp.png:25|t Icy Weapon", 1894, false},
				{"|TInterface\\icons\\inv_weapon_shortblade_48.png:25|t Deathfrost", 3273, false},

                -- Two-Handed
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Massacre +110 Attack Power", 3827, true},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Scourgebane", 3247, true},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Giant Slayer", 3251, true},
                {"|TInterface\\icons\\inv_scroll_05.png:25|tGreater Spellpower +81 Spell Power", 3854, true};
        },
       
        [16] ={
                -- Shields
				{"|TInterface\\icons\\inv_shield_19.png:25|t Titanium Plating -50% Disarm Duration + 81 Block Value", 3849, true};
                {"|TInterface\\icons\\ability_parry.png:25|t Defense +20 Defense Rating", 1952, true},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Greater Intellect +25 Intellect", 1128, true},
                {"|TInterface\\icons\\ability_defend.png:25|t Shield Block +15 Block Rating", 2655, true},
                {"|TInterface\\icons\\inv_shield_32.png:25|t Resilience +12 Stamina", 3229, true},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Major Stamina +18 Stamina", 1071, true},
                {"|TInterface\\icons\\inv_scroll_05.png:25|t Tough Shield +36 Block Value", 2653, true};
		},		
		[17] = {
                -- Ranged
			    {"|TInterface\\icons\\inv_misc_spyglass_02.png:25|t Heartseeker Scope +40 Ranged Critical Rating", 3608, true};
                {"|TInterface\\icons\\inv_misc_spyglass_03.png:25|t Sun Scope +40 Ranged Haste Rating", 3607, true},
        },
};
local pVar = {};
 
function Enchanter(event, plr, unit)
	--plr:GossipSetText(string.format("                  |TInterface\\icons\\inv_rod_enchantedeternium:55:55:30:0|t\n\n        Legends of Azeroth"))

        pVar[plr:GetName()] = nil;
 
        for _, v in ipairs(T["Menu"]) do
                plr:GossipMenuAddItem(1, v[1].."|R", 0, v[2])				
        end
		plr:GossipMenuAddItem(2,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:30|t |cFF8B0000Sair",0,1500)		
        plr:GossipSendMenu(600006, unit, menu_id)
end
 
function EnchanterSelect(event, plr, unit, sender, intid, code)
        if (intid == 1500) then
		    plr:GossipComplete()	
        end

        if (intid < 500) then
                local ID = intid
                local f
                if(intid == 171 or intid == 161 or intid == 151) then
                        ID = math.floor(intid/10)
                        f = true
                end
                pVar[plr:GetName()] = intid;
                if(T[ID]) then
                        for i, v in ipairs(T[ID]) do
                                if((not f and not v[3]) or (f and v[3])) then
								        plr:GossipSetText(string.format("                        |TInterface\\icons\\inv_enchant_formulasuperior_01:55:55:30:0|t\n\nAtravés deste |cff0000ffNPC|cFF000000, o jogador pode encantar instantaneamente seus itens.\n\n|cffff0000Nota|cFF000000: Enchants de profissão, devem ser feitos manualmente. Caso algum enchant esteja faltando, favor contactar a |cff0000ffStaff|cFF000000."))

                                        plr:GossipMenuAddItem(3, v[1]..".|R", 0, v[2])
                                end
                        end
                end
                plr:GossipMenuAddItem(3, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Voltar", 0, 500)
                plr:GossipSendMenu(600006, unit, menu_id)
        elseif (intid == 500) then
                Enchanter(event, plr, unit)		
        elseif (intid >= 900) then
                local ID = pVar[plr:GetName()]
                if(ID == 171 or ID == 161 or ID == 151) then
                        ID = math.floor(ID/10)
                end
                for k, v in pairs(T[ID]) do
                        if v[2] == intid then
                                local item = plr:GetEquippedItemBySlot(ID)
                                if item then
                                        if v[3] then
                                                local WType = item:GetSubClass()
                                                if pVar[plr:GetName()] == 151 then
                                                        if(WType == 1 or WType == 5 or WType == 6 or WType == 8 or WType == 10) then
                                                                item:ClearEnchantment(0,0)
                                                                item:SetEnchantment(intid, 0, 0)
                                                        else
                                                                plr:SendAreaTriggerMessage("Você não tem uma Two Handed Weapon equipada!")
                                                        end    
                                                elseif pVar[plr:GetName()] == 161 then
                                                        if(WType == 6) then
                                                                item:ClearEnchantment(0,0)
                                                                item:SetEnchantment(intid, 0, 0)
                                                        else
                                                                plr:SendAreaTriggerMessage("Você não tem um Shield equipado!")
                                                        end
												 elseif pVar[plr:GetName()] == 171 then
                                                        if(WType == 17) then
                                                                item:ClearEnchantment(0,0)
                                                                item:SetEnchantment(intid, 0, 0)
                                                        else
                                                                plr:SendAreaTriggerMessage("Você não tem uma Ranged Weapon equipada!")	
                                                        end														
                                                end
                                        else
                                                item:ClearEnchantment(0,0)
                                                item:SetEnchantment(intid, 0, 0)
                                                plr:CastSpell(plr, 36937)
                                        end
                                else
                                        plr:SendAreaTriggerMessage("Você não tem nenhum item no slot selecionado!")
                                end
                        end
                end
                EnchanterSelect(event, plr, unit, sender, pVar[plr:GetName()], nil)
        end
end
 
RegisterCreatureGossipEvent(600006, 1, Enchanter)
RegisterCreatureGossipEvent(600006, 2, EnchanterSelect)