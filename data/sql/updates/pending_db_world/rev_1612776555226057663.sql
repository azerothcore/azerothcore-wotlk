INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612776555226057663');

-- Lower respawn of Keanna's Log

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=27819;
