-- DB update 2025_11_17_01 -> 2025_11_17_02

-- Set Spelldifficulty
DELETE FROM `spelldifficulty_dbc` WHERE (`ID` IN (52534, 52535));
INSERT INTO `spelldifficulty_dbc` (`ID`,`DifficultySpellID_1`,`DifficultySpellID_2`,`DifficultySpellID_3`,`DifficultySpellID_4`) VALUES
(52534, 52534, 59357, 0, 0),
(52535, 52535, 59358, 0, 0);

-- Update SmartAIs (call for help and comments).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (28732, 28733, 28734));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (28732, 28733, 28734));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28732, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 6000, 8000, 0, 0, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Warrior - In Combat - Cast \'Strike\''),
(28732, 0, 1, 0, 0, 0, 100, 0, 2000, 10000, 15000, 15000, 0, 0, 11, 49806, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Warrior - In Combat - Cast \'Cleave\''),
(28732, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Warrior - On Aggro - Call For Help'),
(28733, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2500, 0, 0, 11, 52534, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Shadowcaster - In Combat - Cast \'Shadow Bolt\''),
(28733, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 12000, 20000, 0, 0, 11, 52535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Shadowcaster - In Combat - Cast \'Shadow Nova\''),
(28733, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Shadowcaster - On Aggro - Call For Help'),
(28734, 0, 0, 0, 67, 0, 100, 0, 7000, 7000, 7000, 7000, 0, 5, 11, 52540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Skirmisher - On Behind Target - Cast \'Backstab\''),
(28734, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 15000, 15000, 0, 0, 11, 52536, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Skirmisher - In Combat - Cast \'Fixate Trigger\''),
(28734, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Skirmisher - On Aggro - Call For Help');
