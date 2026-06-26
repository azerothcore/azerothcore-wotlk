-- DB update 2026_04_26_01 -> 2026_04_26_02

-- Update Mogor SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18069;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18069) AND (`source_type` = 0) AND (`id` IN (7, 9, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18069, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Evade - Despawn Instant - Failure Event'),
(18069, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogor - On Just Died - Despawn In 5000 ms'),
(18069, 0, 11, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 10, 66480, 18471, 0, 0, 0, 0, 0, 0, 'Mogor - On Respawn - Add Npc Flags Questgiver');

-- Update Gurgthock Action List
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1847117) AND (`source_type` = 9) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1847117, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 9977, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Gurgthock - Mogor Failure Script - Fail Quest \'The Ring of Blood: The Final Challenge\'');
