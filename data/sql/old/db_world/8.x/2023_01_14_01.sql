-- DB update 2023_01_14_00 -> 2023_01_14_01
--
SET @REFERENCE := 29569;

DELETE FROM `item_loot_template` WHERE `Entry`=29569;
INSERT INTO `item_loot_template` (`entry`, `item`, `Chance`, `groupid`, `mincount`, `maxcount`, `reference`, `comment`) VALUES
(29569, 2931, 30, 1, 2, 5, 0, 'Strong Junkbox - Maiden\'s Anguish'),
(29569, 5140, 75, 0, 2, 5, 0, 'Strong Junkbox - Flash Powder'),
(29569, 5173, 30, 1, 2, 5, 0, 'Strong Junkbox - Deathweed'),
(29569, 8923, 10, 1, 2, 5, 0, 'Strong Junkbox - Essence of Agony'),
(29569, 8924, 30, 1, 2, 5, 0, 'Strong Junkbox - Dust of Deterioration'),
(29569, 11979, 0.05, 2, 1, 1, 0, 'Strong Junkbox - Peridot Circle'),
(29569, 11980, 0.05, 2, 1, 1, 0, 'Strong Junkbox - Opal Ring'),
(29569, 11991, 0.05, 2, 1, 1, 0, 'Strong Junkbox - Quicksilver Ring'),
(29569, 12035, 0.05, 2, 1, 1, 0, 'Strong Junkbox - Obsidian Pendant'),
(29569, 16251, 0.1, 2, 1, 1, 0, 'Strong Junkbox - Formula: Enchant Bracer - Superior Stamina'),
(29569, 22829, 12, 0, 1, 1, 0, 'Strong Junkbox - Super Healing Potion'),
(29569, 31331, 0.05, 0, 1, 1, 0, 'Strong Junkbox - The Night Blade'),
(29569, 34622, 0.1, 0, 1, 1, 0, 'Strong Junkbox - Spinesever'),
(29569, 1, 50, 0, 1, 1, @REFERENCE, 'Strong Junkbox (Reference Table)');

DELETE FROM `reference_loot_template` WHERE `Entry`=@REFERENCE AND `Item` IN (24231,24232,24281,24282,27729);
INSERT INTO `reference_loot_template` (`entry`, `item`, `Chance`, `groupid`, `mincount`, `maxcount`, `comment`) VALUES
(@REFERENCE, 24231, 70, 1, 2, 3, 'Reference Table - Coarse Snuff'),
(@REFERENCE, 24232, 8, 1, 2, 2, 'Reference Table - Shabby Knot'),
(@REFERENCE, 24281, 8, 1, 1, 1, 'Reference Table - Carved Ivory Bone'),
(@REFERENCE, 24282, 8, 1, 1, 1, 'Reference Table - Rogue\'s Diary'),
(@REFERENCE, 27729, 6, 1, 1, 1, 'Reference Table - Humanoid Skull');
