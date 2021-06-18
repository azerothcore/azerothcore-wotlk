INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623792334812044570');

SET @POOL = 60004;
SET @WATERBARREL = 1462;
SET @FOODCRATE = 10677;

DELETE FROM `pool_template` WHERE `entry` = @POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (@POOL, 1, 'Water Barrel (1462) / Food Crate (10677) - Kharanos');

DELETE FROM `pool_gameobject` WHERE `guid` IN (@WATERBARREL, @FOODCRATE) AND `pool_entry` = @POOL;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@WATERBARREL, @POOL, 0, 'Water Barrel (1462) - Kharanos'),
(@FOODCRATE, @POOL, 0, 'Food Crate (10677) - Kharanos');
