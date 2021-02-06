INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612528921944990905');

-- Lower respawn of Tablet of Will from 24h to 2s

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=40688;
