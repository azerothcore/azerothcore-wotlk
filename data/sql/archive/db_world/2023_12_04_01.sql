-- DB update 2023_12_04_00 -> 2023_12_04_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23050;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 23050 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23050, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 0, 2305000, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Little Noah - On Respawn - Start Waypoint'),
(23050, 0, 1, 0, 64, 0, 100, 512, 0, 0, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Little Noah - On Gossip - Pause Waypoint');

DELETE FROM `waypoints` WHERE `entry` = 2305000;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(2305000, 1, -8720.444, 470.81836, 98.74464, NULL, 0, 'Little Noah'),
(2305000, 2, -8719.903, 474.74838, 98.74463, NULL, 0, 'Little Noah'),
(2305000, 3, -8723.153, 475.56598, 98.74463, NULL, 0, 'Little Noah'),
(2305000, 4, -8723.759, 471.79776, 98.74464, NULL, 0, 'Little Noah');
