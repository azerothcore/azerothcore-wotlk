-- DB update 2026_04_21_01 -> 2026_04_22_00

-- Edit Row 1002 (from On Waypoint Ended to MovementInfo)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = -101303) AND (`source_type` = 0) AND (`id` IN (1002));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-101303, 0, 1002, 0, 34, 0, 100, 0, 8, 12, 0, 0, 0, 0, 80, 2617002, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - On MovementInfo - Run Script: Last Rites RP Part 1');

-- Edit Action List 2617001 (add Set Run Off & change start waypoint with Move To Pos)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2617001) AND (`source_type` = 9) AND (`id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617001, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Run Off'),
(2617001, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 12, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3713.36, 3570.72, 477.599, 0, 'Thassarian - Actionlist - Move To Position');

-- Edit Action List 2617004 (Add Set Home Pos, Set Run On)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2617004);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2617004, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3722.53, 3567.26, 477.571, 0, 'Thassarian - Actionlist - Set Home Position'),
(2617004, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Set Run On'),
(2617004, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3722.53, 3567.26, 477.571, 0, 'Thassarian - Actionlist - Move To Position'),
(2617004, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thassarian - Actionlist - Say Line 0');

-- Delete Old Set Home Pos from Action List 2617005
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2617005) AND (`source_type` = 9) AND (`id` IN (15));

-- Edit Leryssa Action Lists (set Thassarian target from closest creature to creature guid)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2525101) AND (`source_type` = 9) AND (`id` IN (3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 3'),
(2525101, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Thassarian Standstate Kneel'),
(2525101, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Set Thassarian as Questgiver');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2525102) AND (`source_type` = 9) AND (`id` IN (2, 4, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2525102, 9, 2, 0, 0, 0, 100, 0, 7200, 7200, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 4'),
(2525102, 9, 4, 0, 0, 0, 100, 0, 14200, 14200, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 5'),
(2525102, 9, 6, 0, 0, 0, 100, 0, 14200, 14200, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Thassarian Say Line 6'),
(2525102, 9, 7, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 101303, 26170, 0, 0, 0, 0, 0, 0, 'Leryssa - Actionlist - Send Action to Thassarian, Cleanup Quest Event');
