-- DB update 2025_08_07_00 -> 2025_08_08_00

-- Edit SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26769;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26769);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26769, 0, 0, 0, 9, 0, 100, 0, 3500, 5000, 3500, 5000, 0, 30, 11, 13860, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anok\'ra the Manipulator - Within 0-30 Range - Cast \'Mind Blast\''),
(26769, 0, 1, 0, 9, 0, 100, 0, 1500, 3000, 8000, 11000, 0, 20, 11, 16568, 64, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anok\'ra the Manipulator - Within 0-20 Range - Cast \'Mind Flay\''),
(26769, 0, 2, 0, 0, 0, 100, 0, 6000, 9000, 17000, 20000, 0, 0, 11, 51676, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Anok\'ra the Manipulator - In Combat - Cast \'Wavering Will\''),
(26769, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anok\'ra the Manipulator - On Just Died - Say Line 0');
