-- DB update 2025_03_16_00 -> 2025_03_16_01
-- Add Relic of Ulduar to loot tables
DELETE FROM `creature_loot_template` WHERE `Entry` IN (27960, 27961, 27962, 27963, 27964, 27965, 27969, 27970, 27971, 27972) AND `Item` = 42780;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27960, 42780, 0, 35, 0, 1, 0, 1, 3, 'Dark Rune Warrior - Relic of Ulduar'),
(27961, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Worker - Relic of Ulduar'),
(27962, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Elementalist - Relic of Ulduar'),
(27963, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Theurgist - Relic of Ulduar'),
(27964, 42780, 0, 36, 0, 1, 0, 1, 3, 'Dark Rune Scholar - Relic of Ulduar'),
(27965, 42780, 0, 38, 0, 1, 0, 1, 3, 'Dark Rune Shaper - Relic of Ulduar'),
(27969, 42780, 0, 30, 0, 1, 0, 1, 3, 'Dark Rune Giant - Relic of Ulduar'),
(27970, 42780, 0, 18, 0, 1, 0, 1, 3, 'Raging Construct - Relic of Ulduar'),
(27971, 42780, 0, 22, 0, 1, 0, 1, 3, 'Unrelenting Construct - Relic of Ulduar'),
(27972, 42780, 0, 19, 0, 1, 0, 1, 3, 'Lightning Construct - Relic of Ulduar');
