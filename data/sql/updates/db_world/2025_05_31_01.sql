-- DB update 2025_05_31_00 -> 2025_05_31_01

-- Remove Flight flag
UPDATE `creature_template_movement` SET `Flight` = 0 WHERE (`CreatureId` = 28511);

-- Add Waypoint
DELETE FROM `waypoint_data` WHERE `id` IN ("2851100");
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
("2851100", 1, 2341.5713, -5672.797, 538.3942, NULL, 0, 0, 0, 100, 0),
("2851100", 2, 1957.3962, -5844.1055, 273.86673, NULL, 0, 0, 0, 100, 0),
("2851100", 3, 1758.007, -5876.7847, 166.86671, NULL, 0, 0, 0, 100, 0);

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2851100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2851100, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 51892, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Visual\''),
(2851100, 9, 1, 0, 0, 0, 100, 512, 6000, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Say Line 0'),
(2851100, 9, 2, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 11, 51923, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Flight (Boost)\''),
(2851100, 9, 3, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted Off'),
(2851100, 9, 4, 0, 0, 0, 100, 512, 100, 100, 0, 0, 0, 0, 232, 2851100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Start Path 2851100'),
(2851100, 9, 5, 0, 0, 0, 100, 512, 19200, 19200, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted On'),
(2851100, 9, 6, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 11, 51890, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Cast \'Eye of Acherus Flight\''),
(2851100, 9, 7, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 28, 51923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Remove Aura \'Eye of Acherus Flight (Boost)\''),
(2851100, 9, 8, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 28, 51860, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Remove Aura \'Serverside - Root Self\''),
(2851100, 9, 9, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Say Line 1'),
(2851100, 9, 10, 0, 0, 0, 100, 512, 500, 500, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - Actionlist - Set Rooted Off');

-- Set General SmartAI and remove script name
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 28511;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28511);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28511, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Summoned - Set Rooted On'),
(28511, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 51860, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Summoned - Cast \'Serverside - Root Self\''),
(28511, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2851100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of Acherus - On Just Summoned - Run Script');
