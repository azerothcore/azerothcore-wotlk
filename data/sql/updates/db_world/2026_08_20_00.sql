-- DB update 2026_08_19_04 -> 2026_08_20_00
/* Roger Owens
17:14:45.580 Point 4
Text: Wait, what's that smell? (1)
17:14:50.442
FaceDirection: 6.2657318115234375
17:14:51.660
Text: Can't be me, I took a bath 3 days ago! (5)
17:14:57.728
FaceDirection: 4.520402908325195312
17:14:58.936
Text: Oh, close call. It's just the grain here. (5)
17:15:03.790
17:15:05.819 Point 5
FaceDirection: 1.134464025497436523
17:15:06.014
Text: Wait a second. Grain isn't supposed to smell like THAT! I better go find a guard. (0)
17:15:08.662
Emote ID: 5 (OneShotExclamation)
17:15:13.508
Resume Path
*/

DELETE FROM `waypoint_data` WHERE `id` = 279031;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(279031, 1, 1589.8826, 608.7765, 99.59897, NULL, 0),
(279031, 2, 1588.607, 616.2296, 99.80186, NULL, 0),
(279031, 3, 1586.0604, 619.95734, 99.89137, NULL, 0),
(279031, 4, 1580.0106, 623.68945, 99.884575, NULL, 18210),
(279031, 5, 1576.2976, 620.4587, 99.491745, NULL, 7700),
(279031, 6, 1586.5234, 620.93274, 99.909775, NULL, 0),
(279031, 7, 1589.123, 612.8749, 99.7128, NULL, 0),
(279031, 8, 1591.0701, 601.6522, 99.4684, NULL, 0),
(279031, 9, 1592.5011, 591.76886, 99.187996, NULL, 0);

DELETE FROM `creature_text` WHERE (`CreatureID` = 27903);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27903, 0, 0, 'Ok, enough work for now. Time for refreshments and a little conversation in the inn.', 12, 0, 100, 1, 0, 0, 27247, 0, 'Roger Owens'),
(27903, 1, 0, 'Wait, what\'s that smell?', 12, 0, 100, 1, 0, 0, 27248, 0, 'Roger Owens'),
(27903, 2, 0, 'Can\'t be me, I took a bath 3 days ago!', 12, 0, 100, 5, 0, 0, 27249, 0, 'Roger Owens'),
(27903, 3, 0, 'Oh, close call. It\'s just the grain here.', 12, 0, 100, 5, 0, 0, 27250, 0, 'Roger Owens'),
(27903, 4, 0, 'Wait a second. Grain isn\'t supposed to smell like THAT! I better go find a guard.', 12, 0, 100, 0, 0, 0, 27252, 0, 'Roger Owens');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27903;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27903);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27903, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2790300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - On Action 1 Done - Run Script'),
(27903, 0, 1, 0, 108, 0, 100, 0, 4, 279031, 0, 0, 0, 0, 80, 2790301, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - On Point 4 of Path 279031 Reached - Run Script'),
(27903, 0, 2, 0, 108, 0, 100, 0, 5, 279031, 0, 0, 0, 0, 80, 2790302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - On Point 5 of Path 279031 Reached - Run Script'),
(27903, 0, 3, 0, 109, 0, 100, 0, 0, 279031, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - On Path 279031 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2790300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2790300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.535889744758606, 'Roger Owens - Actionlist - Set Orientation 1.535889744758606'),
(2790300, 9, 1, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Remove FlagStandstate Kneel'),
(2790300, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Say Line 0'),
(2790300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 279031, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Start Path 279031');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2790301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2790301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Say Line 1'),
(2790301, 9, 1, 0, 0, 0, 100, 0, 4860, 4860, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 6.2657318115234375, 'Roger Owens - Actionlist - Set Orientation 6.2657318115234375'),
(2790301, 9, 2, 0, 0, 0, 100, 0, 1220, 1220, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Say Line 2'),
(2790301, 9, 3, 0, 0, 0, 100, 0, 6060, 6060, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.520402908325195, 'Roger Owens - Actionlist - Set Orientation 4.520402908325195'),
(2790301, 9, 4, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Say Line 3');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2790302);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2790302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.1344640254974365, 'Roger Owens - Actionlist - Set Orientation 1.1344640254974365'),
(2790302, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Say Line 4'),
(2790302, 9, 2, 0, 0, 0, 100, 0, 2650, 2650, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Roger Owens - Actionlist - Play Emote 5');

/* Sergeant Morigan & Silvio Perelli
17:15:50.141
Text: You don't mind me checking out your merchandise for signs of tampering, do you? (1)
17:15:56.211 Perelli
Text: Nope. (1)
17:15:58.439
Start Path
17:16:02.074
FaceDirection: 0.767944872379302978
17:16:03.292
StandState: 8
17:16:04.701
Text: Wait, what is this? You've been holding out on me, Perelli! (0)
17:16:06.938
FaceDirection: 2.617993831634521484
StandState: 0
17:16:10.778 Perelli
FaceDirection: 5.916666030883789062
Text: What are you talking about, Sergeant! (5)
17:16:15.444
Text: I'm confiscating this suspicious grain, Perelli. We were looking for signs of tampered food, and it would be in your best interest to stay put while Prince Arthas checks this out. (1)
17:16:23.936 Perelli
Text: You have to believe me, I'm innocent! (20)
17:16:30.005
Text: We'll see about that, Perelli. We'll see about that. (25)
17:16:34.864
Resume Path
*/
DELETE FROM `waypoint_data` WHERE `id` = 278771;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(278771, 1, 1565.856, 668.4106, 102.06239, NULL, 0),
(278771, 2, 1569.2599, 668.55426, 102.14705, NULL, 32790), -- Event 1
(278771, 3, 1573.4156, 658.6976, 102.08973, NULL, 0),
(278771, 4, 1580.717, 651.529, 101.45471, NULL, 0),
(278771, 5, 1588.5903, 650.36957, 101.3488, NULL, 0),
(278771, 6, 1593.7969, 661.7178, 102.69629, NULL, 0),
(278771, 7, 1599.9355, 674.2949, 104.35858, NULL, 0),
(278771, 8, 1606.4768, 687.72473, 105.89872, NULL, 0),
(278771, 9, 1611.9282, 700.4782, 107.59263, NULL, 0);

DELETE FROM `creature_text` WHERE (`CreatureID` = 27877) AND (`GroupID` IN (6, 7, 8, 9));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27877, 6, 0, 'You don\'t mind me checking out your merchandise for signs of tampering, do you?', 12, 0, 100, 1, 0, 0, 27205, 0, 'Sergeant Morigan - Plague Grain Dispelled'),
(27877, 7, 0, 'Wait, what is this? You\'ve been holding out on me, Perelli!', 12, 0, 100, 0, 0, 0, 27206, 0, 'Sergeant Morigan - Plague Grain Dispelled'),
(27877, 8, 0, 'I\'m confiscating this suspicious grain, Perelli. We were looking for signs of tampered food, and it would be in your best interest to stay put while Prince Arthas checks this out.', 12, 0, 100, 1, 0, 0, 27210, 0, 'Sergeant Morigan - Plague Grain Dispelled'),
(27877, 9, 0, 'We\'ll see about that, Perelli. We\'ll see about that.', 12, 0, 100, 25, 0, 0, 27216, 0, 'Sergeant Morigan - Plague Grain Dispelled');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27876);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27876, 0, 0, 'Yes, Sergeant Morigan.', 12, 0, 100, 273, 0, 0, 27202, 0, ''),
(27876, 0, 1, 'Yes, sir.', 12, 0, 100, 273, 0, 0, 27201, 0, ''),
(27876, 1, 0, 'No, Sergeant.', 12, 0, 100, 1, 0, 0, 27198, 0, ''),
(27876, 1, 1, 'No, sir.', 12, 0, 100, 1, 0, 0, 27199, 0, ''),
(27876, 2, 0, 'Nope.', 12, 0, 100, 1, 0, 0, 27200, 0, 'Silvio Perelli - Plague Grain Dispelled'),
(27876, 3, 0, 'What are you talking about, Sergeant!', 12, 0, 100, 5, 0, 0, 27208, 0, 'Silvio Perelli - Plague Grain Dispelled'),
(27876, 4, 0, 'You have to believe me, I\'m innocent!', 12, 0, 100, 20, 0, 0, 27213, 0, 'Silvio Perelli - Plague Grain Dispelled');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27877);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27877, 0, 0, 0, 1, 1, 100, 0, 30000, 35000, 30000, 35000, 0, 0, 87, 2787700, 2787701, 2787702, 2787703, 2787704, 2787705, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Out of Combat - Run Random Script (Phase 1)'),
(27877, 0, 1, 0, 52, 1, 100, 0, 0, 27877, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 0 Over - Say Line 0 (Phase 1)'),
(27877, 0, 2, 0, 52, 1, 100, 0, 1, 27877, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 1 Over - Say Line 1 (Phase 1)'),
(27877, 0, 3, 0, 52, 1, 100, 0, 2, 27877, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 2 Over - Say Line 0 (Phase 1)'),
(27877, 0, 4, 0, 52, 1, 100, 0, 3, 27877, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 3 Over - Say Line 0 (Phase 1)'),
(27877, 0, 5, 0, 52, 1, 100, 0, 4, 27877, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 4 Over - Say Line 1 (Phase 1)'),
(27877, 0, 6, 0, 52, 1, 100, 0, 5, 27877, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27876, 10, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Text 5 Over - Say Line 1 (Phase 1)'),
(27877, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Respawn - Set Event Phase 1'),
(27877, 0, 8, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2787706, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Action 1 Done - Run Script'),
(27877, 0, 9, 0, 108, 0, 100, 0, 2, 278771, 0, 0, 0, 0, 80, 2787707, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Point 2 of Path 278771 Reached - Run Script'),
(27877, 0, 10, 0, 109, 0, 100, 0, 0, 278771, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - On Path 278771 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2787706);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2787706, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Set Event Phase 0'),
(2787706, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 6'),
(2787706, 9, 2, 0, 0, 0, 100, 0, 6070, 6070, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 27876, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Perelli Say Line 2'),
(2787706, 9, 3, 0, 0, 0, 100, 0, 2230, 2230, 0, 0, 0, 0, 232, 278771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Start Path 278771');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2787707);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2787707, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.767944872379303, 'Sergeant Morigan - Actionlist - Set Orientation 0.767944872379303'),
(2787707, 9, 1, 0, 0, 0, 100, 0, 1220, 1220, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Set Flag Standstate Kneel'),
(2787707, 9, 2, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 7'),
(2787707, 9, 3, 0, 0, 0, 100, 0, 2230, 2230, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.6179938316345215, 'Sergeant Morigan - Actionlist - Set Orientation 2.6179938316345215'),
(2787707, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Remove FlagStandstate Kneel'),
(2787707, 9, 5, 0, 0, 0, 100, 0, 3840, 3840, 0, 0, 0, 0, 231, 1, 0, 0, 0, 0, 0, 19, 27876, 20, 0, 0, 0, 0, 0, 5.916666030883789, 'Sergeant Morigan - Actionlist - Set Target Orientation'),
(2787707, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 27876, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Perelli Say Line 3'),
(2787707, 9, 7, 0, 0, 0, 100, 0, 4666, 4666, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 8'),
(2787707, 9, 8, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 27876, 20, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Perelli Say Line 4'),
(2787707, 9, 9, 0, 0, 0, 100, 0, 6070, 6070, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Morigan - Actionlist - Say Line 9');

/* Jena & Martha
17:17:33.968
Jena Face Martha
Text: Martha, I'm out of flour for bread. You wouldn't happen to have any grain (...) (6)
17:17:39.847
Text: Oh hello, Jena. Of course you can borrow some grain. Help yourself. (1)
17:17:45.311
Text: Thanks, Martha! I owe you one. (1)
17:17:49.361
Resume Path
17:17:51.789
StandState: 8
17:17:54.216
Face Martha
StandState: 0
Text: Oh, dear. (5)
17:17:54.401
Text: Martha, something's wrong with this grain! Some of the Prince's soldiers were looking for this. I'm going to go look for one.
17:18:00.288
Resume Path Running
Martha Text: Oh, my. (1)
*/
DELETE FROM `waypoints` WHERE `entry` = 2788500;
DELETE FROM `waypoint_data` WHERE `id` IN (278851, 278852);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
(278851, 1, 1603.4928, 749.756, 114.72388, NULL, 0, 0),
(278851, 2, 1602.1324, 743.804, 114.724106, NULL, 0, 0),

(278852, 1 , 1614.6437, 743.08984, 114.03205, NULL, 0, 0),
(278852, 2 , 1617.5967, 737.8633, 113.46675, NULL, 0, 0),
(278852, 3 , 1623.717, 727.2723, 112.177315, NULL, 0, 0),
(278852, 4 , 1628.8267, 726.03973, 112.51238, NULL, 0, 0),
(278852, 5 , 1633.3663, 726.3549, 113.52023, NULL, 15400, 0), -- Event A
(278852, 6 , 1629.8632, 729.9427, 112.7383, NULL, 8500, 0), -- Event B
(278852, 7 , 1613.9281, 715.9256, 109.661156, NULL, 0, 1),
(278852, 8 , 1607.678, 700.39716, 107.118744, NULL, 0, 1),
(278852, 9 , 1601.9584, 685.70465, 105.30515, NULL, 0, 1),
(278852, 10, 1596.3073, 671.2687, 103.775536, NULL, 0, 1),
(278852, 11, 1590.834, 658.6144, 102.26689, NULL, 0, 1),
(278852, 12, 1583.3926, 641.87726, 100.61924, NULL, 0, 1),
(278852, 13, 1577.5688, 626.5533, 99.96422, NULL, 0, 1),
(278852, 14, 1572.6749, 613.70966, 99.7528, NULL, 0, 1),
(278852, 15, 1565.1901, 611.6257, 99.768425, NULL, 0, 1);

DELETE FROM `creature_text` WHERE (`CreatureID` = 27885);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27885, 0, 0, 'Strawberries! Oh wait, they\'re not in season.', 12, 0, 100, 1, 0, 0, 27222, 0, 'Jena Anderson'),
(27885, 0, 1, 'I need to make something healthy for him, he\'s still not recovered from that illness from last week.', 12, 0, 100, 1, 0, 0, 27221, 0, 'Jena Anderson'),
(27885, 0, 2, 'I\'ve got plenty of cured bacon, but he had some for breakfast.', 12, 0, 100, 1, 0, 0, 27220, 0, 'Jena Anderson'),
(27885, 0, 3, 'Let\'s see, we had chicken last night.', 12, 0, 100, 1, 0, 0, 27219, 0, 'Jena Anderson'),
(27885, 1, 0, 'Martha, I\'m out of flour for bread. You wouldn\'t happen to have any grain from that recent shipment, would you?', 12, 0, 100, 6, 0, 0, 27224, 0, 'Jena Anderson - Plague Grain Dispelled'),
(27885, 2, 0, 'Thanks, Martha! I owe you one.', 12, 0, 100, 1, 0, 0, 27229, 0, 'Jena Anderson - Plague Grain Dispelled'),
(27885, 3, 0, 'Oh, dear.', 12, 0, 100, 5, 0, 0, 27230, 0, 'Jena Anderson - Plague Grain Dispelled'),
(27885, 4, 0, 'Martha, something\'s wrong with this grain! Some of the Prince\'s soldiers were looking for this. I\'m going to go look for one.', 12, 0, 100, 0, 0, 0, 27231, 0, 'Jena Anderson - Plague Grain Dispelled');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27884);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27884, 0, 0, 'Oh hello, Jena. Of course you can borrow some grain. Help yourself.', 12, 0, 100, 1, 0, 0, 27232, 0, 'Martha Goslin - Plague Grain Dispelled'),
(27884, 1, 0, 'Oh, my.', 12, 0, 100, 1, 0, 0, 27235, 0, 'Martha Goslin - Plague Grain Dispelled');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27885);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27885, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 278851, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Respawn - Start Path 278851'),
(27885, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Respawn - Set Event Phase 1'),
(27885, 0, 2, 0, 1, 1, 100, 0, 30000, 60000, 30000, 60000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Out of Combat - Say Line 0 (Phase 1)'),
(27885, 0, 3, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2788500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Action 1 Done - Run Script'),
(27885, 0, 4, 0, 108, 0, 100, 0, 5, 278852, 0, 0, 0, 0, 80, 2788501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Point 5 of Path 278852 Reached - Run Script'),
(27885, 0, 5, 0, 108, 0, 100, 0, 6, 278852, 0, 0, 0, 0, 80, 2788502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Point 6 of Path 278852 Reached - Run Script'),
(27885, 0, 6, 0, 109, 0, 100, 0, 0, 278852, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - On Path 278852 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2788500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2788500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 234, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Stop Movement'),
(2788500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Set Event Phase 0'),
(2788500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 278852, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Start Path 278852');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2788501);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2788501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 27884, 30, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Set Orientation Closest Creature \'Martha Goslin\''),
(2788501, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Say Line 1'),
(2788501, 9, 2, 0, 0, 0, 100, 0, 5880, 5880, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 27884, 30, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Martha Say Line 0'),
(2788501, 9, 3, 0, 0, 0, 100, 0, 5460, 5460, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Say Line 2');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2788502);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2788502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Set Flag Standstate Kneel'),
(2788502, 9, 1, 0, 0, 0, 100, 0, 2427, 2427, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Remove FlagStandstate Kneel'),
(2788502, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 27884, 30, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Set Orientation Closest Creature \'Martha Goslin\''),
(2788502, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Say Line 3'),
(2788502, 9, 4, 0, 0, 0, 100, 0, 185, 185, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Say Line 4'),
(2788502, 9, 5, 0, 0, 0, 100, 0, 5887, 5887, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 27884, 30, 0, 0, 0, 0, 0, 0, 'Jena Anderson - Actionlist - Martha Say Line 1');

/* Malcolm Moore and Scruffy
Entry: 27891
[2] Position: X: 1604.988 Y: 805.8108 Z: 123.02908
[2] Orientation: 5.284210681915283203
Entry: 27892
[3] Position: X: 1600.7809 Y: 805.67804 Z: 123.83765
[3] Orientation: 5.471605777740478515

17:19:05.036
FaceDirection: 2.30383467674255371
17:19:06.654
Text: What did you find, boy? (16)
17:19:11.508
Face Scruffy
Text: This is no good, Scruffy. Stay here and guard the house, I need to go find a soldier.
17:19:17.576
Scruffy FaceDirection: 5.445427417755126953
Scruffy StandState: 1
Start Path
*/
DELETE FROM `waypoint_data` WHERE `id` IN (278911, 278912, 278913, 278921);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(278911, 1, 1613.629, 795.90607, 121.7731, NULL, 0),
(278911, 2, 1623.6769, 799.60864, 120.454506, NULL, 0), -- Storm's coming in
(278911, 3, 1625.6471, 805.19086, 120.28289, NULL, 0),
(278911, 4, 1623.5256, 808.27356, 121.26217, NULL, 0), -- Stop in front of house

(278912, 1, 1628.0137, 806.93915, 120.20235, NULL, 0),
(278912, 2, 1630.1967, 808.7338, 120.130684, NULL, 0),
(278912, 3, 1630.2346, 810.94226, 120.34784, NULL, 0),

(278913, 1 , 1637.624, 809.69464, 119.88685, NULL, 0),
(278913, 2 , 1641.0455, 814.65454, 119.9189, NULL, 0),
(278913, 3 , 1643.8357, 822.07367, 119.85951, NULL, 0),
(278913, 4 , 1645.969, 828.4629, 119.64096, NULL, 0),
(278913, 5 , 1650.3689, 838.3262, 119.15922, NULL, 0),
(278913, 6 , 1655.4144, 848.9295, 119.02617, NULL, 0),
(278913, 7 , 1660.5952, 860.4657, 119.232956, NULL, 0),
(278913, 8 , 1667.5911, 874.5321, 119.80949, NULL, 0),
(278913, 9 , 1673.2579, 886.38403, 119.63572, NULL, 0),
(278913, 10, 1679.6431, 901.3481, 119.87763, NULL, 0),
(278913, 11, 1683.0983, 913.15845, 120.47839, NULL, 0),
(278913, 12, 1685.3273, 920.5432, 120.52994, NULL, 0),
(278913, 13, 1689.6124, 929.0876, 120.02029, NULL, 0),
(278913, 14, 1693.2422, 937.0495, 119.68428, NULL, 0),
(278913, 15, 1697.4131, 947.5701, 120.00734, NULL, 0),
(278913, 16, 1701.398, 957.1926, 120.79074, NULL, 0),
(278913, 17, 1703.1063, 968.2274, 121.95268, NULL, 0),
(278913, 18, 1699.1735, 977.87683, 122.25317, NULL, 0),
(278913, 19, 1692.942, 991.3913, 122.32308, NULL, 0),
(278913, 20, 1687.0529, 1002.4241, 123.098175, NULL, 0),
(278913, 21, 1684.8319, 1010.5754, 124.015656, NULL, 0),
(278913, 22, 1683.1489, 1020.4166, 125.04175, NULL, 0),
(278913, 23, 1681.325, 1035.5245, 125.9373, NULL, 0),
(278913, 24, 1680.36, 1054.4977, 125.81591, NULL, 0),
(278913, 25, 1680.5261, 1066.6195, 125.94018, NULL, 0),
(278913, 26, 1681.8284, 1078.0787, 126.318085, NULL, 0),
(278913, 27, 1683.9103, 1090.7983, 127.00963, NULL, 0),
(278913, 28, 1688.957, 1097.002, 128.3042, NULL, 0),
(278913, 29, 1699.5281, 1103.7521, 130.76225, NULL, 0),
(278913, 30, 1710.9727, 1110.3429, 133.8588, NULL, 0),
(278913, 31, 1723.031, 1116.0657, 137.51024, NULL, 0),
(278913, 32, 1733.3789, 1122.1475, 140.7415, NULL, 0),

(278921, 1, 1609.4974, 797.1868, 122.30818, NULL, 0),
(278921, 2, 1612.8555, 794.5053, 121.80821, NULL, 0),
(278921, 3, 1617.0718, 793.0383, 121.23241, NULL, 0),
(278921, 4, 1621.1256, 794.45355, 120.75687, NULL, 0),
(278921, 5, 1624.841, 798.4964, 120.24649, NULL, 0),
(278921, 6, 1626.933, 801.0958, 120.08853, NULL, 0),
(278921, 7, 1628.7216, 805.10004, 120.09788, NULL, 3467), -- Growl
(278921, 8, 1629.0042, 810.138, 120.42241, NULL, 0); -- Stop

DELETE FROM `creature_text` WHERE (`CreatureID` = 27892);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27892, 0, 0, '%s begins to growl...', 16, 0, 100, 0, 0, 0, 27237, 0, 'Scruffy');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27892;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27892);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27892, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 278921, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scruffy - On Just Summoned - Start Path 278921'),
(27892, 0, 1, 2, 108, 0, 100, 0, 7, 278921, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scruffy - On Point 7 of Path 278921 Reached - Say Line 0'),
(27892, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 27891, 20, 0, 0, 0, 0, 0, 0, 'Scruffy - On Point 7 of Path 278921 Reached - Do Action ID 1'),
(27892, 0, 3, 4, 109, 0, 100, 0, 0, 278921, 0, 0, 0, 0, 5, 393, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scruffy - On Path 278921 Finished - Play Emote 393'),
(27892, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 9036, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scruffy - On Path 278921 Finished - Play Sound 9036');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27891);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27891, 0, 0, 'Looks like a storm\'s coming in, Scruffy...', 12, 0, 100, 0, 0, 0, 27236, 0, 'Malcolm Moore'),
(27891, 1, 0, 'What\'s wrong, pal?', 12, 0, 100, 1, 0, 0, 27238, 0, 'Malcolm Moore'),
(27891, 2, 0, 'What did you find, boy?', 12, 0, 100, 16, 0, 0, 27240, 0, 'Malcolm Moore'),
(27891, 3, 0, 'This is no good, Scruffy. Stay here and guard the house, I need to go find a soldier.', 12, 0, 100, 0, 0, 0, 27241, 0, 'Malcolm Moore');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27891;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27891);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27891, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 278911, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - On Just Summoned - Start Path 278911'),
(27891, 0, 1, 0, 108, 0, 100, 0, 2, 278911, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - On Point 2 of Path 278911 Reached - Say Line 0'),
(27891, 0, 2, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2789100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - On Action 1 Done - Run Script'),
(27891, 0, 3, 0, 109, 0, 100, 0, 0, 278912, 0, 0, 0, 0, 80, 2789101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - On Path 278912 Finished - Run Script'),
(27891, 0, 4, 0, 109, 0, 100, 0, 0, 278913, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - On Path 278913 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2789100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2789100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 27892, 20, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Set Orientation Closest Creature \'Scruffy\''),
(2789100, 9, 1, 0, 0, 0, 100, 0, 1238, 1238, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Say Line 1'),
(2789100, 9, 2, 0, 0, 0, 100, 0, 7258, 7258, 0, 0, 0, 0, 232, 278912, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Start Path 278912');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2789101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2789101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.3038346767425537, 'Malcolm Moore - Actionlist - Set Orientation 2.3038346767425537'),
(2789101, 9, 1, 0, 0, 0, 100, 0, 1618, 1618, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Say Line 2'),
(2789101, 9, 2, 0, 0, 0, 100, 0, 4854, 4854, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 27892, 20, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Set Orientation Closest Creature \'Scruffy\''),
(2789101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Say Line 3'),
(2789101, 9, 4, 0, 0, 0, 100, 0, 6068, 6068, 0, 0, 0, 0, 232, 278913, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Start Path 278913'),
(2789101, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 231, 1, 0, 0, 0, 0, 0, 19, 27892, 20, 0, 0, 0, 0, 0, 5.445427417755127, 'Malcolm Moore - Actionlist - Set Target Orientation'),
(2789101, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 1, 0, 0, 0, 0, 0, 19, 27892, 20, 0, 0, 0, 0, 0, 0, 'Malcolm Moore - Actionlist - Set Flag Standstate Sit Down');

/* Bartleby
17:19:43.474
StandState: 8
17:19:47.120
Text: Oh, come on! My cart broke, my horse lost a shoe, and now the cargo goes bad!
17:19:49.547
Emote ID: 1 (OneShotTalk)
17:19:55.610
Resume Path
StandState: 0
Text: I guess I'll go find the authorities. If I'm lucky they'll tell me it's the plague and that we're all going to die.
*/
DELETE FROM `waypoint_data` WHERE `id` = 279071;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(279071, 1, 1672.9556, 872.13824, 120.1779, NULL, 12200),
(279071, 2, 1667.0764, 870.0946, 119.832954, NULL, 0),
(279071, 3, 1662.8284, 866.6351, 119.5747, NULL, 0),
(279071, 4, 1658.1075, 859.9075, 119.13811, NULL, 0),
(279071, 5, 1653.9028, 852.6165, 118.970245, NULL, 0),
(279071, 6, 1648.1691, 841.8626, 119.03337, NULL, 0),
(279071, 7, 1641.229, 825.2514, 119.86557, NULL, 0),
(279071, 8, 1638.217, 815.4248, 119.87927, NULL, 0),
(279071, 9, 1633.981, 802.764, 119.80745, NULL, 0),
(279071, 10, 1627.4513, 780.37915, 118.34766, NULL, 0),
(279071, 11, 1625.1217, 771.533, 117.41954, NULL, 0),
(279071, 12, 1620.6166, 756.6836, 115.75331, NULL, 0),
(279071, 13, 1616.889, 741.244, 113.86244, NULL, 0),
(279071, 14, 1613.6106, 728.4866, 111.832886, NULL, 0),
(279071, 15, 1606.2946, 706.35657, 107.74899, NULL, 0),
(279071, 16, 1601.2357, 692.0279, 105.68627, NULL, 0),
(279071, 17, 1598.3884, 682.02313, 104.76993, NULL, 0),
(279071, 18, 1592.339, 665.5434, 102.98855, NULL, 0),
(279071, 19, 1586.1924, 654.10754, 101.72828, NULL, 0),
(279071, 20, 1583.3892, 651.7168, 101.46962, NULL, 0),
(279071, 21, 1577.7487, 653.7333, 101.75149, NULL, 0),
(279071, 22, 1571.4282, 659.63995, 102.08807, NULL, 0),
(279071, 23, 1564.7112, 666.69305, 102.05773, NULL, 0);

DELETE FROM `creature_text` WHERE (`CreatureID` = 27907) AND (`GroupID` IN (1, 2, 3));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27907, 1, 0, 'Well, guess I should load everything back into the cart.', 12, 0, 100, 0, 0, 0, 27257, 0, 'Bartleby Battson - Plague Grain Dispelled'),
(27907, 2, 0, 'Oh, come on! My cart broke, my horse lost a shoe, and now the cargo goes bad!', 12, 0, 100, 5, 0, 0, 27258, 0, 'Bartleby Battson - Plague Grain Dispelled'),
(27907, 3, 0, 'I guess I\'ll go find the authorities. If I\'m lucky they\'ll tell me it\'s the plague and that we\'re all going to die.', 12, 0, 100, 0, 0, 0, 27259, 0, 'Bartleby Battson - Plague Grain Dispelled');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27907);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27907, 0, 0, 0, 1, 1, 100, 0, 20000, 25000, 20000, 25000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Out of Combat - Say Line 0 (Phase 1)'),
(27907, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - On Respawn - Set Event Phase 1'),
(27907, 0, 2, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2790700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - On Action 1 Done - Run Script'),
(27907, 0, 3, 0, 108, 0, 100, 0, 1, 279071, 0, 0, 0, 0, 80, 2790701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - On Point 1 of Path 279071 Reached - Run Script'),
(27907, 0, 4, 0, 109, 0, 100, 0, 0, 279071, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - On Path 279071 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2790700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2790700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Set Event Phase 0'),
(2790700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Say Line 1'),
(2790700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 279071, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Start Path 279071');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2790701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2790701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Set Flag Standstate Kneel'),
(2790701, 9, 1, 0, 0, 0, 100, 0, 3646, 3646, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Say Line 2'),
(2790701, 9, 2, 0, 0, 0, 100, 0, 2427, 2427, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Play Emote 1'),
(2790701, 9, 3, 0, 0, 0, 100, 0, 6063, 6063, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Remove FlagStandstate Kneel'),
(2790701, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bartleby Battson - Actionlist - Say Line 3');

-- New Spawns: Triggers
SET @GUID := 53063;
DELETE FROM `creature` WHERE `map` = 595 AND `id` IN (20562, 28815, 28960) AND `guid` BETWEEN @GUID AND @GUID+26;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID+0 , 20562, 595, 4100, 4100, 3, 0, 2113.52, 1288.01, 136.382, 2.30383, 7200, 68974, 1, NULL),
(@GUID+1 , 28815, 595, 4100, 4100, 3, 0, 2150.4, 1281.51, 134.292, 0.331613, 7200, 68974, 1, NULL),
(@GUID+2 , 28815, 595, 4100, 4100, 3, 0, 2174.96, 1298.34, 132.809, 5.48033, 7200, 68974, 1, NULL),
(@GUID+3 , 28815, 595, 4100, 4100, 3, 0, 2125.11, 1355.01, 131.568, 4.88692, 7200, 68974, 1, NULL),
(@GUID+4 , 28815, 595, 4100, 4100, 3, 0, 2181.02, 1320.77, 129.955, 2.47837, 7200, 68974, 1, NULL),
(@GUID+5 , 28815, 595, 4100, 4100, 3, 0, 2149.3, 1351.12, 132.138, 5.55015, 7200, 68974, 1, NULL),
(@GUID+6 , 28815, 595, 4100, 4100, 3, 0, 2172.07, 1270.73, 133.154, 5.68977, 7200, 68974, 1, NULL),
(@GUID+7 , 28815, 595, 4100, 4100, 3, 0, 2167.81, 1350.49, 130.391, 3.85718, 7200, 68974, 1, NULL),
(@GUID+8 , 28815, 595, 4100, 4100, 3, 0, 2177.88, 1249.26, 135.762, 3.54302, 7200, 68974, 1, NULL),
(@GUID+9 , 28815, 595, 4100, 4100, 3, 0, 2252.33, 1155.02, 138.448, 4.29351, 7200, 68974, 1, NULL),
(@GUID+10, 28815, 595, 4100, 4100, 3, 0, 2348.23, 1207.27, 130.612, 6.17847, 7200, 68974, 1, NULL),
(@GUID+11, 28815, 595, 4100, 4100, 3, 0, 2188.69, 1341.37, 130.276, 5.68977, 7200, 68974, 1, NULL),
(@GUID+12, 28815, 595, 4100, 4100, 3, 0, 2211.82, 1332.63, 129.119, 0.418879, 7200, 68974, 1, NULL),
(@GUID+13, 28815, 595, 4100, 4100, 3, 0, 2218.47, 1198.19, 136.075, 2.19911, 7200, 68974, 1, NULL),
(@GUID+14, 28815, 595, 4100, 4100, 3, 0, 2233.71, 1178.74, 136.516, 0.506145, 7200, 68974, 1, NULL),
(@GUID+15, 28815, 595, 4100, 4100, 3, 0, 2282.51, 1195.83, 138.92, 4.43314, 7200, 68974, 1, NULL),
(@GUID+16, 28815, 595, 4100, 4100, 3, 0, 2280.4, 1141.83, 137.913, 3.21141, 7200, 68974, 1, NULL),
(@GUID+17, 28815, 595, 4100, 4100, 3, 0, 2307.07, 1180.5, 136.423, 1.09956, 7200, 68974, 1, NULL),
(@GUID+18, 28815, 595, 4100, 4100, 3, 0, 2342.06, 1182.33, 130.479, 3.54302, 7200, 68974, 1, NULL),
(@GUID+19, 28815, 595, 4100, 4100, 3, 0, 2290.56, 1165.07, 137.477, 3.78736, 7200, 68974, 1, NULL),
(@GUID+20, 28815, 595, 4100, 4100, 3, 0, 2263.29, 1174.14, 138.222, 3.24631, 7200, 68974, 1, NULL),
(@GUID+21, 28960, 595, 4100, 4100, 3, 0, 1665.11, 877.442, 119.916, 6.12611, 7200, 68974, 1, NULL);

-- New Spawns: Critters
SET @GUID := 134848;
DELETE FROM `creature` WHERE `map` = 595 AND `id` IN (721, 883, 890, 1933, 4075, 4076, 6368, 14881) AND `guid` BETWEEN @GUID AND @GUID+66;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `CreateObject`) VALUES
(@GUID+0 , 721, 595, 4100, 4100, 3, 1560.71, 740.572, 110.854, 4.08407, 7200,    10, 1, 68974, 1),
(@GUID+1 , 721, 595, 4100, 4100, 3, 1612.9, 634.904, 100.819, 3.90832, 7200,     10, 1, 68974, 1),
(@GUID+2 , 721, 595, 4100, 4100, 3, 1634.63, 707.005, 111.152, 2.52641, 7200,    10, 1, 68974, 1),
(@GUID+3 , 721, 595, 4100, 4100, 3, 1662.19, 798.683, 123.207, 4.96467, 7200,    10, 1, 68974, 1),
(@GUID+4 , 721, 595, 4100, 4100, 3, 1665.59, 1092.02, 128.494, 0.36282, 7200,    10, 1, 68974, 1),
(@GUID+5 , 721, 595, 4100, 4100, 3, 1668.34, 992.271, 125.706, 6.08062, 7200,    10, 1, 68974, 1),
(@GUID+6 , 721, 595, 4100, 4100, 3, 1730.56, 982.065, 131.765, 5.43054, 7200,    10, 1, 68974, 1),
(@GUID+7 , 721, 595, 4100, 4100, 3, 1756.02, 1038.21, 137.911, 0.589295, 7200,   10, 1, 68974, 1),
(@GUID+8 , 883, 595, 4100, 4100, 3, 1562.7, 643.177, 102.259, 4.21293, 7200,     10, 1, 68974, 1),
(@GUID+9 , 883, 595, 4100, 4100, 3, 1596.94, 777.855, 121.259, 2.67358, 7200,    10, 1, 68974, 1),
(@GUID+10, 883, 595, 4100, 4100, 3, 1614.61, 680.574, 107.075, 3.38823, 7200,    10, 1, 68974, 1),
(@GUID+11, 883, 595, 4100, 4100, 3, 1617.04, 614.423, 100.798, 5.82395, 7200,    10, 1, 68974, 1),
(@GUID+12, 883, 595, 4100, 4100, 3, 1655.13, 945.231, 129.236, 1.75842, 7200,    10, 1, 68974, 1),
(@GUID+13, 883, 595, 4100, 4100, 3, 1719.66, 1079.02, 135.533, 1.45335, 7200,    10, 1, 68974, 1),
(@GUID+14, 883, 595, 4100, 4100, 3, 1727.33, 1169.49, 139.729, 5.23734, 7200,    10, 1, 68974, 1),
(@GUID+15, 883, 595, 4100, 4100, 3, 1783.51, 950.33, 134.897, 0.573919, 7200,    10, 1, 68974, 1),
(@GUID+16, 890, 595, 4100, 4100, 3, 1568, 643.315, 102.029, 5.69453, 7200,       10, 1, 68974, 1),
(@GUID+17, 890, 595, 4100, 4100, 3, 1585.01, 771.803, 121.306, 0.738667, 7200,   10, 1, 68974, 1),
(@GUID+18, 1933, 595, 4100, 4100, 3, 1596.67, 730.609, 112.023, 2.90249, 7200,   5, 1, 68974, 1),
(@GUID+19, 1933, 595, 4100, 4100, 3, 1597.98, 724.578, 110.743, 3.08788, 7200,   5, 1, 68974, 1),
(@GUID+20, 1933, 595, 4100, 4100, 3, 1630.16, 883.578, 126.765, 3.76991, 7200,   5, 1, 68974, 1),
(@GUID+21, 1933, 595, 4100, 4100, 3, 1639.17, 756.914, 116.172, 2.27597, 7200,   5, 1, 68974, 1),
(@GUID+22, 1933, 595, 4100, 4100, 3, 1642.19, 897.839, 126.421, 0.96204, 7200,   5, 1, 68974, 1),
(@GUID+23, 1933, 595, 4100, 4100, 3, 1644.65, 759.008, 116.304, 1.08177, 7200,   5, 1, 68974, 1),
(@GUID+24, 1933, 595, 4100, 4100, 3, 1645.85, 904.985, 127.75, 6.20889, 7200,    5, 1, 68974, 1),
(@GUID+25, 4075, 595, 4100, 4100, 3, 1543.8, 577.059, 92.6907, 4.24115, 7200,    3, 1, 68974, 1),
(@GUID+26, 4075, 595, 4100, 4100, 3, 2091.09, 1271, 141.555, 2.58325, 7200,      3, 1, 68974, 1),
(@GUID+27, 4075, 595, 4100, 4100, 3, 2109.08, 1346.97, 132.492, 1.59115, 7200,   3, 1, 68974, 1),
(@GUID+28, 4075, 595, 4100, 4100, 3, 2136.36, 1091.19, 34.248, 5.75959, 7200,    3, 1, 68974, 1),
(@GUID+29, 4075, 595, 4100, 4100, 3, 2147.96, 1294.29, 135.732, 2.45734, 7200,   3, 1, 68974, 1),
(@GUID+30, 4075, 595, 4100, 4100, 3, 2162.12, 1315.64, 133.235, 4.76475, 7200,   3, 1, 68974, 1),
(@GUID+31, 4075, 595, 4100, 4100, 3, 2194.33, 1219.81, 137.523, 4.97405, 7200,   3, 1, 68974, 1),
(@GUID+32, 4075, 595, 4100, 4100, 3, 2204.58, 1219.15, 137.189, 4.55664, 7200,   3, 1, 68974, 1),
(@GUID+33, 4075, 595, 4100, 4100, 3, 2223.56, 1321.29, 128.925, 6.18552, 7200,   3, 1, 68974, 1),
(@GUID+34, 4075, 595, 4100, 4100, 3, 2247.38, 1158.33, 138.14, 5.51087, 7200,    3, 1, 68974, 1),
(@GUID+35, 4075, 595, 4100, 4100, 3, 2280.47, 1137.05, 138.162, 1.97678, 7200,   3, 1, 68974, 1),
(@GUID+36, 4075, 595, 4100, 4100, 3, 2301.92, 1446.75, 128.868, 2.83915, 7200,   3, 1, 68974, 1),
(@GUID+37, 4075, 595, 4100, 4100, 3, 2315.97, 1260.77, 133.672, 4.03711, 7200,   3, 1, 68974, 1),
(@GUID+38, 4075, 595, 4100, 4100, 3, 2343.23, 1396.65, 130.644, 5.7885, 7200,    3, 1, 68974, 1),
(@GUID+39, 4075, 595, 4100, 4100, 3, 2352.44, 1167.13, 131.225, 6.27066, 7200,   3, 1, 68974, 1),
(@GUID+40, 4075, 595, 4100, 4100, 3, 2389.22, 1405.93, 128.728, 5.23176, 7200,   3, 1, 68974, 1),
(@GUID+41, 4075, 595, 4100, 4100, 3, 2430.72, 1177.29, 133.932, 1.63844, 7200,   3, 1, 68974, 1),
(@GUID+42, 4075, 595, 4100, 4100, 3, 2457.91, 1404.88, 130.304, 6.1206, 7200,    3, 1, 68974, 1),
(@GUID+43, 4075, 595, 4100, 4100, 3, 2486.33, 1103.92, 145.856, 2.77507, 7200,   3, 1, 68974, 1),
(@GUID+44, 4075, 595, 4100, 4100, 3, 2520.03, 1322.26, 132.405, 4.93009, 7200,   3, 1, 68974, 1),
(@GUID+45, 4075, 595, 4100, 4100, 3, 2537.89, 1143.79, 130.965, 0.57512, 7200,   3, 1, 68974, 1),
(@GUID+46, 4075, 595, 4100, 4100, 3, 2565.36, 1126, 128.454, 2.77547, 7200,      3, 1, 68974, 1),
(@GUID+47, 4076, 595, 4100, 4100, 3, 2118.05, 1370.5, 131.676, 0.0204706, 7200,  3, 1, 68974, 1),
(@GUID+48, 4076, 595, 4100, 4100, 3, 2125.34, 1368.89, 131.436, 1.65958, 7200,   3, 1, 68974, 1),
(@GUID+49, 4076, 595, 4100, 4100, 3, 2178.5, 1281.61, 133.579, 1.309, 7200,      3, 1, 68974, 1),
(@GUID+50, 4076, 595, 4100, 4100, 3, 2180.55, 1282.76, 133.671, 0.576362, 7200,  3, 1, 68974, 1),
(@GUID+51, 4076, 595, 4100, 4100, 3, 2262.55, 1156.32, 138.302, 5.32325, 7200,   3, 1, 68974, 1),
(@GUID+52, 4076, 595, 4100, 4100, 3, 2272.78, 1142.47, 138.055, 2.1293, 7200,    3, 1, 68974, 1),
(@GUID+53, 4076, 595, 4100, 4100, 3, 2279.65, 1134.66, 138.327, 5.58748, 7200,   3, 1, 68974, 1),
(@GUID+54, 4076, 595, 4100, 4100, 3, 2280.4, 1185.07, 138.491, 2.72766, 7200,    3, 1, 68974, 1),
(@GUID+55, 4076, 595, 4100, 4100, 3, 2324.53, 1259.62, 133.553, 5.97214, 7200,   3, 1, 68974, 1),
(@GUID+56, 6368, 595, 4100, 4100, 3, 1628.17, 727.566, 112.58, 0.638735, 7200,   5, 1, 68974, 1),
(@GUID+57, 6368, 595, 4100, 4100, 3, 1682.82, 866.776, 122.68, 5.22802, 7200,    5, 1, 68974, 1),
(@GUID+58, 6368, 595, 4100, 4100, 3, 2115.67, 1303.26, 137.097, 0.456406, 7200,  5, 1, 68974, 1),
(@GUID+59, 6368, 595, 4100, 4100, 3, 2446.69, 1441.5, 132.354, 5.31996, 7200,    5, 1, 68974, 1),
(@GUID+60, 14881, 595, 4100, 4100, 3, 2326.68, 1442.46, 128.132, 5.03886, 7200,  3, 1, 68974, 1),
(@GUID+61, 14881, 595, 4100, 4100, 3, 2414.57, 1160.07, 148.061, 6.03136, 7200,  3, 1, 68974, 1),
(@GUID+62, 14881, 595, 4100, 4100, 3, 2450.18, 1189.65, 148.061, 5.42231, 7200,  3, 1, 68974, 1),
(@GUID+63, 14881, 595, 4100, 4100, 3, 2455.26, 1096.56, 148.061, 1.54846, 7200,  3, 1, 68974, 1),
(@GUID+64, 14881, 595, 4100, 4100, 3, 2466.86, 1124.32, 150.012, 4.51048, 7200,  3, 1, 68974, 1),
(@GUID+65, 14881, 595, 4100, 4100, 3, 2489.08, 1126.43, 139.841, 3.68717, 7200,  3, 1, 68974, 1),
(@GUID+66, 14881, 595, 4100, 4100, 3, 2504.75, 1369.57, 133.121, 4.57276, 7200,  3, 1, 68974, 1);
