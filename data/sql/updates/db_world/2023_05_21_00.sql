-- DB update 2023_05_20_02 -> 2023_05_21_00
/*
	Blood Guard Porung
*/
-- Add some leftover details to Porung
UPDATE `creature` SET `zoneId` = 3714, `areaId` = 3714 WHERE `guid` = 151283 AND `id1` = 20923;

-- SAI Override for Zealots
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|67108864 WHERE (`entry` IN (17462, 20595));

-- Delete deprecated summon_group
DELETE FROM `creature_summon_groups` WHERE `summonerID` = 20923;

SET @CGUID := 151283;

-- Add the pre-spawn Zealots
DELETE FROM `creature` WHERE `id1` = 17462 AND `guid` BETWEEN @CGUID+1 AND @CGUID+8;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`) VALUES
(@CGUID+1, 17462, 540, 3714, 3714, 3, 1, 500.66077, 335.08316, 2.1801622, 4.790035247802734375, 86400, 46924),
(@CGUID+2, 17462, 540, 3714, 3714, 3, 1, 502.3265, 339.933, 2.1924121, 4.682251453399658203, 86400, 46924),
(@CGUID+3, 17462, 540, 3714, 3714, 3, 1, 507.43033, 340.37152, 2.1807163, 4.49735260009765625, 86400, 46924),
(@CGUID+4, 17462, 540, 3714, 3714, 3, 1, 515.1152, 339.82166, 2.1918812, 4.189203739166259765, 86400, 46924),
(@CGUID+5, 17462, 540, 3714, 3714, 3, 1, 500.43695, 299.709, 2.0352724, 1.837408661842346191, 86400, 46924),
(@CGUID+6, 17462, 540, 3714, 3714, 3, 1, 500.4554, 295.4435, 2.0247803, 1.765462279319763183, 86400, 46924),
(@CGUID+7, 17462, 540, 3714, 3714, 3, 1, 505.0166, 294.01736, 2.0213714, 1.931191682815551757, 86400, 46924),
(@CGUID+8, 17462, 540, 3714, 3714, 3, 1, 510.66922, 292.43665, 2.0080533, 2.112969875335693359, 86400, 46924);

DELETE FROM `creature_addon` WHERE (`guid` IN (@CGUID+1,@CGUID+2,@CGUID+3,@CGUID+4,@CGUID+5,@CGUID+6,@CGUID+7,@CGUID+8));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+1, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+2, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+3, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+4, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+5, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+6, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+7, 0, 0, 0, 0, 0, 0, '18950'),
(@CGUID+8, 0, 0, 0, 0, 0, 0, '18950');

DELETE FROM `waypoints` WHERE `point_comment` LIKE 'Shattered Hand Zealot - %' AND `entry` BETWEEN 1746200 AND 1746208;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(1746200,1,518.51355,254.91473,1.935091,NULL,'Shattered Hand Zealot - Summon Gauntlet Guards'),
(1746200,2,522.1381,253.96086,1.9344256,NULL,'Shattered Hand Zealot - Summon Gauntlet Guards'),
(1746200,3,512.82446,286.9732,2.1900017,NULL,'Shattered Hand Zealot - Summon Gauntlet Guards'), -- Decomposed to not clip through the wall
(1746200,4,497.68735,316.3075,1.9454536,NULL,'Shattered Hand Zealot - Summon Gauntlet Guards'),
(1746200,5,485.92004,316.08777,1.9463365,NULL,'Shattered Hand Zealot - Summon Gauntlet Guards'),
(1746201,1,495.4776,316.98608,1.946535,NULL,'Shattered Hand Zealot - Add 1'),
(1746201,2,483.1907,317.86993,1.9473528,NULL,'Shattered Hand Zealot - Add 1'),
(1746201,3,455.10214,317.3777,1.9421942,NULL,'Shattered Hand Zealot - Add 1'),
(1746201,4,430.9916,316.97632,1.9160842,NULL,'Shattered Hand Zealot - Add 1'),
(1746201,5,400.69287,318.7411,1.8979802,NULL,'Shattered Hand Zealot - Add 1'),
(1746201,6,385.03403,321.49213,1.9389232,3.351032257080078125,'Shattered Hand Zealot - Add 1'),
(1746202,1,501.7538,320.9323,1.9434687,NULL,'Shattered Hand Zealot - Add 2'),
(1746202,2,476.05844,317.75107,1.9364125,NULL,'Shattered Hand Zealot - Add 2'),
(1746202,3,455.1762,318.79874,1.9421194,NULL,'Shattered Hand Zealot - Add 2'),
(1746202,4,429.9724,317.08362,1.9209572,NULL,'Shattered Hand Zealot - Add 2'),
(1746202,5,418.716,319.8783,1.9447119,3.351032257080078125,'Shattered Hand Zealot - Add 2'),
(1746203,1,503.322,321.56223,1.9413302,NULL,'Shattered Hand Zealot - Add 3'),
(1746203,2,492.0797,318.1158,1.9481977,NULL,'Shattered Hand Zealot - Add 3'),
(1746203,3,480.32916,318.5935,1.9409089,NULL,'Shattered Hand Zealot - Add 3'),
(1746203,4,454.69748,319.9294,1.942607,3.351032257080078125,'Shattered Hand Zealot - Add 3'),
(1746204,1,503.59293,319.84564,1.9425683,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,2,493.9259,316.13474,1.9472932,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,3,476.05844,317.75107,1.9364125,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,4,455.65674,317.68033,1.9416298,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,5,429.9724,317.08362,1.9209572,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,6,409.81305,318.26263,1.9170406,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,7,384.47876,318.11124,1.9394886,NULL,'Shattered Hand Zealot - Add 4'),
(1746204,8,359.87564,320.17487,1.9181617,3.351032257080078125,'Shattered Hand Zealot - Add 4'),
(1746205,1,497.69696,309.7413,1.9453896,NULL,'Shattered Hand Zealot - Add 5 - Decomposed'),
(1746205,2,485.07498,314.65887,1.9463371,NULL,'Shattered Hand Zealot - Add 5'),
(1746205,3,460.72418,313.97842,1.9364703,NULL,'Shattered Hand Zealot - Add 5'),
(1746205,4,434.42194,314.33572,1.9077104,NULL,'Shattered Hand Zealot - Add 5'),
(1746205,5,403.79083,314.16635,1.9008716,NULL,'Shattered Hand Zealot - Add 5'),
(1746205,6,374.89954,312.64014,1.9247476,NULL,'Shattered Hand Zealot - Add 5'),
(1746205,7,359.43372,312.43814,1.9181622,2.809980154037475585,'Shattered Hand Zealot - Add 5'),
(1746206,1,496.7627,314.17264,1.9459041,NULL,'Shattered Hand Zealot - Add 6'),
(1746206,2,485.07498,314.65887,1.9463371,NULL,'Shattered Hand Zealot - Add 6'),
(1746206,3,460.7832,315.03976,1.9364105,NULL,'Shattered Hand Zealot - Add 6'),
(1746206,4,435.2396,312.74365,1.9061459,NULL,'Shattered Hand Zealot - Add 6'),
(1746206,5,403.83655,312.20764,1.9023694,NULL,'Shattered Hand Zealot - Add 6'),
(1746206,6,385.5018,309.696,1.938451,2.809980154037475585,'Shattered Hand Zealot - Add 6'),
(1746207,1,497.28668,314.52902,1.9456482,NULL,'Shattered Hand Zealot - Add 7'),
(1746207,2,484.36633,313.18347,1.9463377,NULL,'Shattered Hand Zealot - Add 7'),
(1746207,3,459.75717,313.03488,1.9374542,NULL,'Shattered Hand Zealot - Add 7'),
(1746207,4,439.54303,312.2451,1.8873941,NULL,'Shattered Hand Zealot - Add 7'),
(1746207,5,420.8947,309.70868,1.9430903,2.809980154037475585,'Shattered Hand Zealot - Add 7'),
(1746208,1,497.14935,314.8804,1.9457157,NULL,'Shattered Hand Zealot - Add 8'),
(1746208,2,485.2548,314.55142,1.946337,NULL,'Shattered Hand Zealot - Add 8'),
(1746208,3,469.40604,311.16257,1.9173245,NULL,'Shattered Hand Zealot - Add 8'),
(1746208,4,460.55313,309.96686,1.936643,2.809980154037475585,'Shattered Hand Zealot - Add 8');

DELETE FROM `spell_target_position` WHERE `ID` = 30976;
INSERT INTO `spell_target_position` (`ID`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `VerifiedBuild`) VALUES
(30976, 540, 520.062, 255.486, 2.0333333, 48999);

-- SmartAI for spell
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17462) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17462, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746200, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Just Summoned - Start Waypoint'),
(17462, 0, 2, 0, 58, 0, 100, 0, 0, 1746200, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Set In Combat With Zone');

-- SmartAI for pre-spawns
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+1),-(@CGUID+2),-(@CGUID+3),-(@CGUID+4),-(@CGUID+5),-(@CGUID+6),-(@CGUID+7),-(@CGUID+8)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+1), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+1), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+1), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746201, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+1), 0, 1003, 0, 58, 0, 100, 0, 0, 1746201, 0, 0, 0, 80, 1746200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+2), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+2), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+2), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746202, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+2), 0, 1003, 0, 58, 0, 100, 0, 0, 1746202, 0, 0, 0, 80, 1746200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+3), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+3), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+3), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746203, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+3), 0, 1003, 0, 58, 0, 100, 0, 0, 1746203, 0, 0, 0, 80, 1746200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+4), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+4), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+4), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746204, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+4), 0, 1003, 0, 58, 0, 100, 0, 0, 1746204, 0, 0, 0, 80, 1746200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+5), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+5), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+5), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746205, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+5), 0, 1003, 0, 58, 0, 100, 0, 0, 1746205, 0, 0, 0, 80, 1746201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+6), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+6), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+6), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746206, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+6), 0, 1003, 0, 58, 0, 100, 0, 0, 1746206, 0, 0, 0, 80, 1746201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+7), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+7), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+7), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746207, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+7), 0, 1003, 0, 58, 0, 100, 0, 0, 1746207, 0, 0, 0, 80, 1746201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script'),
(-(@CGUID+8), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Respawn - Disable'),
(-(@CGUID+8), 0, 1001, 1002, 38, 0, 100, 0, 1, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Data Set 1 1 - Enable'),
(-(@CGUID+8), 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1746208, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Linked - Start Waypoint'),
(-(@CGUID+8), 0, 1003, 0, 58, 0, 100, 0, 0, 1746208, 0, 0, 0, 80, 1746201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - On Waypoint Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1746200, 1746201));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1746200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.351032257080078, 'Shattered Hand Zealot - Actionlist - Set Orientation 3.351032257080078'),
(1746200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Actionlist - Set Sheath Melee'),
(1746200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Actionlist - Set Emote State 333'),
(1746201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.809980154037475585, 'Shattered Hand Zealot - Actionlist - Set Orientation 2.809980154037475585'),
(1746201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Actionlist - Set Sheath Melee'),
(1746201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Zealot - Actionlist - Set Emote State 333');

/*
	Kargath Bladefist
*/
DELETE FROM `waypoints` WHERE `entry`=1680800;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(1680800,1,312.5911,-84.185234,1.9369955,NULL,'Warchief Kargath Bladefist Add'),
(1680800,2,301.18335,-83.94184,1.9370385,NULL,'Warchief Kargath Bladefist Add'),
(1680800,3,289.016,-83.993065,1.9304622,NULL,'Warchief Kargath Bladefist Add'),
(1680800,4,279.15543,-84.08081,2.1895409,NULL,'Warchief Kargath Bladefist Add'),
(1680800,5,274.1177,-84.06761,2.3095043,NULL,'Warchief Kargath Bladefist Add');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17621) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17621, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1680800, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heathen Guard - On Just Summoned - Start Waypoint'),
(17621, 0, 4, 0, 58, 0, 100, 0, 0, 1680800, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heathen Guard - On Waypoint Finished - Set In Combat With Zone');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17622) AND (`source_type` = 0) AND (`id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17622, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1680800, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sharpshooter Guard - On Just Summoned - Start Waypoint'),
(17622, 0, 5, 0, 58, 0, 100, 0, 0, 1680800, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sharpshooter Guard - On Waypoint Finished - Set In Combat With Zone');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17623) AND (`source_type` = 0) AND (`id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17623, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1680800, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reaver Guard - On Just Summoned - Start Waypoint'),
(17623, 0, 5, 0, 58, 0, 100, 0, 0, 1680800, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reaver Guard - On Waypoint Finished - Set In Combat With Zone');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE (`entry` IN (17621, 17622, 17623, 20569, 20578, 20575));

UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` IN (17621, 20569, 17623, 20575));
UPDATE `creature_template_addon` SET `bytes2` = 2 WHERE (`entry` IN (17622, 20578));
