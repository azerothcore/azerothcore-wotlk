-- DB update 2025_09_23_01 -> 2025_09_23_02
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` in (26115, -96556)) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26115,0,0,0,25,0,100,512, 0,0,0,0,0,0, 53,0,26115,1,0,0,2, 1,0,0,0,0, 0,0,0,0,'Darkfallen Bloodbearer - On Reset - Start Waypoint');

DELETE FROM `waypoints` WHERE (`entry` in (26115, 96556));
INSERT INTO `waypoints` (entry, pointid, position_x, position_y, position_z, orientation, delay, point_comment) VALUES
(26115, 1, 3923.71, 3581.69, 70.9999, null, 0, 'Darkfallen Bloodbearer'),
(26115, 2, 3918.45, 3585.35, 69.3552, null, 0, 'Darkfallen Bloodbearer'),
(26115, 3, 3896.45, 3596.38, 55.8367, null, 0, 'Darkfallen Bloodbearer'),
(26115, 4, 3879.15, 3604.24, 46.8601, null, 0, 'Darkfallen Bloodbearer'),
(26115, 5, 3871.85, 3607.03, 47.2741, null, 0, 'Darkfallen Bloodbearer'),
(26115, 6, 3868.65, 3598.51, 47.017, null, 0, 'Darkfallen Bloodbearer'),
(26115, 7, 3853.92, 3592.71, 47.1739, null, 0, 'Darkfallen Bloodbearer'),
(26115, 8, 3803.91, 3593.67, 47.765, null, 0, 'Darkfallen Bloodbearer'),
(26115, 9, 3854.77, 3655.25, 47.1985, null, 0, 'Darkfallen Bloodbearer'),
(26115, 10, 3877.82, 3691.49, 46.6437, null, 0, 'Darkfallen Bloodbearer'),
(26115, 11, 3895.21, 3694.12, 53.6007, null, 0, 'Darkfallen Bloodbearer'),
(26115, 12, 3910.21, 3694.9, 62.0738, null, 0, 'Darkfallen Bloodbearer'),
(26115, 13, 3932.8, 3693.62, 61.2775, null, 0, 'Darkfallen Bloodbearer'),
(26115, 14, 3954.78, 3655.3, 62.6392, null, 0, 'Darkfallen Bloodbearer'),
(26115, 15, 3948.77, 3635.18, 73.1082, null, 0, 'Darkfallen Bloodbearer'),
(26115, 16, 3946.09, 3627.11, 74.2526, null, 0, 'Darkfallen Bloodbearer'),
(26115, 17, 3926.76, 3578.1, 70.8602, null, 0, 'Darkfallen Bloodbearer');

DELETE FROM `creature_addon` WHERE (`guid` = 96556);

UPDATE `creature`
SET `MovementType` = 2, `wander_distance` = 0
WHERE `id1` = 26115;

UPDATE  `creature_template`
SET `MovementType` = 2
WHERE entry = 26115;