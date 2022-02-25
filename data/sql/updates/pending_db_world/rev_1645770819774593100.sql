INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645770819774593100');

UPDATE `creature_loot_template` SET `QuestRequired` = 1 WHERE `Item` IN (21104, 21105);
