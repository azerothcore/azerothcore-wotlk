INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612530048757741422');

-- Lower respawn of Thermaplugg's Safe from 24h to 2s

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=32387;
