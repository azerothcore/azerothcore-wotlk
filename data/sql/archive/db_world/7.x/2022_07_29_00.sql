-- DB update 2022_07_27_04 -> 2022_07_29_00
--
UPDATE `creature_template` SET `skinloot` = 14887 WHERE (`entry` IN (14887, 14888, 14889, 14890));

DELETE FROM `skinning_loot_template` WHERE (`Entry` = 14887) AND (`Item` IN (15412, 20381));
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14887, 15412, 0, 60, 0, 1, 1, 5, 8, ''),
(14887, 20381, 0, 40, 0, 1, 1, 3, 5, '');
