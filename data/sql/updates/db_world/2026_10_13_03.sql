-- DB update 2026_10_13_02 -> 2026_10_13_03
--
SET @NPC := 68779;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `id` = 19256 AND `guid` = @NPC;
DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@NPC, @PATH, 0, 0, 1, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, 59.8979, 2536.76, 64.3227, NULL, 0),
(@PATH, 2, 59.3928, 2545.8, 64.8096, NULL, 0);
