INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630089240125826910');

-- Decreases the respawntime for Garrick Padfoot to 90 s
UPDATE `creature` SET `spawntimesecs` = 90 WHERE `id` = 103 AND `guid` IN (80247);
