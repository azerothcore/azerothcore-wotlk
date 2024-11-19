-- DB update 2024_06_25_03 -> 2024_06_25_04
-- loot cleanup
DELETE FROM `creature_loot_template` WHERE `Entry` = 20784 AND `Item` = 31943; -- Armbreaker Huffaz
DELETE FROM `creature_loot_template` WHERE `Entry` = 20785 AND `Item` = 31573; -- Fel Tinkerer Zortan
DELETE FROM `creature_loot_template` WHERE `Entry` = 20786 AND `Item` IN (31929, 31937, 31939, 31940); -- Gul'bor
DELETE FROM `creature_loot_template` WHERE `Entry` = 20788 AND `Item` = 31565; -- Forgosh
DELETE FROM `creature_loot_template` WHERE `Entry` = 20789 AND `Item` = 32520; -- Wrathbringer Laz-tarash
DELETE FROM `creature_loot_template` WHERE `Entry` = 20790 AND `Item` = 31581; -- Malevus the Mad

-- reference time baby
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(20783, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Porfus the Gem Gorger - (ReferenceTable)'),
(20784, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Armbreaker Huffaz - (ReferenceTable)'),
(20785, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Fel Tinkerer Zortan - (ReferenceTable)'),
(20786, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Gul''bor - (ReferenceTable)'),
(20788, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Forgosh - (ReferenceTable)'),
(20789, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Wrathbringer Laz-tarash - (ReferenceTable)'),
(20790, 14501, 14501, 100, 0, 1, 0, 1, 1, 'Malevus the Mad - (ReferenceTable)');
