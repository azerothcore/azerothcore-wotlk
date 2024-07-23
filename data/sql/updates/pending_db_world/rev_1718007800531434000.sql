UPDATE `creature` SET `MovementType` = 2 WHERE `id1` = 23600 AND `guid` = 18604;

DELETE FROM `creature_addon` WHERE (`guid` IN (18604));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18604, 186040, 0, 0, 1, 0, 0, NULL);

DELETE FROM `waypoint_data` WHERE `id` = 186040;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(186040, 1, -4044.12, -3393.59, 38.1363, NULL, 6000), -- 1s, Talk 0, 5s, Talk 1
(186040, 2, -4044.21, -3394.23, 38.3905, NULL, 0),
(186040, 3, -4042.96, -3396.48, 38.3905, NULL, 0),
(186040, 4, -4041.71, -3397.23, 38.3905, NULL, 0),
(186040, 5, -4040.8, -3396.88, 38.1447, NULL, 16000), -- 2s, Emote 16, 6s, Talk 2, 6s, Garion Talk 0
(186040, 6, -4043.67, -3395.27, 38.1634, NULL, 0),
(186040, 7, -4043.67, -3395.27, 38.1634, 3.87463, 240000);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23600;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23600, 0, 0, 0, 108, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2360000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 1 of Path Any Reached - Run Script'),
(23600, 0, 1, 0, 108, 0, 100, 0, 5, 0, 0, 0, 0, 0, 80, 2360001, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - On Point 5 of Path Any Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2360000, 2360001));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2360000, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - Actionlist - Say Line 0'),
(2360000, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - Actionlist - Say Line 1'),

(2360001, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - Actionlist - Play Emote 16'),
(2360001, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - Actionlist - Say Line 2'),
(2360001, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 23601, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Morlann - Actionlist - Say Line 0 (Apprentice Garion)');

DELETE FROM `waypoint_scripts` WHERE `id` IN (1007, 1008) AND `guid` IN (648, 649);

