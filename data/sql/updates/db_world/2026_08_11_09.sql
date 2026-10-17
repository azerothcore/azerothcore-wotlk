-- DB update 2026_08_11_08 -> 2026_08_11_09
--
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 188163;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 188163);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(188163, 1, 0, 0, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 18816300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bell Rope - On Gossip Hello - Run Script');

DELETE FROM `creature_text` WHERE (`CreatureID` = 25238);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25238, 0, 0, 'To the town hall, everyone!  We\'ve brought you weapons!  Arm yourselves and beat the Scourge back!', 14, 0, 100, 5, 0, 0, 25832, 0, 'Gamlen - Call to Arms! Quest');

-- Timers below are sequential deltas (each starts when the previous action fires), derived from the sniff timeline.
-- Cumulative offsets from the bell being rung: 0 / 0 / 1582 / 2761 / 4048 / 4173 / 5217 / 5217 / 6495 / 16193 / 27112 / 38017
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 18816300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18816300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 25238, 3, 20000, 0, 0, 0, 8, 0, 0, 0, 0, 2614.7705, 5263.4736, 39.493538, 2.155400037765503, 'Bell Rope - Actionlist - Summon Creature \'Gamlen\''),
(18816300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 6594, 0, 1, 0, 0, 0, 10, 103941, 24921, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Play Sound 6594 (1/6)'),
(18816300, 9, 2, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 4, 6594, 0, 1, 0, 0, 0, 10, 103941, 24921, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Play Sound 6594 (2/6)'),
(18816300, 9, 3, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 4, 6594, 0, 1, 0, 0, 0, 10, 103941, 24921, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Play Sound 6594 (3/6)'),
(18816300, 9, 4, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 4, 6594, 0, 1, 0, 0, 0, 10, 103941, 24921, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Play Sound 6594 (4/6)'),
(18816300, 9, 5, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 25238, 100, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Gamlen Say Line'),
(18816300, 9, 6, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 4, 6594, 0, 1, 0, 0, 0, 10, 103941, 24921, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Play Sound 6594 (5/6)'),
(18816300, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Summon Farshire Militia Wave 0'),
(18816300, 9, 8, 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 0, 4, 6594, 0, 1, 0, 0, 0, 10, 103941, 24921, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Play Sound 6594 (6/6)'),
(18816300, 9, 9, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Summon Farshire Militia Wave 1'),
(18816300, 9, 10, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Summon Farshire Militia Wave 2'),
(18816300, 9, 11, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bell Rope - Actionlist - Summon Farshire Militia Wave 3');

/*
-- 12:56:01.898 Bell Rung (State 0)
Sound 6594 SMSG_PLAY_OBJECT_SOUND:
12:56:01.898
12:56:03.480
12:56:04.659
12:56:05.946
12:56:07.115
12:56:08.393

-- 12:56:06.071 CHAT

-- 12:56:07.115
[2] Position: X: 2582.2043 Y: 5286.3047 Z: 36.429863
[2] Orientation: 5.916666030883789062
[5] Position: X: 2587.82 Y: 5298.0747 Z: 37.00283
[5] Orientation: 5.201081275939941406
[6] Position: X: 2589.4414 Y: 5296.7305 Z: 36.711174
[6] Orientation: 5.16617441177368164
[7] Position: X: 2580.9414 Y: 5288.185 Z: 36.26087
[7] Orientation: 5.951572895050048828

-- 12:56:18.091
[0] Position: X: 2588.1177 Y: 5297.9746 Z: 36.93236
[0] Orientation: 5.393067359924316406
[1] Position: X: 2580.7925 Y: 5288.2427 Z: 36.24729
[1] Orientation: 5.724679946899414062
[3] Position: X: 2582.1897 Y: 5286.6255 Z: 36.415543
[3] Orientation: 5.707226753234863281
[4] Position: X: 2589.4858 Y: 5296.837 Z: 36.709045
[4] Orientation: 5.393067359924316406

-- 12:56:29.010
[2] Position: X: 2580.9 Y: 5288.4424 Z: 36.252953
[2] Orientation: 5.689773082733154296
[3] Position: X: 2582.1257 Y: 5286.186 Z: 36.427933
[3] Orientation: 5.742133140563964843
[4] Position: X: 2588.1296 Y: 5298.03 Z: 36.940678
[4] Orientation: 5.393067359924316406
[8] Position: X: 2589.8257 Y: 5296.3403 Z: 36.750645
[8] Orientation: 5.375614166259765625

-- 12:56:39.915
[0] Position: X: 2589.6392 Y: 5296.5674 Z: 36.729828
[0] Orientation: 5.375614166259765625
[1] Position: X: 2580.417 Y: 5288.195 Z: 36.21635
[1] Orientation: 5.707226753234863281
[2] Position: X: 2582.0833 Y: 5286.468 Z: 36.413296
[2] Orientation: 5.724679946899414062
[4] Position: X: 2588.138 Y: 5298.1934 Z: 36.969833
[4] Orientation: 5.393067359924316406
*/

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 188163 AND `summonerType` = 1;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(188163, 1, 0, 25617, 2582.2043, 5286.3047, 36.429863, 5.916666030883789062, 4, 60000, 'Bell Rope - Farshire Militia Wave 0'),
(188163, 1, 0, 25617, 2587.82, 5298.0747, 37.00283, 5.201081275939941406, 4, 60000, 'Bell Rope - Farshire Militia Wave 0'),
(188163, 1, 0, 25617, 2589.4414, 5296.7305, 36.711174, 5.16617441177368164, 4, 60000, 'Bell Rope - Farshire Militia Wave 0'),
(188163, 1, 0, 25617, 2580.9414, 5288.185, 36.26087, 5.951572895050048828, 4, 60000, 'Bell Rope - Farshire Militia Wave 0'),
(188163, 1, 1, 25617, 2588.1177, 5297.9746, 36.93236, 5.393067359924316406, 4, 60000, 'Bell Rope - Farshire Militia Wave 1'),
(188163, 1, 1, 25617, 2580.7925, 5288.2427, 36.24729, 5.724679946899414062, 4, 60000, 'Bell Rope - Farshire Militia Wave 1'),
(188163, 1, 1, 25617, 2582.1897, 5286.6255, 36.415543, 5.707226753234863281, 4, 60000, 'Bell Rope - Farshire Militia Wave 1'),
(188163, 1, 1, 25617, 2589.4858, 5296.837, 36.709045, 5.393067359924316406, 4, 60000, 'Bell Rope - Farshire Militia Wave 1'),
(188163, 1, 2, 25617, 2580.9, 5288.4424, 36.252953, 5.689773082733154296, 4, 60000, 'Bell Rope - Farshire Militia Wave 2'),
(188163, 1, 2, 25617, 2582.1257, 5286.186, 36.427933, 5.742133140563964843, 4, 60000, 'Bell Rope - Farshire Militia Wave 2'),
(188163, 1, 2, 25617, 2588.1296, 5298.03, 36.940678, 5.393067359924316406, 4, 60000, 'Bell Rope - Farshire Militia Wave 2'),
(188163, 1, 2, 25617, 2589.8257, 5296.3403, 36.750645, 5.375614166259765625, 4, 60000, 'Bell Rope - Farshire Militia Wave 2'),
(188163, 1, 3, 25617, 2589.6392, 5296.5674, 36.729828, 5.375614166259765625, 4, 60000, 'Bell Rope - Farshire Militia Wave 3'),
(188163, 1, 3, 25617, 2580.417, 5288.195, 36.21635, 5.707226753234863281, 4, 60000, 'Bell Rope - Farshire Militia Wave 3'),
(188163, 1, 3, 25617, 2582.0833, 5286.468, 36.413296, 5.724679946899414062, 4, 60000, 'Bell Rope - Farshire Militia Wave 3'),
(188163, 1, 3, 25617, 2588.138, 5298.1934, 36.969833, 5.393067359924316406, 4, 60000, 'Bell Rope - Farshire Militia Wave 3');

/* Paths to Weapons
X: 2613.4844 Y: 5266.2974 Z: 39.414585
X: 2615.0513 Y: 5266.825 Z: 39.41305

X: 2604.6396 Y: 5275.1904 Z: 37.04267
X: 2612.492 Y: 5266.3013 Z: 39.411716
X: 2609.7305 Y: 5263.4307 Z: 39.409756

X: 2604.6396 Y: 5275.1904 Z: 37.04267
X: 2612.492 Y: 5266.3013 Z: 39.411716
X: 2611.5493 Y: 5261.658 Z: 39.40324

X: 2604.639 Y: 5274.1016 Z: 37.093304
X: 2612.1926 Y: 5267.116 Z: 39.414043
X: 2622.1306 Y: 5257.2104 Z: 38.274437

X: 2608.5396 Y: 5270.824 Z: 38.410854
X: 2614.004 Y: 5265.765 Z: 39.411907
X: 2614.0928 Y: 5259.838 Z: 39.39466

-- Wait 2s, Change Equipment then run
*/

/* Final Paths
X: 2604.8347 Y: 5286.645 Z: 36.815502
X: 2607.5652 Y: 5324.0244 Z: 31.018406
X: 2611.8296 Y: 5351.459 Z: 32.863174
X: 2622.6104 Y: 5387.384 Z: 32.863174
X: 2626.7065 Y: 5402.0703 Z: 32.863174
X: 2629.7988 Y: 5413.136 Z: 30.653997

X: 2601.0093 Y: 5279.1606 Z: 36.828663
X: 2604.5352 Y: 5300.9995 Z: 36.480186
X: 2613.8127 Y: 5321.6313 Z: 31.018402
X: 2624.7915 Y: 5359.0264 Z: 32.863174
X: 2638.1523 Y: 5386.913 Z: 32.863174

X: 2606.4014 Y: 5274.857 Z: 37.1605
X: 2598.247 Y: 5293.678 Z: 36.814384
X: 2602.7478 Y: 5325.407 Z: 31.018406
X: 2613.2375 Y: 5354.188 Z: 32.863174
X: 2625.8896 Y: 5398.117 Z: 32.863174

X: 2606.9521 Y: 5272.983 Z: 37.169373
X: 2606.2026 Y: 5300.4604 Z: 36.49433
X: 2618.5266 Y: 5329.3213 Z: 31.071074
X: 2622.632 Y: 5355.4214 Z: 32.863174
X: 2635.3538 Y: 5380.17 Z: 32.863174
X: 2708.6326 Y: 5360.3237 Z: 31.040672
*/

/* Weapons
ItemID: 25228
ItemID: 2178
ItemID: 143
ItemID: 13160
ItemID: 2182
*/

DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 25617);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(25617, 1, 1485, 0, 0, 18019),
(25617, 2, 25228, 0, 0, 68887),
(25617, 3, 2178, 0, 0, 68887),
-- (25617, 4, 143, 0, 0, 68887),
(25617, 4, 13160, 0, 0, 68887),
(25617, 5, 2182, 0, 0, 68887);

-- Unused between 256170 and 256180
DELETE FROM `waypoint_data` WHERE `id` BETWEEN 256170 AND 256179;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
(256170, 1, 2613.4844, 5266.2974, 39.414585, NULL, 1),
(256170, 2, 2615.0513, 5266.825, 39.41305, NULL, 1),

(256171, 1, 2604.6396, 5275.1904, 37.04267, NULL, 1),
(256171, 2, 2612.492, 5266.3013, 39.411716, NULL, 1),
(256171, 3, 2609.7305, 5263.4307, 39.409756, NULL, 1),

(256172, 1, 2604.6396, 5275.1904, 37.04267, NULL, 1),
(256172, 2, 2612.492, 5266.3013, 39.411716, NULL, 1),
(256172, 3, 2611.5493, 5261.658, 39.40324, NULL, 1),

(256173, 1, 2604.639, 5274.1016, 37.093304, NULL, 1),
(256173, 2, 2612.1926, 5267.116, 39.414043, NULL, 1),
(256173, 3, 2622.1306, 5257.2104, 38.274437, NULL, 1),

(256174, 1, 2608.5396, 5270.824, 38.410854, NULL, 1),
(256174, 2, 2614.004, 5265.765, 39.411907, NULL, 1),
(256174, 3, 2614.0928, 5259.838, 39.39466, NULL, 1),

(256175, 1, 2604.8347, 5286.645, 36.815502 , NULL, 1),
(256175, 2, 2607.5652, 5324.0244, 31.018406, NULL, 1),
(256175, 3, 2611.8296, 5351.459, 32.863174 , NULL, 1),
(256175, 4, 2622.6104, 5387.384, 32.863174 , NULL, 1),
(256175, 5, 2626.7065, 5402.0703, 32.863174, NULL, 1),
(256175, 6, 2629.7988, 5413.136, 30.653997 , NULL, 1),

(256176, 1, 2601.0093, 5279.1606, 36.828663, NULL, 1),
(256176, 2, 2604.5352, 5300.9995, 36.480186, NULL, 1),
(256176, 3, 2613.8127, 5321.6313, 31.018402, NULL, 1),
(256176, 4, 2624.7915, 5359.0264, 32.863174, NULL, 1),
(256176, 5, 2638.1523, 5386.913, 32.863174 , NULL, 1),

(256177, 1, 2606.4014, 5274.857, 37.1605  , NULL, 1),
(256177, 2, 2598.247, 5293.678, 36.814384 , NULL, 1),
(256177, 3, 2602.7478, 5325.407, 31.018406, NULL, 1),
(256177, 4, 2613.2375, 5354.188, 32.863174, NULL, 1),
(256177, 5, 2625.8896, 5398.117, 32.863174, NULL, 1),

(256178, 1, 2606.9521, 5272.983, 37.169373 , NULL, 1),
(256178, 2, 2606.2026, 5300.4604, 36.49433 , NULL, 1),
(256178, 3, 2618.5266, 5329.3213, 31.071074, NULL, 1),
(256178, 4, 2622.632, 5355.4214, 32.863174 , NULL, 1),
(256178, 5, 2635.3538, 5380.17, 32.863174  , NULL, 1),
(256178, 6, 2708.6326, 5360.3237, 31.040672, NULL, 1);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25617;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25617);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25617, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 256170, 256174, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Just Summoned - Start Random Path 256170-256174'),
(25617, 0, 1, 0, 109, 0, 100, 0, 0, 256170, 0, 0, 0, 0, 88, 2561700, 2561703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256170 Finished - Run Random Script'),
(25617, 0, 2, 0, 109, 0, 100, 0, 0, 256171, 0, 0, 0, 0, 88, 2561700, 2561703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256171 Finished - Run Random Script'),
(25617, 0, 3, 0, 109, 0, 100, 0, 0, 256172, 0, 0, 0, 0, 88, 2561700, 2561703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256172 Finished - Run Random Script'),
(25617, 0, 4, 0, 109, 0, 100, 0, 0, 256173, 0, 0, 0, 0, 88, 2561700, 2561703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256173 Finished - Run Random Script'),
(25617, 0, 5, 0, 109, 0, 100, 0, 0, 256174, 0, 0, 0, 0, 88, 2561700, 2561703, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256174 Finished - Run Random Script'),

(25617, 0, 6, 0, 109, 0, 100, 0, 0, 256175, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256175 Finished - Despawn Instant'),
(25617, 0, 7, 0, 109, 0, 100, 0, 0, 256176, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256176 Finished - Despawn Instant'),
(25617, 0, 8, 0, 109, 0, 100, 0, 0, 256177, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256177 Finished - Despawn Instant'),
(25617, 0, 9, 0, 109, 0, 100, 0, 0, 256178, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - On Path 256178 Finished - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2561700, 2561701, 2561702, 2561703, 2561704));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2561700, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 124, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Load Equipment Id 2'),
(2561700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 256175, 256178, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Start Random Path 256175-256178'),

(2561701, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 124, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Load Equipment Id 3'),
(2561701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 256175, 256178, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Start Random Path 256175-256178'),

(2561702, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 124, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Load Equipment Id 4'),
(2561702, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 256175, 256178, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Start Random Path 256175-256178'),

(2561703, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 124, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Load Equipment Id 5'),
(2561703, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 233, 256175, 256178, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Farshire Militia - Actionlist - Start Random Path 256175-256178');
