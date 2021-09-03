INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630679189870696600');

SET @POOL = 60010;
SET @WATERBARREL = 32742;
SET @FOODCRATE = 32287;

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, 1, 'Water Barrel (29275) / Food Crate (30758) - Stormwind City');

DELETE FROM `pool_gameobject`WHERE `pool_entry`=@POOL;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@WATERBARREL, @POOL, 0, 'Water Barrel (29275) - Stormwind City'),
(@FOODCRATE, @POOL, 0, 'Food Crate (30758) - Stormwind City');
