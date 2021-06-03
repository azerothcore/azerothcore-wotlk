INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622733528401617288');

UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1
WHERE `guid` IN (9720, 9761, 9981, 10226, 31701, 31706, 31708, 31710);
