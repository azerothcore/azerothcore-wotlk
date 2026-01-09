-- DB update 2026_01_05_01 -> 2026_01_05_02
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 31787);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31787, 26002, 26002, 3, 0, 1, 1, 1, 1, 'Citadel Watcher - (ReferenceTable)'),
(31787, 26040, 26040, 25, 0, 1, 0, 1, 1, 'Citadel Watcher - (ReferenceTable)'),
(31787, 35947, 0, 6, 0, 1, 2, 1, 1, 'Citadel Watcher - Sparkling Frostcap'),
(31787, 43624, 0, 0.1, 0, 1, 0, 1, 1, 'Citadel Watcher - Titanium Lockbox'),
(31787, 43851, 0, 20, 0, 1, 3, 1, 1, 'Citadel Watcher - Fur Clothing Scraps'),
(31787, 43852, 0, 15, 0, 1, 3, 1, 1, 'Citadel Watcher - Thick Fur Clothing Scraps'),
(31787, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Citadel Watcher - Book of Glyph Mastery'),
(31787, 33445, 0, 3, 0, 1, 2, 1, 1, 'Citadel Watcher - Honeymint Tea');
