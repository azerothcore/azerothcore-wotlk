SET @ITEM = 5773;
SET @ENTRY = 1054;

-- Deletes "Pattern: Robes of Arcana" from Reference Loot #24704
DELETE FROM `reference_loot_template` WHERE `Entry` = 24704 AND `Item` = @ITEM;

-- Creates a reference loot for "Pattern: Robes of Arcana"
DELETE FROM `reference_loot_template` WHERE `Entry` = @ENTRY AND `Item` = @ITEM;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, @ITEM, 0, 100, 0, 1, 0, 1, 1, 'Pattern: Robes of Arcana');

DELETE FROM `creature_loot_template` WHERE `item` = 5773;

-- Adds reference loot for "Pattern: Robes of Arcana" for 
DELETE FROM `creature_loot_template` WHERE `Reference` = @ENTRY AND `Entry` IN (910, 2337, 10760);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(910, @ITEM, @ENTRY, 2, 0, 1, 0, 1, 1, 'Pattern: Robes of Arcana'), -- Defias Enchanter
(2337, @ITEM, @ENTRY, 2, 0, 1, 0, 1, 1, 'Pattern: Robes of Arcana'),--  Dark Strand Voidcalle
(10760, @ITEM, @ENTRY, 2, 0, 1, 0, 1, 1, 'Pattern: Robes of Arcana');-- Grimtotem Geomancer
