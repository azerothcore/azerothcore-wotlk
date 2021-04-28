INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619629615739305133');

SET
@POOL            = 11657,
@POOLSIZE        = 5,
@POOLDESC        = 'Treasures - Alterac Mountains',
@RESPAWN         = 900,
@GUID = '33304,33206,33207,33200,33193,33208';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(33304,@POOL,0,@POOLDESC),
(33206,@POOL,0,@POOLDESC),
(33207,@POOL,0,@POOLDESC),
(33200,@POOL,0,@POOLDESC),
(33193,@POOL,0,@POOLDESC),
(33208,@POOL,0,@POOLDESC);

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);

