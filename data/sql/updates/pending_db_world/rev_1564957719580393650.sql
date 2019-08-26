INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1564957719580393650');

UPDATE `creature` SET `MovementType` = 1, `spawndist` = 5 WHERE `id` IN (30260,30422);
