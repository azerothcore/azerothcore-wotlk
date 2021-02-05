INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612532175395999264');

-- Lower respawn of Scourge Data

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=27880;
