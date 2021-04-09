INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617988329167837335');

-- Create pooling, 11651 is the latest+2 entry in `pool_template`
DELETE FROM `pool_template` WHERE `entry` IN (11651);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(11651,1,"Solid Chests, Northfold Manor");

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE `guid` IN (16946,100068);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(16946,11651,0,"Solid Chests, Northfold Manor, node 1"),
(100068,11651,0,"Solid Chests, Northfold Manor, node 2");

-- Set spawn time to 15 minutes
UPDATE `gameobject` SET `spawntimesecs`=900 WHERE `guid` IN (16946,100068);

