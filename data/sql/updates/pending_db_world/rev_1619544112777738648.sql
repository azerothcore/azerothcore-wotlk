INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619544112777738648');

SET
@POOL            = 11655,
@POOLSIZE        = 5,
@POOLDESC        = 'Treasures - Arathi Highlands',
@RESPAWN         = 900,
@GUID = '16648,100067,16950,85851,100068,16946,87385,85710,16794,16949,100070,16978,16789,16977';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(16648,@POOL,0,@POOLDESC),
(100067,@POOL,0,@POOLDESC),
(16950,@POOL,0,@POOLDESC),
(85851,@POOL,0,@POOLDESC),
(100068,@POOL,0,@POOLDESC),
(16946,@POOL,0,@POOLDESC),
(87385,@POOL,0,@POOLDESC),
(85710,@POOL,0,@POOLDESC),
(16794,@POOL,0,@POOLDESC),
(16949,@POOL,0,@POOLDESC),
(100070,@POOL,0,@POOLDESC),
(16978,@POOL,0,@POOLDESC),
(16789,@POOL,0,@POOLDESC),
(16977,@POOL,0,@POOLDESC);

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);

