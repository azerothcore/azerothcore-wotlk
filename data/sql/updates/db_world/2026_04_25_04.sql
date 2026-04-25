-- DB update 2026_04_25_03 -> 2026_04_25_04

-- Update General SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28511;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28511) AND (`source_type` = 0) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28511, 0, 3, 0, 108, 0, 100, 512, 3, 2851100, 0, 0, 0, 0, 80, 2851101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Point 3 of Path 2851100 Reached - Run Script'),
(28511, 0, 4, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 51852, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Died - Remove Aura \'The Eye of Acherus\'');

-- Delete Action List rows (they are moved on new Action List).
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2851100) AND (`source_type` = 9) AND (`id` IN (5, 6, 7, 8, 9, 10));

-- Create new Action List.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2851101) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2851101, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted On'),
(2851101, 9, 1, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 11, 51890, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Flight\''),
(2851101, 9, 2, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 28, 51923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Remove Aura \'Eye of Acherus Flight (Boost)\''),
(2851101, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 28, 51860, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Remove Aura \'Serverside - Root Self\''),
(2851101, 9, 4, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Say Line 1'),
(2851101, 9, 5, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted Off');
