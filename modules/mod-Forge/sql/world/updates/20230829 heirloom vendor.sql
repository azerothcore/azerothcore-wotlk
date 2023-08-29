DELETE FROM acore_world.item_template where entry = 1000002;
INSERT INTO acore_world.item_template (entry, class, subclass, SoundOverrideSubclass, name, displayid, Quality, Flags, FlagsExtra, BuyCount, BuyPrice, SellPrice, InventoryType, AllowableClass, AllowableRace, ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank, requiredspell, requiredhonorrank, RequiredCityRank, RequiredReputationFaction, RequiredReputationRank, maxcount, stackable, ContainerSlots, StatsCount, stat_type1, stat_value1, stat_type2, stat_value2, stat_type3, stat_value3, stat_type4, stat_value4, stat_type5, stat_value5, stat_type6, stat_value6, stat_type7, stat_value7, stat_type8, stat_value8, stat_type9, stat_value9, stat_type10, stat_value10, ScalingStatDistribution, ScalingStatValue, dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2, armor, holy_res, fire_res, nature_res, frost_res, shadow_res, arcane_res, delay, ammo_type, RangedModRange, spellid_1, spelltrigger_1, spellcharges_1, spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1, spellid_2, spelltrigger_2, spellcharges_2, spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2, spellid_3, spelltrigger_3, spellcharges_3, spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3, spellid_4, spelltrigger_4, spellcharges_4, spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4, spellid_5, spelltrigger_5, spellcharges_5, spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5, bonding, description, PageText, LanguageID, PageMaterial, startquest, lockid, Material, sheath, RandomProperty, RandomSuffix, block, itemset, MaxDurability, area, `Map`, BagFamily, TotemCategory, socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3, socketBonus, GemProperties, RequiredDisenchantSkill, ArmorDamageModifier, duration, ItemLimitCategory, HolidayId, ScriptName, DisenchantID, FoodType, minMoneyLoot, maxMoneyLoot, flagsCustom, VerifiedBuild) VALUES(1000002, 15, 0, -1, 'Darkmoon Token of Endeavor', 55217, 7, 4096, 0, 1, 0, 0, 0, -1, -1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, 0.0, 0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.0, 0, 0, 0, 0.0, -1, 0, -1, 0, 0, 0, 0.0, -1, 0, -1, 0, 0, 0, 0.0, -1, 0, -1, 0, 0, 0, 0.0, -1, 0, -1, 0, 0, 0, 0.0, -1, 0, -1, 1, 'Used to purchase fate altering items.', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0.0, 0, 0, 0, '', 0, 0, 0, 0, 0, 11159);

DELETE FROM acore_world.creature_template where entry = 1000001;
INSERT INTO acore_world.creature_template (entry,difficulty_entry_1,difficulty_entry_2,difficulty_entry_3,KillCredit1,KillCredit2,modelid1,modelid2,modelid3,modelid4,name,subname,IconName,gossip_menu_id,minlevel,maxlevel,`exp`,faction,npcflag,speed_walk,speed_run,speed_swim,speed_flight,detection_range,`scale`,`rank`,dmgschool,DamageModifier,BaseAttackTime,RangeAttackTime,BaseVariance,RangeVariance,unit_class,unit_flags,unit_flags2,dynamicflags,family,trainer_type,trainer_spell,trainer_class,trainer_race,`type`,type_flags,lootid,pickpocketloot,skinloot,PetSpellDataId,VehicleId,mingold,maxgold,AIName,MovementType,HoverHeight,HealthModifier,ManaModifier,ArmorModifier,ExperienceModifier,RacialLeader,movementId,RegenHealth,mechanic_immune_mask,spell_school_immune_mask,flags_extra,ScriptName,VerifiedBuild) VALUES
	 (1000001,0,0,0,0,0,488,0,0,0,'Crash','Collector','',0,80,80,0,1555,4224,1.0,1.14286,1.0,1.0,100.0,1.0,3,0,1.0,2000,2000,1.0,1.0,8,33536,2048,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'',0,1.0,1.77381,1.0,1.0,1.0,0,0,1,0,0,0,'',11159);

DELETE FROM acore_world.npc_vendor where entry = 1000001;
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1013123,0,0,2998,0),
	 (1000001,0,1016943,0,0,2998,0),
	 (1000001,0,1016944,0,0,2998,0),
	 (1000001,0,1016945,0,0,2998,0),
	 (1000001,0,1016946,0,0,2998,0),
	 (1000001,0,1016947,0,0,2998,0),
	 (1000001,0,1016948,0,0,2998,0),
	 (1000001,0,1016949,0,0,2998,0),
	 (1000001,0,1016950,0,0,2998,0),
	 (1000001,0,1022416,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022417,0,0,2998,0),
	 (1000001,0,1022418,0,0,2998,0),
	 (1000001,0,1022419,0,0,2998,0),
	 (1000001,0,1022420,0,0,2998,0),
	 (1000001,0,1022421,0,0,2998,0),
	 (1000001,0,1022422,0,0,2998,0),
	 (1000001,0,1022423,0,0,2998,0),
	 (1000001,0,1022424,0,0,2998,0),
	 (1000001,0,1022425,0,0,2998,0),
	 (1000001,0,1022426,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022427,0,0,2998,0),
	 (1000001,0,1022428,0,0,2998,0),
	 (1000001,0,1022429,0,0,2998,0),
	 (1000001,0,1022430,0,0,2998,0),
	 (1000001,0,1022431,0,0,2998,0),
	 (1000001,0,1022436,0,0,2998,0),
	 (1000001,0,1022437,0,0,2998,0),
	 (1000001,0,1022438,0,0,2998,0),
	 (1000001,0,1022439,0,0,2998,0),
	 (1000001,0,1022440,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022441,0,0,2998,0),
	 (1000001,0,1022442,0,0,2998,0),
	 (1000001,0,1022443,0,0,2998,0),
	 (1000001,0,1022464,0,0,2998,0),
	 (1000001,0,1022465,0,0,2998,0),
	 (1000001,0,1022466,0,0,2998,0),
	 (1000001,0,1022467,0,0,2998,0),
	 (1000001,0,1022468,0,0,2998,0),
	 (1000001,0,1022469,0,0,2998,0),
	 (1000001,0,1022470,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022471,0,0,2998,0),
	 (1000001,0,1022476,0,0,2998,0),
	 (1000001,0,1022477,0,0,2998,0),
	 (1000001,0,1022478,0,0,2998,0),
	 (1000001,0,1022479,0,0,2998,0),
	 (1000001,0,1022480,0,0,2998,0),
	 (1000001,0,1022481,0,0,2998,0),
	 (1000001,0,1022482,0,0,2998,0),
	 (1000001,0,1022483,0,0,2998,0),
	 (1000001,0,1022488,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022489,0,0,2998,0),
	 (1000001,0,1022490,0,0,2998,0),
	 (1000001,0,1022491,0,0,2998,0),
	 (1000001,0,1022492,0,0,2998,0),
	 (1000001,0,1022493,0,0,2998,0),
	 (1000001,0,1022494,0,0,2998,0),
	 (1000001,0,1022495,0,0,2998,0),
	 (1000001,0,1022504,0,0,2998,0),
	 (1000001,0,1022505,0,0,2998,0),
	 (1000001,0,1022506,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022507,0,0,2998,0),
	 (1000001,0,1022508,0,0,2998,0),
	 (1000001,0,1022509,0,0,2998,0),
	 (1000001,0,1022510,0,0,2998,0),
	 (1000001,0,1022511,0,0,2998,0),
	 (1000001,0,1022512,0,0,2998,0),
	 (1000001,0,1022513,0,0,2998,0),
	 (1000001,0,1022514,0,0,2998,0),
	 (1000001,0,1022515,0,0,2998,0),
	 (1000001,0,1022516,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1022517,0,0,2998,0),
	 (1000001,0,1022518,0,0,2998,0),
	 (1000001,0,1022519,0,0,2998,0),
	 (1000001,0,1042943,0,0,2998,0),
	 (1000001,0,1042944,0,0,2998,0),
	 (1000001,0,1042945,0,0,2998,0),
	 (1000001,0,1042946,0,0,2998,0),
	 (1000001,0,1042947,0,0,2998,0),
	 (1000001,0,1042948,0,0,2998,0),
	 (1000001,0,1044096,0,0,2998,0);
INSERT INTO acore_world.npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,VerifiedBuild) VALUES
	 (1000001,0,1048716,0,0,2998,0),
	 (1000001,0,1048718,0,0,2998,0);
