-- DB update 2025_12_27_01 -> 2025_12_27_02
--
DELETE FROM `item_loot_template` WHERE `Entry` = 43575;
INSERT INTO `item_loot_template` (`entry`, `item`, `Chance`, `groupid`, `mincount`, `maxcount`, `reference`, `comment`) VALUES
(43575, 5237, 11.9, 0, 1, 1, 0, 'Reinforced Junkbox - Mind-numbing Poison'),
(43575, 24231, 49.5, 0, 2, 3, 0, 'Reinforced Junkbox - Coarse Snuff'),
(43575, 24232, 4.7, 0, 2, 2, 0, 'Reinforced Junkbox - Shabby Knot'),
(43575, 24281, 3.7, 0, 1, 1, 0, 'Reinforced Junkbox - Carved Ivory Bone'),
(43575, 24282, 4.2, 0, 1, 1, 0, 'Reinforced Junkbox - Rogue\'s Diary'),
(43575, 27729, 2.6, 0, 1, 1, 0, 'Reinforced Junkbox - Humanoid Skull'),
(43575, 33447, 12.6, 0, 1, 1, 0, 'Reinforced Junkbox - Runic Healing Potion'),
(43575, 36918, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Scarlet Ruby'),
(43575, 36921, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Autumn\'s Glow'),
(43575, 36924, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Sky Sapphire'),
(43575, 36927, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Twilight Opal'),
(43575, 36930, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Monarch Topaz'),
(43575, 36422, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Filigree Ring'),
(43575, 36423, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Posy Ring'),
(43575, 36424, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Cameo Ring'),
(43575, 36427, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Engraved Ring'),
(43575, 36436, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Jasper Bead Necklace'),
(43575, 43230, 9.9, 0, 1, 1, 0, 'Reinforced Junkbox - Instant Poison VIII'),
(43575, 43232, 10.2, 0, 1, 1, 0, 'Reinforced Junkbox - Deadly Poison VIII'),
(43575, 43234, 10.4, 0, 1, 1, 0, 'Reinforced Junkbox - Wound Poison VI'),
(43575, 43235, 11.1, 0, 1, 1, 0, 'Reinforced Junkbox - Wound Poison VII'),
(43575, 43237, 10.3, 0, 1, 1, 0, 'Reinforced Junkbox - Anesthetic Poison II'),
(43575, 43611, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Krol Cleaver'),
(43575, 43612, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - Spineslicer'),
(43575, 43613, 0.1, 0, 1, 1, 0, 'Reinforced Junkbox - The Dusk Blade');
