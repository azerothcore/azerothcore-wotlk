-- DB update 2022_11_12_11 -> 2022_11_12_12
-- Removes Rock Shell ability
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4661;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4661) AND (`source_type` = 0);
-- Add Summon Gelkis Rumbler
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4651;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4651) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4651, 0, 2, 0, 1, 0, 100, 0, 5000, 5000, 0, 0, 0, 11, 9653, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gelkis Earthcaller - Out of Combat - Cast \'Summon Gelkis Rumbler\'');
