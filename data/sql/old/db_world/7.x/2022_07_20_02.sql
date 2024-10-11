-- DB update 2022_07_20_01 -> 2022_07_20_02
-- Rocklance
SET @NPC := 20720;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `position_x`=-1199.35, `position_y`=-3100.46, `position_z`=94.7484, `orientation`=2.7918, `MovementType`='2' WHERE  `guid`=@NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES 
(@PATH, 1, -1201.63, -3099.24, 94.8781),
(@PATH, 2, -1219.21, -3099.76, 95.241),
(@PATH, 3, -1272.76, -3089.53, 93.8928),
(@PATH, 4, -1315.08, -3106.5, 91.7995),
(@PATH, 5, -1330.48, -3095.55, 92.4438),
(@PATH, 6, -1341.49, -3060.61, 92.6899),
(@PATH, 7, -1354.4, -3030.3, 93.3309),
(@PATH, 8, -1386.31, -3005.86, 93.1475),
(@PATH, 9, -1430.19, -2974.08, 93.1218),
(@PATH, 10, -1436.49, -2943.46, 91.668),
(@PATH, 11, -1436.75, -2920.35, 92.5429),
(@PATH, 12, -1410.03, -2893.52, 93.1282),
(@PATH, 13, -1388.5, -2866.72, 94.5754),
(@PATH, 14, -1360.27, -2850.79, 94.705),
(@PATH, 15, -1332.8, -2857.77, 93.5965),
(@PATH, 16, -1288.33, -2870.37, 93.0108),
(@PATH, 17, -1265.32, -2850.79, 94.069),
(@PATH, 18, -1239.87, -2834.24, 94.41),
(@PATH, 19, -1219.09, -2834.03, 93.9937),
(@PATH, 20, -1194.71, -2865.09, 93.5771),
(@PATH, 21, -1170.2, -2886.21, 94.3522),
(@PATH, 22, -1146.43, -2925.68, 93.1956),
(@PATH, 23, -1123.57, -2957.35, 92.8819),
(@PATH, 24, -1114.24, -2966.51, 92.4826),
(@PATH, 25, -1111.46, -3018.12, 94.8292),
(@PATH, 26, -1101.72, -3047.27, 93.4784),
(@PATH, 27, -1123.65, -3070.33, 91.8408),
(@PATH, 28, -1147.38, -3076.85, 92.3126),
(@PATH, 29, -1177.95, -3082.89, 92.8266);

DELETE FROM `creature_formations` WHERE `leaderGUID` = @NPC;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES (@NPC, @NPC, 0, 0, 512);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES (@NPC, 20588, 3, 215, 512);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES (@NPC, 14007, 3, 135, 512);

UPDATE `creature` SET `spawntimesecs`=25000 WHERE  `guid`=14007;
UPDATE `creature` SET `spawntimesecs`=25000 WHERE  `guid`=20588;
UPDATE `creature` SET `spawntimesecs`=19800 WHERE  `guid`=@NPC;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5841;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5841) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5841, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 70, 500, 0, 0, 0, 0, 0, 10, 14007, 0, 0, 0, 0, 0, 0, 0, 'Rocklance - On Respawn - Respawn Formation Member 14007'),
(5841, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 70, 500, 0, 0, 0, 0, 0, 10, 20588, 0, 0, 0, 0, 0, 0, 0, 'Rocklance - On Respawn - Respawn Formation Member 20588');
