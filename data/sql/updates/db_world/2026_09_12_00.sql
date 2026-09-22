-- DB update 2026_09_11_01 -> 2026_09_12_00
-- Mogg (14908): the waypoint 29 event linked to event 8, which was never defined, so
-- SmartScript::ProcessAction logged "Event 7, Link Event 8 not found, skipped" on every pass.
-- The link dates from the 2017 script (2017_02_03_15.sql) and has no target to point at.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14908);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14908, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 1, 14908, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Reset - Start Waypoint'),
(14908, 0, 1, 0, 40, 0, 100, 512, 5, 14908, 0, 0, 0, 0, 80, 1490800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 5 Reached - Run Script'),
(14908, 0, 2, 0, 40, 0, 100, 512, 6, 14908, 0, 0, 0, 0, 80, 1490801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 6 Reached - Run Script'),
(14908, 0, 3, 0, 40, 0, 100, 512, 7, 14908, 0, 0, 0, 0, 80, 1490802, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 7 Reached - Run Script'),
(14908, 0, 4, 0, 40, 0, 100, 512, 17, 14908, 0, 0, 0, 0, 80, 1490803, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 17 Reached - Run Script'),
(14908, 0, 5, 0, 40, 0, 100, 512, 27, 14908, 0, 0, 0, 0, 80, 1490804, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 27 Reached - Run Script'),
(14908, 0, 6, 0, 40, 0, 100, 512, 28, 14908, 0, 0, 0, 0, 80, 1490805, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 28 Reached - Run Script'),
(14908, 0, 7, 0, 40, 0, 100, 512, 29, 14908, 0, 0, 0, 0, 80, 1490806, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mogg - On Waypoint 29 Reached - Run Script');
