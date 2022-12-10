-- DB update 2022_08_15_03 -> 2022_08_15_04
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

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ayamiss_swarmer_start_loop';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25711, 'spell_ayamiss_swarmer_start_loop');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_gen_ayamiss_swarmer_loop_1', 'spell_gen_ayamiss_swarmer_loop_2', 'spell_gen_ayamiss_swarmer_loop_3');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25833, 'spell_gen_ayamiss_swarmer_loop_1'),
(25834, 'spell_gen_ayamiss_swarmer_loop_2'),
(25835, 'spell_gen_ayamiss_swarmer_loop_3');

UPDATE `creature_template` SET `ScriptName` = 'npc_hive_zara_swarmer' WHERE `entry` = 15546;

SET @NPC := 15546;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9758.247, 1426.3112, 84.167656, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9762.383, 1436.3455, 84.428795, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9760.481, 1452.1432, 75.32612, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9754.527, 1466.5826, 61.60388, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9750.208, 1479.4608, 45.937202, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 1) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9804.298, 1432.3503, 85.9217, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9799.983, 1443.1294, 82.55095, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9785.31, 1456.0002, 76.88425, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9769.325, 1467.856, 68.520706, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9750.661, 1477.6143, 48.96516, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 2) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9818.727, 1512.838, 89.24695, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9812.264, 1511.9375, 87.49864, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9806.9375, 1505.4645, 83.19313, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9796.596, 1494.5698, 76.8735, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9781.221, 1486.8652, 71.7902, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9765.105, 1476.7782, 63.17909, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -9753.014, 1478.1317, 50.817974, 0, 0, 0, 0, 100, 0);

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
(@PATH, 1, -9818.173, 1460.0463, 95.69417, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9811.176, 1460.6091, 92.56013, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9802.768, 1455.1123, 86.143425, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9797.88, 1450.7151, 81.69902, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9761.196, 1470.298, 64.64121, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9754.684, 1475.3403, 49.030098, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 5) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9745.072, 1489.5533, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9745.766, 1502.0659, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9734.748, 1502.8883, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9715.551, 1496.5533, 42.267452, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9697.712, 1511.8822, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9694.466, 1539.3663, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -9696.591, 1561.1914, 41.37858, 0, 0, 0, 0, 100, 0),
(@PATH, 8, -9667.614, 1571.5212, 43.489666, 0, 0, 0, 0, 100, 0),
(@PATH, 9, -9653.44, 1552.1632, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 10, -9612.033, 1551.3334, 39.26745, 0, 0, 0, 0, 100, 0),
(@PATH, 11, -9582.261, 1572.4617, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 12, -9598.483, 1615.416, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 13, -9638.286, 1645.0948, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 14, -9682.366, 1625.8219, 37.211887, 0, 0, 0, 0, 100, 0),
(@PATH, 15, -9667.457, 1593.8171, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 16, -9625.382, 1598.9684, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 17, -9618.158, 1566.9963, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 18, -9661.183, 1554.485, 42.489677, 0, 0, 0, 0, 100, 0),
(@PATH, 19, -9690.858, 1543.3951, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 20, -9711.017, 1540.3297, 43.517445, 0, 0, 0, 0, 100, 0),
(@PATH, 21, -9736.964, 1511.8362, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 22, -9725.431, 1487.6272, 44.323, 0, 0, 0, 0, 100, 0),
(@PATH, 23, -9742.012, 1485.945, 44.323, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 6) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9748.129, 1488.4904, 45.764896, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9748.667, 1498.9249, 47.07047, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9744.251, 1508.8634, 46.820465, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9713.56, 1502.6979, 43.542686, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9701.453, 1522.0952, 43.542686, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9702.735, 1548.3297, 40.987125, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -9682.249, 1544.3987, 41.12602, 0, 0, 0, 0, 100, 0),
(@PATH, 8, -9661.323, 1537.9355, 42.959347, 0, 0, 0, 0, 100, 0),
(@PATH, 9, -9647.55, 1544.9911, 42.959347, 0, 0, 0, 0, 100, 0),
(@PATH, 10, -9651.3125, 1565.7776, 42.98713, 0, 0, 0, 0, 100, 0),
(@PATH, 11, -9657.682, 1593.8557, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 12, -9684.013, 1619.9458, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 13, -9645.765, 1642.1168, 50.042664, 0, 0, 0, 0, 100, 0),
(@PATH, 14, -9618.591, 1606.9883, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 15, -9624.827, 1566.3673, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 16, -9662.095, 1559.2485, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 17, -9689.207, 1559.972, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 18, -9692.733, 1523.6748, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 19, -9731.375, 1527.3365, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 20, -9729.185, 1490.0042, 45.070454, 0, 0, 0, 0, 100, 0),
(@PATH, 21, -9745.345, 1485.0509, 45.487125, 0, 0, 0, 0, 100, 0);

SET @PATH := (@NPC + 7) * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -9745.88, 1488.399, 45.917397, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -9744.661, 1507.4883, 46.028458, 0, 0, 0, 0, 100, 0),
(@PATH, 3, -9735.175, 1527.706, 43.806267, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -9701.6455, 1545.9641, 44.3896, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -9658.681, 1541.812, 43.472916, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -9616.4375, 1554.6978, 41.278492, 0, 0, 0, 0, 100, 0),
(@PATH, 7, -9583.255, 1572.3322, 42.61181, 0, 0, 0, 0, 100, 0),
(@PATH, 8, -9594.106, 1611.233, 43.16736, 0, 0, 0, 0, 100, 0),
(@PATH, 9, -9626.409, 1625.0471, 40.945137, 0, 0, 0, 0, 100, 0),
(@PATH, 10, -9665.356, 1653.7917, 45.472958, 0, 0, 0, 0, 100, 0),
(@PATH, 11, -9684.14, 1617.8658, 42.111813, 0, 0, 0, 0, 100, 0),
(@PATH, 12, -9687.5625, 1573.8448, 43.97294, 0, 0, 0, 0, 100, 0),
(@PATH, 13, -9690.304, 1535.7795, 44.167366, 0, 0, 0, 0, 100, 0),
(@PATH, 14, -9711.632, 1498.4967, 41.334064, 0, 0, 0, 0, 100, 0),
(@PATH, 15, -9741.987, 1484.3424, 45.7785, 0, 0, 0, 0, 100, 0);

DELETE FROM `creature_addon` WHERE `guid` = 144641;

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 15369;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(15369, 1, 0, 1, 0, 0, NULL);
