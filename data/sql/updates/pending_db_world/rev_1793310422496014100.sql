--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` & ~256 WHERE `entry` = 5391;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5391);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5391, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Respawn - Set Event Phase 1'),
(5391, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Aggro - Say Line 0'),
(5391, 0, 2, 0, 19, 0, 100, 512, 1393, 0, 0, 0, 0, 0, 80, 539100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Quest \'Galen\'s Escape\' Taken - Run Script'),
(5391, 0, 3, 0, 40, 0, 100, 512, 1, 0, 0, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Waypoint 1 Reached - Pause Waypoint'),
(5391, 0, 4, 5, 40, 0, 100, 512, 21, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Waypoint 21 Reached - Set Run On'),
(5391, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Link - Set Orientation Stored Target'),
(5391, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Link - Say Line 3'),
(5391, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Link - Say Line 4'),
(5391, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Link - Say Line 5'),
(5391, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 15, 1393, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Link - Quest Credit \'Galen\'s Escape\''),
(5391, 0, 10, 0, 40, 0, 100, 512, 22, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Waypoint 22 Reached - Despawn (0)'),
(5391, 0, 11, 0, 38, 1, 100, 0, 0, 1, 60000, 60000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Data Set 0 1 - Say Line 1 (Phase 1)'),
(5391, 0, 12, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 6, 1393, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Death - Fail Quest \'Galen\'s Escape\''),
(5391, 0, 13, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Galen Goodward - On Respawn - Set Flags Immune To Players');
