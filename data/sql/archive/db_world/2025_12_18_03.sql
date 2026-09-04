-- DB update 2025_12_18_02 -> 2025_12_18_03
--
DELETE FROM `disenchant_loot_template` WHERE `Entry` IN (15, 16, 34, 35);
INSERT INTO `disenchant_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15, 34053, 0, 0, 0, 1, 1, 1, 1, 'Small Dream Shard'),
(15, 34054, 0, 75, 0, 1, 1, 1, 3, 'Infinite Dust'),
(15, 34056, 0, 22, 0, 1, 1, 1, 2, 'Lesser Cosmic Essence'),
(16, 34052, 0, 0, 0, 1, 1, 1, 1, 'Dream Shard'),
(16, 34054, 0, 75, 0, 1, 1, 4, 7, 'Infinite Dust'),
(16, 34055, 0, 22, 0, 1, 1, 1, 2, 'Greater Cosmic Essence'),
(34, 34053, 0, 0, 0, 1, 1, 1, 1, 'Small Dream Shard'),
(34, 34054, 0, 22, 0, 1, 1, 1, 3, 'Infinite Dust'),
(34, 34056, 0, 75, 0, 1, 1, 1, 2, 'Lesser Cosmic Essence'),
(35, 34052, 0, 0, 0, 1, 1, 1, 1, 'Dream Shard'),
(35, 34054, 0, 22, 0, 1, 1, 4, 7, 'Infinite Dust'),
(35, 34055, 0, 75, 0, 1, 1, 1, 2, 'Greater Cosmic Essence');
