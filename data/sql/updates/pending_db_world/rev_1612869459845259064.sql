INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612869459845259064');

-- Increase drop rate of Healthy Dragon Scale

UPDATE `creature_loot_template` SET `Chance`=20 WHERE `Item` = 13920 AND `reference` = 0;
