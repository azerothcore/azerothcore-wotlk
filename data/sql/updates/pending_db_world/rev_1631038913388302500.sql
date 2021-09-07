INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631038913388302500');

DELETE FROM `creature_loot_template` WHERE `Entry`=193 AND `Item`=34535;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(193, 34535, 0, 0.1, 0, 1, 0, 1, 1, 'Blue Dragonspawn - Azure Whelpling');

