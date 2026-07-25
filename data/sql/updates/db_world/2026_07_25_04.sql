-- DB update 2026_07_25_03 -> 2026_07_25_04
--
DELETE FROM `creature` WHERE (`id` = 24516) AND (`guid` IN (114439, 114440));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `CreateObject`, `VerifiedBuild`) VALUES
(114439, 24516, 571, 0, 0, 1, 1, 0, 2319.6106, -3020.8176, 136.57187, 2.20952, 300, 0, 0, 0, 0, 2, 0, 0, 0, '', NULL, 1, 65512);

DELETE FROM `creature_addon` WHERE `guid` = 114439;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES
(114439, 1144390);

DELETE FROM `waypoint_data` WHERE `id` = 1144390;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(1144390, 1 , 2319.6106, -3020.8176, 136.57187, NULL),
(1144390, 2 , 2293.5505, -3033.0613, 136.70703, NULL),
(1144390, 3 , 2270.9585, -3049.1892, 136.7957, NULL),
(1144390, 4 , 2261.9817, -3069.591, 137.1125, NULL),
(1144390, 5 , 2244.4805, -3111.4001, 136.79797, NULL),
(1144390, 6 , 2234.3372, -3129.741, 138.23094, NULL),
(1144390, 7 , 2205.1501, -3149.454, 140.47078, NULL),
(1144390, 8 , 2178.7832, -3143.6543, 139.04956, NULL),
(1144390, 9 , 2159.131, -3118.843, 138.94107, NULL),
(1144390, 10, 2157.4236, -3090.9448, 138.66618, NULL),
(1144390, 11, 2184.6926, -3076.7776, 137.69681, NULL),
(1144390, 12, 2205.2817, -3067.4485, 138.47263, NULL),
(1144390, 13, 2241.1084, -3040.399, 136.02086, NULL),
(1144390, 14, 2251.2544, -3001.0442, 135.393, NULL),
(1144390, 15, 2261.8438, -2975.5894, 137.61548, NULL),
(1144390, 16, 2288.5696, -2967.9568, 134.09793, NULL),
(1144390, 17, 2312.0784, -2973.8508, 131.73712, NULL),
(1144390, 18, 2327.24, -2996.011, 135.02109, NULL);
