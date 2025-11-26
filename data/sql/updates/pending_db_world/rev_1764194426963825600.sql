SET @ITEM = 5773;
SET @ENTRY = 1054;

-- Deletes "Pattern: Robes of Arcana" from Reference Loot #24704
DELETE FROM `reference_loot_template` WHERE `Entry` = 24704 AND `Item` = @ITEM;

-- Creates a reference loot for "Pattern: Robes of Arcana"
DELETE FROM `reference_loot_template` WHERE `Entry` = @ENTRY AND `Item` = @ITEM;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@ENTRY, @ITEM, 0, 100, 0, 1, 1, 1, 1, 'Pattern: Robes of Arcana');

-- Deletes "Pattern: Robes of Arcana" from every creature's loot
DELETE FROM `creature_loot_template` WHERE `item` = 5773;

-- Adds reference loot for "Pattern: Robes of Arcana" for each creature below
DELETE FROM `creature_loot_template` WHERE `Reference` = @ENTRY AND `Entry` IN (910, 2337, 10760);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(910, @ITEM, @ENTRY, 2, 0, 1, 0, 1, 1, 'Defias Enchanter - Pattern: Robes of Arcana'),
(2337, @ITEM, @ENTRY, 2, 0, 1, 0, 1, 1, 'Dark Strand Voidcalle - Pattern: Robes of Arcana'),
(10760, @ITEM, @ENTRY, 2, 0, 1, 0, 1, 1, 'Grimtotem Geomancer - Pattern: Robes of Arcana');
