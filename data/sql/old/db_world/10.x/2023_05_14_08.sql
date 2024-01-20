-- DB update 2023_05_14_07 -> 2023_05_14_08
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (19130,30925,12739,30500,30495);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(19130, 19130, 40392),
(30925, 30925, 40059),
(12739, 12739, 15472),
(30500, 30500, 35954),
(30495, 30495, 35953);

