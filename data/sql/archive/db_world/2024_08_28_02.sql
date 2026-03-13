-- DB update 2024_08_28_01 -> 2024_08_28_02
UPDATE `smart_scripts`
SET `link` = 28
WHERE `entryorguid` = 9520 AND `source_type` = 0 AND `id` = 3;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9520) AND (`source_type` = 0) AND (`id` IN (28));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9520, 0, 28, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'On Quest Accept - Store Party Targetlist');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 952001) AND (`source_type` = 9) AND (`id` IN (11, 12));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(952001, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 4121, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Complete Quest'),
(952001, 9, 12, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Script9 - Despawn');
