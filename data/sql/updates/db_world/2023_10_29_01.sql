-- DB update 2023_10_29_00 -> 2023_10_29_01
-- Unyielding Knight
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16906);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16906, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 22911, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Knight - On Aggro - Cast \'Charge\''),
(16906, 0, 1, 0, 74, 0, 100, 0, 0, 0, 22000, 22000, 50, 40, 11, 33910, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Knight - On Friendly Below 50% Health - Cast \'Heal Other\''),
(16906, 0, 2, 0, 2, 0, 100, 0, 0, 30, 0, 0, 0, 0, 39, 25, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Knight - Between 0-30% Health - Call For Help (25 yards)');
