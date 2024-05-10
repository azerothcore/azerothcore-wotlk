-- DB update 2022_09_19_00 -> 2022_09_19_01
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 1675);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1675, 159, 0, 6, 0, 1, 2, 1, 1, 'Rot Hide Mongrel - Refreshing Spring Water'),
(1675, 2589, 0, 44, 0, 1, 0, 1, 2, 'Rot Hide Mongrel - Linen Cloth'),
(1675, 2834, 0, 31, 1, 1, 0, 1, 1, 'Rot Hide Mongrel - Embalming Ichor'),
(1675, 4604, 0, 11, 0, 1, 2, 1, 1, 'Rot Hide Mongrel - Forest Mushroom Cap'),
(1675, 11111, 11111, 0.1, 0, 1, 0, 1, 1, 'Rot Hide Mongrel - (ReferenceTable)'),
(1675, 24073, 24073, 30, 0, 1, 1, 1, 1, 'Rot Hide Mongrel - (ReferenceTable)'),
(1675, 24100, 24100, 5, 0, 1, 1, 1, 1, 'Rot Hide Mongrel - (ReferenceTable)'),
(1675, 24720, 24720, 1, 0, 1, 1, 1, 1, 'Rot Hide Mongrel - (ReferenceTable)'),
(1675, 24730, 24730, 1, 0, 1, 1, 1, 1, 'Rot Hide Mongrel - (ReferenceTable)'),
(1675, 44007, 44007, 0.5, 0, 1, 1, 1, 1, 'Rot Hide Mongrel - (ReferenceTable)');
