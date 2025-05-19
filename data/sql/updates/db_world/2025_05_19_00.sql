-- DB update 2025_05_18_00 -> 2025_05_19_00
-- Deletes `Dalaran Wizard's Robe` (5110) from References: `World Drop - White World Drop - NPC Levels` 14-15 (1011415), 15-15 (1011515), 15-16 (1011516), 16-16 (1011616)
DELETE FROM `reference_loot_template` WHERE `Item` = 5110;

DELETE FROM `creature_loot_template` WHERE `Item` = 5110;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1867, 5110, 0, 3, 0, 1, 0, 1, 1, 'Dalaran Apprentice - Dalaran Wizard\'s Robe'),
(1888, 5110, 0, 4, 0, 1, 0, 1, 1, 'Dalaran Watcher - Dalaran Wizard\'s Robe'),
(1889, 5110, 0, 4, 0, 1, 0, 1, 1, 'Dalaran Wizard - Dalaran Wizard\'s Robe'),
(1912, 5110, 0, 3, 0, 1, 0, 1, 1, 'Dalaran Protector - Dalaran Wizard\'s Robe'),
(1913, 5110, 0, 4, 0, 1, 0, 1, 1, 'Dalaran Warder - Dalaran Wizard\'s Robe'),
(1914, 5110, 0, 3, 0, 1, 0, 1, 1, 'Dalaran Mage - Dalaran Wizard\'s Robe'),
(1915, 5110, 0, 4, 0, 1, 0, 1, 1, 'Dalaran Conjuror - Dalaran Wizard\'s Robe'),
(1920, 5110, 0, 1.6, 0, 1, 0, 1, 1, 'Dalaran Spellscribe - Dalaran Wizard\'s Robe'),
(2120, 5110, 0, 1.8, 0, 1, 0, 1, 1, 'Archmage Ataeric - Dalaran Wizard\'s Robe'),
(3577, 5110, 0, 4, 0, 1, 0, 1, 1, 'Dalaran Brewmaster - Dalaran Wizard\'s Robe'),
(3578, 5110, 0, 3, 0, 1, 0, 1, 1, 'Dalaran Miner - Dalaran Wizard\'s Robe');
