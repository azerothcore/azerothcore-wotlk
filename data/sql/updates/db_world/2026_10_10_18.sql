-- DB update 2026_10_10_17 -> 2026_10_10_18
--
SET @CGUID := 75086;
SET @PATH := 75731 * 10;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+1 AND `id` = 21701;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(@CGUID+0, 21701, 530, 1, 1, 1, -3694.19, 1073.53, 56.7576, 3.26377, 180, 0, 0),
(@CGUID+1, 21701, 530, 1, 1, 1, -3694.14, 1069.22, 56.7586, 3.14159, 180, 0, 0);

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 75731 AND `id` = 21701;

DELETE FROM `creature_addon` WHERE `guid` = 75731;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(75731, @PATH, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -3688.81, 1070.93, 56.7577, NULL, 0, 0, 0, 100, 0),
(@PATH, 2, -3750.32, 1072.48, 56.7722, NULL, 0, 0, 0, 100, 0),
(@PATH, 3, -3718.54, 1072.17, 56.8956, NULL, 0, 0, 0, 100, 0);
