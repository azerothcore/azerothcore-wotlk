INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631329691460885909');

-- Set Felix's Box respawn to 10 seconds
UPDATE `gameobject` SET `spawntimesecs` = 10 WHERE `id` = 148499 AND `guid`= 1380;

-- Set Felix's Chest respawn to 10 seconds
UPDATE `gameobject` SET `spawntimesecs` = 10 WHERE `id` = 178084 AND `guid`= 1386;

-- Set Felix's Bucket of Bolts respawn to 10 seconds
UPDATE `gameobject` SET `spawntimesecs` = 10 WHERE `id` = 178085 AND `guid`= 1394;

