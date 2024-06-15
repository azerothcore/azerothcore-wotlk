-- DB update 2022_07_13_00 -> 2022_07_18_00
--
DELETE FROM `item_loot_template` WHERE (`Entry` = 9265) AND (`Item` IN (9360, 9361));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9265, 9360, 0, 92, 0, 1, 1, 1, 1, 'Cuergo\'s Hidden Treasure - Cuergo\'s Gold'),
(9265, 9361, 0, 0, 0, 1, 1, 1, 1, 'Cuergo\'s Hidden Treasure - Cuergo\'s Gold with worm');
