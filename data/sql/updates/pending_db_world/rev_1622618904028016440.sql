INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622618904028016440');

SET @AKUMAI = 27433;
SET @PATH = @AKUMAI * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @AKUMAI;

DELETE FROM `creature_addon` WHERE `guid` = @AKUMAI;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(@AKUMAI, @PATH, 0, 0, 0, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -835.87, -419.49, -33.8904, 0, 0, 0, 0, 100, 0),
(@PATH, 2, -833.91, -391.22, -33.8904, 1.928, 10000, 0, 0, 100, 0),
(@PATH, 3, -835.87, -419.49, -33.8904, 0, 0, 0, 0, 100, 0),
(@PATH, 4, -832.57, -461.36, -34.0912, 0, 0, 0, 0, 100, 0),
(@PATH, 5, -850.49, -467.74, -34.0226, 0, 0, 0, 0, 100, 0),
(@PATH, 6, -848.45, -453.86, -33.8922, 1.253, 10000, 0, 0, 100, 0);
