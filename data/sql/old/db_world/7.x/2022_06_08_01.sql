-- DB update 2022_06_08_00 -> 2022_06_08_01
DELETE FROM `item_loot_template` WHERE (`Entry` = 11024) AND (`Item` IN (785, 2449, 2450, 3356, 3357, 3820, 3821, 4625, 8838, 8839, 8846, 49209));
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11024, 49209, 0, 63, 0, 1, 1, 1, 3, 'Evergreen Herb Casing - Mutated Morrowgrain');
