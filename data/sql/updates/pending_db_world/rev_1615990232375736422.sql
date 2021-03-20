INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615990232375736422');

SET
@POOL            = '11651',
@POOLSIZE        = '4',
@POOLDESC        = 'Treasures - Teldrassil',
@GUID = '49528,49529,49621,49622,49623,49624,49625,49626,49627,49628';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(49528,@POOL,0,@POOLDESC),
(49529,@POOL,0,@POOLDESC),
(49621,@POOL,0,@POOLDESC),
(49622,@POOL,0,@POOLDESC),
(49623,@POOL,0,@POOLDESC),
(49624,@POOL,0,@POOLDESC),
(49625,@POOL,0,@POOLDESC),
(49626,@POOL,0,@POOLDESC),
(49627,@POOL,0,@POOLDESC),
(49628,@POOL,0,@POOLDESC);

-- Respawn rates of gameobjects is 5 minutes
UPDATE `gameobject` SET `spawntimesecs`=300 WHERE FIND_IN_SET (`guid`,@GUID);
