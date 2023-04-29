--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (33617, 33783);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(33617, 33617, 39363),
(33783, 33783, 39364);
