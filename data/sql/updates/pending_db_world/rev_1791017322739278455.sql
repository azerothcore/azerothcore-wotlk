--
-- Sif's Blizzard, Frostbolt, Frostbolt Volley and Frost Nova
-- 10m      25m
-- 62577	62603	Blizzard (entry already exists)
-- 62580	62604	Frostbolt Volley
-- 62583	62601	Frostbolt
-- 62597	62605	Frost Nova
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (62580, 62583, 62597);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(62580, 62580, 62604, 0, 0),
(62583, 62583, 62601, 0, 0),
(62597, 62597, 62605, 0, 0);
