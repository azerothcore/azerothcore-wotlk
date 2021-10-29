-- DB update 2021_01_09_02 -> 2021_01_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_09_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_09_02 2021_01_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609100844918098600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609100844918098600');

DELETE FROM `creature` WHERE (`id` IN (25258, 25261, 25259) AND `guid` IN (85221, 85222, 85226));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(85221, 25258, 571, 0, 0, 1, 1, 23031, 0, 2280.15, 5179.14, 11.423, 4.38078, 1200, 0, 0, 1, 0, 2, 0, 0, 0, '', 0),
(85222, 25259, 571, 0, 0, 1, 1, 23031, 0, 2282.03, 5179.58, 11.423, 3.76991, 1200, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(85226, 25261, 571, 0, 0, 1, 1, 23031, 0, 2280.96, 5180.91, 11.423, 3.735, 1200, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

UPDATE `creature_template` SET `flags_extra` = 2, `unit_flags` = 0, `AIName` = 'SmartAI' WHERE `entry` IN (25258, 25259, 25260, 25261);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (25258, 25259, 25260, 25261));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25258, 0, 0, 0, 34, 0, 100, 1, 2, 5, 0, 0, 0, 80, 2525800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - On Reached Point 5 - Run Script (No Repeat)'),
(25258, 0, 1, 0, 34, 0, 100, 0, 2, 9, 0, 0, 0, 80, 2525801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - On Reached Point 9 - Run Script'),
(25258, 0, 2, 0, 34, 0, 100, 0, 2, 10, 0, 0, 0, 80, 2525802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - On Reached Point 10 - Run Script'),
(25258, 0, 3, 0, 34, 0, 100, 1, 2, 15, 0, 0, 0, 12, 25260, 3, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 2255.77, 5186.26, 11.4391, 1.47479, 'Footman Rob - On Reached Point 15 - Summon Creature \'Footman Mitch\' (No Repeat)'),
(25258, 0, 4, 0, 34, 0, 100, 0, 2, 16, 0, 0, 0, 80, 2525803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - On Reached Point 16 - Run Script'),
(25258, 0, 5, 0, 17, 0, 100, 0, 25260, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - On Summoned Unit - Store Targetlist'),
(25258, 0, 6, 0, 1, 0, 100, 1, 100, 100, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Out of Combat - Change Equipment (No Repeat)'),
(25258, 0, 7, 0, 1, 0, 100, 1, 100, 100, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Out of Combat - Change Equipment (No Repeat)'),
(25258, 0, 8, 0, 1, 0, 100, 1, 100, 100, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Out of Combat - Change Equipment (No Repeat)'),
(25259, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.27258, 'Footman George - On Data Set 1 1 - Set Orientation 4.27258'),
(25260, 0, 0, 1, 63, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Mitch - On Just Created - Say Line 0'),
(25260, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Mitch - On Just Created - Set Run Off'),
(25260, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2264.94, 5221.99, 11.2882, 4.3713, 'Footman Mitch - On Just Created - Move To Position'),
(25261, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.27258, 'Footman Chuck - On Data Set 1 1 - Set Orientation 4.28258');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2525800, 2525801, 2525802, 2525803));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525800, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 0'),
(2525800, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 0'),
(2525801, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 1'),
(2525801, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 10, 110613, 25245, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 0'),
(2525801, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 2, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 2'),
(2525801, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 10, 110613, 25245, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 1'),
(2525801, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 5, 397, 0, 0, 0, 0, 0, 10, 110613, 25245, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 397'),
(2525801, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 17, 423, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Emote State 423'),
(2525801, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 1, 0, 2703, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 1, 0, 2703, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 1, 0, 2703, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 17, 423, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Emote State 423'),
(2525801, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 423, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Emote State 423'),
(2525801, 9, 11, 0, 0, 0, 100, 0, 22000, 22000, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Emote State 0'),
(2525801, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Emote State 0'),
(2525801, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Emote State 0'),
(2525801, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 1, 0, 2703, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 1, 0, 2703, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 1, 0, 2703, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525801, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Change Equipment'),
(2525802, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 3, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 3'),
(2525802, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Data 1 1'),
(2525802, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Set Data 1 1'),
(2525802, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Say Line 0'),
(2525802, 9, 4, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 11'),
(2525802, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 11'),
(2525802, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 11'),
(2525802, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 274'),
(2525802, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 274'),
(2525802, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 274, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Play Emote 274'),
(2525803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 10, 85222, 25259, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Despawn Instant'),
(2525803, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 10, 85226, 25261, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Despawn Instant'),
(2525803, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Despawn Instant'),
(2525803, 9, 3, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Footman Rob - Actionlist - Despawn Instant');

SET @PATH := 8522110;
DELETE FROM `creature_addon` WHERE `guid` = 85221;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(85221, @PATH , 0, 0, 1, 0, '');
                                                                                         
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(@PATH, 1, 2277.19, 5177.20, 11.33, 0, 0, 0, 0, 100, 0),
(@PATH, 2, 2268.98, 5175.54, 11.166, 0, 0, 0, 0, 100, 0),
(@PATH, 3, 2254.60, 5188.90, 11.385, 0, 0, 0, 0, 100, 0),
(@PATH, 4, 2256.71, 5195.323, 11.450, 0, 0, 0, 0, 100, 0),
(@PATH, 5, 2260.67, 5200.36, 11.3711, 0, 0, 0, 0, 100, 0),
(@PATH, 6, 2264.38, 5199.09, 11.3676, 0, 13000, 0, 0, 100, 0),
(@PATH, 7, 2270.18, 5196.94, 12.4959, 0, 0, 0, 0, 100, 0),
(@PATH, 8, 2275.23, 5194.94, 12.49, 0, 0, 0, 0, 100, 0),
(@PATH, 9, 2276.23, 5197.58, 12.4896, 0, 0, 0, 0, 100, 0),
(@PATH, 10, 2279.08, 5206.5, 12.494, 0, 60000, 0, 0, 100, 0),
(@PATH, 11, 2278.6, 5205.3, 12.4926, 0, 16000, 0, 0, 100, 0),
(@PATH, 12, 2275.55, 5197.84, 12.4897, 0, 0, 0, 0, 100, 0),
(@PATH, 13, 2273.063, 5196.067, 12.4932, 0, 0, 0, 0, 100, 0),
(@PATH, 14, 2265.21, 5198.54, 11.3533, 0, 0, 0, 0, 100, 0),
(@PATH, 15, 2260.26, 5202.83, 11.4377, 0, 0, 0, 0, 100, 0),
(@PATH, 16, 2258.98, 5205.83, 11.322, 0, 0, 0, 0, 100, 0),
(@PATH, 17, 2268.17, 5226.07, 11.2421, 0, 5000, 0, 0, 100, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID`= 85221;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(85221, 85221, 0, 0, 4, 0, 0),
(85221, 85226, 1, 305, 4, 8, 4),
(85221, 85222, 1, 55, 4, 8, 4);
                                                                                                                  
DELETE FROM `creature_text` WHERE `CreatureID` IN (25245, 25258, 25259, 25260, 25261);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(25245, 0, 0, 'You lads know the drill.  No alcohol to servicemen on duty.  You want the general to kill me himself?', 12, 7, 100, 274, 0, 0, 24744, 0, 'James Deacon'),
(25245, 1, 0, 'All right, all right... but you didn\'t get these from me!', 12, 7, 100, 6, 0, 0, 24745, 0, 'James Deacon'),
(25258, 0, 0, 'One last drink before we head to the front?', 12, 7, 100, 1, 0, 0, 24475, 0, 'Footman Rob'),
(25258, 1, 0, 'Barkeep!  Bring out your strongest ale.  We\'re off to the front.', 12, 7, 100, 1, 0, 0, 24478, 0, 'Footman Rob'),
(25258, 2, 0, 'You\'ll surely make an exception for us, eh?  We might not come back.', 12, 7, 100, 1, 0, 0, 24479, 0, 'Footman Rob'),
(25258, 3, 0, 'I guess that\'s it then.  Off we go.', 12, 7, 100, 1, 0, 0, 24482, 0, 'Footman Rob'),
(25259, 0, 0, 'Sure, why not?', 12, 7, 100, 6, 0, 0, 24476, 0, 'Footman George'),
(25260, 0, 0, 'Hey, guys!  Wait up!', 12, 7, 100, 0, 0, 0, 24761, 0, 'Footman Mitch'),
(25261, 0, 0, 'That was the worst beer I\'ve ever had.', 12, 7, 100, 0, 0, 0, 24483, 0, 'Footman Chuck');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
