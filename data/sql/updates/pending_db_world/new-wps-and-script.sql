--
DELETE FROM `waypoint_data` WHERE `id` = 186040;

DELETE FROM `waypoints` WHERE `entry` = 23600;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(23600, 1, -4044.27, -3393.28, 38.1284, NULL, 4000, 'Apprentice Morlann'),
(23600, 2, -4045.51, -3394.92, 38.1749, NULL, 2000, 'Apprentice Morlann'),
(23600, 3, -4042.77, -3396.91, 38.1887, NULL, 0, 'Apprentice Morlann'),
(23600, 4, -4040.72, -3397.23, 38.1476, NULL, 9000, 'Apprentice Morlann'),
(23600, 5, -4043.21, -3395.28, 38.1581, NULL, 0, 'Apprentice Morlann'),
(23600, 6, -4043.43, -3395.40, 38.2663, NULL, 240000, 'Apprentice Morlann');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23600;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 23600 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23600, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 23600, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Respawn - Start Waypoint'),
(23600, 0, 1, 2, 40, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On WP1 reached - Say line 1'),
(23600, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On WP1 reached - Pause 4s'),
(23600, 0, 3, 0, 40, 0, 100, 0, 2, 0, 0, 0, 0, 0, 54, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On WP2 reached - Pause 2s'),
(23600, 0, 4, 5, 40, 0, 100, 0, 4, 0, 0, 0, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On WP4 reached - Say Line 2'),
(23600, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 9000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On WP4 reached - Pause 9s'),
(23600, 0, 6, 7, 52, 0, 100, 0, 1, 23600, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On text-over - Say Line 3'),
(23600, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On text-over - Play emote kneel');
