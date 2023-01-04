-- Pathing for Frances Lin Entry: 20401
SET @NPC := 20401;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=1820.7647705078125,`position_y`=1016.41839599609375,`position_z`=11.68548202514648437, `orientation`=1.570796370506286621 WHERE `id1`=@NPC;
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
UPDATE `creature` SET `position_x`=1816.1407,`position_y`=1006.5959,`position_z`=11.672032, `orientation`=0.03490658476948738 WHERE `guid`=83695 AND `id1`=20378;

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
(2037800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Set Event Phase 2'),
(2037800, 9, 1, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Say Line 0'),
(2037800, 9, 2, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 53, 0, 2037800, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Start Waypoint'),
(2037801, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Say Line 1'),
(2037801, 9, 1, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 20345, 10, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Set Orientation Closest Creature \'Commander Mograine\''),
(2037801, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 19, 20345, 10, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Say Line 2'),
(2037801, 9, 3, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.5707963705062866, 'Chef Jessen - In Combat - Set Orientation 1.5707963705062866'),
(2037801, 9, 4, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Say Line 3'),
(2037801, 9, 5, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Say Line 4'),
(2037801, 9, 6, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Play Emote 14'),
(2037801, 9, 7, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 53, 0, 2037801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chef Jessen - In Combat - Start Waypoint');

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

-- Pathing for Herod the Bully Entry: 20360
SET @NPC := (SELECT `guid` FROM `creature` WHERE `id1`=20360);
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=1763.9722,`position_y`=1068.7299,`position_z`=6.8648014 WHERE `guid`=@NPC;
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
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2081.0735,`position_y`=1025.8383,`position_z`=32.678593 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=2081.0735,`position_y`=1025.8383,`position_z`=32.678593 WHERE `guid`=83629; -- Follower
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
UPDATE `creature` SET `position_x`=1805.0438232421875,`position_y`=1042.4078369140625,`position_z`=19.50431442260742187, `orientation`=4.642575740814208984 WHERE `guid`=83697 AND `id1`=20355;
DELETE FROM `creature_template_addon` WHERE (`entry` = 20355);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20355, 0, 0, 3, 0, 0, 0, '14915');

-- Taelan
UPDATE `creature` SET `wander_distance`=7.5,`MovementType`=1 WHERE `guid`=83698 AND `id1`=20361;

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

