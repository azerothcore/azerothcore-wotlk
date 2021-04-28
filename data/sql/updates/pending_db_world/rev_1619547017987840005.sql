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
(30169,@POOL,0,'Solid Chest, Desolace, node 1'),
(85697,@POOL,0,'Solid Chest, Desolace, node 2'),
(30170,@POOL,0,'Solid Chest, Desolace, node 3'),
(85853,@POOL,0,'Solid Chest, Desolace, node 4'),
(30171,@POOL,0,'Solid Chest, Desolace, node 5'),
(85852,@POOL,0,'Solid Chest, Desolace, node 6'),
(85712,@POOL,0,'Solid Chest, Desolace, node 7'),
(30178,@POOL,0,'Solid Chest, Desolace, node 8'),
(85863,@POOL,0,'Solid Chest, Desolace, node 9'),
(30183,@POOL,0,'Solid Chest, Desolace, node 10'),
(85713,@POOL,0,'Solid Chest, Desolace, node 11'),
(85862,@POOL,0,'Solid Chest, Desolace, node 12'),
(30182,@POOL,0,'Solid Chest, Desolace, node 13'),
(30184,@POOL,0,'Solid Chest, Desolace, node 14'),
(85861,@POOL,0,'Solid Chest, Desolace, node 15');

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);
UPDATE `gameobject` SET `zoneId`= '405' WHERE FIND_IN_SET (`guid`,@GUID);

