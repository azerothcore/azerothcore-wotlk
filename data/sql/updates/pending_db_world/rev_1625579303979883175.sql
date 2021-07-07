INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625579303979883175');

-- Correct Glasshide Gazer position and movement
UPDATE `creature`  SET `position_z` = 16.25, `MovementType` = 1, `wander_distance` = 25 where `id` = 5420 AND `guid` = 21996;
