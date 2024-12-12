-- DB update 2024_11_02_02 -> 2024_11_02_03
DELETE FROM `item_loot_template` WHERE `Entry` = 34077 AND `Item` = 34068;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34077, 34068, 0, 100, 0, 1, 0, 3, 5, 'Crudely Wrapped Gift - Weighted Jack-o\'-Lantern');
