INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622849161495010100');

UPDATE `creature` SET `wander_distance` = 5 WHERE `guid` IN (3713, 3863, 3878);
