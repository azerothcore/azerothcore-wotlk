-- DB update 2026_05_17_07 -> 2026_05_18_00

-- Set idle for Burning Blade Fanatics and Apprentices.
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 3198) AND (`guid` IN (6430, 6431));
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 3197) AND (`guid` IN (6427, 6429));

-- Remove Old Waypoint from Creature Addon and set Movement Type to 0.
UPDATE `creature` SET `MovementType` = 0 WHERE (`id1` = 3203) AND (`guid` IN (6455));
UPDATE `creature_addon` SET `path_id` = 0 WHERE (`guid` IN (6455));

-- Delete old Fizzle Darkstorm waypoint and add a sniffed new one.
DELETE FROM `waypoint_data` WHERE (`id` IN (645500));
INSERT INTO `waypoint_data` (`id`,  `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(645500, 1, 869.7513, -4202.463, -14.066155, NULL, 0, 0, 0, 100, 0),
(645500, 2, 871.55255, -4210.9136, -12.093292, NULL, 0, 0, 0, 100, 0),
(645500, 3, 876.02, -4217.9136, -11.525927, NULL, 25000, 0, 0, 100, 0),
(645500, 4, 870.5361, -4208.033, -13.908268, NULL, 0, 0, 0, 100, 0),
(645500, 5, 867.7095, -4194.5493, -14.389078, NULL, 0, 0, 0, 100, 0),
(645500, 6, 868.6138, -4189.563, -14.07393, NULL, 45000, 0, 0, 100, 0);

-- Set Fizzle Darkstorm SmartAI and update old comments.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3203;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 3203);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3203, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 0, 0, 11, 11939, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - Out of Combat - Cast \'Summon Imp\' (No Repeat)'),
(3203, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2400, 3800, 0, 0, 11, 20791, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - In Combat - Cast \'Shadow Bolt\''),
(3203, 0, 2, 0, 2, 0, 100, 0, 0, 50, 20000, 30000, 0, 0, 11, 7290, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - Between 0-50% Health - Cast \'Soul Siphon\''),
(3203, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - Between 0-15% Health - Flee For Assist (No Repeat)'),
(3203, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 645500, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - On Reset - Start Path 645500'),
(3203, 0, 5, 0, 108, 0, 100, 0, 3, 645500, 0, 0, 0, 0, 80, 320300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - On Point 3 of Path 645500 Reached - Run Script');

-- Add Action List.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 320300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(320300, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 21157, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - Actionlist - Cast \'Dark Channeling\''),
(320300, 9, 1, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 0, 0, 28, 21157, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzle Darkstorm - Actionlist - Remove Aura \'Dark Channeling\'');
