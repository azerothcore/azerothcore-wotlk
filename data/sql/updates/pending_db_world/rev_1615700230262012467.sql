INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615700230262012467');

UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 2852;
DELETE FROM `creature_loot_template` WHERE `Entry` = 2852;
