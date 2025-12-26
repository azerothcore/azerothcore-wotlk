--
DELETE FROM `spelldifficulty_dbc` WHERE `ID`=54095;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(54095, 54095, 54096, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16506);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16506, 0, 0, 0, 0, 0, 70, 0, 3000, 5000, 2500, 2500, 0, 0, 11, 54095, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - In Combat - Cast \'Fireball\''),
(16506, 0, 1, 0, 6, 0, 100, 2, 0, 0, 0, 0, 0, 0, 11, 28732, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - On Just Died - Cast \'Widow`s Embrace\' (Normal Dungeon)'),
(16506, 0, 2, 0, 5, 0, 100, 512, 0, 0, 1, 0, 0, 0, 34, 119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Naxxramas Worshipper - On Killed Unit - Set Instance Data 119 to 0');
