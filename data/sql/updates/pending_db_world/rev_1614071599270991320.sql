INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614071599270991320');

-- Create pooling for Copper Veins on Bloodmyst Isle

DELETE FROM `pool_template` WHERE `entry`=11646;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(11646,1,"Copper Veins - Bloodmyst Isle");

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE `guid` IN (120324,120325,120363);

INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(120324,11645,0,"Bloodmyst Isle, Copper Vein, spawn 1"),
(120325,11645,0,"Bloodmyst Isle, Copper Vein, spawn 2"),
(120363,11645,0,"Bloodmyst Isle, Copper Vein, spawn 3");

-- Lower respawn of veins to 1 minute
UPDATE `gameobject` SET `spawntimesecs`=60 WHERE `guid` IN (120324,120325,120363);
