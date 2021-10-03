INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632479021658969480');

-- Decreases the respawn time for Colonel Kurzen to 5 min
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 813 AND `guid` = 1481;
