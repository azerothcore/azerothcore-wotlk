-- DB update 2023_05_10_00 -> 2023_05_10_01
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (33617, 33783);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(33617, 33617, 39363),
(33783, 33783, 39364);

DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (33783, 39364);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(33783, 4194304),
(39364, 4194304);
