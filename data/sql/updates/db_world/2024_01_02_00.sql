-- DB update 2024_01_01_05 -> 2024_01_02_00
--
DELETE FROM `waypoints` WHERE `entry` IN (1829800, 1829801);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(1829800, 1, -2672.9744, 7931.336, -27.176205, NULL, 0, 'Gava\'xi'),
(1829800, 2, -2684.0105, 7918.5903, -31.449396, NULL, 0, 'Gava\'xi'),
(1829800, 3, -2709.6504, 7895.3516, -40.8449, NULL, 0, 'Gava\'xi'),
(1829800, 4, -2722.3762, 7894.163, -41.931747, NULL, 0, 'Gava\'xi'),
(1829800, 5, -2732.9348, 7900.942, -41.43452, NULL, 0, 'Gava\'xi'),
(1829800, 6, -2738.069, 7909.868, -41.615604, NULL, 0, 'Gava\'xi'),
(1829800, 7, -2731.4773, 7926.874, -40.430233, NULL, 0, 'Gava\'xi'),
(1829800, 8, -2706.214, 7966.6875, -44.424637, NULL, 0, 'Gava\'xi'),
(1829800, 9, -2678.335, 7982.9517, -46.47888, NULL, 0, 'Gava\'xi'),
(1829800, 10, -2664.7808, 7981.76, -47.284157, NULL, 0, 'Gava\'xi'),
(1829800, 11, -2643.7148, 7983.618, -47.950817, NULL, 0, 'Gava\'xi'),
(1829800, 12, -2627.47, 7988.2173, -48.725338, NULL, 0, 'Gava\'xi'),
(1829800, 13, -2608.5688, 7992.2085, -49.956314, NULL, 0, 'Gava\'xi'),
(1829800, 14, -2591.1943, 7998.155, -51.645016, NULL, 0, 'Gava\'xi'),
(1829800, 15, -2587.0571, 8000.884, -51.988026, NULL, 0, 'Gava\'xi'),
(1829801, 1, -2595.9915, 7978.7476, -51.318558, NULL, 0, 'Gava\'xi'),
(1829801, 2, -2606.409, 7970.6963, -50.899216, NULL, 0, 'Gava\'xi'),
(1829801, 3, -2618.4011, 7955.8125, -51.952393, NULL, 0, 'Gava\'xi'),
(1829801, 4, -2631.3743, 7933.137, -52.171066, NULL, 0, 'Gava\'xi'),
(1829801, 5, -2629.679, 7916.777, -53.126976, NULL, 0, 'Gava\'xi'),
(1829801, 6, -2638.3762, 7903.308, -51.517876, NULL, 0, 'Gava\'xi'),
(1829801, 7, -2654.426, 7890.7925, -49.859486, NULL, 0, 'Gava\'xi'),
(1829801, 8, -2675.7644, 7878.1504, -45.659203, NULL, 0, 'Gava\'xi'),
(1829801, 9, -2694.0188, 7872.3525, -44.287346, NULL, 0, 'Gava\'xi'),
(1829801, 10, -2705.9536, 7878.065, -43.997498, NULL, 0, 'Gava\'xi'),
(1829801, 11, -2707.866, 7888.1953, -41.754112, NULL, 0, 'Gava\'xi'),
(1829801, 12, -2702.4153, 7895.1562, -39.975098, NULL, 0, 'Gava\'xi'),
(1829801, 13, -2694.282, 7903.423, -37.312958, NULL, 0, 'Gava\'xi'),
(1829801, 14, -2675.754, 7928.2773, -28.246132, NULL, 0, 'Gava\'xi'),
(1829801, 15, -2670.222, 7942.9243, -23.193773, NULL, 0, 'Gava\'xi'),
(1829801, 16, -2665.6055, 7953.998, -18.960806, NULL, 0, 'Gava\'xi');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 18298 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18298, 0, 0, 0, 0, 0, 100, 0, 2500, 4000, 9500, 12000, 0, 0, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - In Combat - Cast \'Sinister Strike\''),
(18298, 0, 1, 0, 2, 0, 100, 1, 20, 80, 0, 0, 0, 0, 11, 12540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - Between 20-80% Health - Cast \'Gouge\' (No Repeat)'),
(18298, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 1829800, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - Respawn - Start waypoint movement'),
(18298, 0, 3, 4, 40, 0, 100, 0, 15, 1829800, 0, 0, 0, 0, 89, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - WP reached - Start wander movement (10yds)'),
(18298, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 15000, 15000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - WP reached - Do timed event 1'),
(18298, 0, 5, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 53, 0, 1829801, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - On timed event triggered - Start waypoint movement'),
(18298, 0, 6, 7, 40, 0, 100, 0, 16, 1829801, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - WP reached - Start wander movement (0yds)'),
(18298, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 2, 4000, 4000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - WP reached - Do timed event 2'),
(18298, 0, 8, 9, 59, 0, 100, 0, 2, 0, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - On timed event triggered - Do emote \'ONESHOT_ROAR\''),
(18298, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 3, 22000, 22000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - On timed event triggered - Do timed event 3'),
(18298, 0, 10, 0, 59, 0, 100, 0, 3, 0, 0, 0, 0, 0, 53, 1, 1829800, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gava\'xi - On timed event triggered - Start waypoint movement');
