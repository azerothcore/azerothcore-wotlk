-- DB update 2025_06_08_02 -> 2025_06_08_03
-- Remove tokens from original ref table
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34068) AND (`Item` IN (31095, 31096, 31097));

-- Create new reference table with just tokens tokens
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1276884);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1276884, 31095, 0, 33.33, 0, 1, 1, 1, 1, 'Helm of the Forgotten Protector'),
(1276884, 31096, 0, 33.33, 0, 1, 1, 1, 1, 'Helm of the Forgotten Vanquisher'),
(1276884, 31097, 0, 33.33, 0, 1, 1, 1, 1, 'Helm of the Forgotten Conqueror');

-- Set chance of 100 with seperate groups (2/3)
-- Chance for regular items 2/2
-- ~~Chance for tokens is 2/3~~ must only be 2/2? <- Maybe this needs to be changed in core?
-- PLEASE READ I set Item to 34069 for ref table 1276884 because from my understanding Item just needs to be unique
DELETE FROM `creature_loot_template` WHERE (`Entry` = 17968) AND (`Item` IN (34068, 34069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17968, 34068, 34068, 100, 0, 1, 2, 2, 2, 'Archimonde - (ReferenceTable Regular)'),
(17968, 34069, 1276884, 100, 0, 1, 3, 2, 2, 'Archimonde - (ReferenceTable Tokens)');
