-- DB update 2022_06_29_00 -> 2022_06_29_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (237, 238);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 237) AND (`source_type` = 0) AND (`id` IN (0));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 238) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(237, 0, 0, 0, 1, 0, 100, 0, 10000, 10000, 180000, 180000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Farmer Furlbrow - Out of Combat - Say Line 0'),
(238, 0, 0, 0, 1, 0, 100, 0, 6000, 8000, 240000, 240000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Verna Furlbrow - Out of Combat - Say Line 0');
