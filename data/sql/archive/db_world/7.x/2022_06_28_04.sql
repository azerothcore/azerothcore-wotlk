-- DB update 2022_06_28_03 -> 2022_06_28_04
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25063;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25063);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25063, 0, 0, 0, 10, 0, 100, 0, 0, 70, 3000, 6500, 1, 11, 45189, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Hawkrider - Within 0-70 Range Out of Combat LoS - Cast \'Dawnblade Attack\'');
