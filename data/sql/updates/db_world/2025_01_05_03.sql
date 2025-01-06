-- DB update 2025_01_05_02 -> 2025_01_05_03
--
-- Amani'shi Warbringer: Set MinHealth% to 0 for HEALTH_PCT
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23580) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23580, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 43274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 0-30% Health - Cast \'Dismount Bear\' (No Repeat)'),
(23580, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 0-30% Health - Set Flag Standstate Stand Up (No Repeat)'),
(23580, 0, 2, 3, 61, 0, 100, 3, 0, 0, 0, 0, 0, 0, 11, 40743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 0-30% Health - Cast \'Frenzy\' (No Repeat)'),
(23580, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Between 0-30% Health - Set caster combat distance to 0 (RestToMax: 0) (No Repeat)');
-- Amani Bear Mount
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24217;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24217) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24217, 0, 0, 0, 7, 0, 100, 1, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - On Evade - Despawn Instant (No Repeat)');
