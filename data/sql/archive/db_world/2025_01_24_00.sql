-- DB update 2025_01_23_04 -> 2025_01_24_00
-- Fix Kaelthas HC
DELETE FROM `creature_loot_template` WHERE (`Entry` = 24857) AND (`Item` IN (23572, 25028, 25029, 34609, 34610, 34611, 34612, 34613, 34614, 34615, 34616));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24857, 23572, 0, 100, 0, 1, 0, 1, 1, 'Kael\'thas Sunstrider (1) - Primal Nether'),
(24857, 34612, 0, 0, 0, 1, 1, 1, 1, 'Kael\'thas Sunstrider (1) - Greaves of the Penitent Knight'),
(24857, 34609, 0, 0, 0, 1, 1, 1, 1, 'Kael\'thas Sunstrider (1) - Quickening Blade of the Prince'),
(24857, 34611, 0, 0, 0, 1, 1, 1, 1, 'Kael\'thas Sunstrider (1) - Cudgel of Consecration'),
(24857, 34610, 0, 0, 0, 1, 1, 1, 1, 'Kael\'thas Sunstrider (1) - Scarlet Sin\'dorei Robes'),
(24857, 34614, 0, 0, 0, 1, 2, 1, 1, 'Kael\'thas Sunstrider (1) - Tunic of the Ranger Lord'),
(24857, 34615, 0, 0, 0, 1, 2, 1, 1, 'Kael\'thas Sunstrider (1) - Netherforce Chestplate'),
(24857, 34616, 0, 0, 0, 1, 2, 1, 1, 'Kael\'thas Sunstrider (1) - Breeching Comet'),
(24857, 34613, 0, 0, 0, 1, 2, 1, 1, 'Kael\'thas Sunstrider (1) - Shoulderpads of the Silvermoon Retainer');

-- Remove normal loot from Delrissa HC
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25560) AND (`Item` IN (25027));

-- Remove normal loot from Vexallus HC
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25573) AND (`Item` IN (25026));

-- Remove normal loot from Selin Fireheart HC
DELETE FROM `creature_loot_template` WHERE (`Entry` = 25562) AND (`Item` IN (25025));
