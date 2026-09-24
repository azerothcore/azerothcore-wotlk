-- DB update 2026_08_31_06 -> 2026_08_31_07
-- Brunnhildar route (Path 1) spawn and route separation.
-- Spawn position (6821.0693, -1800.8033, 940.85815) is set on the creature only.
-- Waypoints are fully replaced starting at point 1 (first airborne patrol point).
-- The old spawn position (6748.211, -1664.3069, 919.3118) becomes the last loop point.

-- Creature spawn positions for TLPD (guid 39203) and Vyragosa (guid 39207) on Path 1
UPDATE `creature` SET `position_x` = 6821.0693, `position_y` = -1800.8033, `position_z` = 940.85815, `orientation` = 0.8169179, `VerifiedBuild` = 0 WHERE `guid` = 39203 AND `id` = 32491;
UPDATE `creature` SET `position_x` = 6821.0693, `position_y` = -1800.8033, `position_z` = 940.85815, `orientation` = 0.8169179, `VerifiedBuild` = 0 WHERE `guid` = 39207 AND `id` = 32630;

-- Rebuild the patrol route with point 1 as the first airborne waypoint (old point 2).
-- Old point 1 (spawn) is appended as the final point so the loop completes naturally.
DELETE FROM `waypoint_data` WHERE `id` = 392030;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (392030,  1, 6913.308,    -1725.2614,  954.7917,   NULL, 0, 1),
    (392030,  2, 7167.578,    -1501.6945,  962.5693,   NULL, 0, 1),
    (392030,  3, 7440.402,    -1295.8611,  997.2911,   NULL, 0, 1),
    (392030,  4, 7210.9585,   -1046.8922, 1006.1796,   NULL, 0, 1),
    (392030,  5, 6998.4653,   -1076.8466, 1024.8191,   NULL, 0, 1),
    (392030,  6, 6874.249,    -1097.3822,  927.736,    NULL, 0, 1),
    (392030,  7, 6614.7915,    -875.7547,  812.7645,   NULL, 0, 1),
    (392030,  8, 6563.2754,    -811.7673,  749.87573,  NULL, 0, 1),
    (392030,  9, 6299.502,     -797.57697, 529.12573,  NULL, 0, 1),
    (392030, 10, 6194.549,    -1013.1437,  501.54242,  NULL, 0, 1),
    (392030, 11, 6319.2544,   -1251.6613,  468.6258,   NULL, 0, 1),
    (392030, 12, 6309.161,    -1537.8574,  615.0423,   NULL, 0, 1),
    (392030, 13, 6748.211,    -1664.3069,  919.3118,   NULL, 0, 1);

UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` = 392030;

-- Waterfall Path 3 (path 392050) spawn and route separation.
-- Spawn position (6550.9775, -671.7839, 834.73395) is set on the creature only.
-- Waypoints are fully replaced starting at point 1 (first airborne patrol point).
-- The old spawn position (6481.932, -689.96844, 770.06104) becomes the last loop point.

-- Creature spawn positions for TLPD (guid 39205) and Vyragosa (guid 39209) on Path 3
UPDATE `creature` SET `position_x` = 6550.9775, `position_y` = -671.7839, `position_z` = 834.73395, `orientation` = 5.51175, `VerifiedBuild` = 0 WHERE `guid` = 39205 AND `id` = 32491;
UPDATE `creature` SET `position_x` = 6550.9775, `position_y` = -671.7839, `position_z` = 834.73395, `orientation` = 5.51175, `VerifiedBuild` = 0 WHERE `guid` = 39209 AND `id` = 32630;

-- Rebuild the patrol route with point 1 as the first airborne waypoint (old point 2).
-- Old point 1 (spawn) is appended as the final point so the loop completes naturally.
DELETE FROM `waypoint_data` WHERE `id` = 392050;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (392050,  1, 6649.857,   -781.58746,  855.9499,  NULL, 0, 1),
    (392050,  2, 6952.5728,   -758.1678,  807.22784, NULL, 0, 1),
    (392050,  3, 7057.876,    -690.5854,  807.22784, NULL, 0, 1),
    (392050,  4, 7070.7056,   -460.4938,  821.33875, NULL, 0, 1),
    (392050,  5, 7083.6943,   -252.1965,  817.78326, NULL, 0, 1),
    (392050,  6, 6910.3896,  -164.06386,  821.42194, NULL, 0, 1),
    (392050,  7, 6754.1,      -16.06277,  805.08875, NULL, 0, 1),
    (392050,  8, 6525.3613,   -70.11849,  808.1164,  NULL, 0, 1),
    (392050,  9, 6400.468,   -192.77023,  704.8667,  NULL, 0, 1),
    (392050, 10, 6312.018,   -498.71994,  704.8667,  NULL, 0, 1),
    (392050, 11, 6455.723,   -562.87396,  814.643,   NULL, 0, 1),
    (392050, 12, 6481.932,   -689.96844,  770.06104, NULL, 0, 1);

UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` = 392050;

-- ---------------------------------------------------------------------------
-- Drop Path 2 (392040) - duplicate of this Waterfall spawn, folded in above.
-- ---------------------------------------------------------------------------
DELETE FROM `waypoint_data` WHERE `id` = 392040;

DELETE FROM `creature_addon` WHERE `guid` IN (39204, 39208);

DELETE FROM `creature` WHERE `guid` = 39204 AND `id` = 32491;
DELETE FROM `creature` WHERE `guid` = 39208 AND `id` = 32630;

DELETE FROM `pool_creature` WHERE `pool_entry` = 32493;
DELETE FROM `pool_pool` WHERE `pool_id` = 32493 OR `mother_pool` = 32493;
DELETE FROM `pool_template` WHERE `entry` = 32493;

-- Frozen Lake Path 4 (path 392060) spawn and route separation.
-- Spawn position (6880.4116, -398.9924, 1004.92456) is set on the creature only.
-- Waypoints are fully replaced starting at point 1 (first airborne patrol point).
-- The old spawn position (6954.7627, -472.37695, 997.65027) becomes the last loop point.

-- Creature spawn positions for TLPD (guid 39206) and Vyragosa (guid 39210) on Path 4
UPDATE `creature` SET `position_x` = 6880.4116, `position_y` = -398.9924, `position_z` = 1004.92456, `orientation` = 0.9124172, `VerifiedBuild` = 0 WHERE `guid` = 39206 AND `id` = 32491;
UPDATE `creature` SET `position_x` = 6880.4116, `position_y` = -398.9924, `position_z` = 1004.92456, `orientation` = 0.9124172, `VerifiedBuild` = 0 WHERE `guid` = 39210 AND `id` = 32630;

-- Rebuild the patrol route with point 1 as the first airborne waypoint (old point 2).
-- Old point 1 (spawn) is appended as the final point so the loop completes naturally.
DELETE FROM `waypoint_data` WHERE `id` = 392060;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
    (392060,  1, 6903.07,     -363.67593,  992.3348,  NULL, 0, 1),
    (392060,  2, 7002.2744,   -270.31137,  908.9182,  NULL, 0, 1),
    (392060,  3, 7150.6274,   -142.2627,   859.1961,  NULL, 0, 1),
    (392060,  4, 7316.008,     -35.80534,  859.1961,  NULL, 0, 1),
    (392060,  5, 7542.2666,    -97.61708,  878.5572,  NULL, 0, 1),
    (392060,  6, 7667.518,    -102.67128,  899.2793,  NULL, 0, 1),
    (392060,  7, 7794.171,    -209.65338,  925.02905, NULL, 0, 1),
    (392060,  8, 7899.086,    -401.56662,  928.9456,  NULL, 0, 1),
    (392060,  9, 7997.539,    -546.96466,  949.58435, NULL, 0, 1),
    (392060, 10, 8143.803,      -636.999,  999.3811,  NULL, 0, 1),
    (392060, 11, 8245.65,      -775.7319,  999.3811,  NULL, 0, 1),
    (392060, 12, 8238.106,     -987.4192,  983.9922,  NULL, 0, 1),
    (392060, 13, 7946.1025,  -1003.7714,  1088.5669,  NULL, 0, 1),
    (392060, 14, 7586.955,   -1071.2095,  1054.2891,  NULL, 0, 1),
    (392060, 15, 7313.6016,   -857.4793,   987.2056,  NULL, 0, 1),
    (392060, 16, 7143.3037,   -697.4054,   969.9835,  NULL, 0, 1),
    (392060, 17, 6954.7627,   -472.37695,  997.65027, NULL, 0, 1);

UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` = 392060;

-- Adds a 5th patrol path for Time-Lost Proto Drake / Vyragosa circling Ulduar.
-- TLPD guid 39211 (path 5), Vyragosa guid 39228 (path 5), sub-pool 32496.

-- ---------------------------------------------------------------------------
-- Waypoints – path 392110  (= guid 39211 * 10, TLPD Ulduar path)
-- Spawn position (8545.776, -1879.3956, 1131.0109) is in the creature table only.
-- Route starts at point 1 (first airborne patrol point, formerly point 2).
-- ---------------------------------------------------------------------------
DELETE FROM `waypoint_data` WHERE `id` = 392110;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
    (392110,  1, 8710.676,   -1898.1595, 1124.5157, NULL, 0, 1, 0, 100, 0),
    (392110,  2, 8792.491,   -1807.033,  1114.2876, NULL, 0, 1, 0, 100, 0),
    (392110,  3, 8813.976,   -1688.0184, 1094.7952, NULL, 0, 1, 0, 100, 0),
    (392110,  4, 8727.826,   -1352.7471, 1074.8005, NULL, 0, 1, 0, 100, 0),
    (392110,  5, 8744.546,   -1019.28076,1055.7817, NULL, 0, 1, 0, 100, 0),
    (392110,  6, 8726.103,    -913.81915,1053.7843, NULL, 0, 1, 0, 100, 0),
    (392110,  7, 8512.191,    -528.02966,1073.2588, NULL, 0, 1, 0, 100, 0),
    (392110,  8, 8413.002,    -403.5435, 1100.8687, NULL, 0, 1, 0, 100, 0),
    (392110,  9, 8398.43,     -212.46346,1049.5369, NULL, 0, 1, 0, 100, 0),
    (392110, 10, 8285.105,     -61.45302,  959.68085,NULL, 0, 1, 0, 100, 0),
    (392110, 11, 8198.244,     -26.941242, 908.8873, NULL, 0, 1, 0, 100, 0),
    (392110, 12, 8057.321,     -95.137184, 903.2169, NULL, 0, 1, 0, 100, 0),
    (392110, 13, 7948.71,     -164.20184,  905.00885,NULL, 0, 1, 0, 100, 0),
    (392110, 14, 7806.529,    -198.08,     917.8996, NULL, 0, 1, 0, 100, 0),
    (392110, 15, 7601.64,      -96.94775,  899.8608, NULL, 0, 1, 0, 100, 0),
    (392110, 16, 7493.8726,    -88.879845, 881.671,  NULL, 0, 1, 0, 100, 0),
    (392110, 17, 7230.171,     -98.89482,  867.2068, NULL, 0, 1, 0, 100, 0),
    (392110, 18, 7110.845,    -148.89287,  842.1238, NULL, 0, 1, 0, 100, 0),
    (392110, 19, 7070.274,    -271.08237,  851.1952, NULL, 0, 1, 0, 100, 0),
    (392110, 20, 7069.7754,   -444.9418,   841.5178, NULL, 0, 1, 0, 100, 0),
    (392110, 21, 7072.199,    -505.89044,  808.6802, NULL, 0, 1, 0, 100, 0),
    (392110, 22, 7043.844,    -608.80347,  856.4439, NULL, 0, 1, 0, 100, 0),
    (392110, 23, 7047.859,    -678.79645,  891.93475,NULL, 0, 1, 0, 100, 0),
    (392110, 24, 7147.5117,   -763.36414,  941.46716,NULL, 0, 1, 0, 100, 0),
    (392110, 25, 7244.83,     -841.64685,  981.2637, NULL, 0, 1, 0, 100, 0),
    (392110, 26, 7330.0835,   -961.8496,   994.1743, NULL, 0, 1, 0, 100, 0),
    (392110, 27, 7494.1934,  -1329.4451,  1009.914,  NULL, 0, 1, 0, 100, 0),
    (392110, 28, 7609.6084,  -1489.7345,  1126.6444, NULL, 0, 1, 0, 100, 0),
    (392110, 29, 7683.7646,  -1581.4442,  1254.2268, NULL, 0, 1, 0, 100, 0),
    (392110, 30, 7739.265,   -1696.0844,  1351.2458, NULL, 0, 1, 0, 100, 0),
    (392110, 31, 7837.52,    -1743.9873,  1336.2135, NULL, 0, 1, 0, 100, 0),
    (392110, 32, 8072.9897,  -1609.3593,  1307.5187, NULL, 0, 1, 0, 100, 0),
    (392110, 33, 8205.831,   -1561.8914,  1297.8762, NULL, 0, 1, 0, 100, 0),
    (392110, 34, 8406.739,   -1629.1973,  1286.1545, NULL, 0, 1, 0, 100, 0),
    (392110, 35, 8533.676,   -1761.9286,  1258.0981, NULL, 0, 1, 0, 100, 0),
    (392110, 36, 8525.301,   -1820.4775,  1227.4388, NULL, 0, 1, 0, 100, 0);

UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` = 392110;

-- ---------------------------------------------------------------------------
-- Creatures – TLPD (39211) and Vyragosa (39228) on path 5
-- ---------------------------------------------------------------------------
DELETE FROM `creature` WHERE `guid` = 39211 AND `id` = 32491;
DELETE FROM `creature` WHERE `guid` = 39228 AND `id` = 32630;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
    (39211, 32491, 571, 67, 0, 1, 511, 0, 8545.776, -1879.3956, 1131.0109, 6.2809854, 21600, 0, 0, 1, 0, 2, 0, 0, 0, '', 0, 1, 'Time-Lost Proto Drake - Path 5 (Ulduar)'),
    (39228, 32630, 571, 67, 0, 1, 511, 0, 8545.776, -1879.3956, 1131.0109, 6.2809854, 21600, 0, 0, 1, 0, 2, 0, 0, 0, '', 0, 1, 'Vyragosa - Path 5 (Ulduar)');

-- ---------------------------------------------------------------------------
-- creature_addon – assign waypoint path for path 5 creatures
-- ---------------------------------------------------------------------------
DELETE FROM `creature_addon` WHERE `guid` IN (39211, 39228);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
    (39211, 392110, 0, 0, 0, 0, 0, ''),
    (39228, 392110, 0, 0, 0, 0, 0, '');

-- ---------------------------------------------------------------------------
-- Pool – sub-pool 32496 for path 5, linked into master pool 32491
-- ---------------------------------------------------------------------------
DELETE FROM `pool_template` WHERE `entry` = 32496;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
    (32496, 1, 'Time-Lost Proto Drake / Vyragosa - Path 5 (Ulduar)');

DELETE FROM `pool_creature` WHERE `pool_entry` = 32496;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
    (39211, 32496, 10, 'Time-Lost Proto Drake - Path 5 (Ulduar)'),
    (39228, 32496,  0, 'Vyragosa - Path 5 (Ulduar)');

DELETE FROM `pool_pool` WHERE `pool_id` = 32496 OR `mother_pool` = 32496;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
    (32496, 32491, 0, 'Time-Lost Proto Drake / Vyragosa - Path 5 (Ulduar)');

-- ---------------------------------------------------------------------------
-- spawntimesecs – set 6h (21600s) on all paths so that death-to-visibility
-- totals 6-22h when combined with the 0-16h C++ reveal timer.
-- ---------------------------------------------------------------------------
UPDATE `creature` SET `spawntimesecs` = 21600 WHERE `guid` IN (39203, 39205, 39206) AND `id` = 32491;
UPDATE `creature` SET `spawntimesecs` = 21600 WHERE `guid` IN (39207, 39209, 39210) AND `id` = 32630;
