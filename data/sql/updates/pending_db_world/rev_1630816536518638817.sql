INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630816536518638817');

-- Delete Arena Spoils items from arena team loot tables
DELETE FROM `creature_loot_template` WHERE `Entry` IN (16049, 16050, 16051, 16052, 16055, 16058, 16095);

-- Clear loot tables for arena team
UPDATE `creature_template` SET `lootid` = 0 WHERE `Entry` IN (16049, 16050, 16051, 16052, 16055, 16058, 16095);

