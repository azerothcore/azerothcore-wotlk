INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617974280334682621');

-- Splintered Skeleton
SET @ENTRY := 10478;

-- Set template ai to SAI
DELETE FROM `creature_template` WHERE (`entry` = @ENTRY);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 11401, 9788, 9789, 9790, 'Splintered Skeleton', NULL, NULL, 0, 59, 60, 0, 233, 0, 1, 1.71429, 1, 1, 0, 3.5, 1000, 2000, 1, 1, 1, 64, 2048, 0, 0, 0, 0, 0, 0, 6, 0, 10478, 10478, 0, 0, 0, 488, 643, 'SmartAI', 1, 3, 1, 3, 3, 1, 0, 164, 1, 8602131, 0, 0, '', 12340);

-- Add SAI for Hate to zero
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 25, 0, 18000, 20000g, 20000, 20000, 0, 11, 11838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Splintered Skeleton - In Combat - Cast \'Serverside - Hate to Zero\'');

-- Set Creature spawn locations
DELETE FROM `creature` WHERE (`id` = @ENTRY);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(48855, @ENTRY, 289, 2057, 2057, 1, 1, 9789, 0, 130.59, -2.94946, 75.3979, 3.88106, 86400, 9.26609, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48853, @ENTRY, 289, 2057, 2057, 1, 1, 11401, 0, 130.454, 11.1551, 75.3979, 2.60897, 86400, 2.18645, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48852, @ENTRY, 289, 2057, 2057, 1, 1, 9788, 0, 125.041, -7.80471, 75.3979, 4.7045, 86400, 1.84464, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48856, @ENTRY, 289, 2057, 2057, 1, 1, 9790, 0, 130.76, -13.64, 75.3979, 1.99339, 86400, 2.07342, 0, 8883, 0, 1, 0, 0, 0, '', 0),
(48851, @ENTRY, 289, 2057, 2057, 1, 1, 9788, 0, 123.429, 5.89935, 75.3979, 3.36196, 86400, 1.84617, 0, 8883, 0, 1, 0, 0, 0, '', 0);
