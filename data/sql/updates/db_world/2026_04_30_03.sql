-- DB update 2026_04_30_02 -> 2026_04_30_03

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2245200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2245200, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 0, 3500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Exarch - Actionlist - Say Line 0'),
(2245200, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Exarch - Actionlist - Set Orientation Closest Player'),
(2245200, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Exarch - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2245200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 20, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Exarch - Actionlist - Start Attacking');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22452;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22452);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22452, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2245200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Exarch - On Just Summoned - Run Script'),
(22452, 0, 1, 0, 0, 0, 100, 1, 2000, 4000, 0, 0, 0, 0, 11, 8258, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Reanimated Exarch - In Combat - Cast \'Devotion Aura\' (No Repeat)');
