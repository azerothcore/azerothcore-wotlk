-- DB update 2023_05_10_04 -> 2023_05_10_05
--
SET @NPC := 76415;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3749.31,`position_y`=1033.3,`position_z`=89.7322 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3749.31,`position_y`=1033.3,`position_z`=89.7322 WHERE `guid` IN (70887, 70888) AND `id1` = 19801;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`) VALUES
(@PATH, 1, -3757.53, 1029.77, 90.9887),
(@PATH, 2, -3775.93, 1032.31, 94.4492),
(@PATH, 3, -3799.31, 1053.31, 93.5239),
(@PATH, 4, -3773.25, 1031.12, 94.2648),
(@PATH, 5, -3755.86, 1031.77, 90.2802),
(@PATH, 6, -3740.91, 1039.71, 88.719),
(@PATH, 7, -3733.53, 1049.68, 87.3525),
(@PATH, 8, -3733.34, 1054.4, 86.5162),
(@PATH, 9, -3733.61, 1069.99, 87.8559),
(@PATH, 10, -3733.91, 1091.72, 85.9495),
(@PATH, 11, -3741.86, 1107.72, 84.366),
(@PATH, 12, -3744.4, 1111.01, 81.5303),
(@PATH, 13, -3752.36, 1119.98, 78.0073),
(@PATH, 14, -3759.7, 1124.51, 78.7782),
(@PATH, 15, -3770.4, 1127.24, 81.069),
(@PATH, 16, -3779.04, 1124.86, 83.6984),
(@PATH, 17, -3784.03, 1121.51, 84.4721),
(@PATH, 18, -3802.33, 1102.43, 84.2911),
(@PATH, 19, -3778.69, 1126.16, 83.4765),
(@PATH, 20, -3761.36, 1125.7, 79.0511),
(@PATH, 21, -3751.51, 1120.88, 77.9496),
(@PATH, 22, -3744.7, 1112.58, 81.0952),
(@PATH, 23, -3741.91, 1107.71, 84.3617),
(@PATH, 24, -3738.71, 1101.87, 85.9315),
(@PATH, 25, -3733.65, 1083.04, 86.6572),
(@PATH, 26, -3733.3, 1069.77, 87.8538),
(@PATH, 27, -3733.15, 1054.19, 86.5299),
(@PATH, 28, -3737.15, 1042.46, 88.3021),
(@PATH, 29, -3748.86, 1033.82, 89.6873);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (76415, 70887, 70888);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(76415, 76415, 0, 0, 515),
(76415, 70887, 4, 135, 515),
(76415, 70888, 4, 225, 515);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21827);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21827, 0, 0, 0, 9, 0, 100, 0, 0, 30, 14300, 28200, 0, 11, 38051, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zandras - Within 0-30 Range - Cast \'Fel Shackles\'');
