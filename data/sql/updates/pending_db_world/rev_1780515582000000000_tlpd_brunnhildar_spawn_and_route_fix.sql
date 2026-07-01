-- Brunnhildar route (Path 1) spawn and route separation.
-- Spawn position (6821.0693, -1800.8033, 940.85815) is set on the creature only.
-- Waypoints are fully replaced starting at point 1 (first airborne patrol point).
-- The old spawn position (6748.211, -1664.3069, 919.3118) becomes the last loop point.

-- Creature spawn positions for TLPD (guid 39203) and Vyragosa (guid 39207) on Path 1
UPDATE `creature` SET `position_x` = 6821.0693, `position_y` = -1800.8033, `position_z` = 940.85815, `orientation` = 0.8169179 WHERE `guid` = 39203 AND `id` = 32491;
UPDATE `creature` SET `position_x` = 6821.0693, `position_y` = -1800.8033, `position_z` = 940.85815, `orientation` = 0.8169179 WHERE `guid` = 39207 AND `id` = 32630;

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
