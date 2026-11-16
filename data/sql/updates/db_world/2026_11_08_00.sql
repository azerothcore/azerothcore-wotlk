-- DB update 2026_11_06_01 -> 2026_11_08_00
-- Troyas Moonbreeze (7764): roleplay on quest 'Return to Troyas' (2943) reward
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7764;

UPDATE `creature_text` SET `Emote` = 0 WHERE `CreatureID` = 7764 AND `GroupID` = 2;

DELETE FROM `waypoints` WHERE `entry` = 7764;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(7764, 1, -4476.23, 3230.55, 13.7301, 'Troyas Moonbreeze'),
(7764, 2, -4474.9, 3232.88, 13.7295, 'Troyas Moonbreeze');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 7764 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7764, 0, 0, 0, 20, 0, 100, 0, 2943, 0, 0, 0, 0, 0, 80, 776400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - On Quest \'Return to Troyas\' Finished - Run Script'),
(7764, 0, 1, 0, 40, 0, 100, 0, 1, 7764, 0, 0, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - On Point 1 of Path 7764 Reached - Pause Waypoint'),
(7764, 0, 2, 0, 40, 0, 100, 0, 1, 7764, 0, 0, 0, 0, 80, 776401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - On Point 1 of Path 7764 Reached - Run Script'),
(7764, 0, 3, 0, 40, 0, 100, 0, 2, 7764, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.951991, 'Troyas Moonbreeze - On Point 2 of Path 7764 Reached - Set Orientation'),
(7764, 0, 4, 0, 40, 0, 100, 0, 2, 7764, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - On Point 2 of Path 7764 Reached - Add Npc Flag Questgiver'),
(7764, 0, 5, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - On Reached Home - Add Npc Flag Questgiver');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 776400 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(776400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - Actionlist - Remove Npc Flag Questgiver'),
(776400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - Actionlist - Say Line 0'),
(776400, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 53, 1, 7764, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - Actionlist - Start Waypoint Path 7764 (Walk)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 776401 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(776401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.99471, 'Troyas Moonbreeze - Actionlist - Set Orientation'),
(776401, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - Actionlist - Say Line 1'),
(776401, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Troyas Moonbreeze - Actionlist - Say Line 2');
