-- DB update 2025_07_22_03 -> 2025_07_23_00

-- Add Unit Flags (Immune To PC and Immune To NPC).
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512 WHERE (`entry` = 28416);

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28416;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28416);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28416, 0, 0, 0, 8, 0, 100, 0, 51964, 0, 0, 0, 0, 0, 80, 2841600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - On Spellhit \'Tormentor`s Incense\' - Run Script'),
(28416, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 4000, 8000, 0, 0, 11, 34298, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - In Combat - Cast \'Maul\'');

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2841600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2841600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - Actionlist - Remove FlagStandstate Sleep'),
(2841600, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - Actionlist - Say Line 0'),
(2841600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3, 'Rhunok - Actionlist - Set Orientation 3'),
(2841600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45111, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - Actionlist - Cast \'Enrage\''),
(2841600, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2841600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rhunok - Actionlist - Start Attacking');
