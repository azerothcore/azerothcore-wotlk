-- DB update 2019_03_25_00 -> 2019_03_25_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_25_00 2019_03_25_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553383116284680300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553383116284680300');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2435;

DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 2435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2435, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(2435, 0, 1, 0, 1, 0, 100, 1, 120000, 120000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(2435, 0, 2, 0, 1, 0, 100, 1, 126000, 126000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(2435, 0, 3, 0, 1, 0, 100, 1, 130000, 130000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(2435, 0, 4, 0, 1, 0, 100, 1, 140000, 140000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -780.091248, -530.876099, 20.693323, 0.205787, ''),
(2435, 0, 5, 0, 1, 0, 100, 1, 142000, 142000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -793.784363, -572.725769, 16.075451, 5.450406, ''),
(2435, 0, 6, 0, 1, 0, 100, 1, 144000, 144000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -851.030151, -518.15387, 12.146384, 2.463797, ''),
(2435, 0, 7, 0, 1, 0, 100, 1, 146000, 146000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -830.228943, -530.124084, 13.691698, 5.620338, ''),
(2435, 0, 8, 0, 1, 0, 100, 1, 148000, 148000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -859.666992, -544.375977, 10.144335, 1.15192, ''),
(2435, 0, 9, 0, 1, 0, 100, 1, 150000, 150000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -805.856506, -479.743591, 15.871011, 5.608394, ''),
(2435, 0, 10, 0, 1, 0, 100, 1, 152000, 152000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -887.816284, -545.123413, 7.047425, 0.609322, ''),
(2435, 0, 11, 0, 1, 0, 100, 1, 154000, 154000, 0, 0, 12, 2434, 6, 60000, 0, 0, 0, 8, 0, 0, 0, -893.224487, -590.699219, 7.445801, 1.06091, ''),
(2435, 0, 12, 0, 1, 0, 100, 1, 156000, 156000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, ''),
(2435, 0, 13, 0, 11, 0, 100, 1, 0, 0, 0, 0, 41, 180000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `creature` WHERE `guid` IN(2054680, 2054762, 2054790, 2054758, 2054765);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(2054680, 2435, 0, 0, 0, 1, 1, 0, 1, -743.976, -521.674, 21.6875, 0.356982, 300, 0, 0, 2033, 0, 0, 0, 0, 0, '', 0),
(2054762, 2386, 0, 0, 0, 1, 1, 0, 1, -830.2, -530.016, 13.5798, 5.58997, 300, 0, 0, 2310, 0, 2, 0, 0, 0, '', 0),
(2054790, 2386, 0, 0, 0, 1, 1, 0, 1, -820.187, -587.001, 15.1409, 0.337865, 300, 0, 0, 2310, 0, 2, 0, 0, 0, '', 0),
(2054758, 2386, 0, 0, 0, 1, 1, 0, 1, -851.274, -514.767, 12.3157, 4.75353, 300, 0, 0, 2310, 0, 2, 0, 0, 0, '', 0),
(2054765, 2386, 0, 0, 0, 1, 1, 0, 1, -894.552, -593.034, 8.03216, 0.822596, 300, 0, 0, 2310, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_template` WHERE `entry` IN(2435, 2386, 2436);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES 
(2435, 0, 0, 0, 0, 0, 3664, 0, 0, 0, 'Southshore Crier', NULL, NULL, 0, 45, 45, 0, 96, 0, 1.09, 1.14286, 1, 0, 45, 60, 0, 108, 5, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 31, 46, 10, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.1, 1, 1, 0, 0, 1, 0, 0, '', 12340),
(2386, 0, 0, 0, 0, 0, 3705, 3708, 0, 0, 'Southshore Guard', NULL, NULL, 0, 45, 45, 0, 96, 0, 1, 1.42857, 1, 0, 76, 100, 0, 184, 1, 2000, 2000, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 52, 76, 17, 7, 0, 2386, 2386, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.25, 1, 1, 0, 144, 1, 0, 0, '', 12340),
(2436, 0, 0, 0, 0, 0, 3667, 0, 0, 0, 'Farmer Kent', NULL, NULL, 0, 45, 45, 0, 96, 0, 1, 1.14286, 1, 0, 35, 48, 0, 86, 5, 2000, 2000, 1, 4096, 2048, 0, 0, 0, 0, 0, 0, 24, 36, 6, 7, 0, 2436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1.02, 1, 1, 0, 0, 1, 0, 0, '', 12340);

DELETE FROM `creature_addon` WHERE `guid` IN(2054762, 2054790, 2054758);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(2054762, 20547620, 0, 0, 0, 0, NULL),
(2054790, 20547900, 0, 0, 0, 0, NULL),
(2054758, 20547580, 0, 0, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` IN(20547620, 20547900, 20547580);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(20547620, 5, -820.391, -533.587, 15.0998, 0, 0, 0, 0, 100, 0),
(20547620, 4, -811.54, -537.426, 15.5707, 0, 0, 0, 0, 100, 0),
(20547620, 3, -812.723, -542.349, 15.7681, 0, 0, 0, 0, 100, 0),
(20547620, 2, -818.293, -536.134, 15.4268, 0, 0, 0, 0, 100, 0),
(20547620, 1, -824.617, -532.774, 14.6419, 0, 0, 0, 0, 100, 0),
(20547620, 6, -827.359, -531.308, 14.2184, 0, 0, 0, 0, 100, 0),
(20547900, 1, -811.639, -584.494, 15.1499, 0, 0, 0, 0, 100, 0),
(20547900, 2, -800.046, -581.489, 15.2147, 0, 0, 0, 0, 100, 0),
(20547900, 3, -800.833, -572.892, 15.257, 0, 0, 0, 0, 100, 0),
(20547900, 4, -801.21, -563.578, 15.4117, 0, 0, 0, 0, 100, 0),
(20547900, 5, -803.931, -564.6, 15.2881, 0, 0, 0, 0, 100, 0),
(20547900, 6, -801.668, -574.03, 15.2231, 0, 0, 0, 0, 100, 0),
(20547900, 7, -803.813, -581.047, 15.1528, 0, 0, 0, 0, 100, 0),
(20547900, 8, -816.032, -584.642, 15.1528, 0, 0, 0, 0, 100, 0),
(20547580, 9, -859.389, -518.092, 11.0379, 0, 0, 0, 0, 100, 0),
(20547580, 8, -858.511, -524.652, 10.5177, 0, 0, 0, 0, 100, 0),
(20547580, 7, -852.398, -526.75, 10.4794, 0, 0, 0, 0, 100, 0),
(20547580, 6, -840.13, -523.399, 11.2839, 0, 0, 0, 0, 100, 0),
(20547580, 5, -839.172, -527.138, 11.2478, 0, 0, 0, 0, 100, 0),
(20547580, 4, -854.201, -532.857, 9.89841, 0, 0, 0, 0, 100, 0),
(20547580, 3, -852.599, -541.857, 10.5971, 0, 0, 0, 0, 100, 0),
(20547580, 2, -856.708, -542.947, 10.352, 0, 0, 0, 0, 100, 0),
(20547580, 1, -860.698, -518.619, 10.9982, 0, 0, 0, 0, 100, 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
