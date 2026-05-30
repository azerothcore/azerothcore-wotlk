UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12818;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (12818);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (1281801, 1281802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
`event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
`action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
`target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
--
(12818, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                 'Ruul Snowhoof - On Respawn - Set Reactstate Passive'),
(12818, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 12819, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Ruul Snowhoof - On Respawn - Morph To Creature Ruul Snowhoof Bear Form'),
(12818, 0, 2, 3, 19, 0, 100, 0, 6482, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0,            'Ruul Snowhoof - On Quest Taken - Store Targetlist'),
(12818, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                 'Ruul Snowhoof - On Quest Taken - Set Reactstate Aggressive'),
(12818, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                'Ruul Snowhoof - On Quest Taken - Set Event Phase 1'),
(12818, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,                'Ruul Snowhoof - On Quest Taken - Set Run Off'),
--
(12818, 0, 6, 0, 1, 1, 100, 1, 100, 100, 0, 0, 0, 0, 53, 0, 12818, 0, 6482, 10000, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0,  'Ruul Snowhoof - Out of Combat - Start Waypoint'),
(12818, 0, 7, 0, 1, 1, 100, 1, 3100, 3100, 0, 0, 0, 0, 54, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,        'Ruul Snowhoof - Out of Combat - Pause Waypoint'),
(12818, 0, 8, 0, 1, 1, 100, 1, 3150, 3150, 0, 0, 0, 0, 1, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,         'Ruul Snowhoof - Out of Combat - Say Line 0'),
(12818, 0, 9, 0, 1, 1, 100, 513, 5000, 5000, 0, 0, 0, 0, 3, 0, 29421, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,      'Ruul Snowhoof - Out of Combat - Morph To Model 29421'),
(12818, 0, 10, 0, 1, 1, 100, 513, 5000, 5000, 0, 0, 0, 0, 3, 12819, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,     'Ruul Snowhoof - Out of Combat - Morph To Creature Ruul Snowhoof Bear Form'),
--
(12818, 0, 11, 0, 40, 1, 100, 1, 4, 12818, 0, 0, 0, 0, 80, 1281801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,     'Ruul Snowhoof - On Waypoint Reached - Run Script'),
(12818, 0, 12, 0, 40, 1, 100, 1, 7, 12818, 0, 0, 0, 0, 80, 1281802, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,     'Ruul Snowhoof - On Waypoint Reached - Run Script'),
--
(12818, 0, 13, 14, 58, 1, 100, 1, 16, 12818, 0, 0, 0, 0, 1, 1, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,       'Ruul Snowhoof - On Waypoint Finished - Say Line 1'),
(12818, 0, 14, 15, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,             'Ruul Snowhoof - On Waypoint Finished - Demorph'),
(12818, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 15, 6482, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0,         'Ruul Snowhoof - On Waypoint Finished - Quest Credit'),
--
(1281801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 3921, 7, 60000, 1, 1, 0, 8, 0, 0, 0, 0, 3439.62, -616.591, 171.968, 4.30965,       'Ruul Snowhoof - Actionlist - Summon Creature Thistlefur Ursa'),
(1281801, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 12, 3922, 7, 60000, 1, 1, 0, 8, 0, 0, 0, 0, 3439.62, -616.591, 171.968, 4.30965, 'Ruul Snowhoof - Actionlist - Summon Creature Thistlefur Totemic'),
(1281801, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 12, 3926, 7, 60000, 1, 1, 0, 8, 0, 0, 0, 0, 3439.62, -616.591, 171.968, 4.30965, 'Ruul Snowhoof - Actionlist - Summon Creature Thistlefur Pathfinder'),
(1281802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 3921, 7, 60000, 1, 1, 0, 8, 0, 0, 0, 0, 3495.9, -526.57, 188.322, 4.62782,         'Ruul Snowhoof - Actionlist - Summon Creature Thistlefur Ursa'),
(1281802, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 12, 3922, 7, 60000, 1, 1, 0, 8, 0, 0, 0, 0, 3495.9, -526.57, 188.322, 4.62782,   'Ruul Snowhoof - Actionlist - Summon Creature Thistlefur Totemic'),
(1281802, 9, 2, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 12, 3926, 7, 60000, 1, 1, 0, 8, 0, 0, 0, 0, 3495.9, -526.57, 188.322, 4.62782,   'Ruul Snowhoof - Actionlist - Summon Creature Thistlefur Pathfinder');

DELETE FROM `waypoints` WHERE `entry` = 12818;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(12818, 1, 3339.1, -693.613, 162.218, NULL, 0, 'Ruul Snowhoof'),
(12818, 2, 3343.94, -682.272, 163.039, NULL, 0, 'Ruul Snowhoof'),
(12818, 3, 3381.5, -659.834, 162.487, NULL, 0, 'Ruul Snowhoof'),
(12818, 4, 3398.88, -639.631, 164.475, NULL, 0, 'Ruul Snowhoof'),
(12818, 5, 3435.28, -626.7, 169.293, NULL, 0, 'Ruul Snowhoof'),
(12818, 6, 3448.07, -602.344, 173.647, NULL, 0, 'Ruul Snowhoof'),
(12818, 7, 3494.7, -562.032, 181.617, NULL, 0, 'Ruul Snowhoof'),
(12818, 8, 3495.38, -544.667, 185.993, NULL, 0, 'Ruul Snowhoof'),
(12818, 9, 3498.32, -511.16, 188.352, NULL, 0, 'Ruul Snowhoof'),
(12818, 10, 3495.54, -495.119, 185.284, NULL, 0, 'Ruul Snowhoof'),
(12818, 11, 3456.1, -479.545, 170.831, NULL, 0, 'Ruul Snowhoof'),
(12818, 12, 3431.75, -460.84, 160.697, NULL, 0, 'Ruul Snowhoof'),
(12818, 13, 3383.33, -423.934, 148.55, NULL, 0, 'Ruul Snowhoof'),
(12818, 14, 3310.56, -450.354, 150.207, NULL, 0, 'Ruul Snowhoof'),
(12818, 15, 3281.33, -523.056, 155.155, NULL, 0, 'Ruul Snowhoof'),
(12818, 16, 3236.17, -518.389, 148.701, NULL, 0, 'Ruul Snowhoof');
