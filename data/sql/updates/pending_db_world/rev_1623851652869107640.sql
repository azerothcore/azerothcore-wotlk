INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623851652869107640');

-- Reduce Plans: Copper Chain Vest drop rate for Siltfin Murloc and Mistbat
UPDATE `creature_loot_template` SET `Chance` = 0.3 WHERE `entry` IN (17190, 16353) AND `item` = 3609;


