-- DB update 2026_08_11_00 -> 2026_08_11_01
-- The Prophet needs to be passive otherwise he might go back attacking before he reaches the middle
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29028) AND (`source_type` = 0) AND (`id` IN (7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29028, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prophet of Akali - Between 0-70% Health - Set Reactstate Passive');

-- Which means we need to reset Aggressive when Har'koa arrives :)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2902802) AND (`source_type` = 9) AND (`id` IN (18, 19));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2902802, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prophet of Akali - Actionlist - Set Reactstate Aggressive'),
(2902802, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prophet of Akali - On Script - Start Attacking');

-- And make Har'koa face the Prophet
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29050) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29050, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 53, 2, 29050, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Har\'koa - On Just Summoned - Start Waypoint Path 29050'),
(29050, 0, 1, 0, 40, 0, 100, 512, 5, 29050, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 29028, 100, 0, 0, 0, 0, 0, 0, 'Har\'koa - On Point 5 of Path 29050 Reached - Set Data 0 1'),
(29050, 0, 2, 0, 40, 0, 100, 512, 5, 29050, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 29028, 100, 0, 0, 0, 0, 0, 0, 'Har\'koa - On Point 5 of Path 29050 Reached - Set Orientation to \'Prophet of Akali\''),
(29050, 0, 3, 0, 38, 0, 100, 512, 0, 2, 0, 0, 0, 0, 80, 2905000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Har\'koa - On Data Set 0 2 - Run Script');
