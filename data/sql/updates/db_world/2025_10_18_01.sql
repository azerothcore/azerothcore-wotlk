-- DB update 2025_10_18_00 -> 2025_10_18_01
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (52780, 52658, 52667);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(52780, 52780, 59800, 0, 0), -- Ball Lightning
(52658, 52658, 59795, 0, 0), -- Static Overload
(52667, 52667, 59833, 0, 0); -- Spark Visual Trigger
