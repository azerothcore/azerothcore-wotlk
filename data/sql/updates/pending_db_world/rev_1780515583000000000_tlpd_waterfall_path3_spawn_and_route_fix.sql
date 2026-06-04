-- Waterfall Path 3 (path 392050) spawn and route separation.
-- Spawn position (6550.9775, -671.7839, 834.73395) is set on the creature only.
-- Waypoints are fully replaced starting at point 1 (first airborne patrol point).
-- The old spawn position (6481.932, -689.96844, 770.06104) becomes the last loop point.

-- Creature spawn positions for TLPD (guid 39205) and Vyragosa (guid 39209) on Path 3
UPDATE `creature` SET `position_x` = 6550.9775, `position_y` = -671.7839, `position_z` = 834.73395, `orientation` = 5.51175 WHERE `guid` IN (39205, 39209);

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
    (392050, 11, 6481.932,   -689.96844,  770.06104, NULL, 0, 1);

UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` = 392050;
