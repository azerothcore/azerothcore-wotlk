INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622644136275319906');

UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 17680;
DELETE FROM `creature_loot_template` WHERE `Entry` = 17680;
