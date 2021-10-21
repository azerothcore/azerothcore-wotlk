INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634315396844620743');

-- Adjusts the loot of Crimson Hammersmith
DELETE FROM `creature_loot_template` WHERE `Entry` = 11120 AND `Item` IN (18781, 12811, 13446, 8932, 8766, 0, 1);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11120, 18781, 0, 64, 0, 1, 0, 1, 1, 'Crimson Hammersmith - Bottom Half of Advanced Armorsmithing: Volume II'),
(11120, 12811, 0, 4, 0, 1, 0, 1, 1, 'Righteous Orb'),
(11120, 13446, 0, 1.1, 0, 1, 0, 1, 1, 'Major Healing Potion'),
(11120, 8932, 0, 4, 0, 1, 0, 1, 1, 'Alterac Swiss'),
(11120, 8766, 0, 1.8, 0, 1, 0, 1, 1, 'Morning Glory Dew'),
(11120, 0, 24024, 2, 0, 1, 0, 1, 1, 'Small chance for RLT 24024 (greys)'),
(11120, 1, 24016, 1.5, 0, 1, 0, 1, 1, 'Small chance for RLT 24016 (greens)');
