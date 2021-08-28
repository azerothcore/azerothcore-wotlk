INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630089599912305764');

-- Decreases the respawntime for Garrick Padfoot to 60 s (90 s in real time when instantly looted)
UPDATE `creature` SET `spawntimesecs` = 60 WHERE `id` = 103 AND `guid` = 80247;
