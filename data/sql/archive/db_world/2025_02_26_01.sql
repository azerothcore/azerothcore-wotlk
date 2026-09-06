-- DB update 2025_02_26_00 -> 2025_02_26_01

-- Add new waypoints
DELETE FROM `waypoints` WHERE `entry` IN (25851);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(25851, 1, 1691.8, 513.581, 85.272, NULL, 0, 'Volatile Fiend'),
(25851, 2, 1685.3, 531.707, 85.2726, NULL, 0, 'Volatile Fiend'),
(25851, 3, 1678.34, 548.748, 85.1301, NULL, 0, 'Volatile Fiend'),
(25851, 4, 1666.06, 562.532, 85.0835, NULL, 0, 'Volatile Fiend'),
(25851, 5, 1637.52, 577.188, 85.0895, NULL, 0, 'Volatile Fiend'),
(25851, 6, 1614.78, 593.407, 84.98, NULL, 0, 'Volatile Fiend'),
(25851, 7, 1597.61, 586.214, 84.9866, NULL, 0, 'Volatile Fiend'),
(25851, 8, 1600.17, 579.387, 84.8456, NULL, 0, 'Volatile Fiend'),
(25851, 9, 1614.05, 560.661, 73.5036, NULL, 0, 'Volatile Fiend'),
(25851, 10, 1628.04, 541.932, 63.0932, NULL, 0, 'Volatile Fiend'),
(25851, 11, 1647.24, 530.052, 53.9219, NULL, 0, 'Volatile Fiend'),
(25851, 12, 1654.32, 527.089, 50.6408, NULL, 0, 'Volatile Fiend'),
(25851, 13, 1659.93, 519.575, 50.5756, NULL, 0, 'Volatile Fiend'),
(25851, 14, 1653.65, 505.556, 50.5756, NULL, 0, 'Volatile Fiend'),
(25851, 15, 1632.21, 514.799, 50.5756, NULL, 0, 'Volatile Fiend'),
(25851, 16, 1614, 529.46, 50.5756, NULL, 0, 'Volatile Fiend'),
(25851, 17, 1596.71, 543.375, 50.5756, NULL, 0, 'Volatile Fiend'),
(25851, 18, 1583.25, 560.562, 50.5756, NULL, 0, 'Volatile Fiend'),
(25851, 19, 1570.92, 574.75, 50.6095, NULL, 0, 'Volatile Fiend'),
(25851, 20, 1557.81, 569.841, 50.5778, NULL, 0, 'Volatile Fiend'),
(25851, 21, 1561.98, 553.198, 47.4638, NULL, 0, 'Volatile Fiend'),
(25851, 22, 1572.27, 537.190, 38.7821, NULL, 0, 'Volatile Fiend'),
(25851, 23, 1583.75, 521.830, 32.7347, NULL, 0, 'Volatile Fiend'),
(25851, 24, 1588.91, 506.692, 32.7835, NULL, 0, 'Volatile Fiend');

-- Remove Wrong Flag (Pacified)
UPDATE `creature_template` SET `unit_flags`=`unit_flags`& ~131072 WHERE (`entry` = 25851);

-- Set Movement Type on Random in Radius
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id1` = 25851) AND (`guid` IN (47044, 47153, 47154, 47155, 47265, 47309, 47313, 47449, 47454, 47470, 47471, 47475, 47578, 47607, 47608, 47768, 47769, 47875, 47884, 47893, 47897, 47898, 47899, 47901, 48151));

-- Modify SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25851;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25851);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25851, 0, 0, 1, 54, 0, 100, 513, 0, 0, 0, 0, 0, 0, 11, 46308, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Just Summoned - Cast \'Burning Winds\' (No Repeat)'),
(25851, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Just Summoned - Set Event Phase 1 (No Repeat)'),
(25851, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 1, 25851, 0, 0, 2500, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Just Summoned - Start Waypoint Path 25851 (No Repeat)'),
(25851, 0, 3, 4, 40, 0, 100, 0, 24, 0, 0, 0, 0, 0, 11, 47287, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Point 24 of Path Any Reached - Cast \'Burning Destruction\''),
(25851, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Point 24 of Path Any Reached - Despawn In 1000 ms'),
(25851, 0, 5, 0, 6, 2, 100, 512, 0, 0, 0, 0, 0, 0, 11, 45779, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Just Died - Cast \'Felfire Fission\' (Phase 2)'),
(25851, 0, 6, 7, 0, 1, 100, 513, 0, 0, 0, 0, 0, 5, 11, 47287, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - In Combat - Cast \'Burning Destruction\' (Phase 1) (No Repeat)'),
(25851, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - In Combat - Set Event Phase 3 (Phase 1) (No Repeat)'),
(25851, 0, 8, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Reset - Set Event Phase 2'),
(25851, 0, 9, 0, 23, 4, 100, 1, 47287, 0, 0, 0, 0, 0, 11, 46751, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volatile Fiend - On Aura \'Burning Destruction\' - Cast \'Suicide\' (Phase 3) (No Repeat)');
