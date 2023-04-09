-- DB update 2023_04_09_11 -> 2023_04_09_12
--
DELETE FROM `spell_target_position` WHERE `ID` IN (31528, 31529, 31530);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(31528, 0, 545, -316.102, -166.444, -7.66667, 0, 48749),
(31529, 0, 545, -348.497, -161.719, -7.66667, 0, 48749),
(31530, 0, 545, -331.162, -112.213, -7.66667, 0, 48749);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 17951;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17951) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17951, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 2000, 2000, 0, 11, 31532, 0, 0, 0, 0, 0, 205, 1, 1, 0, 0, 0, 0, 0, 0, 'Steamrigger Mechanic - In Combat - Cast \'Repair\'');

DELETE FROM `spelldifficulty_dbc` WHERE `ID` = 31532;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(31532, 31532, 37936);
