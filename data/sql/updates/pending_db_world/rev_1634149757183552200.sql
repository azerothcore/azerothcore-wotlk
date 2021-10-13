INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634149757183552200');

DELETE FROM `item_loot_template` WHERE `entry`=9265 AND `item` IN (9361,9360);
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(9265, 9360, 0, 86, 0, 1, 0, 1, 1, 'Cuergo\'s Hidden Treasure - Cuergo\'s Gold'),
(9265, 9361, 0, 8, 0, 1, 0, 1, 1, 'Cuergo\'s Hidden Treasure - Cuergo\'s Gold with worm');
