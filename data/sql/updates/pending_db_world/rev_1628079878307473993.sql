INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628079878307473993');

-- Delete lvl 75 plans from Galak Windchaser
DELETE FROM `creature_loot_template` WHERE `Entry` = 4096 AND `Item` IN (30302, 30322);

