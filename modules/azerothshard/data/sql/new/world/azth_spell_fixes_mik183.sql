-- Rogue: Master Poisoner
DELETE FROM `spell_dbc` WHERE `Id` IN ('45176');
INSERT INTO `spell_dbc` (`Id`, `Dispel`, `Mechanic`, `Attributes`, `AttributesEx`, `AttributesEx2`, `AttributesEx3`, `AttributesEx4`, `AttributesEx5`, `Stances`, `StancesNot`, `Targets`, `CastingTimeIndex`, `AuraInterruptFlags`, `ProcFlags`, `ProcChance`, `ProcCharges`, `MaxLevel`, `BaseLevel`, `SpellLevel`, `DurationIndex`, `RangeIndex`, `StackAmount`, `EquippedItemClass`, `EquippedItemSubClassMask`, `EquippedItemInventoryTypeMask`, `Effect1`, `Effect2`, `Effect3`, `EffectDieSides1`, `EffectDieSides2`, `EffectDieSides3`, `EffectRealPointsPerLevel1`, `EffectRealPointsPerLevel2`, `EffectRealPointsPerLevel3`, `EffectBasePoints1`, `EffectBasePoints2`, `EffectBasePoints3`, `EffectMechanic1`, `EffectMechanic2`, `EffectMechanic3`, `EffectImplicitTargetA1`, `EffectImplicitTargetA2`, `EffectImplicitTargetA3`, `EffectImplicitTargetB1`, `EffectImplicitTargetB2`, `EffectImplicitTargetB3`, `EffectRadiusIndex1`, `EffectRadiusIndex2`, `EffectRadiusIndex3`, `EffectApplyAuraName1`, `EffectApplyAuraName2`, `EffectApplyAuraName3`, `EffectAmplitude1`, `EffectAmplitude2`, `EffectAmplitude3`, `EffectMultipleValue1`, `EffectMultipleValue2`, `EffectMultipleValue3`, `EffectMiscValue1`, `EffectMiscValue2`, `EffectMiscValue3`, `EffectMiscValueB1`, `EffectMiscValueB2`, `EffectMiscValueB3`, `EffectTriggerSpell1`, `EffectTriggerSpell2`, `EffectTriggerSpell3`, `EffectSpellClassMaskA1`, `EffectSpellClassMaskA2`, `EffectSpellClassMaskA3`, `EffectSpellClassMaskB1`, `EffectSpellClassMaskB2`, `EffectSpellClassMaskB3`, `EffectSpellClassMaskC1`, `EffectSpellClassMaskC2`, `EffectSpellClassMaskC3`, `MaxTargetLevel`, `SpellFamilyName`, `SpellFamilyFlags1`, `SpellFamilyFlags2`, `SpellFamilyFlags3`, `MaxAffectedTargets`, `DmgClass`, `PreventionType`, `DmgMultiplier1`, `DmgMultiplier2`, `DmgMultiplier3`, `AreaGroupId`, `SchoolMask`, `Comment`) VALUES
('45176','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','1','1','1','0','1','0','-1','0','0','3','0','0','0','0','0','0','0','0','0','0','0','0','0','0','6','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','8','0','0','0','0','0','0','0','0','0','0','1','Master Poisoner Trigger (SERVERSIDE)');
 
DELETE FROM `spell_proc_event` WHERE `entry` IN ('31226', '31227', '58410');
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
('31226','0','8','0','524288','0','0','0','0','0','0'), -- Master Poisoner (Rank 1)
('31227','0','8','0','524288','0','0','0','0','0','0'), -- Master Poisoner (Rank 2)
('58410','0','8','0','524288','0','0','0','0','0','0'); -- Master Poisoner (Rank 3)

-- Shaman: Tidal Force
DELETE FROM `spell_script_names` WHERE `spell_id` = 55198;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (55198,'spell_sha_tidal_force');

DELETE FROM `spell_proc_event` WHERE `entry` = 55198;
DELETE FROM `spell_proc_event` WHERE `entry` = 55166;

INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES (55166,1,11,448,0,0,16384,2,0,0,0);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES (55198,0,11,448,0,0,16384,2,0,0,0);

-- Rogue: Shadowmeld
DELETE FROM `spell_script_names` WHERE `spell_id` = 58984;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (58984,'spell_shadowmeld');

DELETE FROM `spell_linked_spell` WHERE `spell_effect` = 32747;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (853, 32747, 0, 'Hammer of Justice - Interrupt - Rank 1 ');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (5588, 32747, 0, 'Hammer of Justice - Interrupt - Rank 2');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (5589, 32747, 0, 'Hammer of Justice - Interrupt - Rank 3');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (10308, 32747, 0, 'Hammer of Justice - Interrupt - Rank 4');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (22570, 32747, 0, 'Maim - Interrupt - Rank 1');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (49802, 32747, 0, 'Maim - Interrupt - Rank 2');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (5211, 32747, 0, 'Bash - Interrupt - Rank 1');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (6798, 32747, 0, 'Bash - Interrupt - Rank 2');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (8983, 32747, 0, 'Bash - Interrupt - Rank 3');
DELETE FROM `spell_script_names` WHERE `spell_id` = 32747;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (32747,'spell_gen_interrupt');

-- DANCING RUNE WEAPON
DELETE FROM spell_proc_event WHERE entry = 49028; 
DELETE FROM creature_template WHERE entry = 27893;
INSERT INTO `creature_template` (`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`rank`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`resistance1`,`resistance2`,`resistance3`,`resistance4`,`resistance5`,`resistance6`,`spell1`,`spell2`,`spell3`,`spell4`,`spell5`,`spell6`,`spell7`,`spell8`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`InhabitType`,`HoverHeight`,`Health_mod`,`Mana_mod`,`Armor_mod`,`RacialLeader`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`) VALUES (27893,0,0,0,0,0,11686,0,0,0,'Rune Weapon','','',0,1,1,0,14,0,1,1.14286,1,0,0,3500,2000,1,0,2048,0,0,0,0,0,0,10,1096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'',0,3,1,1,1,1,0,0,1,0,0,'npc_pet_dk_rune_weapon',12340);
DELETE FROM spell_linked_spell WHERE spell_trigger = 49028;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES (49028,81256,0,'Dancing Rune Weapon parry application');

-- Glyph of succubus
DELETE FROM `spell_script_names` WHERE `spell_id` = 6358;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (6358,'spell_warl_seduction');

-- Fix wrong application of fiery payback rank 1 always even if rank2 learned
DELETE FROM `spell_ranks` WHERE `first_spell_id`=44440;

-- Blood queen lanathel autocast of frenzy
DELETE FROM spell_linked_spell WHERE spell_trigger = 70923;
DELETE FROM spell_script_names WHERE spell_id = 70923;
INSERT INTO spell_script_names VALUES (70923,'spell_blood_queen_uncontrollable_frenzy');

-- Shadow Crash, general Vezax
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=63277;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES ('63277', '65269', '2', 'Shadow Crash');

-- Animal Handler
DELETE FROM `spell_ranks` WHERE `first_spell_id`=34453;
INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES
(34453, 34453, 1),
(34453, 34454, 2);

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_paralytic_poison';

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(35201, 'spell_gen_paralytic_poison');

