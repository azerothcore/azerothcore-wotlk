-- DB update 2025_02_12_01 -> 2025_02_13_00
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (28796, 28794, 28798);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(28796, 28796, 54098, 0, 0),
(28794, 28794, 54099, 0, 0),
(28798, 28798, 54100, 0, 0);
