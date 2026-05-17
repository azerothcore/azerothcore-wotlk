-- DB update 2026_05_17_02 -> 2026_05_17_03
DELETE FROM `item_loot_template` WHERE (`Entry` = 41888) AND (`Item` IN (41450, 41452, 41466, 41468, 41492, 41497));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(41888, 41450, 0, 16.9, 0, 1, 1, 1, 1, 'Small Velvet Bag - Perfect Balanced Shadow Crystal'),
(41888, 41452, 0, 16.9, 0, 1, 1, 1, 1, 'Small Velvet Bag - Perfect Glowing Shadow Crystal'),
(41888, 41466, 0, 17.7, 0, 1, 1, 1, 1, 'Small Velvet Bag - Perfect Forceful Dark Jade'),
(41888, 41468, 0, 16.3, 0, 1, 1, 1, 1, 'Small Velvet Bag - Perfect Jagged Dark Jade'),
(41888, 41492, 0, 13, 0, 1, 1, 1, 1, 'Small Velvet Bag - Perfect Inscribed Huge Citrine'),
(41888, 41497, 0, 19.3, 0, 1, 1, 1, 1, 'Small Velvet Bag - Perfect Reckless Huge Citrine');
