-- DB update 2025_09_23_03 -> 2025_09_26_00
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28600;
DELETE FROM `waypoint_scripts` WHERE `guid`=776;
UPDATE `waypoint_data` SET `action`=0 WHERE `id`=1133640 AND `point`=3;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -113364);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-113364, 0, 0, 0, 108, 0, 100, 0, 3, 1133640, 0, 0, 0, 0, 11, 52059, 0, 0, 0, 0, 0, 9, 28387, 0, 30, 0, 0, 0, 0, 0, 'Heb\'Drakkar Headhunter - On Point 3 of Path 1133640 Reached - Cast \'Axe Throw\'');
