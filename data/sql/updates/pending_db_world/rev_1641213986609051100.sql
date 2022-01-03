INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641213986609051100');

-- Grethok immunity flags
UPDATE `creature_template` SET `mechanic_immune_mask` = 33636209 WHERE (`entry` = 12557);
