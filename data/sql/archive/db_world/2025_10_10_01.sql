-- DB update 2025_10_10_00 -> 2025_10_10_01
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23723;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23723) AND (`source_type` = 0) AND (`id` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23723, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 2981, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Lukas - On Respawn - Morph To Model 2981');
