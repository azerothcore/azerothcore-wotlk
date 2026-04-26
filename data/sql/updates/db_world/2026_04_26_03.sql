-- DB update 2026_04_26_02 -> 2026_04_26_03

-- Wipe creature_template_movement.
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28511);

-- Delete old waypoint.
DELETE FROM `waypoint_data` WHERE (`id` IN (2851100));

-- Add new waypoint.
DELETE FROM `waypoints` WHERE `entry` IN (2851100);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2851100, 1, 2341.57, -5672.8, 538.394, NULL, 'Eye of Acherus Flight'),
(2851100, 2, 1957.4, -5844.11, 273.867, NULL, 'Eye of Acherus Flight'),
(2851100, 3, 1758.01, -5876.78, 166.867, NULL, 'Eye of Acherus Flight');

-- Edit SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28511;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28511);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28511, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Summoned - Set Rooted On'),
(28511, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 51860, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Summoned - Cast \'Serverside - Root Self\''),
(28511, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2851100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Summoned - Run Script'),
(28511, 0, 3, 0, 40, 0, 100, 512, 3, 2851100, 0, 0, 0, 0, 80, 2851101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Point 3 of Path 2851100 Reached - Run Script'),
(28511, 0, 4, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 51852, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Died - Remove Aura \'The Eye of Acherus\'');

-- Edit Timed Action Lists
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2851100, 2851101));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2851100, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 51892, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Visual\''),
(2851100, 9, 1, 0, 0, 0, 100, 512, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Say Line 0'),
(2851100, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 51923, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Flight (Boost)\''),
(2851100, 9, 3, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted Off'),
(2851100, 9, 4, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 2851100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Start Waypoint Path 2851100'),
(2851101, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted On'),
(2851101, 9, 1, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 11, 51890, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Flight\''),
(2851101, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 51923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Remove Aura \'Eye of Acherus Flight (Boost)\''),
(2851101, 9, 3, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 28, 51860, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Remove Aura \'Serverside - Root Self\''),
(2851101, 9, 4, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Say Line 1'),
(2851101, 9, 5, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted Off');
