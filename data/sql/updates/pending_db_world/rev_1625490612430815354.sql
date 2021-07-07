INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625490612430815354');

-- Remove Whit Wantmal's loot table
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 275;
DELETE FROM `creature_loot_template` WHERE `Entry` = 275;
