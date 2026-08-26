--
-- LBRS patrol corrections from 2.5.6.69110 sniff dump_2.5.6.69110_2026-08-26_11-50-34.pkt

-- Correct creatures owning sniff-matched waypoint paths.
UPDATE `creature` SET `id1` = 9239, `id2` = 0, `id3` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 43527;
UPDATE `creature` SET `id1` = 9819, `id2` = 0, `id3` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 137933;
UPDATE `creature` SET `id1` = 10319, `id2` = 0, `id3` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 138002;
UPDATE `creature` SET `id1` = 10319, `id2` = 0, `id3` = 0, `wander_distance` = 0, `MovementType` = 2, `VerifiedBuild` = 69110 WHERE `guid` = 137992;
UPDATE `creature` SET `id1` = 9097, `id2` = 0, `id3` = 0, `position_x` = 53.7765, `position_y` = -327.334, `position_z` = 53.916, `orientation` = 1.39626, `wander_distance` = 0, `MovementType` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 138069;
UPDATE `creature` SET `id1` = 9098, `id2` = 0, `id3` = 0, `position_x` = 82.0901, `position_y` = -286.078, `position_z` = 60.6613, `orientation` = 3.38828, `wander_distance` = 0, `MovementType` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 138047;

-- Remove the duplicate Scarshield Acolyte occupying the Blackhand Iron Guard's home position.
DELETE FROM `creature_addon` WHERE `guid` IN (137992, 138004, 138047, 138069);
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (137992, 138004, 138026, 138046, 138047, 138069);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (137992, 138004, 138026, 138046, 138047, 138069);
DELETE FROM `creature` WHERE `guid` = 138004;

-- Transfer the exact sniff-matched route from the duplicate Acolyte to the Iron Guard.
DELETE FROM `creature_addon` WHERE `guid` = 137992;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(137992, 1379920, 0, 0, 1, 0, 0, NULL);

-- The sniff keeps both Scarshield pairs at a median separation of two yards.
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (138026, 138046);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (138026, 138046, 138047, 138069);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(138026, 138026, 0, 0, 515, 0, 0),
(138026, 138069, 2, 90, 515, 0, 0),
(138046, 138046, 0, 0, 515, 0, 0),
(138046, 138047, 2, 90, 515, 0, 0);

-- Followers use formation movement instead of independent paths that drift out of sync after combat or evade.
DELETE FROM `waypoint_data` WHERE `id` IN (1379920, 1380040, 1380470, 1380690);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(1379920, 1, 33.2388, -451.331, 110.947, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 2, 27.8349, -467.173, 110.954, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 3, 22.5882, -486.309, 110.945, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 4, 21.3946, -495.946, 110.941, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 5, 22.5882, -486.309, 110.945, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 6, 27.8349, -467.173, 110.954, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 7, 33.2388, -451.331, 110.947, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 8, 32.9856, -441.198, 110.948, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 9, 33.2187, -432.523, 110.949, NULL, 0, 0, 0, 0, 0, 100, 0),
(1379920, 10, 32.9856, -441.198, 110.948, NULL, 0, 0, 0, 0, 0, 100, 0);
