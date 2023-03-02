-- DB update 2022_12_25_06 -> 2022_12_26_00
--
DELETE FROM `reference_loot_template` WHERE `Entry`=21887 AND `Item`=21887 AND `Comment`='Knothide Leather';
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Comment`) VALUES (21887, 21887, 'Knothide Leather');

UPDATE `creature_template` SET `skinloot` = 21723 WHERE (`entry` = 21723);
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 21723);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21723, 21887, 0, 100, 0, 1, 0, 1, 1, 'Blackwind Sabercat - Knothide Leather'),
(21723, 35229, 0, 25, 1, 1, 0, 1, 1, 'Blackwind Sabercat - Nether Residue'),
(21723, 1, 21887, 10, 0, 1, 0, 1, 1, 'Blackwind Sabercat - Knothide Leather (Reference Table)');
