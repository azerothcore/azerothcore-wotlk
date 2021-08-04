INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628079063977567436');

-- Deletes Pure Un'goro Sample from Firegut Brute
DELETE FROM `creature_loot_template` WHERE `Entry` = 7035 AND `Item` = 12236;

