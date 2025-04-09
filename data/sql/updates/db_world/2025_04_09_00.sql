-- DB update 2025_04_08_00 -> 2025_04_09_00

-- Add gold drop
UPDATE `creature_template` SET `mingold` = 173, `maxgold` = 231 WHERE (`entry` = 23386);

-- Add Netherweave Cloth and change chance drop for Schematic: Field Repair Bot 110G
DELETE FROM `creature_loot_template` WHERE (`Entry` = 23386) AND (`Item` IN (34114, 21877));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23386, 34114, 0, 5, 0, 1, 0, 1, 1, 'Gan\'arg Analyzer - Schematic: Field Repair Bot 110G'),
(23386, 21877, 0, 4, 0, 1, 0, 1, 3, 'Netherweave Cloth');
