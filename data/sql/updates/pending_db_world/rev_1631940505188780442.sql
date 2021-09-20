INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631940505188780442');

-- Deletes Black Lotus from all NPC loot tables
DELETE FROM `creature_loot_template` WHERE `item` = 13468 AND `comment` LIKE '%Black Lotus%';

