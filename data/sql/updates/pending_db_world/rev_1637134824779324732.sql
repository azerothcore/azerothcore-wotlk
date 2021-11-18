INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637134824779324732');

SET @newPathId = 42143 * 10;

-- Change Spawn time

UPDATE `creature` SET `spawntimesecs` = 5400, `MovementType` = 2 WHERE `guid` = 42143;


-- Insert new path

UPDATE `creature_addon` SET `path_id` = @newPathId WHERE `guid` = 42143;

INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`)
VALUES
       (@newPathId, 1, 1960, -346, 35.5772, 10000),
       (@newPathId, 2, 1952, -421, 35.5772, 10000),
       (@newPathId, 3, 2046, -419, 35.5772, 10000),
       (@newPathId, 4, 2056, -357, 35.5772, 10000);
