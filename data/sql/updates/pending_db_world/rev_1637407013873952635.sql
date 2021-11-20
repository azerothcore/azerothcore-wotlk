INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637407013873952635');

-- Reduce Emberstrife's respawn to 5 minutes
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 10321 AND `guid` = 31041;

