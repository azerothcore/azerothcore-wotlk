INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638796411490022910');

-- Remove respawn timer from The Holy Spring object
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE `id` = 759 AND `guid` = 10121;

