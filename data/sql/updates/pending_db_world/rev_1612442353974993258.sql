INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612442353974993258');

-- Faster respawn of Jordan's Hammer

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=40668;
