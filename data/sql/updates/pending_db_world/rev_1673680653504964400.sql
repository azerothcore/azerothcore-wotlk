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
