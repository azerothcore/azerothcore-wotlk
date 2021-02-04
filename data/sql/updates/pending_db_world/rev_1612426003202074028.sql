INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612426003202074028');

-- Lower respawn of Mythology of the Titans

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=15008;
