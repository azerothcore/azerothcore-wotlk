-- DB update 2023_12_03_05 -> 2023_12_03_06
-- D16 Horde remove SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30477);
-- D16 Horde remove Timed Actionlists
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3047700) AND (`source_type` = 9);
-- D16 Aliance remove SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30487);
-- D16 Aliance remove Timed Actionlists
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3048700) AND (`source_type` = 9);
-- Update D16 creature ScriptName
UPDATE `creature_template` SET `AIName`="", `ScriptName` = 'npc_vehicle_d16_propelled_delivery' WHERE `entry` IN (30477, 30487);
-- Plane Aliance k3
SET @PATH := 30477 * 100;
DELETE FROM `waypoint_data` WHERE `id` IN (30477*100, 30487*100);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(@PATH, 1, 6165, -1064.51, 422.119, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, 6204.1, -998.487, 457.563, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, 6289.57, -952.181, 504.619, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, 6307.79, -872.8, 541.73, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, 6370.58, -821.951, 653.868, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, 6413.27, -660.471, 808.395, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, 6554.81, -550.377, 1018.11, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, 6633.27, -419.316, 1173.91, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, 6760.5, -364.466, 1277.72, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, 6807.88, -427.519, 1399.11, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, 6808.07, -471.447, 1419.25, NULL, 0, 0, 0, 100, 0),
(@PATH, 12, 6775.63, -529.231, 1394.39, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, 6720.65, -535.553, 1328.05, NULL, 0, 0, 0, 100, 0),
(@PATH, 14, 6660.31, -486.865, 1238.55, NULL, 0, 0, 0, 100, 0),
(@PATH, 15, 6658.94, -417.841, 1186.11, NULL, 0, 0, 0, 100, 0),
(@PATH, 16, 6680.49, -329.309, 1098.61, NULL, 0, 0, 0, 100, 0),
(@PATH, 17, 6683.78, -220.345, 972.72, NULL, 0, 0, 0, 100, 0),
(@PATH, 18, 6663.77, -192.126, 962.248, NULL, 0, 0, 0, 100, 0),
(@PATH, 19, 6654.82, -180.169, 958.132, NULL, 0, 0, 0, 100, 0),
(@PATH, 20, 6631.47, -171.331, 966.463, NULL, 0, 0, 0, 100, 0),
(@PATH, 21, 6598.22, -162.366, 984.223, NULL, 0, 0, 0, 100, 0),
(@PATH, 22, 6566.67, -155.208, 992.055, NULL, 0, 0, 0, 100, 0),
(@PATH, 23, 6529.65, -154.936, 992.055, NULL, 0, 0, 0, 100, 0),
(@PATH, 24, 6454.42, -152.131, 962.305, NULL, 0, 0, 0, 100, 0);
-- Plane Horde k3

SET @PATH := 30487 * 100;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(@PATH, 1, 6169.23, -1069.62, 420.694, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, 6232.73, -1031.6, 505.778, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, 6339.22, -1035.08, 575.333, NULL, 0, 0, 0, 100, 0),
(@PATH, 4, 6431.49, -987.674, 694.889, NULL, 0, 0, 0, 100, 0),
(@PATH, 5, 6632.44, -925.974, 896.138, NULL, 0, 0, 0, 100, 0),
(@PATH, 6, 6822.08, -755.521, 1171.19, NULL, 0, 0, 0, 100, 0),
(@PATH, 7, 7090.69, -619.487, 1455.64, NULL, 0, 0, 0, 100, 0),
(@PATH, 8, 7260.75, -282.75, 1513.36, NULL, 0, 0, 0, 100, 0),
(@PATH, 9, 7552.5, -334.651, 1657.67, NULL, 0, 0, 0, 100, 0),
(@PATH, 10, 7692.3, -509.425, 1536.5, NULL, 0, 0, 0, 100, 0),
(@PATH, 11, 7799.19, -636.327, 1252.28, NULL, 0, 0, 0, 100, 0),
(@PATH, 12, 7841.56, -726.55, 1193.92, NULL, 0, 0, 0, 100, 0),
(@PATH, 13, 7844.73, -775.361, 1185.83, NULL, 0, 0, 0, 100, 0),
(@PATH, 14, 7842.45, -815.573, 1186.4, NULL, 0, 0, 0, 100, 0),
(@PATH, 15, 7838.7, -859.957, 1173.17, NULL, 0, 0, 0, 100, 0),
(@PATH, 16, 7865.01, -911.218, 1163.98, NULL, 0, 0, 0, 100, 0),
(@PATH, 17, 7856.23, -951.657, 1151.56, NULL, 0, 0, 0, 100, 0);
-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9917;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,9917,0,0,28,12862,0,0,0,'','Ricket - Show gossip option only if player has completed but not rewarded quest When All Else Fails'),
(15,9917,1,0,28,13060,0,0,0,'','Ricket - Show gossip option only if player has completed but not rewarded quest When All Else Fails');
