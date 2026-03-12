-- DB update 2024_08_28_00 -> 2024_08_28_01
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3692) AND (`source_type` = 0) AND (`id` IN (0, 3, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3692, 0, 0, 1, 19, 0, 100, 512, 994, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Volcor - On Quest \'Escape Through Force\' Taken - Store Targetlist'),
(3692, 0, 3, 4, 19, 0, 100, 512, 995, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Volcor - On Quest \'Escape Through Stealth\' Taken - Store Targetlist'),
(3692, 0, 11, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 6298, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Volcor - On Waypoint 2 Reached (Path 369200) - Cast Spell \'Form of the Moonstalker\'');
