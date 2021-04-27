INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619547017987840005');

SET
@POOL            = 11656,
@POOLSIZE        = 5,
@POOLDESC        = 'Treasures - Desolace',
@RESPAWN         = 900,
@GUID = '30169,85697,30170,85853,30171,85852,85712,30178,85863,30183,85713,85862,30182,30184,85861';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(30169,@POOL,0,@POOLDESC),
(85697,@POOL,0,@POOLDESC),
(30170,@POOL,0,@POOLDESC),
(85853,@POOL,0,@POOLDESC),
(30171,@POOL,0,@POOLDESC),
(85852,@POOL,0,@POOLDESC),
(85712,@POOL,0,@POOLDESC),
(30178,@POOL,0,@POOLDESC),
(85863,@POOL,0,@POOLDESC),
(30183,@POOL,0,@POOLDESC),
(85713,@POOL,0,@POOLDESC),
(85862,@POOL,0,@POOLDESC),
(30182,@POOL,0,@POOLDESC),
(30184,@POOL,0,@POOLDESC),
(85861,@POOL,0,@POOLDESC);

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);

