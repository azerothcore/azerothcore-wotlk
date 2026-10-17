-- DB update 2025_12_08_01 -> 2025_12_09_00
SET @ITEM = 7666;
SET @REFERENCE = 1056;
SET @INSIDE = 6;
SET @OUTSIDE = 3;

-- Creates a reference loot for "Shattered Necklace"
DELETE FROM `reference_loot_template` WHERE `Entry` = @REFERENCE AND `Item` = @ITEM;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REFERENCE, @ITEM, 0, 100, 0, 1, 1, 1, 1, 'Shattered Necklace');

-- Deletes "Shattered Necklace" from every creature's loot
DELETE FROM `creature_loot_template` WHERE `item` = @ITEM;

-- Adds reference loot for "Shattered Necklace" for each creature below
DELETE FROM `creature_loot_template` WHERE `Reference` = @REFERENCE AND `Entry` IN (4852, 4851, 4856, 4845, 4846, 4844);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4852, @ITEM, @REFERENCE, @INSIDE, 0, 1, 0, 1, 1, 'Stonevault Oracle - Shattered Necklace'),
(4851, @ITEM, @REFERENCE, @INSIDE, 0, 1, 0, 1, 1, 'Stonevault Rockchewer - Shattered Necklace'),
(4856, @ITEM, @REFERENCE, @INSIDE, 0, 1, 0, 1, 1, 'Stonevault Cave Hunter - Shattered Necklace'),
(4845, @ITEM, @REFERENCE, @OUTSIDE, 0, 1, 0, 1, 1, 'Shadowforge Ruffian - Shattered Necklace'),
(4846, @ITEM, @REFERENCE, @OUTSIDE, 0, 1, 0, 1, 1, 'Shadowforge Digger - Shattered Necklace'),
(4844, @ITEM, @REFERENCE, @OUTSIDE, 0, 1, 0, 1, 1, 'Shadowforge Surveyor - Shattered Necklace');
