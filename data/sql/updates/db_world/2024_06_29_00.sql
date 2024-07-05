-- DB update 2024_06_28_04 -> 2024_06_29_00
DELETE FROM `item_loot_template` WHERE `Entry` = 35512;
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(35512, 17202, 0, 100, 0, 1, 0, 2, 5, 'Pocket Full of Snow - Snowball');
