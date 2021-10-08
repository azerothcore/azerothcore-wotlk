INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633177696846115469');

-- Change Alanna's Embrace drop chance from Ras Frostwhisper to 0.36% (x2 = 0.72% total)
UPDATE `reference_loot_template` SET `Chance` = 0.36 WHERE `Entry` = 35030 AND `Item` = 13314;

