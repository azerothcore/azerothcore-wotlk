-- DB update 2024_08_28_02 -> 2024_08_28_03
-- Scryers
SET @CGUID := 12556;

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

DELETE FROM `waypoint_data` WHERE `id` = 234341;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`, `delay`) VALUES
(234341, 1, -4075.5479, 1081.4083, 33.318653, NULL, 1, 0),
(234341, 2, -4066.6372, 1067.3375, 30.281086, NULL, 1, 0),
(234341, 3, -4066.6372, 1067.3375, 30.281086, 2.234021425247192382, 0, 2400);

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
(2343400, 9, 5 , 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 232, 234341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - Actionlist - Start Path 234341'),
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
(2343402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Hobb - On Just Died - Despawn Self Instant');

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
(23440, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Aggro - Say Line 1'),
(23440, 0, 5, 0, 37, 0, 100, 257, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Initialize - Disable Respawn');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23440);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23440, 0, 0, 'BURN IT DOWN!', 14, 0, 100, 0, 0, 0, 21656, 0, 'Dragonmaw Skybreaker'),
(23440, 0, 1, 'KILL THEM ALL!', 14, 0, 100, 0, 0, 0, 1690, 0, 'Dragonmaw Skybreaker'),
(23440, 1, 0, 'For the Dragonmaw!', 12, 0, 100, 0, 0, 0, 1937, 0, 'Dragonmaw Skybreaker'),
(23440, 1, 1, 'Long live the Dragonmaw! Die you worthless $N!', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker'),
(23440, 1, 2, 'Your bones will break under my boot, $N', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker');

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

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 23440);

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

-- Aldor
DELETE FROM `creature_text` WHERE (`CreatureID` = 23441);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23441, 0, 0, 'BURN IT DOWN!', 14, 0, 100, 0, 0, 0, 21656, 0, 'Dragonmaw Skybreaker'),
(23441, 0, 1, 'KILL THEM ALL!', 14, 0, 100, 0, 0, 0, 1690, 0, 'Dragonmaw Skybreaker'),
(23441, 1, 0, 'For the Dragonmaw!', 12, 0, 100, 0, 0, 0, 1937, 0, 'Dragonmaw Skybreaker'),
(23441, 1, 1, 'Long live the Dragonmaw! Die you worthless $N!', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker'),
(23441, 1, 2, 'Your bones will break under my boot, $N', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23452);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23452, 0, 0, 'The Dragonmaw must be stopped...', 14, 0, 100, 22, 0, 0, 21685, 0, 'Commander Arcus to Player'),
(23452, 1, 0, 'Stand tall, soldiers. Show them no quarter!', 12, 0, 100, 5, 0, 0, 21633, 0, 'Commander Arcus to Player'),
(23452, 2, 0, 'Victory to the Aldor! The Dragonmaw have been defeated!', 14, 0, 100, 0, 0, 0, 21728, 0, 'Commander Arcus to Commander Arcus');

SET @CGUID := 12720;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+18 AND `id1` IN (23453, 23441);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+0, 23453, 530, 3520, 3754, 1, -3083.6, 687.388, -17.0363, 3.08923, 0, 55639, 2, NULL),
(@CGUID+1, 23453, 530, 3520, 3754, 1, -3085.62, 692.253, -17.6563, 3.08923, 0, 55639, 2, NULL),
(@CGUID+2, 23453, 530, 3520, 3754, 1, -3088.42, 684.481, -17.5697, 3.14159, 0, 55639, 2, NULL),
(@CGUID+3, 23453, 530, 3520, 3754, 1, -3086.17, 680.568, -15.9425, 2.98451, 0, 55639, 2, NULL),
(@CGUID+4, 23453, 530, 3520, 3754, 1, -3096.63, 667.763, -13.7902, 2.77507, 0, 55639, 2, NULL),
(@CGUID+5, 23453, 530, 3520, 3754, 1, -3093.32, 673.408, -15.203, 2.87979, 0, 55639, 2, NULL),
(@CGUID+6, 23453, 530, 3520, 3754, 1, -3091.12, 678.402, -16.3597, 3.03687, 0, 55639, 2, NULL),
(@CGUID+7, 23453, 530, 3520, 3754, 1, -3094.99, 662.722, -12.762, 2.58309, 0, 55639, 2, NULL),
(@CGUID+8, 23453, 530, 3520, 3754, 1, -3091.11, 668.166, -14.1371, 2.74017, 0, 55639, 2, NULL),
(@CGUID+9, 23453, 530, 3520, 3754, 1, -3088.57, 674.317, -14.8953, 2.75762, 0, 55639, 2, NULL),

(@CGUID+10, 23441, 530, 3520, 3754, 1, -3259.4226, 708.5354, 38.91116, 6.233379364013671875, 0, 55639, 2, NULL),
(@CGUID+11, 23441, 530, 3520, 3754, 1, -3006.4463, 564.1875, 48.472195, 2.211099624633789062, 0, 55639, 2, NULL),
(@CGUID+12, 23441, 530, 3520, 3754, 1, -3247.2795, 681.7934, 46.758705, 6.047158718109130859, 0, 55639, 2, NULL),
(@CGUID+13, 23441, 530, 3520, 3754, 1, -3271.6199, 722.7448, 48.811226, 6.087714672088623046, 0, 55639, 2, NULL),
(@CGUID+14, 23441, 530, 3520, 3754, 1, -3030.6301, 557.1302, 34.245502, 2.113452434539794921, 0, 55639, 2, NULL),
(@CGUID+15, 23441, 530, 3520, 3754, 1, -3268.5156, 750.7678, 33.435238, 5.964546680450439453, 0, 55639, 2, NULL),
(@CGUID+16, 23441, 530, 3520, 3754, 1, -3268.2517, 731.8698, 32.24829, 6.274892807006835937, 0, 55639, 2, NULL),
(@CGUID+17, 23441, 530, 3520, 3754, 1, -2987.5417, 575.9792, 58.821465, 2.240255117416381835, 0, 55639, 2, NULL),
(@CGUID+18, 23441, 530, 3520, 3754, 1, -3260.4463, 692.08856, 43.37934, 6.01873016357421875, 0, 55639, 2, NULL);

DELETE FROM `waypoint_data` WHERE `id` = 234521;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`) VALUES
(234521, 1, -3043.0544, 759.7127, -10.093901, NULL, 0, 1),
(234521, 2, -3048.7854, 739.1032, -9.660838, NULL, 0, 1),
(234521, 3, -3047.9675, 718.32794, -10.502778, NULL, 0, 1),
(234521, 4, -3060.013, 682.91296, -13.024189, NULL, 0, 1),
(234521, 5, -3080.6594, 675.9093, -13.976298, NULL, 0, 1),
(234521, 6, -3096.214, 680.7059, -17.963423, NULL, 4200, 1),
(234521, 7, -3096.214, 680.7059, -17.963423, 5.969026088714599609, 4800, 0),
(234521, 8, -3096.214, 680.7059, -17.963423, 2.94960641860961914, 0, 0);

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 23441);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-(@CGUID+10),-(@CGUID+11),-(@CGUID+12),-(@CGUID+13),-(@CGUID+14),-(@CGUID+15),-(@CGUID+16),-(@CGUID+17),-(@CGUID+18))) AND (`source_type` = 0) AND (`id` IN (1000));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+10), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234411, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234411'),
(-(@CGUID+11), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234412, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234412'),
(-(@CGUID+12), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234413, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234413'),
(-(@CGUID+13), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234414, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234414'),
(-(@CGUID+14), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234415, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234415'),
(-(@CGUID+15), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234416, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234416'),
(-(@CGUID+16), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234417, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234417'),
(-(@CGUID+17), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234418, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234418'),
(-(@CGUID+18), 0, 1000, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 234419, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Respawn - Start Path 234419');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23441);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23441, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3500, 3500, 0, 0, 11, 41440, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - In Combat - Cast Shoot'),
(23441, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 12000, 12000, 0, 0, 11, 38370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - In Combat - Cast Aimed Shot'),
(23441, 0, 2, 0, 0, 0, 100, 0, 8000, 8000, 15000, 15000, 0, 0, 11, 41448, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - In Combat - Cast Multi-Shot'),
(23441, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 10, 13564, 23452, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Just Died - Add 1 to Commander Arcus Kill Counter'),
(23441, 0, 4, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Aggro - Say Line 1'),
(23441, 0, 5, 0, 37, 0, 100, 257, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonmaw Skybreaker - On Initialize - Disable Respawn');

UPDATE `creature_template_addon` SET `emote` = 376 WHERE (`entry` = 23453);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23453);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23453, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 3500, 3500, 0, 0, 11, 41440, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Altar Defender - In Combat - Cast Shoot'),
(23453, 0, 1, 0, 37, 0, 100, 257, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Altar Defender - On Initialize - Disable Respawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23452);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23452, 0, 0 , 0, 19, 0, 100, 512, 11101, 0, 0, 0, 0, 0, 80, 2345200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Quest \'The Deadliest Trap Ever Laid\' Taken - Run Script (Start Quest Event)'),
(23452, 0, 1 , 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Respawn - Set Npc Flags Questgiver'),
(23452, 0, 2 , 0, 0, 0, 100, 0, 1000, 1000, 2000, 2000, 0, 0, 11, 41440, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - In Combat - Cast \'Shoot\''),
(23452, 0, 3 , 0, 0, 0, 100, 0, 6000, 6000, 12000, 12000, 0, 0, 11, 38370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - In Combat - Cast \'Aimed Shot\''),
(23452, 0, 4 , 0, 0, 0, 100, 0, 8000, 8000, 15000, 15000, 0, 0, 11, 41448, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - In Combat - Cast \'Multi-Shot\''),
(23452, 0, 5 , 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Aggro - Call For Help'),
(23452, 0, 6 , 7, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2345201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Just Died - Run Script (Fail Quest)'),
(23452, 0, 7 , 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23453, 0, 100, 0, 0, 0, 0, 0, 'Commander Arcus - On Just Died - Disable Quest Creatures'),
(23452, 0, 8 , 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23441, 0, 200, 0, 0, 0, 0, 0, 'Commander Arcus - On Just Died - Disable Quest Creatures'),
(23452, 0, 9 , 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 11101, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Just Died - Fail Quest \'The Deadliest Trap Ever Laid\''),
(23452, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Just Died - Despawn Self Instant'),
(23452, 0, 11, 0, 77, 0, 100, 0, 1, 20, 0, 0, 0, 0, 80, 2345202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On 20 Enemies Killed - Run Script (Complete Quest)'),
(23452, 0, 12, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Respawn - Set Sheath Melee'),
(23452, 0, 13, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Respawn - Set Emote State 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2345200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2345200, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Remove Npc Flags Questgiver'),
(2345200, 9, 1 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Reset Counter'),
(2345200, 9, 2 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Store Targetlist Party'),
(2345200, 9, 3 , 0, 0, 0, 100, 0, 2900, 2900, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Say Line 0'),
(2345200, 9, 4 , 0, 0, 0, 100, 0, 3100, 3100, 0, 0, 0, 0, 232, 234521, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Start Path 234521'),
(2345200, 9, 5 , 0, 0, 0, 100, 0, 26000, 26000, 0, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 9, 23453, 0, 100, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Spawn In Altar Defenders'),
(2345200, 9, 6 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Say Line 1'),
(2345200, 9, 7 , 0, 0, 0, 100, 0, 3100, 3100, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Set Sheath Ranged'),
(2345200, 9, 8 , 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 17, 214, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Set EmoteState 214'),
(2345200, 9, 9 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 2, 1, 1, 5, 5, 0, 9, 23441, 0, 200, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Start Spawning Dragonmaw Skybreakers'),
(2345200, 9, 10, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 23441, 200, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Say Line 0 (Dragonmaw Skybreaker)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2345202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2345202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23453, 0, 100, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Disable Quest Creatures'),
(2345202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 9, 23441, 0, 200, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Disable Quest Creatures'),
(2345202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 26, 11101, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Quest Credit \'The Deadliest Trap Ever Laid\''),
(2345202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Say Line 2'),
(2345202, 9, 4, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Reset Home Position'),
(2345202, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - Actionlist - Evade'),
(2345202, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Commander Arcus - On Just Died - Despawn Self Instant');

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 234411 AND 234419;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- [0] Position: X: -3259.4226, 708.5354, 38.91116
-- [0] Orientation: 6.233379364013671875
(234411, 1, -3242.5364, 707.69366, 52.700848, NULL, 2),
(234411, 2, -3219.2295, 703.29517, 52.700848, NULL, 2),
(234411, 3, -3185.632, 695.4233, 37.25641, NULL, 2),
(234411, 4, -3147.6853, 685.7768, 19.589731, NULL, 2),
(234411, 5, -3107.8901, 674.2289, 6.561962, NULL, 2),
-- [1] Position: X: -3006.4463, 564.1875, 48.472195
-- [1] Orientation: 2.211099624633789062
(234412, 1, -3006.4463, 564.1875, 48.472195, NULL, 2),
(234412, 2, -3020.0957, 582.5085, 26.582497, NULL, 2),
(234412, 3, -3037.433, 610.57153, 8.026941, NULL, 2),
(234412, 4, -3054.981, 636.631, 1.888052, NULL, 2),
(234412, 5, -3081.3538, 670.811, -6.723061, NULL, 2),
-- [2] Position: X: -3247.2795, 681.7934, 46.758705
-- [2] Orientation: 6.047158718109130859
(234413, 1, -3247.2795, 681.7934, 46.758705, NULL, 2),
(234413, 2, -3224.905, 676.4121, 60.397457, NULL, 2),
(234413, 3, -3197.4385, 662.9752, 60.397453, NULL, 2),
(234413, 4, -3175.9648, 654.6516, 60.397453, NULL, 2),
(234413, 5, -3159.4307, 646.17004, 60.397453, NULL, 2),
(234413, 6, -3121.3748, 624.6077, 37.00856, NULL, 2),
(234413, 7, -3101.5295, 653.33734, 2.008561, NULL, 2),
-- [3] Position: X: -3271.6199, 722.7448, 48.811226
-- [3] Orientation: 6.087714672088623046
(234414, 1, -3271.6199, 722.7448, 48.811226, NULL, 2),
(234414, 2, -3255.2827, 719.5101, 46.016747, NULL, 2),
(234414, 3, -3222.5205, 717.1377, 45.511993, NULL, 2),
(234414, 4, -3198.0264, 711.52374, 35.567757, NULL, 2),
(234414, 5, -3167.2495, 706.08527, 16.984415, NULL, 2),
(234414, 6, -3126.632, 691.3753, -8.571138, NULL, 2),
(234414, 7, -3099.939, 682.7796, -15.793356, NULL, 2),
-- [4] Position: X: -3030.6301, 557.1302, 34.245502
-- [4] Orientation: 2.113452434539794921
(234415, 1, -3030.6301, 557.1302, 34.245502, NULL, 2),
(234415, 2, -3044.279, 579.7635, 47.477497, NULL, 2),
(234415, 3, -3056.1836, 615.40344, 25.783052, NULL, 2),
(234415, 4, -3071.745, 646.99536, 5.366384, NULL, 2),
(234415, 5, -3085.0522, 661.14874, -9.10583, NULL, 2),
(234415, 6, -3085.0522, 661.14874, -9.10583, NULL, 2),
-- [5] Position: X: -3268.5156, 750.7678, 33.435238
-- [5] Orientation: 5.964546680450439453
(234416, 1 , -3268.5156, 750.7678, 33.435238, NULL, 2),
(234416, 2 , -3243.4297, 742.4925, 22.651155, NULL, 2),
(234416, 3 , -3213.966, 746.05066, 22.651155, NULL, 2),
(234416, 4 , -3189.9797, 744.0554, 26.484491, NULL, 2),
(234416, 5 , -3150.6821, 757.67755, 29.956709, NULL, 2),
(234416, 6 , -3120.7246, 761.84796, 35.484493, NULL, 2),
(234416, 7 , -3104.629, 754.38446, 29.567825, NULL, 2),
(234416, 8 , -3082.1396, 720.24805, 3.762264, NULL, 2),
(234416, 9 , -3085.2312, 701.88586, -12.293289, NULL, 2),
(234416, 10, -3089.7302, 692.963, -16.515514, NULL, 2),
-- [6] Position: X: -3268.2517, 731.8698, 32.24829
-- [6] Orientation: 6.274892807006835937
(234417, 1, -3268.2517, 731.8698, 32.24829, NULL, 2),
(234417, 2, -3249.601, 731.71515, 36.61551, NULL, 2),
(234417, 3, -3226.119, 729.245, 36.61551, NULL, 2),
(234417, 4, -3200.4783, 728.32074, 36.61551, NULL, 2),
(234417, 5, -3154.492, 724.6342, 28.42106, NULL, 2),
(234417, 6, -3122.896, 709.35486, 13.365505, NULL, 2),
(234417, 7, -3108.9421, 698.5323, 0.143284, NULL, 2),
-- [7] Position: X: -2987.5417, 575.9792, 58.821465
-- [7] Orientation: 2.240255117416381835
(234418, 1, -2987.5417, 575.9792, 58.821465, NULL, 2),
(234418, 2, -3021.1553, 618.4541, 25.290438, NULL, 2),
(234418, 3, -3036.0618, 656.704, 4.762658, NULL, 2),
(234418, 4, -3075.4192, 678.96826, -13.154009, NULL, 2),
(234418, 5, -3083.369, 683.91406, -15.12623, NULL, 2),
-- [8] Position: X: -3260.4463, 692.08856, 43.37934
-- [8] Orientation: 6.01873016357421875
(234419, 1, -3260.4463, 692.08856, 43.37934, NULL, 2),
(234419, 2, -3243.889, 687.60486, 51.14147, NULL, 2),
(234419, 3, -3202.3489, 669.66095, 51.14147, NULL, 2),
(234419, 4, -3183.1746, 660.77405, 51.14147, NULL, 2),
(234419, 5, -3155.9106, 659.907, 33.113697, NULL, 2),
(234419, 6, -3132.411, 658.95215, 3.419254, NULL, 2),
(234419, 7, -3111.927, 665.25214, -7.941859, NULL, 2),
(234419, 8, -3101.4766, 664.6626, -10.552968, NULL, 2);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 23441);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(23441, 1, 0, 1, 0, 0, 0, 0);

-- Converting the older systems
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (10, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Generic - Actionlist - Set Visibility Off'),
(10, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Generic - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(11, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Generic - Actionlist - Set Visibility On'),
(11, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Generic - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s');

UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151291 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151290 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151289 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151288 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151287 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151286 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151285 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151284 AND `source_type`=0 AND `id`=1000;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151034 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151033 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151032 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151031 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151030 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151029 AND `source_type`=0 AND `id`=1006;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151028 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151027 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151026 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151025 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151023 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151022 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151021 AND `source_type`=0 AND `id`=1001;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=10 WHERE `entryorguid`=-151020 AND `source_type`=0 AND `id`=1001;

UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151291 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151290 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151289 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151288 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151287 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151286 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151285 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151284 AND `source_type`=0 AND `id`=1001 AND `link`=1002;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151034 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151033 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151032 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151031 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151030 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151029 AND `source_type`=0 AND `id`=1008 AND `link`=1009;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151028 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151027 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151026 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151025 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151023 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151022 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151021 AND `source_type`=0 AND `id`=1002 AND `link`=1003;
UPDATE `smart_scripts` SET `action_type`=80, `action_param1`=11 WHERE `entryorguid`=-151020 AND `source_type`=0 AND `id`=1002 AND `link`=1003;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -151019);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-151019, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Reset - Set Event Phase 1 (Allow Add to Spawn)'),
(-151019, 0, 1002, 0, 82, 0, 100, 0, 17083, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Summoned Add Dies - Set Event Phase 1 (Allow Add to Spawn)'),
(-151019, 0, 1003, 1004, 38, 1, 100, 0, 1, 1, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 - Say Line 6 (Phase 1)'),
(-151019, 0, 1004, 1005, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 12, 17083, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 89.4649, 187.334, -13.1455, 3.39256, 'Shattered Hand Legionnaire - On Data Set 1 1 - Summon Creature \'Fel Orc Convert\' (Phase 1)'),
(-151019, 0, 1005, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 - Set Event Phase 2 (Do Not Allow Adds to Spawn)'),
(-151019, 0, 1006, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Respawn - Disable'),
(-151019, 0, 1007, 1008, 77, 0, 100, 0, 1, 2, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Counter 2/2 - Enable'),
(-151019, 0, 1008, 1009, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Counter 2/2 - Enable'),
(-151019, 0, 1009, 1010, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 3, 1, 0, 0, 0, 0, 9, 0, 0, 60, 1, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Set Data 3 1 to Start Group 1 Spawn'),
(-151019, 0, 1010, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1670011, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Run Script'),
(-151019, 0, 1011, 0, 58, 0, 100, 0, 0, 1670002, 0, 0, 0, 0, 80, 1670013, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Waypoint Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -151024);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-151024, 0, 1001, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Reset - Set Event Phase 1 (Allow Add to Spawn)'),
(-151024, 0, 1002, 0, 82, 0, 100, 0, 17083, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Summoned Add Dies - Set Event Phase 1 (Allow Add to Spawn)'),
(-151024, 0, 1003, 1004, 38, 1, 100, 0, 1, 1, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 - Say Line 9 (Phase 1)'),
(-151024, 0, 1004, 1005, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 12, 17083, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 79.7924, 218.84, -13.1506, 3.98455, 'Shattered Hand Legionnaire - On Data Set 1 1 - Summon Creature \'Fel Orc Convert\' (Phase 1)'),
(-151024, 0, 1005, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 1 1 - Set Event Phase 2 (Do Not Allow Adds to Spawn)'),
(-151024, 0, 1006, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Respawn - Disable'),
(-151024, 0, 1007, 1008, 38, 0, 100, 0, 3, 2, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 3 2 - Enable'),
(-151024, 0, 1008, 1009, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 3 2 - Enable'),
(-151024, 0, 1009, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1670012, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Run Script'),
(-151024, 0, 1010, 0, 40, 0, 100, 0, 4, 1670004, 0, 0, 0, 0, 80, 1670014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Waypoint Finished - Run Script');
