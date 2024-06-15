-- DB update 2023_03_11_05 -> 2023_03_11_06
--
-- Revamp Aeonus Tables
DELETE FROM `reference_loot_template` WHERE Entry IN (35004);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(35004, 27509, 0, 0, 0, 1, 2, 1, 1, 'Handgrips of Assassination'),
(35004, 27839, 0, 0, 0, 1, 2, 1, 1, 'Legplates of the Righteous'),
(35004, 27873, 0, 0, 0, 1, 2, 1, 1, 'Moonglade Pants'),
(35004, 27977, 0, 0, 0, 1, 2, 1, 1, 'Legplates of the Bold'),
(35004, 28194, 0, 0, 0, 1, 2, 1, 1, 'Primal Surge Bracers'),
(35004, 28207, 0, 0, 0, 1, 2, 1, 1, 'Pauldrons of the Crimson Flight'),
(35004, 28188, 0, 0, 0, 1, 3, 1, 1, 'Bloodfire Greatstaff'),
(35004, 28189, 0, 0, 0, 1, 3, 1, 1, 'Latro\'s Shifting Sword'),
(35004, 28190, 0, 0, 0, 1, 3, 1, 1, 'Scarab of the Infinite Cycle'),
(35004, 28192, 0, 0, 0, 1, 3, 1, 1, 'Helm of Desolation'),
(35004, 28193, 0, 0, 0, 1, 3, 1, 1, 'Mana-Etched Crown'),
(35004, 28206, 0, 0, 0, 1, 3, 1, 1, 'Cowl of the Guiltless');
-- Insert 2nd loot drop
DELETE FROM `creature_loot_template` WHERE `Entry`=17881 AND `Item`=35004 AND `GroupId`=3;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(17881, 35004, 35004, 100, 0, 1, 3, 1, 1, 'Aeonus High Value Table - (ReferenceTable)');
