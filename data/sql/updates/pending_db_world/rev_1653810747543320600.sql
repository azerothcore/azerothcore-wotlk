--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2953);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2953, 0, 11111, 0.2, 0, 1, 0, 1, 1, 'Bristleback Shaman - (Small Pouch ReferenceTable)'),
(2953, 0, 20000, 30, 0, 1, 0, 1, 1, 'Bristleback Shaman - (Grey 1-5 EXP 0 ReferenceTable)'),
(2953, 0, 20014, 30, 0, 1, 0, 1, 1, 'Bristleback Shaman - (Food 1-5 EXP 0 ReferenceTable)'),
(2953, 1388, 0, 2, 0, 1, 0, 1, 1, 'Bristleback Shaman - Crooked Staff'),
(2953, 4770, 0, 90, 1, 1, 0, 1, 1, 'Bristleback Shaman - Bristleback Belt'),
(2953, 6634, 0, 80, 1, 1, 0, 1, 1, 'Bristleback Shaman - Ritual Salve');
