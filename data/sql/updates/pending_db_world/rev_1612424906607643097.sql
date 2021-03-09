INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612424906607643097');

-- Lower respawn rate of Pitted Iron Chest

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=32614;
