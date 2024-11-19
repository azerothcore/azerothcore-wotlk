-- DB update 2023_01_13_00 -> 2023_01_14_00
-- Pathing for Frances Lin Entry: 20401
SET @NPC := 20401;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1820.7647705078125,`position_y`=1016.41839599609375,`position_z`=11.68548202514648437, `orientation`=1.570796370506286621, `VerifiedBuild`=47187 WHERE `id1`=@NPC;
DELETE FROM `waypoints` WHERE `entry`=@NPC;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(@NPC,1,1814.421,1016.1131,11.685482,NULL,0,'Frances Lin'),
(@NPC,2,1812.4491,1018.107,11.685483,NULL,0,'Frances Lin'),
(@NPC,3,1812.9846,1022.4553,11.685482,NULL,0,'Frances Lin'),
(@NPC,4,1811.7157,1025.7238,11.685483,NULL,0,'Frances Lin'),
(@NPC,5,1811.8307,1029.2526,11.060482,NULL,0,'Frances Lin'),
(@NPC,6,1813.155,1030.9547,11.060482,NULL,0,'Frances Lin'), -- "What'll it be?"
(@NPC,7,1811.2089,1037.1213,11.685482,NULL,0,'Frances Lin'),
(@NPC,8,1807.0463,1038.4927,11.685481,NULL,0,'Frances Lin'), -- "More grog?"
(@NPC,9,1811.8945,1036.559,11.685482,NULL,0,'Frances Lin'),
(@NPC,10,1811.4893,1033.161,11.060482,NULL,0,'Frances Lin'),
(@NPC,11,1807.2407,1031.8088,11.060482,NULL,0,'Frances Lin'),
(@NPC,12,1803.4313,1031.8158,11.060482,NULL,0,'Frances Lin'),
(@NPC,13,1802.2823,1027.459,11.374505,NULL,0,'Frances Lin'),
(@NPC,14,1801.75,1018.7515,14.890841,NULL,0,'Frances Lin'),
(@NPC,15,1808.53,1018.5084,14.902864,NULL,0,'Frances Lin'),
(@NPC,16,1808.1046,1026.6862,18.544857,NULL,0,'Frances Lin'),
(@NPC,17,1808.9912,1030.0287,18.544855,NULL,0,'Frances Lin'), -- Room check scene
(@NPC,18,1808.0543,1019.494,14.90403,NULL,0,'Frances Lin'),
(@NPC,19,1802.7164,1019.3997,14.89441,NULL,0,'Frances Lin'),
(@NPC,20,1803.4958,1028.3624,11.060482,NULL,0,'Frances Lin'),
(@NPC,21,1805.415,1031.0358,11.060482,NULL,0,'Frances Lin'),
(@NPC,22,1810.5465,1030.5178,11.060482,NULL,0,'Frances Lin'),
(@NPC,23,1811.577,1025.1711,11.685483,NULL,0,'Frances Lin'),
(@NPC,24,1812.6082,1018.2567,11.685483,NULL,0,'Frances Lin'),
(@NPC,25,1813.9412,1016.4092,11.685482,NULL,0,'Frances Lin'),
(@NPC,26,1820.7648,1016.4184,11.685482,NULL,0,'Frances Lin'); -- Reset orientation
-- 0x204214460013EC4000618C0000233C57 .go xyz 1814.421 1016.1131 11.685482

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20401;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20401, 0, 0, 0, 60, 0, 100, 0, 600000, 600000, 600000, 600000, 0, 53, 0, 20401, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - On Update - Start Waypoint'),
(20401, 0, 1, 0, 40, 0, 100, 0, 6, 20401, 0, 0, 0, 80, 2040100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - On Waypoint 6 Reached - Run "What\'ll it be?" Script'),
(20401, 0, 2, 0, 40, 0, 100, 0, 8, 20401, 0, 0, 0, 80, 2040101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - On Waypoint 8 Reached - Run "More grog?" Script'),
(20401, 0, 3, 0, 40, 0, 100, 0, 17, 20401, 0, 0, 0, 80, 2040102, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - On Waypoint 17 Reached - Run Room Check Script'),
(20401, 0, 4, 0, 58, 0, 100, 0, 26, 20401, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.5707963705062866, 'Frances Lin - On Waypoint Finished - Reset Orientation');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2040100, 2040101, 2040102));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2040100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 9000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - In Combat - Pause Waypoint'),
(2040100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.230825424194336, 'Frances Lin - In Combat - Set Orientation 6.230825424194336'),
(2040100, 9, 2, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - In Combat - Say Line 0'),
(2040100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - In Combat - Say Line "I\'ll come back later."'),
(2040101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 5250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - In Combat - Pause Waypoint'),
(2040101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.286381244659424, 'Frances Lin - In Combat - Set Orientation 2.286381244659424'),
(2040101, 9, 2, 0, 0, 0, 100, 0, 1800, 1800, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - In Combat - Say Line "More grog?"'),
(2040102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 6600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frances Lin - In Combat - Pause Waypoint'),
(2040102, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.410520553588867, 'Frances Lin - In Combat - Set Orientation 5.410520553588867'),
(2040102, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.6806784272193909, 'Frances Lin - In Combat - Set Orientation 0.6806784272193909'),
(2040102, 9, 3, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.2165682315826416, 'Frances Lin - In Combat - Set Orientation 2.2165682315826416');

DELETE FROM `creature_text` WHERE `CreatureID`=20401;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20401, 0, 0, 18157, 'What\'ll it be?', 12, 0, 100, 1, 0, 0, 0, 'Frances Lin'),
(20401, 1, 0, 18158, 'I\'ll come back later.', 12, 0, 100, 1, 0, 0, 0, 'Frances Lin'),
(20401, 2, 0, 18159, 'More grog?', 12, 0, 100, 1, 0, 0, 0, 'Frances Lin');

-- Chef Jessen
UPDATE `creature` SET `position_x`=1816.1407,`position_y`=1006.5959,`position_z`=11.672032, `orientation`=0.03490658476948738, `VerifiedBuild`=47187 WHERE `guid`=83695 AND `id1`=20378;

DELETE FROM `creature_template_addon` WHERE (`entry` = 20378);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20378, 0, 0, 0, 1, 0, 0, '');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20378;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20378);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20378, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Respawn - Set Event Phase 1'),
(20378, 0, 1, 0, 60, 1, 100, 0, 1200, 1200, 1200, 1200, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Update - Play Emote 36 (Phase 1)'),
(20378, 0, 2, 0, 60, 0, 100, 0, 900000, 900000, 900000, 900000, 0, 80, 2037800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Update - Run Script'),
(20378, 0, 3, 0, 58, 0, 100, 0, 3, 2037800, 0, 0, 0, 80, 2037801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Waypoint Finished - Run Script'),
(20378, 0, 4, 5, 58, 0, 100, 0, 2, 2037801, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.03490658476948738, 'Chef Jessen - On Waypoint Finished - Set Orientation 0.03490658476948738'),
(20378, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Waypoint Finished - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2037800, 2037801));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2037800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Set Event Phase 2'),
(2037800, 9, 1, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Say Line 0'),
(2037800, 9, 2, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 53, 0, 2037800, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Start Waypoint'),
(2037801, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Say Line 1'),
(2037801, 9, 1, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20345, 10, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Set Orientation Closest Creature \'Commander Mograine\''),
(2037801, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 19, 20345, 10, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Say Line 2'),
(2037801, 9, 3, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.5707963705062866, 'Chef Jessen - On Script - Set Orientation 1.5707963705062866'),
(2037801, 9, 4, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Say Line 3'),
(2037801, 9, 5, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Say Line 4'),
(2037801, 9, 6, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Play Emote 14'),
(2037801, 9, 7, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 53, 0, 2037801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - On Script - Start Waypoint');

DELETE FROM `waypoints` WHERE `entry` IN (2037800, 2037801);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(2037800,1,1813.269,1010.926,11.675028,NULL,0,'Chef Jessen'),
(2037800,2,1812.7063,1019.1864,11.685483,NULL,0,'Chef Jessen'),
(2037800,3,1811.6666,1025.1326,11.685483,NULL,0,'Chef Jessen'),
(2037801,1,1812.8987,1010.8238,11.674806,NULL,0,'Chef Jessen'),
(2037801,2,1816.1407,1006.5959,11.672032,NULL,0,'Chef Jessen');

DELETE FROM `creature_text` WHERE `CreatureID`=20378;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20378, 0, 0, 18140, 'This is madness! I\'ve had enough! ENOUGH!', 12, 0, 100, 5, 0, 0, 0, 'Chef Jessen'),
(20378, 1, 0, 18141, 'EVERYBODY LISTEN UP!', 12, 0, 100, 22, 0, 0, 0, 'Chef Jessen'),
(20378, 2, 0, 18142, 'I\'m speakin\' to you too, mister fancy britches Mograine! SHUT YER YAP!', 12, 0, 100, 25, 0, 0, 0, 'Chef Jessen'),
(20378, 3, 0, 18143, 'NOW, everybody in this bar is gonna keep the noise to a minimum or ol\' Jessen is gonna bust out his rollin\' pin and cleaver and go orc on all of ya! IS EVERYONE CLEAR?!!!', 12, 0, 100, 22, 0, 0, 0, 'Chef Jessen'),
(20378, 4, 0, 18144, 'AAAAAAaaaarrrrgh!!!!! SHUT IT!', 12, 0, 100, 15, 0, 0, 0, 'Chef Jessen');

-- Citizen Pack 1
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (20428, 20429, 20430);
UPDATE `creature` SET `position_x`=1819.1077,`position_y`=1088.4419,`position_z`=12.576075, `orientation`=2.39110112190246582, `VerifiedBuild`=47187 WHERE `guid`=83704 AND `id1`=20428;
UPDATE `creature` SET `position_x`=1817.1642,`position_y`=1090.5482,`position_z`=12.359373, `orientation`=5.567600250244140625, `VerifiedBuild`=47187 WHERE `guid`=83705 AND `id1`=20429;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -83704) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-83704, 0, 0, 0, 60, 0, 100, 0, 210000, 210000, 210000, 210000, 0, 80, 2042800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Update - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -83705);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-83705, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Data Set 1 1 - Say Line 0'),
(-83705, 0, 1, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Data Set 1 2 - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2042800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2042800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Say Line 0'),
(2042800, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 83705, 20429, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Set Data 1 1'),
(2042800, 9, 2, 0, 0, 0, 100, 0, 8200, 8200, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Say Line 1'),
(2042800, 9, 3, 0, 0, 0, 100, 0, 8600, 8600, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 83705, 20429, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Set Data 1 2'),
(2042800, 9, 4, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Say Line 2');

DELETE FROM `creature_text` WHERE `CreatureID` IN (20428, 20429, 20430);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20428, 0, 0, 18201, 'These damned taxes are breaking my back. King Terenas must be losing his grip if he thinks all this reconstruction will boost the economy.', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 1'),
(20429, 0, 0, 18202, 'He hasn\'t been the same since the War. It\'s like he aged and became an old man overnight. That son of his, though - he\'ll make a fine king one day. \n', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 1'),
(20428, 1, 0, 18203, 'Prince Arthas? Please. Spends all his time chasing after Proudmoore\'s daughter, from what I hear. Boy\'s got more on his mind than affairs of state, I tell ya.\n', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 1'),
(20429, 1, 0, 18204, 'I\'m not so sure. I\'ve heard that he\'s being trained as a paladin. Terenas hopes the Silver Hand can teach him some discipline. If anyone can set Arthas straight, it\'d be old Uther.', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 1'),
(20428, 2, 0, 18205, 'Aye, that\'s true. Uther - now there\'s a real hero for the people.', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 1'),
-- Citizen Pack 2
(20429, 2, 0, 18206, 'So have you heard about Lieutenant Blackmoore\'s new gladiator? Some say he\'s unbeatable.', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 2'),
(20430, 0, 0, 18207, 'Aye, I seen \'im fight. He\'s an orc - big as they come. Lost a week\'s wages bettin\' against that one. Won\'t make that mistake again!', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 2'),
(20429, 3, 0, 18208, 'Win or lose, the Lieutenant must be crazy to keep a pet orc like that. Those ones can\'t be trusted. Animals, they are.\n', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 2'),
(20430, 1, 0, 18209, 'True. True. Light help him if that monster ever gets free!', 12, 0, 100, 0, 0, 0, 0, 'Hillsbrad Citizen - Group 2');

UPDATE `creature` SET `position_x`=1950.0758,`position_y`=1095.8552,`position_z`=26.906488, `orientation`=5.480333805084228515, `id1`=20429, `VerifiedBuild`=47187 WHERE `guid`=83631 AND `id1`=20428;
UPDATE `creature` SET `position_x`=1950.908,`position_y`=1094.0271,`position_z`=26.906424, `orientation`=2.164208173751831054, `VerifiedBuild`=47187 WHERE `guid`=83632 AND `id1`=20430;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -83631) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-83631, 0, 0, 0, 60, 0, 100, 0, 210000, 210000, 210000, 210000, 0, 80, 2042900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Update - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -83632);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-83632, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Data Set 1 1 - Say Line 0'),
(-83632, 0, 1, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Data Set 1 2 - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2042900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2042900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Say Line 2'),
(2042900, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 83632, 20430, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Set Data 1 1'),
(2042900, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Say Line 3'),
(2042900, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, 83632, 20430, 0, 0, 0, 0, 0, 0, 'Hillsbrad Citizen - On Script - Set Data 1 2');

-- Pathing for Herod the Bully Entry: 20360
SET @NPC := (SELECT `guid` FROM `creature` WHERE `id1`=20360);
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1763.9722,`position_y`=1068.7299,`position_z`=6.8648014, `VerifiedBuild`=47187 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1763.9722,1068.7299,6.8648014,NULL,0,0,0,100,0),
(@PATH,2,1775.3702,1064.1283,7.084126,NULL,0,0,0,100,0),
(@PATH,3,1788.0264,1061.6875,7.9343457,NULL,0,0,0,100,0),
(@PATH,4,1797.145,1063.4182,8.314228,NULL,0,0,0,100,0),
(@PATH,5,1801.3014,1067.0065,8.882008,NULL,0,0,0,100,0),
(@PATH,6,1822.5966,1073.9354,11.184986,NULL,0,0,0,100,0),
(@PATH,7,1834.2837,1075.5514,12.219876,NULL,0,0,0,100,0),
(@PATH,8,1846.6216,1071.2936,14.550565,NULL,0,0,0,100,0),
(@PATH,9,1855.1255,1067.6527,15.293363,NULL,0,0,0,100,0),
(@PATH,10,1867.3689,1054.9958,16.089104,NULL,0,0,0,100,0),
(@PATH,11,1868.7181,1047.942,16.896965,NULL,0,0,0,100,0),
(@PATH,12,1869.4846,1041.5859,17.003654,NULL,0,0,0,100,0),
(@PATH,13,1870.846,1033.0781,16.061255,NULL,0,0,0,100,0),
(@PATH,14,1874.0918,1021.8268,15.74021,NULL,0,0,0,100,0),
(@PATH,15,1883.819,1012.6995,15.276465,NULL,0,0,0,100,0),
(@PATH,16,1893.5095,1004.2003,15.3686285,NULL,0,0,0,100,0),
(@PATH,17,1883.819,1012.6995,15.276465,NULL,0,0,0,100,0),
(@PATH,18,1874.0918,1021.8268,15.74021,NULL,0,0,0,100,0),
(@PATH,19,1870.846,1033.0781,16.061255,NULL,0,0,0,100,0),
(@PATH,20,1869.4846,1041.5859,17.003654,NULL,0,0,0,100,0),
(@PATH,21,1868.7181,1047.942,16.896965,NULL,0,0,0,100,0),
(@PATH,22,1867.3689,1054.9958,16.089104,NULL,0,0,0,100,0),
(@PATH,23,1855.1255,1067.6527,15.293363,NULL,0,0,0,100,0),
(@PATH,24,1846.6216,1071.2936,14.550565,NULL,0,0,0,100,0),
(@PATH,25,1834.332,1075.5342,12.168363,NULL,0,0,0,100,0),
(@PATH,26,1822.5966,1073.9354,11.184986,NULL,0,0,0,100,0),
(@PATH,27,1801.3014,1067.0065,8.882008,NULL,0,0,0,100,0),
(@PATH,28,1797.145,1063.4182,8.314228,NULL,0,0,0,100,0),
(@PATH,29,1788.0264,1061.6875,7.9343457,NULL,0,0,0,100,0),
(@PATH,30,1775.3702,1064.1283,7.084126,NULL,0,0,0,100,0);
-- 0x204214460013E20000618C0000233C56 .go xyz 1763.9722 1068.7299 6.8648014

-- Pathing for Hillsbrad Citizen Entry: 20429
SET @NPC := 83630;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2081.0735,`position_y`=1025.8383,`position_z`=32.678593, `VerifiedBuild`=47187 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=2081.0735,`position_y`=1025.8383,`position_z`=32.678593, `VerifiedBuild`=47187 WHERE `guid`=83629; -- Follower
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2081.0735,1025.8383,32.678593,NULL,0,0,0,100,0),
(@PATH,2,2056.4624,1025.1849,30.632473,NULL,0,0,0,100,0),
(@PATH,3,2044.2196,1031.1438,28.663357,NULL,0,0,0,100,0),
(@PATH,4,2026.1462,1037.1044,26.978773,NULL,0,0,0,100,0),
(@PATH,5,2010.0215,1040.3195,25.967909,NULL,0,0,0,100,0),
(@PATH,6,1994.2255,1036.183,25.362244,NULL,0,0,0,100,0),
(@PATH,7,1979.8258,1027.1599,25.370071,NULL,0,0,0,100,0),
(@PATH,8,1963.395,1034.25,23.579353,NULL,0,0,0,100,0),
(@PATH,9,1952.4573,1044.3964,21.332039,NULL,0,0,0,100,0),
(@PATH,10,1938.5619,1049.6716,20.457039,NULL,0,0,0,100,0),
(@PATH,11,1924.3231,1050.8837,19.46478,NULL,0,0,0,100,0),
(@PATH,12,1912.0037,1051.5455,18.71478,NULL,0,0,0,100,0),
(@PATH,13,1896.2391,1053.4166,17.920403,NULL,0,0,0,100,0),
(@PATH,14,1875.6606,1059.7526,17.312126,NULL,0,0,0,100,0),
(@PATH,15,1865.9052,1064.7709,16.056942,NULL,0,0,0,100,0),
(@PATH,16,1855.7153,1072.5393,15.291654,NULL,0,0,0,100,0),
(@PATH,17,1845.4694,1076.6066,13.6820345,NULL,0,0,0,100,0),
(@PATH,18,1832.8164,1076.9388,11.935474,NULL,0,0,0,100,0),
(@PATH,19,1821.2422,1073.1364,11.184986,NULL,0,0,0,100,0),
(@PATH,20,1808.5608,1066.7808,9.476002,NULL,0,0,0,100,0),
(@PATH,21,1808.242,1063.9847,9.294804,NULL,0,0,0,100,0),
(@PATH,22,1816.0052,1055.1232,11.174076,NULL,0,0,0,100,0),
(@PATH,23,1808.242,1063.9847,9.294804,NULL,0,0,0,100,0),
(@PATH,24,1808.5608,1066.7808,9.476002,NULL,0,0,0,100,0),
(@PATH,25,1821.2422,1073.1364,11.184986,NULL,0,0,0,100,0),
(@PATH,26,1832.8164,1076.9388,11.935474,NULL,0,0,0,100,0),
(@PATH,27,1845.4694,1076.6066,13.6820345,NULL,0,0,0,100,0),
(@PATH,28,1855.7153,1072.5393,15.291654,NULL,0,0,0,100,0),
(@PATH,29,1865.9052,1064.7709,16.056942,NULL,0,0,0,100,0),
(@PATH,30,1875.6606,1059.7526,17.312126,NULL,0,0,0,100,0),
(@PATH,31,1896.2391,1053.4166,17.920403,NULL,0,0,0,100,0),
(@PATH,32,1912.0037,1051.5455,18.71478,NULL,0,0,0,100,0),
(@PATH,33,1924.3231,1050.8837,19.46478,NULL,0,0,0,100,0),
(@PATH,34,1938.5619,1049.6716,20.457039,NULL,0,0,0,100,0),
(@PATH,35,1952.4573,1044.3964,21.332039,NULL,0,0,0,100,0),
(@PATH,36,1963.395,1034.25,23.579353,NULL,0,0,0,100,0),
(@PATH,37,1979.8258,1027.1599,25.370071,NULL,0,0,0,100,0),
(@PATH,38,1994.2255,1036.183,25.362244,NULL,0,0,0,100,0),
(@PATH,39,2010.0215,1040.3195,25.967909,NULL,0,0,0,100,0),
(@PATH,40,2026.1462,1037.1044,26.978773,NULL,0,0,0,100,0),
(@PATH,41,2044.1816,1031.1484,28.66946,NULL,0,0,0,100,0),
(@PATH,42,2056.4624,1025.1849,30.632473,NULL,0,0,0,100,0);
-- 0x204214460013F34000618C0001A33C56 .go xyz 2081.0735 1025.8383 32.678593

DELETE FROM `creature_formations` WHERE `memberGUID` IN (83629, 83630) AND `leaderGUID`=83630;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(83630, 83630, 0, 0, 0, 0, 0),
(83630, 83629, 2.5, 270, 512, 0, 0);

-- Stalvan Mistmantle
UPDATE `creature` SET `position_x`=1805.0438232421875,`position_y`=1042.4078369140625,`position_z`=19.50431442260742187, `orientation`=4.642575740814208984, `VerifiedBuild`=47187 WHERE `guid`=83697 AND `id1`=20355;
DELETE FROM `creature_template_addon` WHERE (`entry` = 20355);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20355, 0, 0, 3, 0, 0, 0, '14915');

-- Taelan
UPDATE `creature` SET `wander_distance`=7.5,`MovementType`=1, `VerifiedBuild`=47187 WHERE `guid`=83698 AND `id1`=20361;

-- Kirin Tor Mages in Tavern
SET @CGUID := 83699;
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (20370, 20422) AND `guid` BETWEEN @CGUID+0 AND @CGUID+4;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 20370, 560, 2367, 0, 3, 1, 0, 1819.1646728515625, 1022.37481689453125, 18.62931442260742187, 1.588249564170837402, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187),
(@CGUID+1, 20422, 560, 2367, 0, 3, 1, 0, 1822.1744384765625, 1027.6458740234375, 18.62931442260742187, 1.396263360977172851, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20422 (Area: 0 - Difficulty: 1)
(@CGUID+2, 20422, 560, 2367, 0, 3, 1, 0, 1822.0025634765625, 1023.0665283203125, 18.62931442260742187, 6.213372230529785156, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20422 (Area: 0 - Difficulty: 1)
(@CGUID+3, 20422, 560, 2367, 0, 3, 1, 0, 1813.5748291015625, 1025.072998046875, 18.62931442260742187, 3.455751895904541015, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187), -- 20422 (Area: 0 - Difficulty: 1)
(@CGUID+4, 20422, 560, 2367, 0, 3, 1, 0, 1814.6688232421875, 1019.33587646484375, 18.62931632995605468, 3.333578824996948242, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187); -- 20422 (Area: 0 - Difficulty: 1)

DELETE FROM `creature_template_addon` WHERE (`entry` = 20422);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20422, 0, 0, 0, 0, 133, 0, '');

-- Zixil
UPDATE `creature` SET `position_x`=1759.1192626953125,`position_y`=1052.12646484375,`position_z`=6.962950706481933593, `orientation`=3.700098037719726562, `VerifiedBuild`=47187 WHERE `guid`=83677 AND `id1`=20419;
UPDATE `creature` SET `position_x`=1757.213623046875,`position_y`=1053.4556884765625,`position_z`=6.96295166015625, `orientation`=1.553343057632446289, `VerifiedBuild`=47187 WHERE `guid`=83676 AND `id1`=20420;

DELETE FROM `creature_template_addon` WHERE (`entry` IN (20419, 20420));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20419, 0, 0, 0, 0, 233, 0, ''),
(20420, 0, 0, 7, 0, 65 , 0, '');

DELETE FROM `creature_text` WHERE `CreatureID`=20419;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20419, 0, 0, 18132, 'When I get this hunk of junk up and running, I\'ll be able to walk the roads without fear of being jumped by bandits!', 12, 0, 100, 0, 0, 0, 0, 'Zixil'),
(20419, 0, 1, 18133, 'Just a few more swings and it\'ll be ready...', 12, 0, 100, 0, 0, 0, 0, 'Zixil'),
(20419, 0, 2, 18134, 'Maybe I can sell these things to other goblins? I\'ll be rich! Rich I say!', 12, 0, 100, 0, 0, 0, 0, 'Zixil'),
(20419, 0, 3, 18135, 'Yes, Zixil will be a household name! I\'ll corner the market!', 12, 0, 100, 0, 0, 0, 0, 'Zixil');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20419;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20419);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20419, 0, 0, 0, 60, 0, 100, 0, 40000, 60000, 40000, 60000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zixil - On Update - Say Line 0');

-- Magistrate Henry Maleb
SET @NPC := 83720;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1815.9948,`position_y`=1128.528,`position_z`=14.708552, `VerifiedBuild`=47187 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,1815.9948,1128.528,14.708552,NULL,0,0,0,100,0),
(@PATH,2,1815.9757,1121.9319,14.708552,NULL,0,0,0,100,0);

-- Barkeep Kelly Position
UPDATE `creature` SET `position_x`=1816.5262451171875,`position_y`=1016.9359130859375,`position_z`=11.77144527435302734, `orientation`=1.640609502792358398, `VerifiedBuild`=47187 WHERE `guid`=83693 AND `id1`=20377;

-- Farmer Kent and Hillsbrad Farmers
SET @CGUID := 83646;
-- Delete extra spawns as well
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (20368, 20433) AND `guid` BETWEEN @CGUID+0 AND @CGUID+10;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 20368, 560, 2367, 0, 3, 1, 0, 1852.9478759765625, 962.044921875, 12.03122329711914062, 1.954768776893615722, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20368 (Area: 0 - Difficulty: 1)
(@CGUID+1, 20433, 560, 2367, 0, 3, 1, 1, 1889.12548828125, 943.19989013671875, 11.92574310302734375, 0.575958669185638427, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20433 (Area: 0 - Difficulty: 1)
(@CGUID+2, 20433, 560, 2367, 0, 3, 1, 1, 1886.6531982421875, 949.830078125, 11.92574405670166015, 1.047197580337524414, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20433 (Area: 0 - Difficulty: 1)
(@CGUID+3, 20433, 560, 2367, 0, 3, 1, 1, 1880.808349609375, 934.74957275390625, 11.95547676086425781, 3.892084121704101562, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20433 (Area: 0 - Difficulty: 1)
(@CGUID+4, 20433, 560, 2367, 0, 3, 1, 1, 1874.0767822265625, 941.53289794921875, 11.92574310302734375, 4.049163818359375, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20433 (Area: 0 - Difficulty: 1)
(@CGUID+5, 20433, 560, 2367, 0, 3, 1, 1, 1861.648681640625, 949.70196533203125, 11.92574405670166015, 0.680678427219390869, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20433 (Area: 0 - Difficulty: 1)
(@CGUID+6, 20433, 560, 2367, 0, 3, 1, 1, 1861.728271484375, 937.4669189453125, 11.92574310302734375, 3.944444179534912109, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187), -- 20433 (Area: 0 - Difficulty: 1)
(@CGUID+7, 20433, 560, 2367, 0, 3, 1, 1, 1847.504150390625, 934.8524169921875, 11.92574310302734375, 0.680678427219390869, 7200, 0, 0, 2035, 0, 0, 0, 0, 0, 47187); -- 20433 (Area: 0 - Difficulty: 1)

DELETE FROM `creature_template_addon` WHERE (`entry` = 20433);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20433, 0, 0, 0, 1, 173, 0, '');

-- Bartolo Ginsetti (12y)
UPDATE `creature` SET `position_x`=1875.5154,`position_y`=1087.656,`position_z`=17.860697, `orientation`=4.136430263519287109, `VerifiedBuild`=47187 WHERE `guid`=83723 AND `id1`=20365;

DELETE FROM `creature_text` WHERE `CreatureID`=20365;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20365, 0, 0, 18137, 'You there! Yes, you, peasant $g boy:girl;. Come quickly, I must tell you something... I must tell you about my greatness, lest such things are lost in the void!', 12, 0, 100, 25, 0, 0, 0, 'Bartolo Ginsetti'),
(20365, 1, 0, 18138, 'Ooooh, YAH! Gaze upon my rippling musculature. Bask in the glow of my physique.', 12, 0, 100, 23, 0, 0, 0, 'Bartolo Ginsetti');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20365;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20365);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20365, 0, 0, 1, 10, 0, 100, 0, 0, 12, 60000, 60000, 1, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartolo Ginsetti - Within 0-12 Range Out of Combat LoS - Set Orientation Invoker'),
(20365, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartolo Ginsetti - Within 0-12 Range Out of Combat LoS - Say Line 0'),
(20365, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 6000, 6000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartolo Ginsetti - Within 0-12 Range Out of Combat LoS - Create Timed Event'),
(20365, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartolo Ginsetti - On Timed Event 1 Triggered - Say Line 1');

UPDATE `creature_template` SET `gossip_menu_id` = 8114, `npcflag` = 1 WHERE (`entry` = 20365);
DELETE FROM `gossip_menu` WHERE (`MenuID` = 8114) AND (`TextID` IN (10047)); -- This Gossip was missing but TextID existed
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8114, 10047);

-- Missing Objects (Tome of Scrying, Keg, Locked Chest)
SET @OGUID := 15064;
DELETE FROM `gameobject` WHERE `map`=560 AND `id` IN (184304, 184332, 180570) AND `guid` BETWEEN @OGUID+0 AND @OGUID+2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+0, 184332, 560, 2367, 2367, 3, 1, 1819.0352783203125, 1023.3704833984375, 19.712646484375, 4.729844093322753906, 0, 0, -0.70090866088867187, 0.713251054286956787, 7200, 255, 1, 47213),
(@OGUID+1, 180570, 560, 2367, 2367, 3, 1, 1808.4539794921875, 1022.86962890625, 13.71208763122558593, 1.518436193466186523, 0, 0, 0.6883544921875, 0.725374460220336914, 7200, 255, 1, 47213),
(@OGUID+2, 184304, 560, 2367, 2367, 3, 1, 1720.5572509765625, 1017.81988525390625, 0.405580013990402221, 5.881760597229003906, 0, 0, -0.19936752319335937, 0.979924798011779785, 7200, 255, 1, 47213);

-- Natasha Morris
UPDATE `creature` SET `wander_distance`=6,`MovementType`=1, `VerifiedBuild`=47187 WHERE `guid`=83724 AND `id1`=20441;

-- Scarlet Children
SET @CGUID := 84064;
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (20357, 20358, 20359, 20396) AND `guid` BETWEEN @CGUID+0 AND @CGUID+2;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 20357, 560, 2367, 0, 3, 1, 0, 1766.623, 1073.1769, 6.8648014, 6.204990863800048828, 7200, 0, 0, 0, 0, 2, 0, 0, 0, 47187),
(@CGUID+1, 20358, 560, 2367, 0, 3, 1, 0, 1766.623, 1073.1769, 6.8648014, 0.427894920110702514, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187),
(@CGUID+2, 20359, 560, 2367, 0, 3, 1, 0, 1766.623, 1073.1769, 6.8648014, 6.183419704437255859, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 47187);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (@CGUID+0, @CGUID+1, @CGUID+2) AND `leaderGUID`=@CGUID+0;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+0, @CGUID+0, 0, 0, 0, 0, 0),
(@CGUID+0, @CGUID+1, 2.5, 90, 512, 0, 0),
(@CGUID+0, @CGUID+2, 2.5, 180, 512, 0, 0);

DELETE FROM `creature_addon` WHERE (`guid` = @CGUID+0);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
((@CGUID+0), (@CGUID+0)*10, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=(@CGUID+0)*10;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`move_type`) VALUES
((@CGUID+0)*10,1,1766.623,1073.1769,6.8648014,NULL,1),
((@CGUID+0)*10,2,1763.7609,1059.1699,6.872983,NULL,1),
((@CGUID+0)*10,3,1764.3131,1031.9971,6.872983,NULL,1),
((@CGUID+0)*10,4,1769.7189,1015.6437,6.427197,NULL,1),
((@CGUID+0)*10,5,1781.427,1015.7469,9.314404,NULL,1),
((@CGUID+0)*10,6,1784.0868,1026.5377,10.612499,NULL,1),
((@CGUID+0)*10,7,1786.029,1045.1888,9.896137,NULL,1),
((@CGUID+0)*10,8,1787.9987,1059.0806,7.6214795,NULL,1),
((@CGUID+0)*10,9,1815.3898,1060.277,10.641117,NULL,1),
((@CGUID+0)*10,10,1829.5338,1058.778,13.859013,NULL,1),
((@CGUID+0)*10,11,1836.428,1047.2233,14.894588,NULL,1),
((@CGUID+0)*10,12,1838.2704,1026.9523,15.142665,NULL,1),
((@CGUID+0)*10,13,1838.9581,1017.5668,15.270595,NULL,1),
((@CGUID+0)*10,14,1842.7277,1008.9644,14.742396,NULL,1),
((@CGUID+0)*10,15,1849.1177,1000.2745,15.083217,NULL,1),
((@CGUID+0)*10,16,1863.4473,1006.9286,16.00668,NULL,1),
((@CGUID+0)*10,17,1866.1174,1015.569,15.556972,NULL,1),
((@CGUID+0)*10,18,1868.3208,1027.3716,15.498511,NULL,1),
((@CGUID+0)*10,19,1869.6267,1037.2123,16.729485,NULL,1),
((@CGUID+0)*10,20,1865.5181,1049.5011,15.335751,NULL,1),
((@CGUID+0)*10,21,1867.5786,1060.357,16.225822,NULL,1),
((@CGUID+0)*10,22,1878.767,1060.9973,17.684929,NULL,1),
((@CGUID+0)*10,23,1897.9668,1053.58,17.920403,NULL,1),
((@CGUID+0)*10,24,1905.4509,1045.5461,18.431456,NULL,1),
((@CGUID+0)*10,25,1904.2731,1028.3635,19.276466,NULL,1),
((@CGUID+0)*10,26,1904.4609,1016.3633,18.276466,NULL,1),
((@CGUID+0)*10,27,1909.918,993.6586,15.845679,NULL,1),
((@CGUID+0)*10,28,1918.1559,980.7051,17.270973,NULL,1),
((@CGUID+0)*10,29,1927.6208,969.2012,17.91233,NULL,1),
((@CGUID+0)*10,30,1935.2817,973.1046,19.765339,NULL,1),
((@CGUID+0)*10,31,1947.6158,971.5432,21.53548,NULL,1),
((@CGUID+0)*10,32,1958.584,970.6836,22.758991,NULL,1),
((@CGUID+0)*10,33,1968.3883,971.84503,23.962679,NULL,1),
((@CGUID+0)*10,34,1976.2941,978.701,25.267122,NULL,1),
((@CGUID+0)*10,35,1971.8309,999.0618,28.299349,NULL,1),
((@CGUID+0)*10,36,1968.9197,1011.7449,27.550247,NULL,1),
((@CGUID+0)*10,37,1960.7737,1023.3538,25.96747,NULL,1),
((@CGUID+0)*10,38,1950.8038,1033.8225,23.942024,NULL,1),
((@CGUID+0)*10,39,1934.9801,1042.5717,22.137825,NULL,1),
((@CGUID+0)*10,40,1918.8728,1048.3973,19.421812,NULL,1),
((@CGUID+0)*10,41,1909.8624,1053.3057,18.460752,NULL,1),
((@CGUID+0)*10,42,1909.7411,1063.2158,19.511656,NULL,1),
((@CGUID+0)*10,43,1907.1688,1071.0006,21.172655,NULL,1),
((@CGUID+0)*10,44,1911.3334,1086.1061,21.112108,NULL,1),
((@CGUID+0)*10,45,1913.2205,1107.5017,20.97138,NULL,1),
((@CGUID+0)*10,46,1903.625,1124.6158,18.734564,NULL,1),
((@CGUID+0)*10,47,1893.4742,1135.568,18.443138,NULL,1),
((@CGUID+0)*10,48,1874.9469,1136.4017,17.251,NULL,1),
((@CGUID+0)*10,49,1864.8711,1128.6273,15.882499,NULL,1),
((@CGUID+0)*10,50,1863.2114,1102.2101,17.787773,NULL,1),
((@CGUID+0)*10,51,1857.6895,1086.4677,17.20242,NULL,1),
((@CGUID+0)*10,52,1862.7196,1068.6813,15.936551,NULL,1),
((@CGUID+0)*10,53,1842.51,1056.6361,14.976986,NULL,1),
((@CGUID+0)*10,54,1824.3262,1064.956,12.36829,NULL,1),
((@CGUID+0)*10,55,1828.1018,1088.4716,13.716602,NULL,1),
((@CGUID+0)*10,56,1831.9336,1125.584,13.931124,NULL,1),
((@CGUID+0)*10,57,1831.3356,1143.8278,11.518111,NULL,1),
((@CGUID+0)*10,58,1793.192,1150.9938,10.930223,NULL,1),
((@CGUID+0)*10,59,1766.386,1139.3741,11.0818,NULL,1),
((@CGUID+0)*10,60,1768.2086,1114.6821,11.178861,NULL,1),
((@CGUID+0)*10,61,1779.9342,1096.4996,12.219379,NULL,1),
((@CGUID+0)*10,62,1780.1993,1076.44,10.655781,NULL,1);

-- Pentagram Children
SET @CGUID := 83668;
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (21341, 21342, 21343, 21344, 21345) AND `guid` BETWEEN @CGUID+0 AND @CGUID+4;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 21341, 560, 2367, 0, 3, 1, 0, 1820.913818359375, 951.32354736328125, 16.56865119934082031, 1.186823844909667968, 7200, 0, 0, 2035, 852, 0, 0, 0, 0, 47187),
(@CGUID+1, 21343, 560, 2367, 0, 3, 1, 0, 1819.0341796875, 955.4219970703125, 16.11471748352050781, 5.672319889068603515, 7200, 0, 0, 2035, 852, 0, 0, 0, 0, 47187),
(@CGUID+2, 21342, 560, 2367, 0, 3, 1, 0, 1824.5418701171875, 952.72003173828125, 16.35272789001464843, 2.792526721954345703, 7200, 0, 0, 2035, 852, 0, 0, 0, 0, 47187),
(@CGUID+3, 21345, 560, 2367, 0, 3, 1, 0, 1824.8150634765625, 955.70928955078125, 16.31266593933105468, 3.769911050796508789, 7200, 0, 0, 2035, 852, 0, 0, 0, 0, 47187),
(@CGUID+4, 21344, 560, 2367, 0, 3, 1, 0, 1821.304931640625, 957.28057861328125, 16.2471160888671875, 4.852015495300292968, 7200, 0, 0, 2035, 852, 0, 0, 0, 0, 47187);

-- Tower Dialogue (2:20)
UPDATE `creature` SET `position_x`=2335.805908203125,`position_y`=926.97698974609375,`position_z`=54.91743087768554687, `orientation`=4.625122547149658203, `VerifiedBuild`=47187 WHERE `guid`=83459 AND `id1`=20372;
UPDATE `creature` SET `position_x`=2334.0234375,`position_y`=926.92645263671875,`position_z`=54.95403289794921875, `orientation`=4.834561824798583984, `VerifiedBuild`=47187 WHERE `guid`=83458 AND `id1`=20376;

DELETE FROM `creature_text` WHERE `CreatureID` IN (20372, 20376);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20376, 0, 0, 18160, 'Look at it, Jon. It\'s glorious!', 12, 0, 100, 5, 0, 0, 0, 'Jerry Carter'),
(20372, 0, 0, 18161, 'Indeed. What better way to symbolize the bond of friendship and brotherhood between Tarren Mill and Southshore by erecting this tower at the halfway point between both towns. Brilliant!', 12, 0, 100, 1, 0, 0, 0, 'Jonathan Revah');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20376;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20376);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20376, 0, 0, 1, 60, 0, 100, 0, 140000, 140000, 140000, 140000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jerry Carter - On Update - Say Line 0'),
(20376, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 3600, 3600, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jerry Carter - On Update - Create Timed Event'),
(20376, 0, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 83459, 20372, 0, 0, 0, 0, 0, 0, 'Jerry Carter - On Timed Event 1 Triggered - Set Data 1 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20372;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20372);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20372, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jonathan Revah - On Data Set 1 1 - Say Line 0');
