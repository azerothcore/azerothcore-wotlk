-- DB update 2025_09_12_02 -> 2025_09_12_03
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (53472, 53509);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(53509, 53509, 59432),
(53472, 53472, 59433);
