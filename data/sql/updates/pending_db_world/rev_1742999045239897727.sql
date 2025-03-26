-- Remove tokens from original ref table and set groupid of rest to group 0
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34068) AND (`Item` IN (30902, 30903, 30904, 30905, 30906, 30907, 30908, 30909, 30910, 30911, 30912, 30913, 31095, 31096, 31097));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34068, 30902, 0, 0, 0, 1, 0, 1, 1, 'Cataclysms Edge'),
(34068, 30903, 0, 0, 0, 1, 0, 1, 1, 'Legguards of Endless Rage'),
(34068, 30904, 0, 0, 0, 1, 0, 1, 1, 'Saviors Grasp'),
(34068, 30905, 0, 0, 0, 1, 0, 1, 1, 'Midnight Chestguard'),
(34068, 30906, 0, 0, 0, 1, 0, 1, 1, 'Bristleblitz Striker'),
(34068, 30907, 0, 0, 0, 1, 0, 1, 1, 'Mail of Fevered Pursuit'),
(34068, 30908, 0, 0, 0, 1, 0, 1, 1, 'Apostle of Argus'),
(34068, 30909, 0, 0, 0, 1, 0, 1, 1, 'Antonidas Aegis of Rapt Concentration'),
(34068, 30910, 0, 0, 0, 1, 0, 1, 1, 'Tempest of Chaos'),
(34068, 30911, 0, 0, 0, 1, 0, 1, 1, 'Scepter of Purification'),
(34068, 30912, 0, 0, 0, 1, 0, 1, 1, 'Leggings of Eternity'),
(34068, 30913, 0, 0, 0, 1, 0, 1, 1, 'Robes of Rhonin');

-- Create new reference table with just tokens tokens
DELETE FROM `reference_loot_template` WHERE (`Entry` = 1276884) AND (`Item` IN (31095, 31096, 31097));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1276884, 31095, 0, 100, 0, 1, 0, 1, 1, 'Helm of the Forgotten Protector'),
(1276884, 31096, 0, 100, 0, 1, 0, 1, 1, 'Helm of the Forgotten Vanquisher'),
(1276884, 31097, 0, 100, 0, 1, 0, 1, 1, 'Helm of the Forgotten Conqueror');

-- Set chance of 100 with seperate groups (2/3)
-- Chance for regular items 2/2
-- ~~Chance for tokens is 2/3~~ must only be 2/2? <- Maybe this needs to be changed in core?
-- PLEASE READ I set Item to 34069 for ref table 1276884 because from my understanding Item just needs to be unique
DELETE FROM `creature_loot_template` WHERE (`Entry` = 17968) AND (`Item` IN (34068, 34069));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17968, 34068, 34068, 100, 0, 1, 2, 2, 2, 'Archimonde - (ReferenceTable Regular)'),
(17968, 34069, 1276884, 100, 0, 1, 3, 2, 2, 'Archimonde - (ReferenceTable Tokens)');
