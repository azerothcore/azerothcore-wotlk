-- DB update 2025_11_01_02 -> 2025_11_01_03
-- Stomp
DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 50868;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES (50868, 50868, 59744, 0, 0);
-- Ground Spike : Heroic only
DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 59750;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES (59750, 59750, 59750, 0, 0);
