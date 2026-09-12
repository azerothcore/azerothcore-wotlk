--
-- Ulduar trash loot: split 10-man and 25-man epic pools correctly

-- Guardian of Life: 10-man pointed at the 25-man pool (34156), 25-man had no pool at all
DELETE FROM `creature_loot_template` WHERE `Entry` IN (33528, 33733);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(33528, 1, 34112, 100, 0, 1, 0, 1, 1, 'Guardian of Life - (ReferenceTable)'),
(33528, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Guardian of Life - Book of Glyph Mastery'),
(33733, 1, 34156, 100, 0, 1, 0, 1, 1, 'Guardian of Life (1) - (ReferenceTable)'),
(33733, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Guardian of Life (1) - Book of Glyph Mastery');

-- Winter Jormungar shared Guardian of Life's loot id; it drops the generic trash loot but no epics
UPDATE `creature_template` SET `lootid` = 34137 WHERE `entry` = 34137;
DELETE FROM `creature_loot_template` WHERE `Entry` IN (34137, 34140);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34137, 1, 34106, 40, 0, 1, 0, 1, 1, 'Winter Jormungar - (ReferenceTable)'),
(34137, 2, 34106, 40, 0, 1, 0, 1, 1, 'Winter Jormungar - (ReferenceTable)'),
(34137, 3, 34107, 20, 0, 1, 0, 1, 1, 'Winter Jormungar - (ReferenceTable)'),
(34137, 4, 34108, 7, 0, 1, 0, 1, 1, 'Winter Jormungar - (ReferenceTable)'),
(34137, 5, 34109, 10, 0, 1, 0, 1, 1, 'Winter Jormungar - (ReferenceTable)'),
(34137, 6, 34110, 3, 0, 1, 0, 1, 1, 'Winter Jormungar - (ReferenceTable)'),
(34137, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Winter Jormungar - Book of Glyph Mastery'),
(34140, 1, 34106, 40, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - (ReferenceTable)'),
(34140, 2, 34106, 40, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - (ReferenceTable)'),
(34140, 3, 34107, 30, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - (ReferenceTable)'),
(34140, 4, 34108, 15, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - (ReferenceTable)'),
(34140, 5, 34109, 20, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - (ReferenceTable)'),
(34140, 6, 34110, 5, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - (ReferenceTable)'),
(34140, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Winter Jormungar (1) - Book of Glyph Mastery');

-- Faceless Horror: both difficulties shared one loot id with no trash pool
UPDATE `creature_template` SET `lootid` = 33773 WHERE `entry` = 33773;
DELETE FROM `creature_loot_template` WHERE `Entry` IN (33772, 33773);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(33772, 1, 34112, 100, 0, 1, 0, 1, 1, 'Faceless Horror - (ReferenceTable)'),
(33772, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Faceless Horror - Book of Glyph Mastery'),
(33773, 1, 34156, 100, 0, 1, 0, 1, 1, 'Faceless Horror (1) - (ReferenceTable)'),
(33773, 45912, 0, 0.1, 0, 1, 0, 1, 1, 'Faceless Horror (1) - Book of Glyph Mastery');

-- 10-man epic pool: Titanstone Pendant is 25-man only, Mimiron's Repeater was missing
DELETE FROM `reference_loot_template` WHERE `Entry` = 34111 AND `Item` IN (45538, 46339);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34111, 46339, 0, 0, 0, 1, 1, 1, 1, 'Mimiron\'s Repeater');
