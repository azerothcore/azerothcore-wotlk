INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1518477962308987200');

DELETE FROM `item_loot_template` WHERE `Entry` = 54537 AND `Item` = 49426;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(54537, 49426, 0, 100, 0, 1, 0, 2, 2, '');
