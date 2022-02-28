INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646089487915555800');

SET @NPC := 849;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -12378.6, -963.559, 15.3825, 0, 0),
(@PATH, 2, -12389.1, -960.663, 19.123, 0, 0),
(@PATH, 3, -12402, -953.174, 24.9704, 0, 0),
(@PATH, 4, -12410.9, -950.4, 28.0988, 0, 0),
(@PATH, 5, -12415.9, -942.535, 28.7172, 0, 0),
(@PATH, 6, -12422.5, -930.758, 30.8608, 0, 0),
(@PATH, 7, -12434.3, -915.714, 35.5984, 0, 0),
(@PATH, 8, -12448.6, -909.005, 38.7702, 0, 0),
(@PATH, 9, -12434.3, -915.714, 35.5984, 0, 0),
(@PATH, 10, -12422.5, -930.758, 30.8608, 0, 0),
(@PATH, 11, -12415.9, -942.535, 28.7172, 0, 0),
(@PATH, 12, -12410.9, -950.4, 28.0988, 0, 0),
(@PATH, 13, -12402, -953.174, 24.9704, 0, 0),
(@PATH, 14, -12389.1, -960.663, 19.123, 0, 0),
(@PATH, 15, -12378.6, -963.559, 15.3825, 0, 0),
(@PATH, 16, -12369.5, -963.88, 12.9135, 0, 0);
