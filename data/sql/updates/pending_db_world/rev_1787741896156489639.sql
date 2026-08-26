--
-- LBRS patrol corrections from 2.5.6.69110 sniff dump_2.5.6.69110_2026-08-26_11-50-34.pkt

-- Add the four-creature Firebrand camp missing from the tunnel between the Smolderthorn and Firebrand areas.
SET @CGUID := 5300679;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID AND @CGUID + 3 AND `id` IN (9259, 9261, 9262);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID + 0, 9259, 229, 0, 0, 1, 1, 1, 24.366007, -580.332825, -18.518145, 2.984513, 10800, 0, 0, 8097, 0, 0, 0, 0, 0, '', 69110, 1, NULL),
(@CGUID + 1, 9261, 229, 0, 0, 1, 1, 1, 19.092764, -581.621094, -18.518145, 0.541052, 10800, 0, 0, 6477, 2163, 0, 0, 0, 0, '', 69110, 1, NULL),
(@CGUID + 2, 9262, 229, 0, 0, 1, 1, 1, 20.906603, -577.482910, -18.518145, 4.817109, 10800, 0, 0, 6477, 3244, 0, 0, 0, 0, '', 69110, 1, NULL),
(@CGUID + 3, 9259, 229, 0, 0, 1, 1, 1, 23.546329, -568.204590, -18.518145, 2.809980, 10800, 0, 0, 8097, 0, 0, 0, 0, 0, '', 69110, 1, NULL);

DELETE FROM `creature_addon` WHERE `guid` = @CGUID + 3;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID + 3, 0, 0, 7, 1, 0, 0, '16093');

-- Correct creatures owning sniff-matched waypoint paths.
UPDATE `creature` SET `id` = 9239, `VerifiedBuild` = 69110 WHERE `guid` = 43527;
UPDATE `creature` SET `id` = 9819, `VerifiedBuild` = 69110 WHERE `guid` = 137933;
UPDATE `creature` SET `id` = 10319, `VerifiedBuild` = 69110 WHERE `guid` = 138002;
UPDATE `creature` SET `id` = 10319, `wander_distance` = 0, `MovementType` = 2, `VerifiedBuild` = 69110 WHERE `guid` = 137992;
UPDATE `creature` SET `id` = 9097, `position_x` = 53.7765, `position_y` = -327.334, `position_z` = 53.916, `orientation` = 1.39626, `wander_distance` = 0, `MovementType` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 138069;
UPDATE `creature` SET `id` = 9098, `position_x` = 82.0901, `position_y` = -286.078, `position_z` = 60.6613, `orientation` = 3.38828, `wander_distance` = 0, `MovementType` = 0, `VerifiedBuild` = 69110 WHERE `guid` = 138047;

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
