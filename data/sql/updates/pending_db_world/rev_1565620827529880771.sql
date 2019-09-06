INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1565620827529880771');

UPDATE `creature` SET `MovementType` = 1, `spawndist` = 2 WHERE `map` = 658 AND `id` IN (2110,14881);
