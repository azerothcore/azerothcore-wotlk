-- DB update 2025_11_21_03 -> 2025_11_21_04

-- Clean Script Name & add SmartAI (Beryl Sorcerer, Captured Beryl Sorcerer)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` IN (25316, 25474));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (25316, 25474));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25316, 0, 0, 0, 8, 0, 100, 0, 45611, 0, 0, 0, 0, 0, 80, 2531600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Beryl Sorcerer - On Spellhit \'Arcane Chains\' - Run Script'),
(25316, 0, 1, 0, 0, 0, 100, 0, 3000, 4000, 4000, 8000, 0, 0, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Beryl Sorcerer - In Combat - Cast \'Frostbolt\''),
(25316, 0, 2, 0, 2, 0, 100, 0, 35, 50, 8000, 12000, 0, 0, 11, 50648, 64, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Beryl Sorcerer - Between 35-50% Health - Cast \'Blink\''),
(25474, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2547400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Beryl Sorcerer - On Just Summoned - Run Script'),
(25474, 0, 1, 0, 65, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Beryl Sorcerer - On Follow Complete - Despawn Instant');

-- Set Action Lists (Beryl Sorcerer, Captured Beryl Sorcerer)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2531600, 2547400));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2531600, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 45625, 0, 524023, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Beryl Sorcerer - Actionlist - Cast \'Arcane Chains: Character Force Cast\''),
(2531600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25474, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Beryl Sorcerer - Actionlist - Quest Credit \'null\''),
(2531600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Beryl Sorcerer - Actionlist - Despawn Instant'),
(2547400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Beryl Sorcerer - Actionlist - Set Flags Not Attackable & Player Controlled'),
(2547400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Beryl Sorcerer - Actionlist - Set Reactstate Passive'),
(2547400, 9, 2, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 11, 45632, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Beryl Sorcerer - Actionlist - Cast \'Enslaved Arcane Chains: Character Force Cast\''),
(2547400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 180, 25262, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Beryl Sorcerer - Actionlist - Start Follow Owner Or Summoner');
