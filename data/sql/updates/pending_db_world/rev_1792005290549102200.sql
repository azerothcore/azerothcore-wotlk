UPDATE `creature` SET `MovementType` = 0, `wander_distance` = 0 WHERE `guid` IN (42896, 42898) AND `id` = 15184;
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` IN (42896, 42898);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (42895, 42896, 42897, 42898);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(42895, 42895, 0, 0, 515, 0, 0),
(42895, 42896, 6, 180, 515, 0, 0),
(42897, 42897, 0, 0, 515, 0, 0),
(42897, 42898, 6, 180, 515, 0, 0);

DELETE FROM `waypoint_data` WHERE `id` IN (428960, 428980);
