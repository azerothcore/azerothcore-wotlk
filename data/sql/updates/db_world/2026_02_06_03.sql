-- DB update 2026_02_06_02 -> 2026_02_06_03
-- Vyragosa
UPDATE `creature_template` SET `speed_run` = 1.142857, `unit_flags` = `unit_flags`|64|32768 WHERE (`entry` = 32630);
UPDATE `creature_model_info` SET `CombatReach` = 15 WHERE `DisplayID` = 28110;
-- Time-Lost Proto Drake
UPDATE `creature_template` SET `speed_walk` = 1.44444, `speed_run` = 1.5873, `unit_flags` = `unit_flags`|64|32768 WHERE (`entry` = 32491);
UPDATE `creature_model_info` SET `BoundingRadius` = 0.300000011920928955, `CombatReach` = 5 WHERE `DisplayID` = 26711;

DELETE FROM `script_waypoint` WHERE `entry` = 32491;

SET @GUID := 39203;

DELETE FROM `waypoint_data` WHERE `id` IN ((@GUID)*10, (@GUID+1)*10, (@GUID+2)*10, (@GUID+3)*10);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
-- This is the one in which Time-Lost was found
((@GUID)*10, 1 , 6748.211, -1664.3069, 919.3118  , NULL, 0, 1),
((@GUID)*10, 2 , 6913.308, -1725.2614, 954.7917  , NULL, 0, 1),
((@GUID)*10, 3 , 7167.578, -1501.6945, 962.5693  , NULL, 0, 1),
((@GUID)*10, 4 , 7440.402, -1295.8611, 997.2911  , NULL, 0, 1),
((@GUID)*10, 5 , 7210.9585, -1046.8922, 1006.1796, NULL, 0, 1),
((@GUID)*10, 6 , 6998.4653, -1076.8466, 1024.8191, NULL, 0, 1),
((@GUID)*10, 7 , 6874.249, -1097.3822, 927.736   , NULL, 0, 1),
((@GUID)*10, 8 , 6614.7915, -875.7547, 812.7645  , NULL, 0, 1),
((@GUID)*10, 9 , 6563.2754, -811.7673, 749.87573 , NULL, 0, 1),
((@GUID)*10, 10, 6299.502, -797.57697, 529.12573 , NULL, 0, 1),
((@GUID)*10, 11, 6194.549, -1013.1437, 501.54242 , NULL, 0, 1),
((@GUID)*10, 12, 6319.2544, -1251.6613, 468.6258 , NULL, 0, 1),
((@GUID)*10, 13, 6309.161, -1537.8574, 615.0423  , NULL, 0, 1),

((@GUID+1)*10, 1 , 6455.723, -562.87396, 814.643   , NULL, 0, 1),
((@GUID+1)*10, 2 , 6552.79, -672.2307, 835.29645   , NULL, 0, 1),
((@GUID+1)*10, 3 , 6649.857, -781.58746, 855.9499  , NULL, 0, 1),
((@GUID+1)*10, 4 , 6952.5728, -758.1678, 807.22784 , NULL, 0, 1),
((@GUID+1)*10, 5 , 7057.876, -690.5854, 807.22784  , NULL, 0, 1),
((@GUID+1)*10, 6 , 7070.7056, -460.4938, 821.33875 , NULL, 0, 1),
((@GUID+1)*10, 7 , 7083.6943, -252.1965, 817.78326 , NULL, 0, 1),
((@GUID+1)*10, 8 , 6910.3896, -164.06386, 821.42194, NULL, 0, 1),
((@GUID+1)*10, 9 , 6754.1, -16.06277, 805.08875    , NULL, 0, 1),
((@GUID+1)*10, 10, 6525.3613, -70.11849, 808.1164  , NULL, 0, 1),
((@GUID+1)*10, 11, 6400.468, -192.77023, 704.8667  , NULL, 0, 1),
((@GUID+1)*10, 12, 6312.018, -498.71994, 704.8667  , NULL, 0, 1),
((@GUID+1)*10, 13, 6481.932, -689.96844, 770.06104 , NULL, 0, 1),
((@GUID+1)*10, 14, 6649.857, -781.58746, 855.9499  , NULL, 0, 1),
((@GUID+1)*10, 15, 6952.5728, -758.1678, 807.22784 , NULL, 0, 1),

((@GUID+2)*10, 1 , 6481.932, -689.96844, 770.06104 , NULL, 0, 1),
((@GUID+2)*10, 2 , 6649.857, -781.58746, 855.9499  , NULL, 0, 1),
((@GUID+2)*10, 3 , 6952.5728, -758.1678, 807.22784 , NULL, 0, 1),
((@GUID+2)*10, 4 , 7057.876, -690.5854, 807.22784  , NULL, 0, 1),
((@GUID+2)*10, 5 , 7070.7056, -460.4938, 821.33875 , NULL, 0, 1),
((@GUID+2)*10, 6 , 7083.6943, -252.1965, 817.78326 , NULL, 0, 1),
((@GUID+2)*10, 7 , 6910.3896, -164.06386, 821.42194, NULL, 0, 1),
((@GUID+2)*10, 8 , 6754.1, -16.06277, 805.08875    , NULL, 0, 1),
((@GUID+2)*10, 9 , 6525.3613, -70.11849, 808.1164  , NULL, 0, 1),
((@GUID+2)*10, 10, 6400.468, -192.77023, 704.8667  , NULL, 0, 1),
((@GUID+2)*10, 11, 6312.018, -498.71994, 704.8667  , NULL, 0, 1),

((@GUID+3)*10, 1 , 6954.7627, -472.37695, 997.65027, NULL, 0, 1),
((@GUID+3)*10, 2 , 6903.07, -363.67593, 992.3348   , NULL, 0, 1),
((@GUID+3)*10, 3 , 7002.2744, -270.31137, 908.9182 , NULL, 0, 1),
((@GUID+3)*10, 4 , 7150.6274, -142.2627, 859.1961  , NULL, 0, 1),
((@GUID+3)*10, 5 , 7316.008, -35.80534, 859.1961   , NULL, 0, 1),
((@GUID+3)*10, 6 , 7542.2666, -97.61708, 878.5572  , NULL, 0, 1),
((@GUID+3)*10, 7 , 7667.518, -102.67128, 899.2793  , NULL, 0, 1),
((@GUID+3)*10, 8 , 7794.171, -209.65338, 925.02905 , NULL, 0, 1),
((@GUID+3)*10, 9 , 7899.086, -401.56662, 928.9456  , NULL, 0, 1),
((@GUID+3)*10, 10, 7997.539, -546.96466, 949.58435 , NULL, 0, 1),
((@GUID+3)*10, 11, 8143.803, -636.999, 999.3811    , NULL, 0, 1),
((@GUID+3)*10, 12, 8245.65, -775.7319, 999.3811    , NULL, 0, 1),
((@GUID+3)*10, 13, 8238.106, -987.4192, 983.9922   , NULL, 0, 1),
((@GUID+3)*10, 14, 7946.1025, -1003.7714, 1088.5669, NULL, 0, 1),
((@GUID+3)*10, 15, 7586.955, -1071.2095, 1054.2891 , NULL, 0, 1),
((@GUID+3)*10, 16, 7313.6016, -857.4793, 987.2056  , NULL, 0, 1),
((@GUID+3)*10, 17, 7143.3037, -697.4054, 969.9835  , NULL, 0, 1);

DELETE FROM `creature` WHERE (`id1` = 32491) AND `guid` = 1975840;
DELETE FROM `creature` WHERE `id1` IN (32491, 32630) AND `guid` BETWEEN @GUID AND @GUID+7;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID+0, 32491, 571, 67, 511, 6748.211, -1664.3069, 919.3118, 0, 2700, 2, 58558, 1, NULL),
(@GUID+1, 32491, 571, 67, 511, 6455.723, -562.87396, 814.643, 0, 2700, 2, 58558, 1, NULL),
(@GUID+2, 32491, 571, 67, 511, 6481.932, -689.96844, 770.06104, 0, 2700, 2, 58558, 1, NULL),
(@GUID+3, 32491, 571, 67, 511, 6954.7627, -472.37695, 997.65027, 0, 2700, 2, 58558, 1, NULL),

(@GUID+4, 32630, 571, 67, 511, 6748.211, -1664.3069, 919.3118, 0, 2700, 2, 58558, 1, NULL),
(@GUID+5, 32630, 571, 67, 511, 6455.723, -562.87396, 814.643, 0, 2700, 2, 58558, 1, NULL),
(@GUID+6, 32630, 571, 67, 511, 6481.932, -689.96844, 770.06104, 0, 2700, 2, 58558, 1, NULL),
(@GUID+7, 32630, 571, 67, 511, 6954.7627, -472.37695, 997.65027, 0, 2700, 2, 58558, 1, NULL);

DELETE FROM `pool_template` WHERE `entry` = 32491;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(32491, 1, 'Time-Lost Proto Drake / Vyragosa');

DELETE FROM `pool_template` WHERE `entry` BETWEEN 32492 AND 32495;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(32492, 1, 'Time-Lost Proto Drake / Vyragosa - Path 1'),
(32493, 1, 'Time-Lost Proto Drake / Vyragosa - Path 2'),
(32494, 1, 'Time-Lost Proto Drake / Vyragosa - Path 3'),
(32495, 1, 'Time-Lost Proto Drake / Vyragosa - Path 4');

DELETE FROM `pool_pool` WHERE `mother_pool` = 32491;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(32492, 32491, 0, 'Time-Lost Proto Drake / Vyragosa - Path 1'),
(32493, 32491, 0, 'Time-Lost Proto Drake / Vyragosa - Path 2'),
(32494, 32491, 0, 'Time-Lost Proto Drake / Vyragosa - Path 3'),
(32495, 32491, 0, 'Time-Lost Proto Drake / Vyragosa - Path 4');

DELETE FROM `pool_creature` WHERE `pool_entry` BETWEEN 32491 AND 32495;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
-- Seen Time-Lost 1 in 12 sniffs
(@GUID, 32492, 10, 'Time-Lost Proto Drake - Path 1'),
(@GUID+4, 32492, 0, 'Vyragosa - Path 1'),

(@GUID+1, 32493, 10, 'Time-Lost Proto Drake - Path 2'),
(@GUID+5, 32493, 0, 'Vyragosa - Path 2'),

(@GUID+2, 32494, 10, 'Time-Lost Proto Drake - Path 3'),
(@GUID+6, 32494, 0, 'Vyragosa - Path 3'),

(@GUID+3, 32495, 10, 'Time-Lost Proto Drake - Path 4'),
(@GUID+7, 32495, 0, 'Vyragosa - Path 4');

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @GUID+0 AND @GUID+7;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@GUID+0, (@GUID+0)*10, 0, 0, 0, 0, 0, ''),
(@GUID+1, (@GUID+1)*10, 0, 0, 0, 0, 0, ''),
(@GUID+2, (@GUID+2)*10, 0, 0, 0, 0, 0, ''),
(@GUID+3, (@GUID+3)*10, 0, 0, 0, 0, 0, ''),

(@GUID+4, (@GUID+0)*10, 0, 0, 0, 0, 0, ''),
(@GUID+5, (@GUID+1)*10, 0, 0, 0, 0, 0, ''),
(@GUID+6, (@GUID+2)*10, 0, 0, 0, 0, 0, ''),
(@GUID+7, (@GUID+3)*10, 0, 0, 0, 0, 0, '');
