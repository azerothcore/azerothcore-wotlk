-- DB update 2026_04_29_04 -> 2026_04_29_05
--
-- Sartharion 25M drops 2x T7.5 Gloves
SET @REF := 34377;
DELETE FROM `creature_loot_template` WHERE (`Entry` = 31311) AND (`Item` IN (5, 40628, 40629, 40630));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31311, 5, -@REF, 100, 0, 1, 0, 2, 2, 'Sartharion (1) - (ReferenceTable)');

DELETE FROM `reference_loot_template` WHERE (`Entry` = @REF) AND (`Item` IN (40752, 40628, 40629, 40630));
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@REF, 40628, 0, 0, 0, 1, 1, 1, 1, 'T7.5 Gloves Token'),
(@REF, 40629, 0, 0, 0, 1, 1, 1, 1, 'T7.5 Gloves Token'),
(@REF, 40630, 0, 0, 0, 1, 1, 1, 1, 'T7.5 Gloves Token');
