UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10440;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10440) AND (`source_type` = 0) AND (`id` IN (19));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10440, 0, 19, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 6911, 0, 0, 0, 0, 0, 0, 0, 'Baron Ricendare - AGGRO - Open Door');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10416;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10416) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10416, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 6911, 0, 0, 0, 0, 0, 0, 0, 'Bile Spewer - AGGRO - Close door');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10417;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10417) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10417, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 14, 6911, 0, 0, 0, 0, 0, 0, 0, 'Venom Belcher - AGGRO - Close door');


-- Magistrate Barthilas
-- move potion
DELETE
FROM `waypoints`
WHERE `entry`=10435;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES 
 (10435, 1, 3696.79, -3605.93, 139.041, NULL, 0, NULL),
 (10435, 2, 3725.577, -3599.484, 142.367, NULL, 0, NULL);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10435;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 10435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10435, 0, 0, 0, 38, 0, 100, 257, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Data Set - Say Line 0'),
(10435, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16792, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Reset - Cast Furious Anger'),
(10435, 0, 2, 0, 0, 0, 100, 0, 6000, 10000, 12000, 21000, 0, 0, 11, 10887, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Crowd Pummel'),
(10435, 0, 3, 0, 0, 0, 100, 0, 11000, 12000, 15000, 15000, 0, 0, 11, 14099, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Might Blow'),
(10435, 0, 4, 0, 0, 0, 100, 0, 4000, 4000, 12000, 15000, 0, 0, 11, 16793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - In Combat - Cast Drain Blow'),
-- Modify the target to release yourself
(10435, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On Death - Cast Transformation'),
(10435, 0, 6, 0, 37, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 16794, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On AI Init - Cast Transformation'),
-- Escape incident
(10435, 0, 7, 0, 38, 0, 100, 769, 1, 1, 0, 0, 0, 0, 53, 1, 10435, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - Wp_Stat - On Waypoint Path.'),
(10435, 0, 8, 0, 40, 0, 100, 512, 1, 10435, 0, 0, 0, 0, 80, 1043500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Call Timed Actionlist #1043500. Updates always.'),
(10435, 0, 9, 0, 40, 0, 100, 512, 2, 10435, 0, 0, 0, 0, 80, 1043501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Call Timed Actionlist #1043501. Updates always.'),
(10435, 0, 10, 0, 38, 0, 100, 257, 1, 2, 0, 0, 0, 0, 62, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4068.28, -3535.68, 122.771, 2.5, 'Magistrate Barthilas - Telte'),

--close door
(10435, 0, 11, 12, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 15, 175377, 70, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On aggro - Gameobject ID 175377: Set gameobject state to ready'),
(10435, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 1, 0, 0, 0, 0, 0, 15, 175372, 90, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On aggro - Gameobject ID 175372: Set gameobject state to ready'),

--open door
(10435, 0, 13, 14, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 11165, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On death - Gameobject with guid 11165: Set gameobject state to active'),
(10435, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 6852, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On death - Gameobject with guid 6852: Set gameobject state to active'),
(10435, 0, 15, 16, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 11165, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On reset - Gameobject with guid 11165 : Set gameobject state to active'),
(10435, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 118, 2, 0, 0, 0, 0, 0, 14, 6852, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - On reset - Gameobject with guid 6852: Set gameobject state to active');

DELETE
FROM `smart_scripts`
WHERE (`source_type` = 9 AND `entryorguid` IN (1043500,1043501));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1043500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas - stop move'),
(1043500, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Magistrate Barthilas- Delay move'),
(1043501, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 62, 329, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 4068.28, -3535.68, 122.771, 2.5, 'Magistrate Barthilas - Delay telep'),
(1043501, 9, 1, 0, 0, 0, 100, 257, 2000, 2000, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4068.28, -3535.68, 122.771, 2.5, 'Magistrate Barthilas - Set Home');
-- How to save a location to a database Read when the player enters the dungeon？？？
-- (1043501, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '');



