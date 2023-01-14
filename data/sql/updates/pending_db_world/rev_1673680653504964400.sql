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

-- Critters shouldn't get close enough to pull
UPDATE `creature` SET `wander_distance`=5 WHERE `guid` IN (83489, 83490) AND `id1` IN (2350, 2354);

-- Delete Phil (shouldn't be there)
DELETE FROM `creature` WHERE `id1`=21344 AND `guid`=84013;
