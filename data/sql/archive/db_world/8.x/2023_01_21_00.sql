-- DB update 2023_01_19_00 -> 2023_01_21_00

SET @POOL = 60011;
SET @MILKBARREL = 33607;
SET @FOODCRATE = 31401;

DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL, 1, 'Milk Barrel (33607) / Food Crate (31401) - Stormwind City');

DELETE FROM `pool_gameobject` WHERE `pool_entry`=@POOL;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@MILKBARREL, @POOL, 0, 'Milk Barrel (33607) - Stormwind City'),
(@FOODCRATE, @POOL, 0, 'Food Crate (31401) - Stormwind City');
