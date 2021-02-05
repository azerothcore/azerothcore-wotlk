INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612520952274785900');

-- Lower respawn of Shadowforge Cache

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=40694;
