-- DB update 2024_03_31_01 -> 2024_04_02_00
-- delete old entries that are unused
DELETE FROM `reference_loot_template` WHERE `Entry` = 34377 AND `Item` IN (30448, 32944);
-- down
DELETE FROM `reference_loot_template` WHERE `Entry` = 34053 AND `Item` = 32944;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34053, 32944, 0, 0, 0, 1, 1, 1, 1, 'Talon of the Phoenix');
