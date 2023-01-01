-- DB update 2023_01_01_01 -> 2023_01_01_02
--
DELETE FROM `prospecting_loot_template` WHERE (`Entry` = 23425);
INSERT INTO `prospecting_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23425, 1, 13001, 100, 0, 1, 1, 1, 1, '(ReferenceTable)'),
(23425, 2, 13002, 24, 0, 1, 1, 1, 1, '(ReferenceTable)'),
(23425, 3, 13001, 15, 0, 1, 1, 1, 1, '(ReferenceTable)'),
(23425, 24243, 0, 100, 0, 1, 0, 1, 1, 'Adamantite Powder');
