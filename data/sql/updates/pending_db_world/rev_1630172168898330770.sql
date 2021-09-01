INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630172168898330770');

-- Bloodsail Charts
UPDATE `gameobject` SET `spawntimesecs` = 180 WHERE `id` = 2086 AND `guid` = 12154;
-- Bloodsail Orders
UPDATE `gameobject` SET `spawntimesecs` = 180 WHERE `id` = 2087 AND `guid` = 12156;
