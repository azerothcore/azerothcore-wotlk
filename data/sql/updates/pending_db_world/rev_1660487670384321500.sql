--
DELETE FROM `spell_target_position` WHERE `ID` IN (25708, 25709, 25825, 25826, 25827, 25828);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(25708, 0, 509, -9846, 1353, 106.083336, 0, 0),
(25709, 0, 509, -9757.87, 1416.71, 76.7664, 0, 0),
(25825, 0, 509, -9805.95, 1422.85, 77.5852, 0, 0),
(25826, 0, 509, -9827.58, 1506.28, 82.3052, 0, 0),
(25827, 0, 509, -9778.91, 1419.98, 61.0743, 0, 0),
(25828, 0, 509, -9829.42, 1456.37, 90.7015, 0, 0);

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ayamiss_swarmer_teleport_trigger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25830, 'spell_ayamiss_swarmer_teleport_trigger');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ayamiss_swarmer_swarm';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25844, 'spell_ayamiss_swarmer_swarm');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 1, `EffectDieSides_1` = 0 WHERE `ID` = 25708;

SET @NPC := 15546;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9818.173, 1460.0463, 95.69417, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9811.176, 1460.6091, 92.56013, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9802.768, 1455.1123, 86.143425, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9797.88, 1450.7151, 81.69902, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9761.196, 1470.298, 64.64121, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9754.684, 1475.3403, 49.030098, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 1) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9818.727, 1512.838, 89.24695, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9812.264, 1511.9375, 87.49864, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9806.9375, 1505.4645, 83.19313, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9796.596, 1494.5698, 76.8735, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9781.221, 1486.8652, 71.7902, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9765.105, 1476.7782, 63.17909, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -9753.014, 1478.1317, 50.817974, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 2) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9804.298, 1432.3503, 85.9217, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9799.983, 1443.1294, 82.55095, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9785.31, 1456.0002, 76.88425, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9769.325, 1467.856, 68.520706, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9750.661, 1477.6143, 48.96516, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 3) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9776.323, 1428.8531, 65.629776, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9776.123, 1436.0718, 67.35508, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9764.125, 1455.0714, 66.27153, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9754.778, 1466.8633, 62.577053, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9747.529, 1473.6367, 49.077087, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 4) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9758.247, 1426.3112, 84.167656, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9762.383, 1436.3455, 84.428795, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9760.481, 1452.1432, 75.32612, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9754.527, 1466.5826, 61.60388, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9750.208, 1479.4608, 45.937202, 0, 0, 0, 0, 100, 0);
