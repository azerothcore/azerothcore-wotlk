-- Frozen Lake Path 4 (path 392060) spawn and route separation.
-- Spawn position (6880.4116, -398.9924, 1004.92456) is set on the creature only.
-- Waypoints are fully replaced starting at point 1 (first airborne patrol point).
-- The old spawn position (6954.7627, -472.37695, 997.65027) becomes the last loop point.

-- Creature spawn positions for TLPD (guid 39206) and Vyragosa (guid 39210) on Path 4
UPDATE `creature` SET `position_x` = 6880.4116, `position_y` = -398.9924, `position_z` = 1004.92456, `orientation` = 0.9124172 WHERE `guid` = 39206 AND `id` = 32491;
UPDATE `creature` SET `position_x` = 6880.4116, `position_y` = -398.9924, `position_z` = 1004.92456, `orientation` = 0.9124172 WHERE `guid` = 39210 AND `id` = 32630;

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
