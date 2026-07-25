-- DB update 2025_07_24_03 -> 2025_07_25_00
--
SET @CHEST_DROP_CHANCE := 5;
SET @LEGS_DROP_CHANCE := 15;

-- Remove rare loot
DELETE FROM `creature_loot_template` WHERE (`Entry` IN (16143, 16380, 14697, 16379)) AND (`Item` IN (23090, 23087, 23078, 23088, 23082, 23092, 23081, 23089, 23093, 23091, 23084, 23085));

DELETE FROM `creature_loot_template` WHERE (`Entry` = 16143) AND (`Item` IN (43072, 43069, 43080, 43076));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16143, 43072, 0, @CHEST_DROP_CHANCE, 0, 1, 1, 1, 1, 'Shadow of Doom - Blessed Robe of Undead Cleansing'),
(16143, 43069, 0, @CHEST_DROP_CHANCE, 0, 1, 1, 1, 1, 'Shadow of Doom - Blessed Breastplate of Undead Slaying'),
(16143, 43080, 0, @CHEST_DROP_CHANCE, 0, 1, 1, 1, 1, 'Shadow of Doom - Blessed Hauberk of Undead Slaying'),
(16143, 43076, 0, @CHEST_DROP_CHANCE, 0, 1, 1, 1, 1, 'Shadow of Doom - Blessed Tunic of Undead Slaying');

DELETE FROM `reference_loot_template` WHERE (`Entry` = 14697) AND (`Item` IN (43075, 43071, 43083, 43079));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14697, 43075, 0, @LEGS_DROP_CHANCE, 0, 1, 1, 1, 1, 'Blessed Trousers of Undead Cleansing'),
(14697, 43071, 0, @LEGS_DROP_CHANCE, 0, 1, 1, 1, 1, 'Blessed Legplates of Undead Slaying'),
(14697, 43083, 0, @LEGS_DROP_CHANCE, 0, 1, 1, 1, 1, 'Blessed Greaves of Undead Slaying'),
(14697, 43079, 0, @LEGS_DROP_CHANCE, 0, 1, 1, 1, 1, 'Blessed Leggings of Undead Slaying');

DELETE FROM `creature_loot_template` WHERE (`Entry` IN (16380, 14697, 16379)) AND (`Reference` = 14697);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16380, 0, 14697, 100, 0, 1, 0, 1, 1, 'Bone Witch - (ReferenceTable)'),
(14697, 0, 14697, 100, 0, 1, 0, 1, 1, 'Lumbering Horror - (ReferenceTable)'),
(16379, 0, 14697, 100, 0, 1, 0, 1, 1, 'Spirit of the Damned - (ReferenceTable)');

-- Necrotic Rune 30 for Shadow of Doom
UPDATE `creature_loot_template` SET `Chance` = 100, `MinCount` = 30, `MaxCount` = 30 WHERE  `Entry` = 16143 AND `Item` = 22484;
-- Necrotic Rune 2-3 for rare spawns
UPDATE `creature_loot_template` SET `Chance` = 100, `MinCount` = 2, `MaxCount` = 3 WHERE `Entry` IN (14697, 16379, 16380) AND `Item` = 22484;
