INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631945631125292040');

-- Deletes Hide of Lupos from RLT 24062
DELETE FROM `reference_loot_template` WHERE `Entry` = 24062 AND `Item` = 3018;

