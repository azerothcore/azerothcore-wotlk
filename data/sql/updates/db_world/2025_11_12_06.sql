-- DB update 2025_11_12_05 -> 2025_11_12_06

-- Update AI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27254;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27254);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27254, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Emerald Lasher - On Reset - Set Flag Standstate Submerged'),
(27254, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Emerald Lasher - On Aggro - Remove FlagStandstate Submerged'),
(27254, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 37752, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Emerald Lasher - On Aggro - Cast \'Stand\''),
(27254, 0, 3, 0, 0, 0, 100, 0, 4000, 7000, 9000, 13000, 0, 0, 11, 51901, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Emerald Lasher - In Combat - Cast \'Dream Lash\'');
