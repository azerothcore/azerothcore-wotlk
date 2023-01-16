-- Tarren Mill Fishermen
SET @CGUID := 81626;
DELETE FROM `creature` WHERE `map`=560 AND `id1`=18657 AND `guid` BETWEEN @CGUID+0 AND @CGUID+2; -- Completely missing
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 18657, 560, 2367, 2367, 3, 1, 1, 2404.199951171875, 740.22784423828125, 54.41904449462890625, 4.258603572845458984, 7200, 0, 0, 2076, 0, 0, 0, 0, 0, 47213), -- 18657 (Area: 2367 - Difficulty: 1)
(@CGUID+1, 18657, 560, 2367, 2367, 3, 1, 1, 2397, 747.512451171875, 54.26937103271484375, 4.188790321350097656, 7200, 0, 0, 2076, 0, 0, 0, 0, 0, 47213), -- 18657 (Area: 2367 - Difficulty: 1)
(@CGUID+2, 18657, 560, 2367, 2367, 3, 1, 1, 2399.98291015625, 744.4285888671875, 54.37799453735351562, 3.926990747451782226, 7200, 0, 0, 2076, 0, 0, 0, 0, 0, 47213); -- 18657 (Area: 2367 - Difficulty: 1)

DELETE FROM `creature_template_addon` WHERE (`entry` = 18657);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18657, 0, 0, 0, 1, 379, 0, ''); -- Fishing EmoteState

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18657;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@CGUID+0), -(@CGUID+1), -(@CGUID+2)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+0), 0, 0, 0, 60, 0, 100, 0, 20000, 40000, 20000, 40000, 0, 5, 380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 1 - On Update - Play Emote 380 (OneShotFishing)'),
(-(@CGUID+0), 0, 1, 0, 60, 0, 100, 0, 30000, 50000, 30000, 50000, 0, 87, 1865700, 1865701, 1865702, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Update - Run Random Script'),
(-(@CGUID+1), 0, 0, 0, 60, 0, 100, 0, 20000, 40000, 20000, 40000, 0, 5, 380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 2 - On Update - Play Emote 380 (OneShotFishing)'),
(-(@CGUID+1), 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 2 - On Data Set 1 1 - Say Line 3'),
(-(@CGUID+1), 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 2 - On Data Set 2 2 - Say Line 4'),
(-(@CGUID+1), 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 2 - On Data Set 3 3 - Say Line 5'),
(-(@CGUID+2), 0, 0, 0, 60, 0, 100, 0, 20000, 40000, 20000, 40000, 0, 5, 380, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 3 - On Update - Play Emote 380 (OneShotFishing)'),
(-(@CGUID+2), 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 3 - On Data Set 1 1 - Say Line 6'),
(-(@CGUID+2), 0, 2, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 3 - On Data Set 2 2 - Say Line 7'),
(-(@CGUID+2), 0, 3, 0, 38, 0, 100, 0, 3, 3, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman 3 - On Data Set 3 3 - Say Line 8');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1865700, 1865701, 1865702));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1865700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Say Line 0'),
(1865700, 9, 1, 0, 0, 0, 100, 0, 5600, 5600, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, @CGUID+1, 18657, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Set Data 1 1'),
(1865700, 9, 2, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, @CGUID+2, 18657, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Set Data 1 1'),
(1865701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Say Line 1'),
(1865701, 9, 1, 0, 0, 0, 100, 0, 5600, 5600, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, @CGUID+1, 18657, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Set Data 2 2'),
(1865701, 9, 2, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, @CGUID+2, 18657, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Set Data 2 2'),
(1865702, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Say Line 2'),
(1865702, 9, 1, 0, 0, 0, 100, 0, 5600, 5600, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 10, @CGUID+1, 18657, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Set Data 3 3'),
(1865702, 9, 2, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 10, @CGUID+2, 18657, 0, 0, 0, 0, 0, 0, 'Tarren Mill Fisherman - On Script - Set Data 3 3');

DELETE FROM `creature_text` WHERE `CreatureID`=18657;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18657, 0, 0, 'Fine fishing weather!', 12, 0, 100, 0, 0, 0, 15647, 0, 'Tarren Mill Fisherman 1'),
(18657, 0, 1, 'Couldn\'t ask for a nicer day!', 12, 0, 100, 0, 0, 0, 15648, 0, 'Tarren Mill Fisherman 1'),
(18657, 0, 2, 'Nothing like a good evening to fish!', 12, 0, 100, 0, 0, 0, 15649, 0, 'Tarren Mill Fisherman 1'),
(18657, 3, 0, 'Indeed! Nothing like the warm air and a cool pond...', 12, 0, 100, 0, 0, 0, 15650, 0, 'Tarren Mill Fisherman 2'),
(18657, 3, 1, 'I just wish the fish would bite more than the bugs...', 12, 0, 100, 0, 0, 0, 15651, 0, 'Tarren Mill Fisherman 2'),
(18657, 3, 2, 'Aye, if only every day was just like today....', 12, 0, 100, 0, 0, 0, 15652, 0, 'Tarren Mill Fisherman 2'),
(18657, 6, 0, 'Hush up, your yapping will scare the fish away!', 12, 0, 100, 0, 0, 0, 15653, 0, 'Tarren Mill Fisherman 3'),
(18657, 6, 1, 'Bah, real fishermen take on the fiercest rains!', 12, 0, 100, 0, 0, 0, 15654, 0, 'Tarren Mill Fisherman 3'),
(18657, 6, 2, 'What did you say?', 12, 0, 100, 0, 0, 0, 15655, 0, 'Tarren Mill Fisherman 3'),
(18657, 1, 0, 'Think we\'ll see ol\' sooty today?', 12, 0, 100, 0, 0, 0, 15656, 0, 'Tarren Mill Fisherman 1'),
(18657, 1, 1, 'I bet I\'ll catch a big one this time...', 12, 0, 100, 0, 0, 0, 15657, 0, 'Tarren Mill Fisherman 1'),
(18657, 1, 2, 'I better not pull up another of Reggy\'s boots again...', 12, 0, 100, 0, 0, 0, 15658, 0, 'Tarren Mill Fisherman 1'),
(18657, 4, 0, 'Maybe...', 12, 0, 100, 0, 0, 0, 15659, 0, 'Tarren Mill Fisherman 2'),
(18657, 4, 1, 'Anything could happen...', 12, 0, 100, 0, 0, 0, 15660, 0, 'Tarren Mill Fisherman 2'),
(18657, 4, 2, 'Hahah, don\'t get your hope up too high...', 12, 0, 100, 0, 0, 0, 15661, 0, 'Tarren Mill Fisherman 2'),
(18657, 7, 0, 'Got one!', 12, 0, 100, 0, 0, 0, 15662, 0, 'Tarren Mill Fisherman 3'),
(18657, 7, 1, 'You guys have any extra bait?', 12, 0, 100, 0, 0, 0, 15663, 0, 'Tarren Mill Fisherman 3'),
(18657, 7, 2, 'Remember that time we caught the red-finned murloc down in Elwynn?', 12, 0, 100, 0, 0, 0, 15664, 0, 'Tarren Mill Fisherman 3'),
(18657, 2, 0, 'Thank the light that Bertha\'s not here...', 12, 0, 100, 0, 0, 0, 15665, 0, 'Tarren Mill Fisherman 1'),
(18657, 2, 1, 'Nothing like a warm day and no ol\' lady to yell at ya...', 12, 0, 100, 0, 0, 0, 15666, 0, 'Tarren Mill Fisherman 1'),
(18657, 2, 2, 'Nothing like peace an quiet... unlike home!', 12, 0, 100, 0, 0, 0, 15667, 0, 'Tarren Mill Fisherman 1'),
(18657, 5, 0, 'I hear you! I can\'t get a moments peace without Sarah complaining about the chores!', 12, 0, 100, 0, 0, 0, 15668, 0, 'Tarren Mill Fisherman 2'),
(18657, 5, 1, 'Aye, an no squealing youngster to upset the peace of a man and his fish...', 12, 0, 100, 0, 0, 0, 15669, 0, 'Tarren Mill Fisherman 2'),
(18657, 8, 0, 'So you say now, but at least you\'ve got a warm dinner waiting for ya...', 12, 0, 100, 0, 0, 0, 15670, 0, 'Tarren Mill Fisherman 3'),
(18657, 8, 1, 'Could be worse, your wife coulda ran off to Stormwind with some cheese merchant!', 12, 0, 100, 0, 0, 0, 15671, 0, 'Tarren Mill Fisherman 3'),
(18657, 8, 2, 'Better not say that too loudly!', 12, 0, 100, 0, 0, 0, 15672, 0, 'Tarren Mill Fisherman 3');

-- Delete Phil (shouldn't be there)
DELETE FROM `creature` WHERE `id1`=21344 AND `guid`=84013;

-- Jay and Julie
DELETE FROM `creature_text` WHERE `CreatureID` IN (18655, 18656);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18655, 0, 0, 'Tag! You\'re it!', 12, 0, 100, 0, 0, 0, 15114, 0, 'Jay Lemieux'),
(18656, 0, 0, 'Can I play?', 12, 0, 100, 0, 0, 0, 19555, 0, 'Julie Honeywell'),
(18656, 0, 1, 'Ew, boys are gross!', 12, 0, 100, 0, 0, 0, 19556, 0, 'Julie Honeywell');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18656;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18656);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18656, 0, 0, 0, 60, 0, 100, 0, 20000, 40000, 20000, 40000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Julie Honeywell - On Update - Say Line 0');

UPDATE `creature` SET `position_x`=2631.6262,`position_y`=712.85583,`position_z`=56.167076 WHERE `id1`=18655 AND `guid`=83511;

DELETE FROM `waypoints` WHERE `entry` BETWEEN 1865500 AND 1865505 AND `point_comment`='Jay Lemieux';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
-- Jay Lemieux has several loops he can perform. I still haven't found the main "pivot" point so I've used the spawn point I got.
-- Jay Loop 1 (23)
(1865500,1,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
(1865500,2,2617.0854,732.95447,55.809044,NULL,0,'Jay Lemieux'),
(1865500,3,2601.966,758.8726,57.086544,NULL,0,'Jay Lemieux'),
(1865500,4,2572.0723,763.48596,56.499844,NULL,0,'Jay Lemieux'),
(1865500,5,2559.0056,755.42395,55.476406,NULL,0,'Jay Lemieux'),
(1865500,6,2551.7332,729.03955,55.263027,NULL,0,'Jay Lemieux'),
(1865500,7,2538.6519,715.6684,55.263027,NULL,0,'Jay Lemieux'),
(1865500,8,2561.7297,693.924,55.606853,NULL,0,'Jay Lemieux'),
(1865500,9,2558.5928,672.1387,54.826946,NULL,0,'Jay Lemieux'),
(1865500,10,2575.2063,657.85126,55.557545,NULL,0,'Jay Lemieux'),
(1865500,11,2590.891,652.99243,55.884693,NULL,0,'Jay Lemieux'),
(1865500,12,2602.6028,667.1922,56.648727,NULL,0,'Jay Lemieux'),
(1865500,13,2595.3735,699.3335,55.180775,NULL,0,'Jay Lemieux'),
(1865500,14,2615.4082,711.97424,56.755577,NULL,0,'Jay Lemieux'),
(1865500,15,2627.9846,711.6463,56.206993,NULL,0,'Jay Lemieux'),
(1865500,16,2645.302,717.6042,57.68072,NULL,0,'Jay Lemieux'),
(1865500,17,2674.4956,711.60693,57.56565,NULL,0,'Jay Lemieux'),
(1865500,18,2678.1438,697.728,57.338,NULL,0,'Jay Lemieux'),
(1865500,19,2668.836,682.76184,56.687366,NULL,0,'Jay Lemieux'),
(1865500,20,2652.6975,685.83624,56.21021,NULL,0,'Jay Lemieux'),
(1865500,21,2639.464,688.8372,55.247196,NULL,0,'Jay Lemieux'),
(1865500,22,2640.195,699.23486,55.94898,NULL,0,'Jay Lemieux'),
(1865500,23,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
-- Jay Loop 2 (41) 14:07:13 - 14:08:51
(1865501,1 ,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
(1865501,2 ,2617.0854,732.95447,55.809044,NULL,0,'Jay Lemieux'),
(1865501,3 ,2601.966,758.8726,57.086544,NULL,0,'Jay Lemieux'),
(1865501,4 ,2572.0723,763.48596,56.499844,NULL,0,'Jay Lemieux'),
(1865501,5 ,2559.0056,755.42395,55.476406,NULL,0,'Jay Lemieux'),
(1865501,6 ,2551.7332,729.03955,55.263027,NULL,0,'Jay Lemieux'),
(1865501,7 ,2538.6519,715.6684,55.263027,NULL,0,'Jay Lemieux'),
(1865501,8 ,2561.7297,693.924,55.606853,NULL,0,'Jay Lemieux'),
(1865501,9 ,2558.5928,672.1387,54.826946,NULL,0,'Jay Lemieux'),
(1865501,10,2575.2063,657.85126,55.557545,NULL,0,'Jay Lemieux'),
(1865501,11,2590.891,652.99243,55.884693,NULL,0,'Jay Lemieux'),
(1865501,12,2602.6028,667.1922,56.648727,NULL,0,'Jay Lemieux'),
(1865501,13,2574.6025,666.64453,55.182545,NULL,0,'Jay Lemieux'),
(1865501,14,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865501,15,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865501,16,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865501,17,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865501,18,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865501,19,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865501,20,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865501,21,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865501,22,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865501,23,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865501,24,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865501,25,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865501,26,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865501,27,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865501,28,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865501,29,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865501,30,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865501,31,2595.3735,699.3335,55.180775,NULL,0,'Jay Lemieux'),
(1865501,32,2615.4082,711.97424,56.755577,NULL,0,'Jay Lemieux'),
(1865501,33,2627.9846,711.6463,56.206993,NULL,0,'Jay Lemieux'),
(1865501,34,2645.302,717.6042,57.68072,NULL,0,'Jay Lemieux'),
(1865501,35,2674.4956,711.60693,57.56565,NULL,0,'Jay Lemieux'),
(1865501,36,2678.1438,697.728,57.338,NULL,0,'Jay Lemieux'),
(1865501,37,2668.836,682.76184,56.687366,NULL,0,'Jay Lemieux'),
(1865501,38,2652.6975,685.83624,56.21021,NULL,0,'Jay Lemieux'),
(1865501,39,2639.464,688.8372,55.247196,NULL,0,'Jay Lemieux'),
(1865501,40,2640.195,699.23486,55.94898,NULL,0,'Jay Lemieux'),
(1865501,41,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
-- Jay Path 3 (80) 14:13:07 - 14:16:04
(1865502,1,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
(1865502,2,2617.0854,732.95447,55.809044,NULL,0,'Jay Lemieux'),
(1865502,3,2601.966,758.8726,57.086544,NULL,0,'Jay Lemieux'),
(1865502,4,2572.0723,763.48596,56.499844,NULL,0,'Jay Lemieux'),
(1865502,5,2559.0056,755.42395,55.476406,NULL,0,'Jay Lemieux'),
(1865502,6,2551.7332,729.03955,55.263027,NULL,0,'Jay Lemieux'),
(1865502,7,2538.6519,715.6684,55.263027,NULL,0,'Jay Lemieux'),
(1865502,8,2561.7297,693.924,55.606853,NULL,0,'Jay Lemieux'),
(1865502,9,2558.5928,672.1387,54.826946,NULL,0,'Jay Lemieux'),
(1865502,10,2575.2063,657.85126,55.557545,NULL,0,'Jay Lemieux'),
(1865502,11,2590.891,652.99243,55.884693,NULL,0,'Jay Lemieux'),
(1865502,12,2602.6028,667.1922,56.648727,NULL,0,'Jay Lemieux'),
(1865502,13,2596.3298,685.7374,55.826893,NULL,0,'Jay Lemieux'),
(1865502,14,2581.1836,692.01544,55.180775,NULL,0,'Jay Lemieux'),
(1865502,15,2580.177,694.69,55.180775,NULL,0,'Jay Lemieux'),
(1865502,16,2567.5674,693.40216,55.430775,NULL,0,'Jay Lemieux'),
(1865502,17,2554.7092,701.254,55.513027,NULL,0,'Jay Lemieux'),
(1865502,18,2543.655,711.0902,55.33688,NULL,0,'Jay Lemieux'),
(1865502,19,2532.1614,725.5418,55.59628,NULL,0,'Jay Lemieux'),
(1865502,20,2521.3198,737.64923,58.147133,NULL,0,'Jay Lemieux'),
(1865502,21,2525.9456,758.9798,56.90763,NULL,0,'Jay Lemieux'),
(1865502,22,2542.3157,763.96857,56.41464,NULL,0,'Jay Lemieux'),
(1865502,23,2560.5547,757.7245,55.75253,NULL,0,'Jay Lemieux'),
(1865502,24,2576.9424,745.3482,55.263027,NULL,0,'Jay Lemieux'),
(1865502,25,2582.4236,732.5036,55.263027,NULL,0,'Jay Lemieux'),
(1865502,26,2584.6775,729.0917,55.54037,NULL,0,'Jay Lemieux'),
(1865502,27,2595.4766,728.6652,56.90768,NULL,0,'Jay Lemieux'),
(1865502,28,2612.9607,717.943,56.840782,NULL,0,'Jay Lemieux'),
(1865502,29,2619.0908,709.76776,56.438683,NULL,0,'Jay Lemieux'),
(1865502,30,2630.7708,705.35504,56.292076,NULL,0,'Jay Lemieux'),
(1865502,31,2631.5144,692.08246,55.916794,NULL,0,'Jay Lemieux'),
(1865502,32,2619.137,679.4537,54.886765,NULL,0,'Jay Lemieux'),
(1865502,33,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865502,34,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865502,35,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865502,36,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865502,37,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865502,38,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865502,39,2534.6885,716.6532,55.263027,NULL,0,'Jay Lemieux'),
(1865502,40,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865502,41,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865502,42,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865502,43,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865502,44,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865502,45,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865502,46,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865502,47,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865502,48,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865502,49,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865502,50,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865502,51,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865502,52,2596.3298,685.7374,55.826893,NULL,0,'Jay Lemieux'),
(1865502,53,2581.1836,692.01544,55.180775,NULL,0,'Jay Lemieux'),
(1865502,54,2580.177,694.69,55.180775,NULL,0,'Jay Lemieux'),
(1865502,55,2554.7092,701.254,55.513027,NULL,0,'Jay Lemieux'),
(1865502,56,2543.655,711.0902,55.33688,NULL,0,'Jay Lemieux'),
(1865502,57,2532.1614,725.5418,55.59628,NULL,0,'Jay Lemieux'),
(1865502,58,2521.3198,737.64923,58.147133,NULL,0,'Jay Lemieux'),
(1865502,59,2525.9456,758.9798,56.90763,NULL,0,'Jay Lemieux'),
(1865502,60,2542.3157,763.96857,56.41464,NULL,0,'Jay Lemieux'),
(1865502,61,2560.5547,757.7245,55.75253,NULL,0,'Jay Lemieux'),
(1865502,62,2576.9424,745.3482,55.263027,NULL,0,'Jay Lemieux'),
(1865502,63,2582.4236,732.5036,55.263027,NULL,0,'Jay Lemieux'),
(1865502,64,2595.4766,728.6652,56.90768,NULL,0,'Jay Lemieux'),
(1865502,65,2612.9607,717.943,56.840782,NULL,0,'Jay Lemieux'),
(1865502,66,2619.0908,709.76776,56.438683,NULL,0,'Jay Lemieux'),
(1865502,67,2630.7708,705.35504,56.292076,NULL,0,'Jay Lemieux'),
(1865502,68,2631.5144,692.08246,55.916794,NULL,0,'Jay Lemieux'),
(1865502,69,2619.137,679.4537,54.886765,NULL,0,'Jay Lemieux'),
(1865502,70,2595.3735,699.3335,55.180775,NULL,0,'Jay Lemieux'),
(1865502,71,2615.4082,711.97424,56.755577,NULL,0,'Jay Lemieux'),
(1865502,72,2627.9846,711.6463,56.206993,NULL,0,'Jay Lemieux'),
(1865502,73,2645.302,717.6042,57.68072,NULL,0,'Jay Lemieux'),
(1865502,74,2674.4956,711.60693,57.56565,NULL,0,'Jay Lemieux'),
(1865502,75,2678.1438,697.728,57.338,NULL,0,'Jay Lemieux'),
(1865502,76,2668.836,682.76184,56.687366,NULL,0,'Jay Lemieux'),
(1865502,77,2652.6975,685.83624,56.21021,NULL,0,'Jay Lemieux'),
(1865502,78,2639.464,688.8372,55.247196,NULL,0,'Jay Lemieux'),
(1865502,79,2640.195,699.23486,55.94898,NULL,0,'Jay Lemieux'),
(1865502,80,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
-- Jay Loop 4 (62)
(1865503,1 ,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
(1865503,2 ,2617.0854,732.95447,55.809044,NULL,0,'Jay Lemieux'),
(1865503,3 ,2601.966,758.8726,57.086544,NULL,0,'Jay Lemieux'),
(1865503,4 ,2572.0723,763.48596,56.499844,NULL,0,'Jay Lemieux'),
(1865503,5 ,2559.0056,755.42395,55.476406,NULL,0,'Jay Lemieux'),
(1865503,6 ,2551.7332,729.03955,55.263027,NULL,0,'Jay Lemieux'),
(1865503,7 ,2538.6519,715.6684,55.263027,NULL,0,'Jay Lemieux'),
(1865503,8 ,2561.7297,693.924,55.606853,NULL,0,'Jay Lemieux'),
(1865503,9 ,2558.5928,672.1387,54.826946,NULL,0,'Jay Lemieux'),
(1865503,10,2575.2063,657.85126,55.557545,NULL,0,'Jay Lemieux'),
(1865503,11,2590.891,652.99243,55.884693,NULL,0,'Jay Lemieux'),
(1865503,12,2602.6028,667.1922,56.648727,NULL,0,'Jay Lemieux'),
(1865503,13,2596.3298,685.7374,55.826893,NULL,0,'Jay Lemieux'),
(1865503,14,2581.1836,692.01544,55.180775,NULL,0,'Jay Lemieux'),
(1865503,15,2580.177,694.69,55.180775,NULL,0,'Jay Lemieux'),
(1865503,16,2567.5674,693.40216,55.430775,NULL,0,'Jay Lemieux'),
(1865503,17,2554.7092,701.254,55.513027,NULL,0,'Jay Lemieux'),
(1865503,18,2543.655,711.0902,55.33688,NULL,0,'Jay Lemieux'),
(1865503,19,2532.1614,725.5418,55.59628,NULL,0,'Jay Lemieux'),
(1865503,20,2521.3198,737.64923,58.147133,NULL,0,'Jay Lemieux'),
(1865503,21,2525.9456,758.9798,56.90763,NULL,0,'Jay Lemieux'),
(1865503,22,2542.3157,763.96857,56.41464,NULL,0,'Jay Lemieux'),
(1865503,23,2560.5547,757.7245,55.75253,NULL,0,'Jay Lemieux'),
(1865503,24,2576.9424,745.3482,55.263027,NULL,0,'Jay Lemieux'),
(1865503,25,2582.4236,732.5036,55.263027,NULL,0,'Jay Lemieux'),
(1865503,26,2595.4766,728.6652,56.90768,NULL,0,'Jay Lemieux'),
(1865503,27,2612.9607,717.943,56.840782,NULL,0,'Jay Lemieux'),
(1865503,28,2619.0908,709.76776,56.438683,NULL,0,'Jay Lemieux'),
(1865503,29,2630.7708,705.35504,56.292076,NULL,0,'Jay Lemieux'),
(1865503,30,2631.5144,692.08246,55.916794,NULL,0,'Jay Lemieux'),
(1865503,31,2619.137,679.4537,54.886765,NULL,0,'Jay Lemieux'),
(1865503,32,2596.3298,685.7374,55.826893,NULL,0,'Jay Lemieux'),
(1865503,33,2581.1836,692.01544,55.180775,NULL,0,'Jay Lemieux'),
(1865503,34,2580.177,694.69,55.180775,NULL,0,'Jay Lemieux'),
(1865503,35,2567.5674,693.40216,55.430775,NULL,0,'Jay Lemieux'),
(1865503,36,2554.7092,701.254,55.513027,NULL,0,'Jay Lemieux'),
(1865503,37,2543.655,711.0902,55.33688,NULL,0,'Jay Lemieux'),
(1865503,38,2532.1614,725.5418,55.59628,NULL,0,'Jay Lemieux'),
(1865503,39,2521.3198,737.64923,58.147133,NULL,0,'Jay Lemieux'),
(1865503,40,2525.9456,758.9798,56.90763,NULL,0,'Jay Lemieux'),
(1865503,41,2542.3157,763.96857,56.41464,NULL,0,'Jay Lemieux'),
(1865503,42,2560.5547,757.7245,55.75253,NULL,0,'Jay Lemieux'),
(1865503,43,2576.9424,745.3482,55.263027,NULL,0,'Jay Lemieux'),
(1865503,44,2582.4236,732.5036,55.263027,NULL,0,'Jay Lemieux'),
(1865503,45,2584.6775,729.0917,55.54037,NULL,0,'Jay Lemieux'),
(1865503,46,2595.4766,728.6652,56.90768,NULL,0,'Jay Lemieux'),
(1865503,47,2612.9607,717.943,56.840782,NULL,0,'Jay Lemieux'),
(1865503,48,2619.0908,709.76776,56.438683,NULL,0,'Jay Lemieux'),
(1865503,49,2630.7708,705.35504,56.292076,NULL,0,'Jay Lemieux'),
(1865503,50,2631.5144,692.08246,55.916794,NULL,0,'Jay Lemieux'),
(1865503,51,2619.137,679.4537,54.886765,NULL,0,'Jay Lemieux'),
(1865503,52,2595.3735,699.3335,55.180775,NULL,0,'Jay Lemieux'),
(1865503,53,2615.4082,711.97424,56.755577,NULL,0,'Jay Lemieux'),
(1865503,54,2627.9846,711.6463,56.206993,NULL,0,'Jay Lemieux'),
(1865503,55,2645.302,717.6042,57.68072,NULL,0,'Jay Lemieux'),
(1865503,56,2674.4956,711.60693,57.56565,NULL,0,'Jay Lemieux'),
(1865503,57,2678.1438,697.728,57.338,NULL,0,'Jay Lemieux'),
(1865503,58,2668.836,682.76184,56.687366,NULL,0,'Jay Lemieux'),
(1865503,59,2652.6975,685.83624,56.21021,NULL,0,'Jay Lemieux'),
(1865503,60,2639.464,688.8372,55.247196,NULL,0,'Jay Lemieux'),
(1865503,61,2640.195,699.23486,55.94898,NULL,0,'Jay Lemieux'),
(1865503,62,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
-- Jay Path 5 (115)
(1865504,1,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
(1865504,2,2617.0854,732.95447,55.809044,NULL,0,'Jay Lemieux'),
(1865504,3,2601.966,758.8726,57.086544,NULL,0,'Jay Lemieux'),
(1865504,4,2572.0723,763.48596,56.499844,NULL,0,'Jay Lemieux'),
(1865504,5,2559.0056,755.42395,55.476406,NULL,0,'Jay Lemieux'),
(1865504,6,2551.7332,729.03955,55.263027,NULL,0,'Jay Lemieux'),
(1865504,7,2538.6519,715.6684,55.263027,NULL,0,'Jay Lemieux'),
(1865504,8,2561.7297,693.924,55.606853,NULL,0,'Jay Lemieux'),
(1865504,9,2558.5928,672.1387,54.826946,NULL,0,'Jay Lemieux'),
(1865504,10,2575.2063,657.85126,55.557545,NULL,0,'Jay Lemieux'),
(1865504,11,2590.891,652.99243,55.884693,NULL,0,'Jay Lemieux'),
(1865504,12,2602.6028,667.1922,56.648727,NULL,0,'Jay Lemieux'),
(1865504,13,2574.6025,666.64453,55.182545,NULL,0,'Jay Lemieux'),
(1865504,14,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865504,15,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865504,16,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865504,17,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865504,18,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865504,19,2534.6885,716.6532,55.263027,NULL,0,'Jay Lemieux'),
(1865504,20,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865504,21,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865504,22,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865504,23,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865504,24,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865504,25,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865504,26,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865504,27,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865504,28,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865504,29,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865504,30,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865504,31,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865504,32,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865504,33,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865504,34,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865504,35,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865504,36,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865504,37,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865504,38,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865504,39,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865504,40,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865504,41,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865504,42,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865504,43,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865504,44,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865504,45,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865504,46,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865504,47,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865504,48,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865504,49,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865504,50,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865504,51,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865504,52,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865504,53,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865504,54,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865504,55,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865504,56,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865504,57,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865504,58,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865504,59,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865504,60,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865504,61,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865504,62,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865504,63,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865504,64,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865504,65,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865504,66,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865504,67,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865504,68,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865504,69,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865504,70,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865504,71,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865504,72,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865504,73,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865504,74,2534.6885,716.6532,55.263027,NULL,0,'Jay Lemieux'),
(1865504,75,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865504,76,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865504,77,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865504,78,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865504,79,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865504,80,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865504,81,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865504,82,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865504,83,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865504,84,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865504,85,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865504,86,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865504,87,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865504,88,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865504,89,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865504,90,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865504,91,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865504,92,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865504,93,2534.6885,716.6532,55.263027,NULL,0,'Jay Lemieux'),
(1865504,94,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865504,95,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865504,96,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865504,97,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865504,98,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865504,99,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865504,100,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865504,101,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865504,102,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865504,103,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865504,104,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865504,105,2595.3735,699.3335,55.180775,NULL,0,'Jay Lemieux'),
(1865504,106,2615.4082,711.97424,56.755577,NULL,0,'Jay Lemieux'),
(1865504,107,2627.9846,711.6463,56.206993,NULL,0,'Jay Lemieux'),
(1865504,108,2645.302,717.6042,57.68072,NULL,0,'Jay Lemieux'),
(1865504,109,2674.4956,711.60693,57.56565,NULL,0,'Jay Lemieux'),
(1865504,110,2678.1438,697.728,57.338,NULL,0,'Jay Lemieux'),
(1865504,111,2668.836,682.76184,56.687366,NULL,0,'Jay Lemieux'),
(1865504,112,2652.6975,685.83624,56.21021,NULL,0,'Jay Lemieux'),
(1865504,113,2639.464,688.8372,55.247196,NULL,0,'Jay Lemieux'),
(1865504,114,2640.195,699.23486,55.94898,NULL,0,'Jay Lemieux'),
(1865504,115,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
-- Jay Path 6 (78)
(1865505,1 ,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux'),
(1865505,2 ,2617.0854,732.95447,55.809044,NULL,0,'Jay Lemieux'),
(1865505,3 ,2601.966,758.8726,57.086544,NULL,0,'Jay Lemieux'),
(1865505,4 ,2572.0723,763.48596,56.499844,NULL,0,'Jay Lemieux'),
(1865505,5 ,2559.0056,755.42395,55.476406,NULL,0,'Jay Lemieux'),
(1865505,6 ,2551.7332,729.03955,55.263027,NULL,0,'Jay Lemieux'),
(1865505,7 ,2538.6519,715.6684,55.263027,NULL,0,'Jay Lemieux'),
(1865505,8 ,2561.7297,693.924,55.606853,NULL,0,'Jay Lemieux'),
(1865505,9 ,2558.5928,672.1387,54.826946,NULL,0,'Jay Lemieux'),
(1865505,10,2575.2063,657.85126,55.557545,NULL,0,'Jay Lemieux'),
(1865505,11,2590.891,652.99243,55.884693,NULL,0,'Jay Lemieux'),
(1865505,12,2602.6028,667.1922,56.648727,NULL,0,'Jay Lemieux'),
(1865505,13,2574.6025,666.64453,55.182545,NULL,0,'Jay Lemieux'),
(1865505,14,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865505,15,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865505,16,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865505,17,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865505,18,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865505,19,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865505,20,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865505,21,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865505,22,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865505,23,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865505,24,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865505,25,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865505,26,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865505,27,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865505,28,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865505,29,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865505,30,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865505,31,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865505,32,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865505,33,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865505,34,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865505,35,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865505,36,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865505,37,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865505,38,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865505,39,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865505,40,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865505,41,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865505,42,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865505,43,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865505,44,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865505,45,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865505,46,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865505,47,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865505,48,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865505,49,2574.5933,666.6351,55.19634,NULL,0,'Jay Lemieux'),
(1865505,50,2558.3337,671.57,54.889324,NULL,0,'Jay Lemieux'),
(1865505,51,2553.3247,678.7789,55.185955,NULL,0,'Jay Lemieux'),
(1865505,52,2540.089,685.0953,55.201946,NULL,0,'Jay Lemieux'),
(1865505,53,2532.8616,700.723,55.388027,NULL,0,'Jay Lemieux'),
(1865505,54,2533.544,709.47296,55.388027,NULL,0,'Jay Lemieux'),
(1865505,55,2534.6885,716.6532,55.263027,NULL,0,'Jay Lemieux'),
(1865505,56,2535.7722,725.20685,55.388027,NULL,0,'Jay Lemieux'),
(1865505,57,2548.4153,728.50824,55.263027,NULL,0,'Jay Lemieux'),
(1865505,58,2553.3074,736.56055,55.263027,NULL,0,'Jay Lemieux'),
(1865505,59,2557.3096,750.46246,55.263027,NULL,0,'Jay Lemieux'),
(1865505,60,2563.2825,763.01715,56.637295,NULL,0,'Jay Lemieux'),
(1865505,61,2588.3093,764.7947,57.100918,NULL,0,'Jay Lemieux'),
(1865505,62,2598.8862,755.08966,57.186367,NULL,0,'Jay Lemieux'),
(1865505,63,2618.4827,740.90314,56.169064,NULL,0,'Jay Lemieux'),
(1865505,64,2636.1614,722.0441,56.715878,NULL,0,'Jay Lemieux'),
(1865505,65,2639.9583,698.7454,55.94898,NULL,0,'Jay Lemieux'),
(1865505,66,2633.955,671.72253,54.368168,NULL,0,'Jay Lemieux'),
(1865505,67,2615.8096,672.7794,55.31401,NULL,0,'Jay Lemieux'),
(1865505,68,2595.3735,699.3335,55.180775,NULL,0,'Jay Lemieux'),
(1865505,69,2615.4082,711.97424,56.755577,NULL,0,'Jay Lemieux'),
(1865505,70,2627.9846,711.6463,56.206993,NULL,0,'Jay Lemieux'),
(1865505,71,2645.302,717.6042,57.68072,NULL,0,'Jay Lemieux'),
(1865505,72,2674.4956,711.60693,57.56565,NULL,0,'Jay Lemieux'),
(1865505,73,2678.1438,697.728,57.338,NULL,0,'Jay Lemieux'),
(1865505,74,2668.836,682.76184,56.687366,NULL,0,'Jay Lemieux'),
(1865505,75,2652.6975,685.83624,56.21021,NULL,0,'Jay Lemieux'),
(1865505,76,2639.464,688.8372,55.247196,NULL,0,'Jay Lemieux'),
(1865505,77,2640.195,699.23486,55.94898,NULL,0,'Jay Lemieux'),
(1865505,78,2631.6262,712.85583,56.167076,NULL,0,'Jay Lemieux');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18655;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18655, 0, 0, 0, 60, 0, 100, 0, 20000, 40000, 20000, 40000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Update - Say Line 0'),
(18655, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 88, 1865500, 1865505, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Respawn - Run Random Script'),
(18655, 0, 2, 0, 58, 0, 100, 0, 0, 0, 0, 0, 0, 88, 1865500, 1865505, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Waypoint Finished - Run Random Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 1865500 AND 1865505);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1865500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1865500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Script - Start Waypoint'),
(1865501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1865501, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Script - Start Waypoint'),
(1865502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1865502, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Script - Start Waypoint'),
(1865503, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1865503, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Script - Start Waypoint'),
(1865504, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1865504, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Script - Start Waypoint'),
(1865505, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1865505, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jay Lemieux - On Script - Start Waypoint');

-- Rebuild Tarren Mill Guards
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (18092, 18093, 18094, 23176, 23178) AND `guid` IN (83497,83498,83499,83500,83501,83506,83507,83508,83509,83510,83520,83521,83522,83523,83524,83525,84007,84008,84009,84010,84012);
DELETE FROM `creature_addon` WHERE `guid` IN (84009, 84010);
DELETE FROM `waypoint_data` WHERE `id` IN (840090, 840100);

SET @CGUID := 84300;
DELETE FROM `creature` WHERE `map`=560 AND `id1` IN (18092, 18093, 18094) AND `guid` BETWEEN @CGUID+0 AND @CGUID+18;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@CGUID+0 , 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2554.67, 764.913, 56.9444, 3.24039, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+1 , 18093, 0, 0, 560, 2367, 2367, 3, 1, 1, 2552.77, 762.674, 56.8888, 3.29647, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+2 , 18092, 0, 0, 560, 2367, 2367, 3, 1, 1, 2544.99, 763.984, 56.7261, 3.56932, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+3 , 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2539.62, 754.169, 57.2254, 4.13643, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+4 , 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2544.58, 756.798, 57.1765, 0.139626, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+5 , 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2645.47, 753.446, 63.1385, 2.33874, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+6 , 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2613.35, 713.851, 57.0492, 6.02139, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+7 , 18093, 0, 0, 560, 2367, 2367, 3, 1, 1, 2615.79, 710.999, 56.7405, 1.48353, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+8 , 18092, 0, 0, 560, 2367, 2367, 3, 1, 1, 2616.48, 714.543, 56.596, 3.87463, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+9 , 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2642.45, 750, 63.3188, 5.07891, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+10, 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2668.75, 728.152, 57.9636, 0.488692, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+11, 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2681.82, 712.647, 58.0571, 1.72571, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+12, 18093, 0, 0, 560, 2367, 2367, 3, 1, 1, 2683.68, 713.69, 58.2247, 4.86829, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+13, 18092, 0, 0, 560, 2367, 2367, 3, 1, 1, 2681.55, 714.326, 57.9449, 4.8682, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+14, 18093, 0, 0, 560, 2367, 2367, 3, 1, 1, 2673.05, 727.474, 57.7221, 1.72788, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+15, 18092, 0, 0, 560, 2367, 2367, 3, 1, 1, 2674.58, 730.534, 57.6785, 4.34587, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+16, 18093, 0, 0, 560, 2367, 2367, 3, 1, 1, 2617.9, 596.053, 55.6947, 3.90481, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+17, 18092, 0, 0, 560, 2367, 2367, 3, 1, 1, 2613.49, 595.887, 55.1969, 2.7085, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213),
(@CGUID+18, 18094, 0, 0, 560, 2367, 2367, 3, 1, 1, 2618.87, 593.398, 56.1303, 3.93707, 86400, 0, 0, 0, 0, 0, 0, 0, 0, '', 47213);

-- Pathing for Tarren Mill Lookout Entry: 18094
SET @NPC := @CGUID+9;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2642.4526,`position_y`=750.0003,`position_z`=63.31877 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2642.4526,750.0003,63.31877,1.954768776893615722,21000,0,0,100,0),
(@PATH,2,2642.4526,750.0003,63.31877,3.438298702239990234,21000,0,0,100,0),
(@PATH,3,2642.4526,750.0003,63.31877,5.078907966613769531,21000,0,0,100,0);
-- 0x204214460011AB8000618C0001233C55 .go xyz 2642.4526 750.0003 63.31877

-- Pathing for Tarren Mill Lookout Entry: 18094
SET @NPC := @CGUID+5;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2645.4663,`position_y`=753.4458,`position_z`=63.138523 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2645.4663,753.4458,63.138523,1.256637096405029296,18000,0,0,100,0),
(@PATH,2,2645.4663,753.4458,63.138523,2.338741064071655273,18000,0,0,100,0),
(@PATH,3,2645.4663,753.4458,63.138523,5.969026088714599609,18000,0,0,100,0);
-- 0x204214460011AB8000618C0000A33C55 .go xyz 2645.4663 753.4458 63.138523

-- Pathing for Tarren Mill Lookout Entry: 18094
SET @NPC := @CGUID+4;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2544.5837,`position_y`=756.79767,`position_z`=57.176525 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2544.5837,756.79767,57.176525,1.570796370506286621,15000,0,0,100,0),
(@PATH,2,2544.5837,756.79767,57.176525,2.49582076072692871,15000,0,0,100,0),
(@PATH,3,2544.5837,756.79767,57.176525,0.139626339077949523,15000,0,0,100,0);
-- 0x204214460011AB8000618C0001A33C55 .go xyz 2544.5837 756.79767 57.176525

-- Pathing for Tarren Mill Lookout Entry: 18094
SET @NPC := @CGUID+3;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2539.6204,`position_y`=754.1692,`position_z`=57.22537 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2539.6204,754.1692,57.22537,2.478367567062377929,12000,0,0,100,0),
(@PATH,2,2539.6204,754.1692,57.22537,1.762782573699951171,12000,0,0,100,0),
(@PATH,3,2539.6204,754.1692,57.22537,4.136430263519287109,12000,0,0,100,0);
-- 0x204214460011AB8000618C0002233C55 .go xyz 2539.6204 754.1692 57.22537

-- Pathing for Tarren Mill Guardsman Entry: 18092
SET @NPC := @CGUID+17;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2587.5115,`position_y`=625.9022,`position_z`=56.395798 WHERE `guid`=@NPC;
UPDATE `creature` SET `position_x`=2587.5115,`position_y`=625.9022,`position_z`=56.395798 WHERE `guid` IN (@CGUID+16, @CGUID+18);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2587.5115,625.9022,56.395798,NULL,0,0,0,100,0),
(@PATH,2,2597.6282,603.2016,56.021408,NULL,0,0,0,100,0),
(@PATH,3,2620.766,592.524,56.46237,NULL,0,0,0,100,0),
(@PATH,4,2637.2227,612.3849,55.86766,NULL,0,0,0,100,0),
(@PATH,5,2648.4136,627.02606,56.18431,NULL,0,0,0,100,0),
(@PATH,6,2660.1719,643.19727,56.023727,NULL,0,0,0,100,0),
(@PATH,7,2648.4136,627.02606,56.18431,NULL,0,0,0,100,0),
(@PATH,8,2637.2227,612.3849,55.86766,NULL,0,0,0,100,0),
(@PATH,9,2620.766,592.524,56.46237,NULL,0,0,0,100,0),
(@PATH,10,2597.6282,603.2016,56.021408,NULL,0,0,0,100,0);
-- 0x204214460011AB0000618C0000233C55 .go xyz 2587.5115 625.9022 56.395798

-- Pathing for Tarren Mill Guardsman Entry: 18092
SET @NPC := @CGUID+13;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2681.388,`position_y`=715.3746,`position_z`=57.892555 WHERE `guid`=@NPC;
UPDATE `creature` SET `position_x`=2681.388,`position_y`=715.3746,`position_z`=57.892555 WHERE `guid` IN (@CGUID+11, @CGUID+12);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2681.388,715.3746,57.892555,NULL,0,0,0,100,0),
(@PATH,2,2683.1145,704.38184,58.672707,NULL,0,0,0,100,0),
(@PATH,3,2684.7158,694.5088,58.358387,NULL,0,0,0,100,0),
(@PATH,4,2684.9153,684.5862,58.110706,NULL,0,0,0,100,0),
(@PATH,5,2684.1824,674.2352,57.733387,NULL,0,0,0,100,0),
(@PATH,6,2683.4263,666.6116,57.46996,NULL,0,0,0,100,0),
(@PATH,7,2684.1824,674.2352,57.733387,NULL,0,0,0,100,0),
(@PATH,8,2684.9153,684.5862,58.110706,NULL,0,0,0,100,0),
(@PATH,9,2684.7249,694.4693,58.31737,NULL,0,0,0,100,0),
(@PATH,10,2683.1145,704.38184,58.672707,NULL,0,0,0,100,0);
-- 0x204214460011AB0000618C0000A33C55 .go xyz 2681.388 715.3746 57.892555

-- Pathing for Tarren Mill Guardsman Entry: 18092
SET @NPC := @CGUID+2;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2588.9224,`position_y`=758.05286,`position_z`=56.52499 WHERE `guid`=@NPC;
UPDATE `creature` SET `position_x`=2588.9224,`position_y`=758.05286,`position_z`=56.52499 WHERE `guid` IN (@CGUID+0, @CGUID+1);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2588.9224,758.05286,56.52499,NULL,0,0,0,100,0),
(@PATH,2,2581.6646,761.9474,56.38046,NULL,0,0,0,100,0),
(@PATH,3,2572.3047,764.46014,56.733486,NULL,0,0,0,100,0),
(@PATH,4,2560.2358,765.303,57.03683,NULL,0,0,0,100,0),
(@PATH,5,2546.823,764.8195,56.72848,NULL,0,0,0,100,0),
(@PATH,6,2533.316,758.662,56.71073,NULL,0,0,0,100,0),
(@PATH,7,2521.9248,751.6855,57.56266,NULL,0,0,0,100,0),
(@PATH,8,2519.3826,741.1541,58.076088,NULL,0,0,0,100,0),
(@PATH,9,2521.9248,751.6855,57.56266,NULL,0,0,0,100,0),
(@PATH,10,2533.316,758.662,56.71073,NULL,0,0,0,100,0),
(@PATH,11,2546.823,764.8195,56.72848,NULL,0,0,0,100,0),
(@PATH,12,2560.2358,765.303,57.03683,NULL,0,0,0,100,0),
(@PATH,13,2572.3047,764.46014,56.733486,NULL,0,0,0,100,0),
(@PATH,14,2581.6646,761.9474,56.38046,NULL,0,0,0,100,0);
-- 0x204214460011AB0000618C0002233C55 .go xyz 2588.9224 758.05286 56.52499

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (@CGUID+2,@CGUID+13,@CGUID+17,@CGUID+10,@CGUID+5,@CGUID+6,@CGUID+3) AND `memberGUID` IN (@CGUID+2 ,@CGUID+1 ,@CGUID+0 ,@CGUID+13,@CGUID+12,@CGUID+11,@CGUID+17,@CGUID+16,@CGUID+18,@CGUID+10,@CGUID+14,@CGUID+15,@CGUID+5 ,@CGUID+9 ,@CGUID+6 ,@CGUID+7 ,@CGUID+8 ,@CGUID+3 ,@CGUID+4);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+2 , @CGUID+2 , 0, 0, 3, 0, 0),
(@CGUID+2 , @CGUID+1 , 1.75, 90, 515, 0, 0),
(@CGUID+2 , @CGUID+0 , 1.75, 180, 515, 0, 0),
(@CGUID+13, @CGUID+13, 0, 0, 3, 0, 0),
(@CGUID+13, @CGUID+12, 1.75, 90, 515, 0, 0),
(@CGUID+13, @CGUID+11, 1.75, 180, 515, 0, 0),
(@CGUID+17, @CGUID+17, 0, 0, 3, 0, 0),
(@CGUID+17, @CGUID+16, 1.75, 90, 515, 0, 0),
(@CGUID+17, @CGUID+18, 1.75, 180, 515, 0, 0),
(@CGUID+10, @CGUID+10, 0, 0, 3, 0, 0),
(@CGUID+10, @CGUID+14, 0, 0, 3, 0, 0),
(@CGUID+10, @CGUID+15, 0, 0, 3, 0, 0),
(@CGUID+5 , @CGUID+5 , 0, 0, 3, 0, 0),
(@CGUID+5 , @CGUID+9 , 0, 0, 3, 0, 0),
(@CGUID+6 , @CGUID+6 , 0, 0, 3, 0, 0),
(@CGUID+6 , @CGUID+7 , 0, 0, 3, 0, 0),
(@CGUID+6 , @CGUID+8 , 0, 0, 3, 0, 0),
(@CGUID+3 , @CGUID+3 , 0, 0, 3, 0, 0),
(@CGUID+3 , @CGUID+4 , 0, 0, 3, 0, 0);

-- Tarren Mill Orchard
UPDATE `creature` SET `position_x`=2549.044, `position_y`=667.6353, `position_z`=55.86316, `orientation`=1.65806281566619873 WHERE `id1`=18644 AND `guid`=83518; -- Correct coords
DELETE FROM `creature` WHERE `guid`=83502 AND `id1`=18644; -- Remove extra spawn

-- Pathing for Tarren Mill Peasant Entry: 18644
SET @NPC := 83515;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2554.9783,`position_y`=687.0314,`position_z`=55.451946 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2554.9783,687.0314,55.451946,NULL,0,0,0,100,0),
(@PATH,2,2561.218,690.67163,55.576946,NULL,0,0,0,100,0),
(@PATH,3,2568.7146,690.6922,55.44298,NULL,0,0,0,100,0),
(@PATH,4,2577.013,687.39465,55.180775,NULL,0,0,0,100,0),
(@PATH,5,2580.7092,693.7745,55.180775,NULL,0,0,0,100,0),
(@PATH,6,2571.8455,701.53064,55.263027,NULL,0,0,0,100,0),
(@PATH,7,2561.5073,704.2067,55.388027,NULL,0,0,0,100,0),
(@PATH,8,2561.4792,695.0597,55.701946,NULL,0,0,0,100,0),
(@PATH,9,2561.5073,704.2067,55.388027,NULL,0,0,0,100,0),
(@PATH,10,2571.8455,701.53064,55.263027,NULL,0,0,0,100,0),
(@PATH,11,2580.7092,693.7745,55.180775,NULL,0,0,0,100,0),
(@PATH,12,2577.013,687.39465,55.180775,NULL,0,0,0,100,0),
(@PATH,13,2568.7146,690.6922,55.44298,NULL,0,0,0,100,0),
(@PATH,14,2561.218,690.67163,55.576946,NULL,0,0,0,100,0);
-- 0x204214460012350000618C0000233C55 .go xyz 2554.9783 687.0314 55.451946

-- Pathing for Tarren Mill Peasant Entry: 18644
SET @NPC := 83514;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2543.1196,`position_y`=693.89404,`position_z`=55.326946 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2543.1196,693.89404,55.326946,NULL,0,0,0,100,0),
(@PATH,2,2553.9338,701.0461,55.513027,NULL,0,0,0,100,0),
(@PATH,3,2561.695,698.33575,55.611004,NULL,0,0,0,100,0),
(@PATH,4,2568.0493,694.85394,55.430775,NULL,0,0,0,100,0),
(@PATH,5,2561.695,698.33575,55.611004,NULL,0,0,0,100,0),
(@PATH,6,2553.9338,701.0461,55.513027,NULL,0,0,0,100,0);
-- 0x204214460012350000618C0000233C56 .go xyz 2543.1196 693.89404 55.326946

-- Pathing for Tarren Mill Peasant Entry: 18644
SET @NPC := 83513;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=2581.023,`position_y`=719.0766,`position_z`=55.263027 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2581.023,719.0766,55.263027,NULL,0,0,0,100,0),
(@PATH,2,2575.6465,720.1748,55.263027,NULL,0,0,0,100,0),
(@PATH,3,2571.326,717.3841,55.263027,NULL,0,0,0,100,0),
(@PATH,4,2564.6213,715.7407,55.263027,NULL,0,0,0,100,0),
(@PATH,5,2571.326,717.3841,55.263027,NULL,0,0,0,100,0),
(@PATH,6,2575.6465,720.1748,55.263027,NULL,0,0,0,100,0);
-- 0x204214460012350000618C0002233C55 .go xyz 2581.023 719.0766 55.263027

UPDATE `creature` SET `position_x`=2579.1692,`position_y`=741.4955,`position_z`=55.263027 WHERE `guid`=83512;
UPDATE `creature` SET `position_x`=2560.0842,`position_y`=735.0262,`position_z`=55.263027 WHERE `guid`=83505;
UPDATE `creature` SET `position_x`=2533.39,`position_y`=698.4243,`position_z`=55.326946 WHERE `guid`=83504;
UPDATE `creature` SET `position_x`=2540.1965,`position_y`=707.5806,`position_z`=55.388027 WHERE `guid`=83503;

DELETE FROM `waypoints` WHERE `entry` BETWEEN 1864400 AND 1864411 AND `point_comment` LIKE 'Tarren Mill Peasant%';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
-- Farmer 1 Loop
(1864400,1,2579.1692,741.4955,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,2,2567.516,739.04486,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,3,2559.5698,735.6041,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,4,2556.541,742.21185,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,5,2559.5698,735.6041,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,6,2567.516,739.04486,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,7,2573.79,744.6142,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
(1864400,8,2577.3606,741.2238,55.263027,NULL,0,'Tarren Mill Peasant 1 Loop'),
-- Loot
(1864401,1,2580.7603,733.7795,55.263027,NULL,0,'Tarren Mill Peasant 1'),
(1864401,2,2585.122,729.6559,55.540127,NULL,0,'Tarren Mill Peasant 1'),
(1864401,3,2597.298,727.745,57.138027,NULL,0,'Tarren Mill Peasant 1'),
(1864401,4,2610.7305,723.7787,56.300743,NULL,0,'Tarren Mill Peasant 1'),
(1864401,5,2616.56,724.4365,55.667076,NULL,0,'Tarren Mill Peasant 1'),
(1864401,6,2618.2258,722.1252,55.574547,NULL,0,'Tarren Mill Peasant 1'), -- Drop-Off

(1864402,1,2605.0447,728.33813,56.99337,NULL,0,'Tarren Mill Peasant 1'),
(1864402,2,2598.8342,729.49005,57.209316,NULL,0,'Tarren Mill Peasant 1'),
(1864402,3,2591.6653,728.9743,56.325283,NULL,0,'Tarren Mill Peasant 1'),
(1864402,4,2580.683,730.13214,55.263027,NULL,0,'Tarren Mill Peasant 1'),
(1864402,5,2579.1692,741.4955,55.263027,NULL,0,'Tarren Mill Peasant 1'), -- Resume
-- Farmer 2 Loop
(1864403,1,2560.0842,735.0262,55.263027,NULL,0,'Tarren Mill Peasant 2 Loop'),
(1864403,2,2554.5186,733.9661,55.263027,NULL,0,'Tarren Mill Peasant 2 Loop'),
(1864403,3,2560.0842,735.0262,55.263027,NULL,0,'Tarren Mill Peasant 2 Loop'),
(1864403,4,2566.1782,736.39594,55.263027,NULL,0,'Tarren Mill Peasant 2 Loop'),
(1864403,5,2574.5671,741.9193,55.263027,NULL,0,'Tarren Mill Peasant 2 Loop'),
(1864403,6,2566.1782,736.39594,55.263027,NULL,0,'Tarren Mill Peasant 2 Loop'),
-- Loot 
(1864404,1,2555.2058,743.61847,55.263027,NULL,0,'Tarren Mill Peasant 2'),
(1864404,2,2558.5776,752.5052,55.263027,NULL,0,'Tarren Mill Peasant 2'),
(1864404,3,2555.683,755.8353,55.781216,NULL,0,'Tarren Mill Peasant 2'),
(1864404,4,2571.7463,764.7781,56.809902,NULL,0,'Tarren Mill Peasant 2'),
(1864404,5,2604.645,742.22015,56.637325,NULL,0,'Tarren Mill Peasant 2'),
(1864404,6,2604.1758,731.3882,56.774376,NULL,0,'Tarren Mill Peasant 2'),
(1864404,7,2612.1719,718.78,56.88656,NULL,0,'Tarren Mill Peasant 2'),
(1864404,8,2618.5593,716.9926,56.375286,NULL,0,'Tarren Mill Peasant 2'), -- Drop-Off

(1864405,1,2596.1682,722.98474,56.936367,NULL,0,'Tarren Mill Peasant 2'),
(1864405,2,2588.9414,729.4648,55.983974,NULL,0,'Tarren Mill Peasant 2'),
(1864405,3,2579.839,729.3068,55.263027,NULL,0,'Tarren Mill Peasant 2'),
(1864405,4,2572.823,726.1969,55.263027,NULL,0,'Tarren Mill Peasant 2'), -- Resume
-- Farmer 3 Loop
(1864406,1,2533.39,698.4243,55.326946,NULL,0,'Tarren Mill Peasant 3 Loop'),
(1864406,2,2523.5632,692.62366,55.2429,NULL,0,'Tarren Mill Peasant 3 Loop'),
(1864406,3,2518.5513,698.5561,55.2429,NULL,0,'Tarren Mill Peasant 3 Loop'),
(1864406,4,2524.5872,708.29956,55.263027,NULL,0,'Tarren Mill Peasant 3 Loop'),
(1864406,5,2536.4536,714.06866,55.263027,NULL,0,'Tarren Mill Peasant 3 Loop'),
(1864406,6,2540.6436,708.1387,55.388027,NULL,0,'Tarren Mill Peasant 3 Loop'),
-- Loot
(1864407,1,2536.1128,682.46454,55.201946,NULL,0,'Tarren Mill Peasant 3'),
(1864407,2,2547.97,682.8966,55.201946,NULL,0,'Tarren Mill Peasant 3'),
(1864407,3,2566.0503,679.4231,55.201946,NULL,0,'Tarren Mill Peasant 3'),
(1864407,4,2584.7163,689.2281,55.180775,NULL,0,'Tarren Mill Peasant 3'),
(1864407,5,2593.8137,689.33344,55.500843,NULL,0,'Tarren Mill Peasant 3'),
(1864407,6,2607.1274,689.22687,55.648727,NULL,0,'Tarren Mill Peasant 3'),
(1864407,7,2606.8733,693.58124,55.648727,NULL,0,'Tarren Mill Peasant 3'),
(1864407,8,2607.523,707.4654,56.708824,NULL,0,'Tarren Mill Peasant 3'),
(1864407,9,2611.9263,718.2008,57.05526,NULL,0,'Tarren Mill Peasant 3'),
(1864407,10,2615.432,719.9049,56.100426,NULL,0,'Tarren Mill Peasant 3'), -- Drop-Off

(1864408,1,2586.529,711.44806,55.263027,NULL,0,'Tarren Mill Peasant 3'),
(1864408,2,2566.7876,707.8689,55.263027,NULL,0,'Tarren Mill Peasant 3'),
(1864408,3,2549.6401,712.89795,55.263027,NULL,0,'Tarren Mill Peasant 3'),
(1864408,4,2541.9224,705.3675,55.388027,NULL,0,'Tarren Mill Peasant 3'),
(1864408,5,2528.4304,703.2813,55.263027,NULL,0,'Tarren Mill Peasant 3'), -- Resume
-- Farmer 4 Loop 
(1864409,1,2540.1965,707.5806,55.388027,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,2,2537.2483,698.39526,55.326946,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,3,2547.0784,696.1814,55.451946,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,4,2558.412,702.44305,55.513027,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,5,2561.824,713.6516,55.263027,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,6,2558.412,702.44305,55.513027,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,7,2547.0784,696.1814,55.451946,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,8,2537.2483,698.39526,55.326946,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,9,2540.1965,707.5806,55.388027,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,10,2534.49,711.6807,55.298794,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,11,2526.2415,706.0055,55.263027,NULL,0,'Tarren Mill Peasant 4 Loop'),
(1864409,12,2534.49,711.6807,55.298794,NULL,0,'Tarren Mill Peasant 4 Loop'),
-- Farmer 4 Loot
(1864410,1,2563.376,706.6429,55.278408,NULL,0,'Tarren Mill Peasant 4'),
(1864410,2,2574.2478,707.0303,55.263027,NULL,0,'Tarren Mill Peasant 4'),
(1864410,3,2584.5305,707.47,55.263027,NULL,0,'Tarren Mill Peasant 4'),
(1864410,4,2588.7463,713.8691,55.263027,NULL,0,'Tarren Mill Peasant 4'),
(1864410,5,2591.807,713.58954,55.54672,NULL,0,'Tarren Mill Peasant 4'),
(1864410,6,2607.0369,706.183,56.400963,NULL,0,'Tarren Mill Peasant 4'),
(1864410,7,2614.2766,708.18976,56.587364,NULL,0,'Tarren Mill Peasant 4'),
(1864410,8,2620.3577,713.8734,56.323563,NULL,0,'Tarren Mill Peasant 4'), -- Drop-Off

(1864411,1,2604.002,705.33185,56.162193,NULL,0,'Tarren Mill Peasant 4'),
(1864411,2,2595.1753,695.5046,55.180775,NULL,0,'Tarren Mill Peasant 4'),
(1864411,3,2589.2942,690.23413,55.180775,NULL,0,'Tarren Mill Peasant 4'),
(1864411,4,2575.0344,685.8089,55.180775,NULL,0,'Tarren Mill Peasant 4'),
(1864411,5,2561.4514,689.1116,55.576946,NULL,0,'Tarren Mill Peasant 4'),
(1864411,6,2557.9626,696.91675,55.75944,NULL,0,'Tarren Mill Peasant 4'),
(1864411,7,2539.3113,693.7178,55.326946,NULL,0,'Tarren Mill Peasant 4'),
(1864411,8,2531.8923,704.2636,55.388027,NULL,0,'Tarren Mill Peasant 4'); -- Resume

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18644;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (18644, -83512, -83505, -83504, -83503));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-83512, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Respawn - Start Waypoint'),
(-83512, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Respawn - Set Event Phase 1'),
(-83512, 0, 2, 0, 58, 1, 10, 0, 0, 1864400, 0, 0, 0, 80, 1864400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Run Script (Phase 1)'),
(-83512, 0, 3, 0, 58, 1, 100, 0, 0, 1864400, 0, 0, 0, 53, 0, 1864400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Start Waypoint (Phase 1)'),
(-83512, 0, 4, 0, 58, 0, 100, 0, 0, 1864401, 0, 0, 0, 80, 1864401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Run Script'),
(-83512, 0, 5, 0, 58, 0, 100, 0, 0, 1864402, 0, 0, 0, 53, 0, 1864400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Start Waypoint'),
(-83512, 0, 6, 0, 58, 2, 100, 0, 0, 1864400, 0, 0, 0, 53, 0, 1864401, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Start Waypoint (Phase 2)'),

(-83505, 0, 0, 1, 40, 0, 10, 0, 0, 1864403, 0, 0, 0, 11, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Any Waypoint Reached - Cast \'Serverside - Gold Peasant Transform\' (10% Chance)'),
(-83505, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864404, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Any Waypoint Reached - Start Drop-Off'),
(-83505, 0, 2, 0, 40, 0, 100, 0, 8, 1864404, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint 8 Reached - Create Timed Event'),
(-83505, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 0, 28, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Timed Event 1 Triggered - Remove Aura \'Serverside - Gold Peasant Transform\''),
(-83505, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864405, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Timed Event 1 Triggered - Start Waypoint'),
(-83505, 0, 5, 0, 58, 0, 100, 0, 4, 1864405, 0, 0, 0, 53, 0, 1864403, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Resume Loop'),
(-83505, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864403, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Respawn - Start Loop'),

(-83504, 0, 0, 1, 40, 0, 10, 0, 0, 1864406, 0, 0, 0, 11, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Any Waypoint Reached - Cast \'Serverside - Gold Peasant Transform\' (10% Chance)'),
(-83504, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Any Waypoint Reached - Start Drop-Off'),
(-83504, 0, 2, 0, 40, 0, 100, 0, 10, 1864407, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint 10 Reached - Create Timed Event'),
(-83504, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 0, 28, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Timed Event 1 Triggered - Remove Aura \'Serverside - Gold Peasant Transform\''),
(-83504, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864408, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Timed Event 1 Triggered - Start Waypoint'),
(-83504, 0, 5, 0, 58, 0, 100, 0, 5, 1864408, 0, 0, 0, 53, 0, 1864406, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Resume Loop'),
(-83504, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864406, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Respawn - Start Loop'),

(-83503, 0, 0, 1, 40, 0, 10, 0, 0, 1864409, 0, 0, 0, 11, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Any Waypoint Reached - Cast \'Serverside - Gold Peasant Transform\' (10% Chance)'),
(-83503, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864410, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Any Waypoint Reached - Start Drop-Off'),
(-83503, 0, 2, 0, 40, 0, 100, 0, 8, 1864410, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint 10 Reached - Create Timed Event'),
(-83503, 0, 3, 4, 59, 0, 100, 0, 1, 0, 0, 0, 0, 28, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Timed Event 1 Triggered - Remove Aura \'Serverside - Gold Peasant Transform\''),
(-83503, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864411, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Timed Event 1 Triggered - Start Waypoint'),
(-83503, 0, 5, 0, 58, 0, 100, 0, 8, 1864411, 0, 0, 0, 53, 0, 1864409, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Waypoint Finished - Resume Loop'),
(-83503, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1864409, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Respawn - Start Loop');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1864400, 1864401));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1864400, 9, 0, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 11, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Script - Cast \'Serverside - Gold Peasant Transform\''),
(1864400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Script - Set Event Phase 2'),
(1864401, 9, 0, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 28, 32617, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Script - Remove Aura \'Serverside - Gold Peasant Transform\''),
(1864401, 9, 1, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 53, 0, 1864402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Script - Start Waypoint'),
(1864401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tarren Mill Peasant - On Script - Set Event Phase 1');