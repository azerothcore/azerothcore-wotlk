-- DB update 2022_06_06_00 -> 2022_06_06_01
DELETE FROM `creature_loot_template` WHERE (`Entry` = 15204) AND (`Item` IN (20689, 20690, 20691)) OR (`Entry` = 15205) AND (`Item` IN (20686, 20687, 20688)) OR (`Entry` = 15305) AND (`Item` IN (20683, 20684, 20685))OR (`Item` IN (20680, 20681, 20682));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15203, 20680, 0, 33.3334, 0, 1, 3, 1, 1, 'Prince Skaldrenox - Abyssal Mail Pauldrons'),
(15203, 20681, 0, 33.3333, 0, 1, 3, 1, 1, 'Prince Skaldrenox - Abyssal Leather Bracers'),
(15203, 20682, 0, 33.3333, 0, 1, 3, 1, 1, 'Prince Skaldrenox - Elemental Focus Band'),
(15204, 20689, 0, 33.3333, 0, 1, 3, 1, 1, 'High Marshal Whirlaxis - Abyssal Leather Shoulders'),
(15204, 20690, 0, 33.3333, 0, 1, 3, 1, 1, 'High Marshal Whirlaxis - Abyssal Cloth Wristbands'),
(15204, 20691, 0, 33.3334, 0, 1, 3, 1, 1, 'High Marshal Whirlaxis - Windshear Cape'),
(15205, 20686, 0, 33.3334, 0, 1, 3, 1, 1, 'Baron Kazum - Abyssal Cloth Amice'),
(15205, 20687, 0, 33.3333, 0, 1, 3, 1, 1, 'Baron Kazum - Abyssal Plate Vambraces'),
(15205, 20688, 0, 33.3333, 0, 1, 3, 1, 1, 'Baron Kazum - Earthen Guard'),
(15305, 20683, 0, 33.3333, 0, 1, 3, 1, 1, 'Lord Skwol - Abyssal Plate Epaulets'),
(15305, 20684, 0, 33.3333, 0, 1, 3, 1, 1, 'Lord Skwol - Abyssal Mail Armguards'),
(15305, 20685, 0, 33.3334, 0, 1, 3, 1, 1, 'Lord Skwol - Wavefront Necklace');
