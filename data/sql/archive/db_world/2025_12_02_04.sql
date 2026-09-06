-- DB update 2025_12_02_03 -> 2025_12_02_04
-- Seething Revenant (30387) - Add missing loot
-- Closes https://github.com/azerothcore/azerothcore-wotlk/issues/23807

UPDATE `creature_loot_template` SET `Chance` = 0.04 WHERE `Entry` = 30387 AND `Item` = 45912;

DELETE FROM `creature_loot_template` WHERE `Entry` = 30387 AND `Item` IN (39512, 42780, 37702, 39513, 43624, 42173, 42175, 26001, 26002, 26013, 26014, 26015, 26027, 26028, 35074);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30387, 39512, 0, 56, 0, 1, 0, 1, 1, 'Seething Revenant - Hoary Crystals'),
(30387, 42780, 0, 26, 0, 1, 0, 1, 1, 'Seething Revenant - Relic of Ulduar'),
(30387, 37702, 0, 19, 0, 1, 0, 1, 2, 'Seething Revenant - Crystallized Fire'),
(30387, 39513, 0, 14, 0, 1, 0, 1, 1, 'Seething Revenant - Efflorescing Shards'),
(30387, 43624, 0, 0.01, 0, 1, 0, 1, 1, 'Seething Revenant - Titanium Lockbox'),
(30387, 42173, 0, 0.005, 0, 1, 0, 1, 1, 'Seething Revenant - Pattern: Blue Lumberjack Shirt'),
(30387, 42175, 0, 0.005, 0, 1, 0, 1, 1, 'Seething Revenant - Pattern: Green Lumberjack Shirt'),
(30387, 26001, 26001, 3, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 26002, 26002, 3, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 26013, 26013, 1, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 26014, 26014, 1, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 26015, 26015, 1, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 26027, 26027, 0.5, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 26028, 26028, 0.5, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)'),
(30387, 35074, 35074, 0.1, 0, 1, 1, 1, 1, 'Seething Revenant - (ReferenceTable)');
