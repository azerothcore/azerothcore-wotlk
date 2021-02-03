INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611782665942053526');

-- Lower respawn rate of The Book of Ur

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=40667;
