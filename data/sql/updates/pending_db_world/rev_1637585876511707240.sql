INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637585876511707240');

-- Change Treant's Bane drop rate from Gordok Tribute
UPDATE `reference_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 12007 AND `Item` = 18538;

