-- DB update 2025_09_16_04 -> 2025_09_16_05
--

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_azjol_drain_power';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(54314, 'spell_azjol_drain_power'),
(59354, 'spell_azjol_drain_power');

DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (54315, 54314, 54309);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(54315, 54315, 59355),
(54314, 54314, 59354),
(54309, 54309, 59352);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29128) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29128, 0, 0, 0, 0, 0, 100, 0, 0, 10000, 10000, 10000, 0, 0, 11, 54314, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Prime Guard - In Combat - Cast \'Drain Power\''),
(29128, 0, 2, 0, 0, 0, 100, 0, 6000, 12000, 12000, 25000, 0, 0, 11, 54309, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Prime Guard - In Combat - Cast \'Mark of Darkness\'');
