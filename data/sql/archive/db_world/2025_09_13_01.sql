-- DB update 2025_09_13_00 -> 2025_09_13_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28217) AND (`source_type` = 0) AND (`id` IN (8, 9, 10, 16, 17, 18, 19, 20, 21));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28217, 0, 8, 11, 62, 0, 100, 512, 9684, 0, 0, 0, 0, 0, 2, 774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Gossip Option Select - Set Faction (Alliance)'),
(28217, 0, 9, 11, 62, 0, 100, 512, 9684, 0, 0, 0, 0, 0, 2, 775, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Gossip Option Select - Set Faction (Horde)'),
(28217, 0, 16, 0, 40, 0, 100, 512, 16, 282170, 0, 0, 0, 0, 80, 2821701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Point 16 of Path 282170 Reached - Run Script'),
(28217, 0, 17, 0, 40, 0, 100, 512, 17, 282171, 0, 0, 0, 0, 80, 2821701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Point 17 of Path 282171 Reached - Run Script'),
(28217, 0, 18, 0, 40, 0, 100, 512, 16, 282172, 0, 0, 0, 0, 80, 2821701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Point 16 of Path 282172 Reached - Run Script'),
(28217, 0, 19, 0, 40, 0, 100, 512, 19, 282173, 0, 0, 0, 0, 80, 2821701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Point 19 of Path 282173 Reached - Run Script'),
(28217, 0, 20, 0, 40, 0, 100, 512, 21, 282174, 0, 0, 0, 0, 80, 2821701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Point 21 of Path 282174 Reached - Run Script'),
(28217, 0, 21, 0, 40, 0, 100, 512, 17, 282175, 0, 0, 0, 0, 80, 2821701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - On Point 17 of Path 282175 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2821700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2821700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Set Npc Flag '),
(2821700, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Say Line 2'),
(2821700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 282170, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282170'),
(2821700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 282171, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282171'),
(2821700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 282172, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282172'),
(2821700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 282173, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282173'),
(2821700, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 282174, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282174'),
(2821700, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 282175, 0, 12570, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282175');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (3, 4, 5, 6, 7, 8)) AND (`SourceEntry` = 2821700) AND (`SourceId` = 9) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 28217);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 2821700, 9, 0, 31, 1, 3, 28217, 101030, 0, 0, 0, '', 'Injured Rainspeaker Oracle - GUID 1'),
(22, 4, 2821700, 9, 0, 31, 1, 3, 28217, 101028, 0, 0, 0, '', 'Injured Rainspeaker Oracle - GUID 2'),
(22, 5, 2821700, 9, 0, 31, 1, 3, 28217, 101048, 0, 0, 0, '', 'Injured Rainspeaker Oracle - GUID 3'),
(22, 6, 2821700, 9, 0, 31, 1, 3, 28217, 100983, 0, 0, 0, '', 'Injured Rainspeaker Oracle - GUID 4'),
(22, 7, 2821700, 9, 0, 31, 1, 3, 28217, 101029, 0, 0, 0, '', 'Injured Rainspeaker Oracle - GUID 5'),
(22, 8, 2821700, 9, 0, 31, 1, 3, 28217, 101031, 0, 0, 0, '', 'Injured Rainspeaker Oracle - GUID 6');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2821701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2821701, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Say Line 3'),
(2821701, 9, 1, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Say Line 4'),
(2821701, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 52100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Cast \'Summon Frenyheart Tracker\''),
(2821701, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 53, 1, 282176, 0, 0, 10000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Rainspeaker Oracle - Actionlist - Start Waypoint Path 282176');

-- Add Waypoints
DELETE FROM `waypoints` WHERE `entry` IN (282170, 282171, 282172, 282173, 282174, 282175, 282176);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
-- path 1
(282170, 1, 5399.74, 4528.052, -135.478, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 2, 5405.5356, 4526.751, -140.8915, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 3, 5413.198, 4523.4453, -143.88805, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 4, 5422.979, 4519.949, -146.1948, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 5, 5447.172, 4549.334, -149.498, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 6, 5457.187, 4574.096, -147.5059, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 7, 5469.797, 4602.933, -145.9535, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 8, 5482.532, 4609.663, -139.9535, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 9, 5491.722, 4630.365, -135.7035, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 10, 5519.538, 4645.676, -135.4096, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 11, 5547.847, 4651.108, -134.7803, NULL, 'Injured Rainspeaker Oracle 1'), -- Cmangos scriptId 2821701
(282170, 12, 5576.821, 4653.372, -136.5378, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 13, 5597.359, 4641.149, -136.5378, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 14, 5615.371, 4624.71, -137.6426, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 15, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 1'),
(282170, 16, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 1'),
-- path 2
(282171, 1, 5484.66, 4455.59, -140.235, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 2, 5503.24, 4450.52, -146.32, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 3, 5516.12, 4465.61, -147.148, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 4, 5507.12, 4490.48, -147.128, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 5, 5505.15, 4516.67, -147.128, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 6, 5506.33, 4538.27, -145.911, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 7, 5506.38, 4559.37, -141.97, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 8, 5496.35, 4580.67, -139.158, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 9, 5492.16, 4614.84, -137.666, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 10, 5491.722, 4630.365, -135.7035, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 11, 5519.538, 4645.676, -135.4096, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 12, 5547.847, 4651.108, -134.7803, NULL, 'Injured Rainspeaker Oracle 2'), -- Cmangos scriptId 2821701
(282171, 13, 5576.821, 4653.372, -136.5378, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 14, 5597.359, 4641.149, -136.5378, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 15, 5615.371, 4624.71, -137.6426, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 16, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 2'),
(282171, 17, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 2'), -- Cmangos scriptId 2821702
-- path 3
(282172, 1, 5467.172, 4516.1226, -132.3954, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 2, 5477.16, 4516.51, -136.586, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 3, 5482.25, 4512.48, -142.981, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 4, 5485.95, 4513.28, -145.649, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 5, 5499.73, 4526.61, -147.318, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 6, 5506.38, 4559.37, -141.97 , NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 7, 5496.35, 4580.67, -139.158, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 8, 5492.16, 4614.84, -137.666, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 9, 5491.722, 4630.365, -135.7035, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 10, 5519.538, 4645.676, -135.4096, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 11, 5547.847, 4651.108, -134.7803, NULL, 'Injured Rainspeaker Oracle 3'), -- Cmangos scriptId 2821701
(282172, 12, 5576.821, 4653.372, -136.5378, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 13, 5597.359, 4641.149, -136.5378, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 14, 5615.371, 4624.71, -137.6426, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 15, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 3'),
(282172, 16, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 3'),
-- path 4
(282173, 1, 5470.1, 4397.22, -141.991, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 2, 5474.27, 4418.16, -145.096, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 3, 5484, 4433.44, -145.945, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 4, 5503.24, 4450.52, -146.32 , NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 5, 5516.12, 4465.61, -147.148, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 6, 5507.12, 4490.48, -147.128, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 7, 5505.15, 4516.67, -147.128, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 8, 5506.33, 4538.27, -145.911, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 9, 5506.38, 4559.37, -141.97 , NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 10, 5496.35, 4580.67, -139.158, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 11, 5492.16, 4614.84, -137.666, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 12, 5491.722, 4630.365, -135.7035, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 13, 5519.538, 4645.676, -135.4096, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 14, 5547.847, 4651.108, -134.7803, NULL, 'Injured Rainspeaker Oracle 4'), -- Cmangos scriptId 2821701
(282173, 15, 5576.821, 4653.372, -136.5378, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 16, 5597.359, 4641.149, -136.5378, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 17, 5615.371, 4624.71, -137.6426, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 18, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 4'),
(282173, 19, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 4'), -- Cmangos scriptId 2821702
-- path 5
(282174, 1, 5422.91, 4402.33, -138.328, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 2, 5431.45, 4409.64, -145.356, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 3, 5453.34, 4417.19, -145.739, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 4, 5470.28, 4425.27, -146.101, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 5, 5484, 4433.44, -145.945, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 6, 5503.24, 4450.52, -146.32 , NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 7, 5516.12, 4465.61, -147.148, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 8, 5507.12, 4490.48, -147.128, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 9, 5505.15, 4516.67, -147.128, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 10, 5506.33, 4538.27, -145.911, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 11, 5506.38, 4559.37, -141.97 , NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 12, 5496.35, 4580.67, -139.158, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 13, 5492.16, 4614.84, -137.666, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 14, 5491.722, 4630.365, -135.7035, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 15, 5519.538, 4645.676, -135.4096, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 16, 5547.847, 4651.108, -134.7803, NULL, 'Injured Rainspeaker Oracle 5'), -- Cmangos scriptId 2821701
(282174, 17, 5576.821, 4653.372, -136.5378, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 18, 5597.359, 4641.149, -136.5378, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 19, 5615.371, 4624.71, -137.6426, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 20, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 5'),
(282174, 21, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 5'), -- Cmangos scriptId 2821702
-- path 6
(282175, 1, 5415.97, 4567.51, -129.618, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 2, 5418.6, 4557.18, -134.159 , NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 3, 5429.31, 4556.57, -135.49 , NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 4, 5434.51, 4561.48, -136.679, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 5, 5441.12, 4562.36, -140.188, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 6, 5447.86, 4566.34, -145.656, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 7, 5457.187, 4574.096, -147.5059, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 8, 5469.797, 4602.933, -145.9535, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 9, 5482.532, 4609.663, -139.9535, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 10, 5491.722, 4630.365, -135.7035, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 11, 5519.538, 4645.676, -135.4096, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 12, 5547.847, 4651.108, -134.7803, NULL, 'Injured Rainspeaker Oracle 6'), -- Cmangos scriptId 2821701
(282175, 13, 5576.821, 4653.372, -136.5378, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 14, 5597.359, 4641.149, -136.5378, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 15, 5615.371, 4624.71, -137.6426, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 16, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 6'),
(282175, 17, 5637.85, 4597.664, -137.1443, NULL, 'Injured Rainspeaker Oracle 6'), -- Cmangos scriptId 2821702
-- path home
(282176, 1, 5642.518, 4593.687, -137.6443, NULL, 'Injured Rainspeaker Oracle Home'),
(282176, 2, 5680.222, 4590.04, -132.5749, NULL, 'Injured Rainspeaker Oracle Home'),
(282176, 3, 5698.854, 4587.619, -125.0749, NULL, 'Injured Rainspeaker Oracle Home'),
(282176, 4, 5705.868, 4579.395, -120.0971, NULL, 'Injured Rainspeaker Oracle Home'),
(282176, 5, 5724.732, 4560.532, -119.2611, NULL, 'Injured Rainspeaker Oracle Home');

-- Add Missing Spawn
DELETE FROM `creature` WHERE (`id1` = 28217) AND (`guid` = 101048);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(101048, 28217, 0, 0, 571, 0, 0, 1, 1, 0, 5459.16, 4515.15, -134.444, 0.80285, 300, 0, 0, 9103, 8313, 0, 0, 0, 0, '', 0, 0, NULL);
