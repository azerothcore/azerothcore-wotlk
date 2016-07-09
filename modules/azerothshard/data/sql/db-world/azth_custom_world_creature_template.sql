SET 
	@entry := 1000001,
	@modelid := 28156,
	@name := 'Currency Supplier',
	@subname := 'AzerothShard Supplies',
	@rank := 4,
	@unitflags1 := 131078, -- UNIT_FLAG_PACIFIED + UNIT_FLAG_DISABLE_MOVE + UNIT_FLAG_NON_ATTACKABLE
	@faction := 1774;
    
DELETE FROM creature_template WHERE entry = @entry;
INSERT INTO creature_template (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, modelid3, modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction, npcflag, speed_walk, speed_run, scale, rank, dmgschool, BaseAttackTime, RangeAttackTime, BaseVariance, RangeVariance, unit_class, unit_flags, unit_flags2, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, type, type_flags, lootid, pickpocketloot, skinloot, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, DamageModifier, ExperienceModifier, RacialLeader, movementId, RegenHealth, mechanic_immune_mask, flags_extra, ScriptName, VerifiedBuild) VALUES
(@entry, '0', '0', '0', '0', '0', @modelid, '0', '0', '0', @name, @subname, '', '0', '80', '80', '2', @faction, '128', '1', '1.14286', '1', @rank, '0', '2000', '2000', '1', '1', '1', @unitflags1, '0', '0', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '3', '1', '1', '1', '1', '1', '1', '0', '0', '1', '0', '0', '', '12340');

SET 
	@entry := 1000002,
	@modelid := 28156,
	@name := 'Transmogrification Items',
	@subname := 'AzerothShard Supplies',
	@rank := 4,
	@unitflags1 := 131078, -- UNIT_FLAG_PACIFIED + UNIT_FLAG_DISABLE_MOVE + UNIT_FLAG_NON_ATTACKABLE
	@faction := 1774;
    
DELETE FROM creature_template WHERE entry = @entry;
INSERT INTO creature_template (entry, difficulty_entry_1, difficulty_entry_2, difficulty_entry_3, KillCredit1, KillCredit2, modelid1, modelid2, modelid3, modelid4, name, subname, IconName, gossip_menu_id, minlevel, maxlevel, exp, faction, npcflag, speed_walk, speed_run, scale, rank, dmgschool, BaseAttackTime, RangeAttackTime, BaseVariance, RangeVariance, unit_class, unit_flags, unit_flags2, dynamicflags, family, trainer_type, trainer_spell, trainer_class, trainer_race, type, type_flags, lootid, pickpocketloot, skinloot, resistance1, resistance2, resistance3, resistance4, resistance5, resistance6, spell1, spell2, spell3, spell4, spell5, spell6, spell7, spell8, PetSpellDataId, VehicleId, mingold, maxgold, AIName, MovementType, InhabitType, HoverHeight, HealthModifier, ManaModifier, ArmorModifier, DamageModifier, ExperienceModifier, RacialLeader, movementId, RegenHealth, mechanic_immune_mask, flags_extra, ScriptName, VerifiedBuild) VALUES
(@entry, '0', '0', '0', '0', '0', @modelid, '0', '0', '0', @name, @subname, '', '0', '80', '80', '2', @faction, '128', '1', '1.14286', '1', @rank, '0', '2000', '2000', '1', '1', '1', @unitflags1, '0', '0', '0', '0', '0', '0', '0', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '3', '1', '1', '1', '1', '1', '1', '0', '0', '1', '0', '0', '', '12340');