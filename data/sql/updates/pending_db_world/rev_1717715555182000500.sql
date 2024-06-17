--
SET @CGUID := 12529;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+18 AND `id1` IN (23435, 23440);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0 , 23435, 530, 3520, 3938, 1, 1, 1, -4063.517333984375, 1079.0699462890625, 32.32865142822265625, 5.462880611419677734, 0 /* spawntimesecs */, 0, 0, 19626, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+1 , 23435, 530, 3520, 3938, 1, 1, 1, -4086.240478515625, 1060.3443603515625, 31.09149932861328125, 5.305800914764404296, 0 /* spawntimesecs */, 0, 0, 20283, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+2 , 23435, 530, 3520, 3938, 1, 1, 1, -4077.014404296875, 1070.7025146484375, 31.12168502807617187, 5.375614166259765625, 0 /* spawntimesecs */, 0, 0, 19626, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+3 , 23435, 530, 3520, 3938, 1, 1, 1, -4070.817626953125, 1074.8057861328125, 31.39684104919433593, 5.393067359924316406, 0 /* spawntimesecs */, 0, 0, 20958, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+4 , 23435, 530, 3520, 3938, 1, 1, 1, -4084.223876953125, 1066.301025390625, 31.44091796875, 5.427973747253417968, 0 /* spawntimesecs */, 0, 0, 20958, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+5 , 23435, 530, 3520, 3938, 1, 1, 1, -4056.84033203125, 1079.5728759765625, 32.50324630737304687, 5.567600250244140625, 0 /* spawntimesecs */, 0, 0, 19626, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2 (Auras: )
(@CGUID+6 , 23435, 530, 3520, 3938, 1, 1, 1, -4074.188720703125, 1076.3873291015625, 31.96249771118164062, 5.358160972595214843, 0 /* spawntimesecs */, 0, 0, 20958, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+7 , 23435, 530, 3520, 3938, 1, 1, 1, -4064.421875, 1074.611328125, 31.13295936584472656, 5.323254108428955078, 0 /* spawntimesecs */, 0, 0, 19626, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+8 , 23435, 530, 3520, 3938, 1, 1, 1, -4078.46435546875, 1065.28515625, 31.173919677734375, 5.358160972595214843, 0 /* spawntimesecs */, 0, 0, 20283, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2 (Auras: )
(@CGUID+9 , 23435, 530, 3520, 3938, 1, 1, 1, -4071.4462890625, 1070.081787109375, 30.65686798095703125, 5.358160972595214843, 0 /* spawntimesecs */, 0, 0, 19626, 0, 0, 0, 0, 0, 52237), -- 23435 (Area: 3938 - Difficulty: 0) CreateObject2
(@CGUID+10, 23440, 530, 3520, 3938, 1, 1, 1, -4063.1006, 963.11896, 61.477966, 1.549625277519226074, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+11, 23440, 530, 3520, 3938, 1, 1, 1, -4050.1597, 963.0414, 53.95147, 1.311231613159179687, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+12, 23440, 530, 3520, 3938, 1, 1, 1, -4020.2585, 970.38385, 60.901543, 0.900896310806274414, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+13, 23440, 530, 3520, 3938, 1, 1, 1, -3999.5762, 981.1174, 50.560707, 4.405356407165527343, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+14, 23440, 530, 3520, 3938, 1, 1, 1, -4038.3103, 965.81195, 56.55157, 1.584519624710083007, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+15, 23440, 530, 3520, 3938, 1, 1, 1, -4088.2646, 962.83264, 60.189224, 1.564426898956298828, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+16, 23440, 530, 3520, 3938, 1, 1, 1, -4114.435, 973.54456, 70.249596, 1.752815127372741699, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+17, 23440, 530, 3520, 3938, 1, 1, 1, -4074.8384, 962.56665, 54.436428, 1.432607769966125488, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237),
(@CGUID+18, 23440, 530, 3520, 3938, 1, 1, 1, -4100.3086, 965.0279, 64.35575, 1.525284409523010253, 0 /* spawntimesecs */, 0, 0, 0, 0, 0, 0, 0, 0, 52237);

-- DELETE FROM `waypoint_data` WHERE `id` = 234341;
-- INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`, `delay`) VALUES
-- (234341, 1, -4075.5479, 1081.4083, 33.318653, NULL, 1, 0),
-- (234341, 2, -4066.6372, 1067.3375, 30.281086, NULL, 1, 0),
-- (234341, 3, -4066.6372, 1067.3375, 30.281086, 2.234021425247192382, 0, 2400);

DELETE FROM `waypoints` WHERE `entry` = 2343400;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(2343400, 1, -4075.5479, 1081.4083, 33.318653, 'Commander Hobb'),
(2343400, 2, -4066.6372, 1067.3375, 30.281086, 'Commander Hobb');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23434);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23434, 0, 0, 'Defenders, show these mongrels the fury of a Scryer!', 14, 0, 100, 22, 0, 0, 21632, 0, 'Commander Hobb'),
(23434, 1, 0, 'Stand tall, soldiers. Show them no quarter!', 14, 0, 100, 1, 0, 0, 0, 0, 'Commander Hobb'),
(23434, 2, 0, 'Victory to the Scryers! The Dragonmaw have been defeated!', 14, 0, 100, 0, 0, 0, 21663, 0, 'Commander Hobb');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23434);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23434, 0, 0 , 0, 19, 0, 100, 512, 11097, 0, 0, 0, 0, 0, 80, 2343400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Quest \'The Deadliest Trap Ever Laid\' Taken - Run Script (Start Quest Event)'),
(23434, 0, 1 , 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Respawn - Set Npc Flags Questgiver'),
(23434, 0, 2 , 0, 0, 0, 100, 0, 1000, 1000, 2000, 2000, 0, 0, 11, 41440, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - In Combat - Cast \'Shoot\''),
(23434, 0, 3 , 0, 0, 0, 100, 0, 6000, 6000, 12000, 12000, 0, 0, 11, 38370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - In Combat - Cast \'Aimed Shot\''),
(23434, 0, 4 , 0, 0, 0, 100, 0, 8000, 8000, 15000, 15000, 0, 0, 11, 41448, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - In Combat - Cast \'Multi-Shot\''),
(23434, 0, 5 , 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Aggro - Call For Help'),
(23434, 0, 6 , 7, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2343401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Run Script (Fail Quest)'),
(23434, 0, 7 , 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23435, 0, 100, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Disable Quest Creatures'),
(23434, 0, 8 , 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23440, 0, 150, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Disable Quest Creatures'),
(23434, 0, 9 , 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 11097, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Fail Quest \'The Deadliest Trap Ever Laid\''),
(23434, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Despawn Self Instant (I\'m having issues with Home Pos and Evade)'),
(23434, 0, 11, 0, 77, 0, 100, 0, 1, 20, 0, 0, 0, 0, 80, 2343402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On 20 Enemies Killed - Run Script (Complete Quest)'),
(23434, 0, 12, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Respawn - Set Sheath Melee');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2343400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2343400, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Remove Npc Flags Questgiver'),
(2343400, 9, 1 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Reset Counter'),
(2343400, 9, 2 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Store Targetlist Party'),
(2343400, 9, 3 , 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 9, 23435, 0, 100, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Spawn In Sanctum Defenders'),
(2343400, 9, 4 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Say Line 0'),
-- (2343400, 9, 5 , 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 232, 234341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Start Path 234341'),
(2343400, 9, 5 , 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 53, 1, 2343400, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Start Path 234341'),
(2343400, 9, 6 , 0, 0, 0, 100, 0, 11400, 11400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Say Line 1'),
(2343400, 9, 7 , 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.340707302093506, 'Commander Hobb - Actionlist - Set Orientation'),
(2343400, 9, 8 , 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Set Sheath Ranged'),
(2343400, 9, 9 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 48, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Play Emote 48 (OneShotReadyBow)'),
(2343400, 9, 10, 0, 0, 0, 100, 0, 2100, 2100, 0, 0, 0, 0, 226, 2, 1, 1, 5, 5, 0, 9, 23440, 0, 150, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Start Spawning Dragonmaw Skybreakers'),
(2343400, 9, 11, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 23440, 150, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Say Line 0 (Dragonmaw Skybreaker)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2343402);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2343402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23435, 0, 100, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Disable Quest Creatures'),
(2343402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23440, 0, 150, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Disable Quest Creatures'),
(2343402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 11097, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Quest Credit \'The Deadliest Trap Ever Laid\''),
(2343402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Say Line 2'),
(2343402, 9, 4, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Reset Home Position'),
(2343402, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Evade'),
(2343402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Despawn Self Instant (I\'m having issues with Home Pos and Evade)');

UPDATE `creature_template_addon` SET `emote` = 376 WHERE (`entry` = 23435);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23435, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3500, 3500, 0, 0, 11, 41440, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sanctum Defender - In Combat - Cast Shoot'),
(23435, 0, 1, 0, 37, 0, 100, 257, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sanctum Defender - On Initialize - Disable Respawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23440);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23440, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3500, 3500, 0, 0, 11, 41440, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - In Combat - Cast Shoot'),
(23440, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 12000, 12000, 0, 0, 11, 38370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - In Combat - Cast Aimed Shot'),
(23440, 0, 2, 0, 0, 0, 100, 0, 8000, 8000, 15000, 15000, 0, 0, 11, 41448, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - In Combat - Cast Multi-Shot'),
(23440, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 1011, 23434, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Just Died - Add 1 to Commander Hobb Kill Counter'),
(23440, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Aggro - Say Line 1'),
(23440, 0, 5, 0, 37, 0, 100, 257, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Initialize - Disable Respawn');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23440);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23440, 0, 0, 'BURN IT DOWN!', 14, 0, 100, 0, 0, 0, 21656, 0, 'Dragonmaw Skybreaker'),
(23440, 0, 1, 'KILL THEM ALL!', 14, 0, 100, 0, 0, 0, 1690, 0, 'Dragonmaw Skybreaker'),
(23440, 1, 0, 'For the Dragonmaw!', 12, 0, 100, 0, 0, 0, 1937, 0, 'Dragonmaw Skybreaker'),
(23440, 1, 1, 'Long live the Dragonmaw! Die you worthless $N!', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker'),
(23440, 1, 2, 'Your bones will break under my boot, $N', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker');

/*
DELETE FROM `waypoint_data` WHERE `id` BETWEEN 234401 AND 234409;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- [1] Position: X: -4063.1006 Y: 963.11896 Z: 61.477966
-- [1] Orientation: 1.549625277519226074
-- (234401, 1, -4063.3423, 928.9622, 82.92392, NULL, 2),
(234401, 1,  -4063.14, 960.33984, 63.31019, NULL, 2),
(234401, 2,  -4062.9375, 991.71747, 43.696457, NULL, 2),
(234401, 3,  -4068.4714, 1033.1897, 43.69646, NULL, 2),
(234401, 4,  -4063.366, 1066.3694, 36.36312, NULL, 2),
(234401, 5,  -4063.366, 1066.3694, 36.36312, NULL, 2),

-- [2] Position: X: -4050.1597 Y: 963.0414 Z: 53.95147
-- [2] Orientation: 1.311231613159179687
-- (234402, 1, -4059.524, 924.002, 65.44735, NULL, 2),
(234402, 1, -4050.9375, 959.96356, 54.90167, NULL, 2),
(234402, 2, -4042.351, 995.9251, 44.355988, NULL, 2),
(234402, 3, -4043.5217, 1043.2762, 44.355988, NULL, 2),
(234402, 4, -4053.7783, 1066.186, 35.717106, NULL, 2),
(234402, 5, -4053.7783, 1066.186, 35.717106, NULL, 2),

-- [3] Position: X: -4020.2585 Y: 970.38385 Z: 60.901543
-- [3] Orientation: 0.900896310806274414
-- (234403, 1, -4037.4287, 946.79236, 83.177536, NULL, 2),
(234403, 1, -4021.8472, 968.2917, 63.01559, NULL, 2),
(234403, 2, -4006.2656, 989.791, 42.853645, NULL, 2),
(234403, 3, -3996.3499, 1025.583, 42.853645, NULL, 2),
(234403, 4, -4003.674, 1055.279, 42.853645, NULL, 2),
(234403, 5, -4028.947, 1082.6088, 42.853645, NULL, 2),
(234403, 6, -4045.464, 1078.8114, 39.575867, NULL, 2),
(234403, 7, -4045.464, 1078.8114, 39.575867, NULL, 2),

-- [4] Position: X: -3999.5762 Y: 981.1174 Z: 50.560707
-- [4] Orientation: 4.405356407165527343
-- (234404, 1, -3996.5837, 984.6102, 39.35212, NULL, 2),
(234404, 1, -3998.6301, 983.61804, 49.09008, NULL, 2),
(234404, 2, -3999.1016, 983.38947, 51.333473, NULL, 2),
(234404, 3, -3990.658, 1017.7838, 56.139027, NULL, 2),
(234404, 4, -4006.1025, 1049.133, 55.555695, NULL, 2),
(234404, 5, -4019.0344, 1080.7048, 35.305683, NULL, 2),
(234404, 6, -4053.2844, 1074.483, 33.611267, NULL, 2),
(234404, 7, -4053.2844, 1074.483, 33.611267, NULL, 2),

-- [5] Position: X: -4038.3103 Y: 965.81195 Z: 56.55157
-- [5] Orientation: 1.584519624710083007
-- (234405, 1, -4037.4302, 934.6457, 40.033707, NULL, 2),
(234405, 1, -4038.25, 962.934, 54.8684, NULL, 2),
(234405, 2, -4039.0698, 991.22235, 69.703094, NULL, 2),
(234405, 3, -4044.9453, 1026.4785, 51.564217, NULL, 2),
(234405, 4, -4046.6675, 1054.0055, 34.70309, NULL, 2),
(234405, 5, -4054.3298, 1074.1635, 32.84199, NULL, 2),
(234405, 6, -4054.3298, 1074.1635, 32.84199, NULL, 2),

-- [6] Position: X: -4088.2646 Y: 962.83264 Z: 60.189224
-- [6] Orientation: 1.564426898956298828
-- (234406, 1, -4088.8037, 925.66644, 67.038666, NULL, 2),
(234406, 1, -4088.2986, 959.6094, 60.73994, NULL, 2),
(234406, 2, -4087.7935, 993.5523, 54.441216, NULL, 2),
(234406, 3, -4083.7122, 1036.6643, 35.0801, NULL, 2),
(234406, 4, -4081.1072, 1055.6353, 31.913435, NULL, 2),
(234406, 5, -4081.1072, 1055.6353, 31.913435, NULL, 2),

-- [7] Position: X: -4114.435 Y: 973.54456 Z: 70.249596
-- [7] Orientation: 1.752815127372741699
-- (234407, 1, -4108.9116, 938.1812, 94.50812, NULL, 2),
(234407, 1, -4113.9756, 970.84375, 72.16011, NULL, 2),
(234407, 2, -4119.0396, 1003.5063, 49.8121, NULL, 2),
(234407, 3, -4113.9204, 1050.867, 36.728764, NULL, 2),
(234407, 4, -4099.3726, 1059.4963, 33.645435, NULL, 2),
(234407, 5, -4093.058, 1059.0251, 31.534332, NULL, 2),
(234407, 6, -4093.058, 1059.0251, 31.534332, NULL, 2),

-- [8] Position: X: -4074.8384 Y: 962.56665 Z: 54.436428
-- [8] Orientation: 1.432607769966125488
-- (234408, 1, -4079.2244, 931.53033, 76.49546, NULL, 2),
(234408, 1, -4075.2153, 959.8802, 56.398266, NULL, 2),
(234408, 2, -4071.2063, 988.23004, 36.30107, NULL, 2),
(234408, 3, -4066.255, 1017.4882, 29.634405, NULL, 2),
(234408, 4, -4060.89, 1066.7999, 31.106628, NULL, 2),
(234408, 5, -4060.89, 1066.7999, 31.106628, NULL, 2),

-- [9] Position: X: -4100.3086 Y: 965.0279 Z: 64.35575
-- [9] Orientation: 1.525284409523010253
-- (234409, 1, -4101.632, 942.9062, 58.775528, NULL, 2),
(234409, 1, -4100.46, 962.17706, 63.36372, NULL, 2),
(234409, 2, -4099.288, 981.44794, 67.95191, NULL, 2),
(234409, 3, -4094.4888, 1028.0123, 51.118576, NULL, 2),
(234409, 4, -4088.3276, 1055.0275, 41.36858, NULL, 2),
(234409, 5, -4088.3276, 1055.0275, 41.36858, NULL, 2);
*/

DELETE FROM `waypoints` WHERE `entry` BETWEEN 2344001 AND 2344009;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
-- [1] Position: X: -4063.1006 Y: 963.11896 Z: 61.477966
-- [1] Orientation: 1.549625277519226074
-- (234401, 1, -4063.3423, 928.9622, 82.92392, NULL, 2),
(2344001, 1,  -4063.14, 960.33984, 63.31019, 'Dragonmaw Skybreaker (Scryer) - Path 1'),
(2344001, 2,  -4062.9375, 991.71747, 43.696457, 'Dragonmaw Skybreaker (Scryer) - Path 1'),
(2344001, 3,  -4068.4714, 1033.1897, 43.69646, 'Dragonmaw Skybreaker (Scryer) - Path 1'),
(2344001, 4,  -4063.366, 1066.3694, 36.36312, 'Dragonmaw Skybreaker (Scryer) - Path 1'),
(2344001, 5,  -4063.366, 1066.3694, 36.36312, 'Dragonmaw Skybreaker (Scryer) - Path 1'),

-- [2] Position: X: -4050.1597 Y: 963.0414 Z: 53.95147
-- [2] Orientation: 1.311231613159179687
-- (234402, 1, -4059.524, 924.002, 65.44735, 'Dragonmaw Skybreaker (Scryer) - Path 2'),
(2344002, 1, -4050.9375, 959.96356, 54.90167, 'Dragonmaw Skybreaker (Scryer) - Path 2'),
(2344002, 2, -4042.351, 995.9251, 44.355988, 'Dragonmaw Skybreaker (Scryer) - Path 2'),
(2344002, 3, -4043.5217, 1043.2762, 44.355988, 'Dragonmaw Skybreaker (Scryer) - Path 2'),
(2344002, 4, -4053.7783, 1066.186, 35.717106, 'Dragonmaw Skybreaker (Scryer) - Path 2'),
(2344002, 5, -4053.7783, 1066.186, 35.717106, 'Dragonmaw Skybreaker (Scryer) - Path 2'),

-- [3] Position: X: -4020.2585 Y: 970.38385 Z: 60.901543
-- [3] Orientation: 0.900896310806274414
-- (234403, 1, -4037.4287, 946.79236, 83.177536, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 1, -4021.8472, 968.2917, 63.01559, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 2, -4006.2656, 989.791, 42.853645, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 3, -3996.3499, 1025.583, 42.853645, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 4, -4003.674, 1055.279, 42.853645, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 5, -4028.947, 1082.6088, 42.853645, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 6, -4045.464, 1078.8114, 39.575867, 'Dragonmaw Skybreaker (Scryer) - Path 3'),
(2344003, 7, -4045.464, 1078.8114, 39.575867, 'Dragonmaw Skybreaker (Scryer) - Path 3'),

-- [4] Position: X: -3999.5762 Y: 981.1174 Z: 50.560707
-- [4] Orientation: 4.405356407165527343
-- (234404, 1, -3996.5837, 984.6102, 39.35212, NULL, 2),
(2344004, 1, -3998.6301, 983.61804, 49.09008, 'Dragonmaw Skybreaker (Scryer) - Path 4'),
(2344004, 2, -3999.1016, 983.38947, 51.333473, 'Dragonmaw Skybreaker (Scryer) - Path 4'),
(2344004, 3, -3990.658, 1017.7838, 56.139027, 'Dragonmaw Skybreaker (Scryer) - Path 4'),
(2344004, 4, -4006.1025, 1049.133, 55.555695, 'Dragonmaw Skybreaker (Scryer) - Path 4'),
(2344004, 5, -4019.0344, 1080.7048, 35.305683, 'Dragonmaw Skybreaker (Scryer) - Path 4'),
(2344004, 6, -4053.2844, 1074.483, 33.611267, 'Dragonmaw Skybreaker (Scryer) - Path 4'),
(2344004, 7, -4053.2844, 1074.483, 33.611267, 'Dragonmaw Skybreaker (Scryer) - Path 4'),

-- [5] Position: X: -4038.3103 Y: 965.81195 Z: 56.55157
-- [5] Orientation: 1.584519624710083007
-- (234405, 1, -4037.4302, 934.6457, 40.033707, NULL, 2),
(2344005, 1, -4038.25, 962.934, 54.8684, 'Dragonmaw Skybreaker (Scryer) - Path 5'),
(2344005, 2, -4039.0698, 991.22235, 69.703094, 'Dragonmaw Skybreaker (Scryer) - Path 5'),
(2344005, 3, -4044.9453, 1026.4785, 51.564217, 'Dragonmaw Skybreaker (Scryer) - Path 5'),
(2344005, 4, -4046.6675, 1054.0055, 34.70309, 'Dragonmaw Skybreaker (Scryer) - Path 5'),
(2344005, 5, -4054.3298, 1074.1635, 32.84199, 'Dragonmaw Skybreaker (Scryer) - Path 5'),
(2344005, 6, -4054.3298, 1074.1635, 32.84199, 'Dragonmaw Skybreaker (Scryer) - Path 5'),

-- [6] Position: X: -4088.2646 Y: 962.83264 Z: 60.189224
-- [6] Orientation: 1.564426898956298828
-- (234406, 1, -4088.8037, 925.66644, 67.038666, NULL, 2),
(2344006, 1, -4088.2986, 959.6094, 60.73994, 'Dragonmaw Skybreaker (Scryer) - Path 6'),
(2344006, 2, -4087.7935, 993.5523, 54.441216, 'Dragonmaw Skybreaker (Scryer) - Path 6'),
(2344006, 3, -4083.7122, 1036.6643, 35.0801, 'Dragonmaw Skybreaker (Scryer) - Path 6'),
(2344006, 4, -4081.1072, 1055.6353, 31.913435, 'Dragonmaw Skybreaker (Scryer) - Path 6'),
(2344006, 5, -4081.1072, 1055.6353, 31.913435, 'Dragonmaw Skybreaker (Scryer) - Path 6'),

-- [7] Position: X: -4114.435 Y: 973.54456 Z: 70.249596
-- [7] Orientation: 1.752815127372741699
-- (234407, 1, -4108.9116, 938.1812, 94.50812, NULL, 2),
(2344007, 1, -4113.9756, 970.84375, 72.16011, 'Dragonmaw Skybreaker (Scryer) - Path 7'),
(2344007, 2, -4119.0396, 1003.5063, 49.8121, 'Dragonmaw Skybreaker (Scryer) - Path 7'),
(2344007, 3, -4113.9204, 1050.867, 36.728764, 'Dragonmaw Skybreaker (Scryer) - Path 7'),
(2344007, 4, -4099.3726, 1059.4963, 33.645435, 'Dragonmaw Skybreaker (Scryer) - Path 7'),
(2344007, 5, -4093.058, 1059.0251, 31.534332, 'Dragonmaw Skybreaker (Scryer) - Path 7'),
(2344007, 6, -4093.058, 1059.0251, 31.534332, 'Dragonmaw Skybreaker (Scryer) - Path 7'),

-- [8] Position: X: -4074.8384 Y: 962.56665 Z: 54.436428
-- [8] Orientation: 1.432607769966125488
-- (234408, 1, -4079.2244, 931.53033, 76.49546, NULL, 2),
(2344008, 1, -4075.2153, 959.8802, 56.398266, 'Dragonmaw Skybreaker (Scryer) - Path 8'),
(2344008, 2, -4071.2063, 988.23004, 36.30107, 'Dragonmaw Skybreaker (Scryer) - Path 8'),
(2344008, 3, -4066.255, 1017.4882, 29.634405, 'Dragonmaw Skybreaker (Scryer) - Path 8'),
(2344008, 4, -4060.89, 1066.7999, 31.106628, 'Dragonmaw Skybreaker (Scryer) - Path 8'),
(2344008, 5, -4060.89, 1066.7999, 31.106628, 'Dragonmaw Skybreaker (Scryer) - Path 8'),

-- [9] Position: X: -4100.3086 Y: 965.0279 Z: 64.35575
-- [9] Orientation: 1.525284409523010253
-- (234409, 1, -4101.632, 942.9062, 58.775528, NULL, 2),
(2344009, 1, -4100.46, 962.17706, 63.36372, 'Dragonmaw Skybreaker (Scryer) - Path 9'),
(2344009, 2, -4099.288, 981.44794, 67.95191, 'Dragonmaw Skybreaker (Scryer) - Path 9'),
(2344009, 3, -4094.4888, 1028.0123, 51.118576, 'Dragonmaw Skybreaker (Scryer) - Path 9'),
(2344009, 4, -4088.3276, 1055.0275, 41.36858, 'Dragonmaw Skybreaker (Scryer) - Path 9'),
(2344009, 5, -4088.3276, 1055.0275, 41.36858, 'Dragonmaw Skybreaker (Scryer) - Path 9');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 23440);

/*
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-(@CGUID+10),-(@CGUID+11),-(@CGUID+12),-(@CGUID+13),-(@CGUID+14),-(@CGUID+15),-(@CGUID+16),-(@CGUID+17),-(@CGUID+18))) AND (`source_type` = 0) AND (`id` IN (1000));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+10), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234401'),
(-(@CGUID+11), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234402'),
(-(@CGUID+12), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234403'),
(-(@CGUID+13), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234404'),
(-(@CGUID+14), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234405'),
(-(@CGUID+15), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234406'),
(-(@CGUID+16), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234407'),
(-(@CGUID+17), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234408, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234408'),
(-(@CGUID+18), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234409, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234409');
*/

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-(@CGUID+10),-(@CGUID+11),-(@CGUID+12),-(@CGUID+13),-(@CGUID+14),-(@CGUID+15),-(@CGUID+16),-(@CGUID+17),-(@CGUID+18))) AND (`source_type` = 0) AND (`id` IN (1000));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+10), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344001, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234401'),
(-(@CGUID+11), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344002, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234402'),
(-(@CGUID+12), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344003, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234403'),
(-(@CGUID+13), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344004, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234404'),
(-(@CGUID+14), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344005, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234405'),
(-(@CGUID+15), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344006, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234406'),
(-(@CGUID+16), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344007, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234407'),
(-(@CGUID+17), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344008, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234408'),
(-(@CGUID+18), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 2344009, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234409');
