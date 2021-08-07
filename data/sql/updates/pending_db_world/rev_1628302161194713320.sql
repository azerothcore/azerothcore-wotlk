INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628302161194713320');

-- Disables Fedfennel wandering
UPDATE `creature` SET `MovementType` = 0, `wander_distance` = 0 WHERE `id` = 472 AND `guid` IN (81122, 134000, 134001, 134002);

