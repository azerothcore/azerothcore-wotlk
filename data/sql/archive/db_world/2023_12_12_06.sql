-- DB update 2023_12_12_05 -> 2023_12_12_06
-- Tor'gan After completing mission ID 640

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2706;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2706) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2706, 0, 1, 0, 20, 0, 100, 0, 640, 0, 0, 0, 0, 0, 80, 270600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tor\'gan - Quest The Broken Sigil finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 270600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(270600, 9, 0, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 4093, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tor\'gan - On Script - cast "Reconstruction" 4093'),
(270600, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tor\'gan - On Script - Remove Npc Flag Questgiver'),
(270600, 9, 2, 0, 0, 0, 100, 0, 5200, 5200, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tor\'gan - On Script - Add Npc Flag Questgiver'),
(270600, 9, 3, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tor\'gan - On Script - Talk');

