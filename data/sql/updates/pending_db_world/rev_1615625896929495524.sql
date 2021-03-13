INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615625896929495524');

-- Decrease respawn rate to 10m
UPDATE `creature` SET `spawntimesecs`=600 WHERE `guid`=2169;
