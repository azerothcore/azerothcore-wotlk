-- DB update 2025_09_30_00 -> 2025_09_30_01
-- Drakkari Colossus - Mortal Strike spell difficulty
DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 54715;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES (54715, 54715, 59454, 0, 0);
