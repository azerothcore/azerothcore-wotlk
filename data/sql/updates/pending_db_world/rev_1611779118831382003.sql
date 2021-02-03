INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611779118831382003');

-- Lower respawn rate of Compendium of the Fallen

UPDATE `gameobject` SET `spawntimesecs`=2 WHERE `guid`=32236;
