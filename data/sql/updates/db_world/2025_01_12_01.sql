-- DB update 2025_01_12_00 -> 2025_01_12_01
DELETE FROM `reference_loot_template` WHERE `Entry` = 34078 AND `Item` = 34029;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24239, 34029, 0, 30, 0, 1, 0, 1, 1, 'Hex Lord Malacrass - Tiny Voodoo Mask');

UPDATE `creature_loot_template` SET `MinCount` = 2, `MaxCount` = 2 WHERE `Entry` = 24239 AND `Reference` = 34078;
