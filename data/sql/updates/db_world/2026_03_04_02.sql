-- DB update 2026_03_04_01 -> 2026_03_04_02
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 30260) AND (`Item` IN (45912, 1, 2));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30260, 1, 1200077, 0, 0, 1, 5, 1, 1, 'Stoic Mammoth - World Loot Level 77'),
(30260, 2, 1200078, 0, 0, 1, 5, 1, 1, 'Stoic Mammoth - World Loot Level 78');
