-- DB update 2025_11_01_01 -> 2025_11_01_02

-- Spelldifficulty
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (50378);
INSERT INTO `spelldifficulty_dbc` (`ID`,`DifficultySpellID_1`,`DifficultySpellID_2`,`DifficultySpellID_3`,`DifficultySpellID_4`) VALUES
(50378, 50378, 59017, 0, 0);

-- Scourge Reanimator (unholy frenzy on self / update client)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26626;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26626);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26626, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 6000, 8000, 0, 0, 11, 50378, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast \'Frostbolt\''),
(26626, 0, 1, 0, 0, 0, 100, 0, 7000, 10000, 15000, 15000, 0, 0, 11, 50379, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast \'Cripple\''),
(26626, 0, 2, 0, 0, 0, 100, 0, 2000, 10000, 18000, 24000, 0, 0, 11, 49805, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scourge Reanimator - In Combat - Cast \'Unholy Frenzy\'');
