--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_patchwerk_hateful_strike_primer';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(28307, 'spell_patchwerk_hateful_strike_primer');

DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 28308;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(28308, 28308, 59192, 0, 0);
