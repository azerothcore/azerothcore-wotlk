-- DB update 2025_12_18_06 -> 2025_12_18_07

-- Update SAI and Comments
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31279;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31279);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31279, 0, 0, 2, 19, 0, 100, 512, 13221, 0, 0, 0, 0, 0, 53, 1, 31279, 0, 13221, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Quest \'I\'m Not Dead Yet!\' Taken - Start Waypoint Path 31279'),
(31279, 0, 1, 2, 19, 0, 100, 512, 13229, 0, 0, 0, 0, 0, 53, 1, 31279, 0, 13229, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Quest \'I\'m Not Dead Yet!\' Taken - Start Waypoint Path 31279'),
(31279, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Quest \'I\'m Not Dead Yet!\' Taken - Say Line 0'),
(31279, 0, 3, 4, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Aggro - Say Line 1'),
(31279, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 32595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Aggro - Cast \'Power Word: Shield\''),
(31279, 0, 5, 0, 0, 0, 100, 0, 1000, 1000, 2500, 2500, 0, 0, 11, 25054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - In Combat - Cast \'Holy Smite\''),
(31279, 0, 6, 0, 0, 0, 100, 0, 1000, 3000, 12000, 12000, 0, 0, 11, 17146, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - In Combat - Cast \'Shadow Word: Pain\''),
(31279, 0, 7, 0, 0, 0, 100, 0, 15000, 25000, 15000, 25000, 0, 0, 11, 32595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - In Combat - Cast \'Power Word: Shield\''),
(31279, 0, 8, 9, 40, 0, 100, 0, 24, 0, 0, 0, 0, 0, 1, 2, 8000, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Point 24 of Path Any Reached - Say Line 2'),
(31279, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 12000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Kamaros - On Point 24 of Path Any Reached - Despawn In 12000 ms');
