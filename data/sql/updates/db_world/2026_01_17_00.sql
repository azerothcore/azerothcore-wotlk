-- DB update 2026_01_16_00 -> 2026_01_17_00
--
DELETE FROM `prospecting_loot_template` WHERE (`Entry` = 23424);
INSERT INTO `prospecting_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23424, 21929, 0, 0, 0, 1, 1, 1, 2, 'Flame Spessarite'),
(23424, 23077, 0, 0, 0, 1, 1, 1, 2, 'Blood Garnet'),
(23424, 23079, 0, 0, 0, 1, 1, 1, 2, 'Deep Peridot'),
(23424, 23107, 0, 0, 0, 1, 1, 1, 2, 'Shadow Draenite'),
(23424, 23112, 0, 0, 0, 1, 1, 1, 2, 'Golden Draenite'),
(23424, 23117, 0, 0, 0, 1, 1, 1, 2, 'Azure Moonstone'),
(23424, 23436, 0, 4, 0, 1, 2, 1, 1, 'Living Ruby'),
(23424, 23437, 0, 4, 0, 1, 2, 1, 1, 'Talasite'),
(23424, 23438, 0, 4, 0, 1, 2, 1, 1, 'Star of Elune'),
(23424, 23439, 0, 4, 0, 1, 2, 1, 1, 'Noble Topaz'),
(23424, 23440, 0, 4, 0, 1, 2, 1, 1, 'Dawnstone'),
(23424, 23441, 0, 4, 0, 1, 2, 1, 1, 'Nightseye');

DELETE FROM `reference_loot_template` WHERE `Entry` = 1000;
