INSERT INTO version_db_world (`sql_rev`) VALUES ('1488798687580958500');
DELETE FROM `creature_addon` WHERE `guid` IN (107122, 107123, 107124, 107130, 107029);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(107122, 0, 0, 0, 1, 0, '50503'), -- 28025 - 50503 - 50503
(107123, 0, 0, 0, 1, 0, '50503'), -- 28025 - 50503 - 50503
(107124, 0, 0, 0, 1, 0, '50503'), -- 28025 - 50503 - 50503
(107130, 0, 0, 0, 1, 0, '50503 52102'), -- 28025 - 50503 - 50503
(107029, 0, 0, 0, 1, 0, '50917'); -- 28024 - 50917 - 50917


DELETE FROM `creature_formations` WHERE `leaderGUID`= 118178;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(118178,118178,0,0,2,0,0),
(118178,118180,2,290,2,0,0);

DELETE FROM `creature_formations` WHERE `leaderGUID`= 118181;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(118181,118181,0,0,2,0,0),
(118181,118179,2,70,2,0,0);

UPDATE `creature` SET `spawndist` = 0 , `MovementType` = 0 WHERE `guid` IN (107029, 107130); 
UPDATE `creature` SET `position_x` = 5674.187 , `position_y` = 4603.267 , `position_z` = -137.191 WHERE `guid` = 107029; 


-- Pathing for Rainspeaker Oracle Entry: 28025 'TDB FORMAT' 
SET @NPC := 107124;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=5650.549,`position_y`=4581.872,`position_z`=-137.3909 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5650.549,4581.872,-137.3909,0,0,0,0,100,0), -- 21:03:30
(@PATH,2,5672.96,4587.905,-134.6465,0,0,0,0,100,0), -- 21:03:39
(@PATH,3,5698.817,4588.952,-125.194,0,0,0,0,100,0), -- 21:03:49
(@PATH,4,5705.767,4581.825,-119.9322,6.200202,5000,0,0,100,0), -- 21:04:00
(@PATH,5,5695.923,4590.621,-126.2863,0,0,0,0,100,0), -- 21:03:49
(@PATH,6,5678.215,4589.218,-133.0249,0,0,0,0,100,0), -- 21:04:13
(@PATH,7,5658.794,4585.683,-136.1378,0,0,0,0,100,0), -- 21:04:27
(@PATH,8,5625.052,4573.458,-137.703,3.624144,55000,0,0,100,0), -- 21:04:35
(@PATH,9,5650.549,4581.872,-137.3909,0,0,0,0,100,0); -- 21:05:34


-- Pathing for Gorloc Hatchling Entry: 28140 'TDB FORMAT' 
SET @NPC := 118181;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=5637.416,`position_y`=4595.454,`position_z`=-137.2239 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5637.416,4595.454,-137.2239,0,0,1,0,100,0), -- 21:02:43
(@PATH,2,5642.184,4611.476,-134.7247,0,0,1,0,100,0), -- 21:02:46
(@PATH,3,5655.648,4612.583,-133.3453,0,0,1,0,100,0), -- 21:02:48
(@PATH,4,5658.208,4603.957,-134.7711,0,0,1,0,100,0), -- 21:02:50
(@PATH,5,5668.683,4583.652,-135.4119,0,0,1,0,100,0), -- 21:02:52
(@PATH,6,5670.186,4581.974,-136.0505,0.4537856,10000,1,0,100,0), -- 21:02:56
(@PATH,7,5682.068,4580.444,-134.4037,0,0,1,0,100,0), -- 21:03:05
(@PATH,8,5698.051,4567.978,-129.0662,0,0,1,0,100,0), -- 21:03:06
(@PATH,9,5680.886,4564.793,-133.685,0,3000,1,0,100,0), -- 21:03:08
(@PATH,10,5655.097,4576.272,-136.5881,0,0,1,0,100,0), -- 21:03:20
(@PATH,11,5641.471,4576.043,-137.6747,0,0,1,0,100,0), -- 21:03:23
(@PATH,12,5638.296,4570.477,-137.1636,0,0,1,0,100,0), -- 21:03:24
(@PATH,13,5645.734,4563.63,-134.6706,0,0,1,0,100,0), -- 21:03:25
(@PATH,14,5646.459,4563.039,-134.6787,0,10000,1,0,100,0), -- 21:03:26
(@PATH,15,5645.932,4575.221,-137.0915,0,0,1,0,100,0), -- 21:03:37
(@PATH,16,5637.424,4595.413,-137.2054,0,0,1,0,100,0); -- 21:03:40


-- Pathing for Gorloc Hatchling Entry: 28140 'TDB FORMAT' 
SET @NPC := 118178;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=5629.266,`position_y`=4611.305,`position_z`=-136.869 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,5629.266,4611.305,-136.869,0,0,1,0,100,0), -- 21:02:45
(@PATH,2,5627.232,4618.4,-135.7587,0,0,1,0,100,0), -- 21:02:46
(@PATH,3,5607.584,4623.498,-136.7098,0,7000,1,0,100,0), -- 21:02:48
(@PATH,4,5583.438,4620.037,-136.7961,0,0,1,0,100,0), -- 21:03:02
(@PATH,5,5567.276,4620.011,-136.7031,0,0,1,0,100,0), -- 21:03:04
(@PATH,6,5551.069,4606.722,-132.1287,0,0,1,0,100,0), -- 21:03:05
(@PATH,7,5550.813,4596.588,-131.6744,0,0,1,0,100,0), -- 21:03:08
(@PATH,8,5582.382,4591.426,-137.7399,0,0,1,0,100,0), -- 21:03:10
(@PATH,9,5557.418,4592.301,-133.0564,0,0,1,0,100,0), -- 21:03:14
(@PATH,10,5555.726,4575.782,-135.4762,0,0,1,0,100,0), -- 21:03:17
(@PATH,11,5565.243,4559.398,-136.6539,0,0,1,0,100,0), -- 21:03:21
(@PATH,12,5593.586,4553.95,-135.5951,0,0,1,0,100,0), -- 21:03:24
(@PATH,13,5601.106,4560.068,-132.6202,0,0,1,0,100,0), -- 21:03:26
(@PATH,14,5602.62,4561.788,-132.6895,2.391101,15000,1,0,100,0), -- 21:03:29
(@PATH,15,5581.576,4572.833,-138.8004,0,0,1,0,100,0), -- 21:03:50
(@PATH,16,5585.17,4575.303,-139.9812,0,0,1,0,100,0), -- 21:03:53
(@PATH,17,5598.924,4583.062,-140.2092,0,0,1,0,100,0), -- 21:03:55
(@PATH,18,5615.134,4599.039,-139.1217,0,0,1,0,100,0), -- 21:03:58
(@PATH,19,5625.804,4600.934,-136.86,0,0,1,0,100,0), -- 21:04:01
(@PATH,20,5628.201,4600.755,-136.8774,4.959375,10000,1,0,100,0), -- 21:04:03
(@PATH,21,5629.266,4611.305,-136.869,0,0,1,0,100,0); -- 21:02:45

-- Gorloc Hatchling SAI
SET @GUID := -118178;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=28140;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,0,34,0,100,0,2,13,0,0,17,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 13 - Set Emote State 1"),
(@GUID,0,1,0,34,0,100,0,2,2,0,0,17,173,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 2 - Set Emote State 173"),
(@GUID,0,2,3,34,0,100,0,2,19,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 19 - Play Emote 25"),
(@GUID,0,3,0,61,0,100,0,2,19,0,0,17,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 19 - Set Emote State 1");

-- Gorloc Hatchling SAI
SET @GUID := -118181;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=28140;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,1,34,0,100,0,2,5,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 5 - Play Emote 25"),
(@GUID,0,1,0,61,0,100,0,2,5,0,0,17,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 5 - Set Emote State 1"),
(@GUID,0,2,0,34,0,100,0,2,13,0,0,17,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gorloc Hatchling - On Reached Point 13 - Set Emote State 1");

-- Rainspeaker Oracle SAI
SET @ENTRY := 28025;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,0,6000,8000,11,15305,64,0,0,0,0,2,0,0,0,0,0,0,0,"Rainspeaker Oracle - Combat CMC - Cast 'Chain Lightning'"),
(@ENTRY,0,1,0,0,0,100,0,3000,6000,12000,15000,11,54919,1,0,0,0,0,5,0,0,0,0,0,0,0,"Rainspeaker Oracle - Combat - Cast 'Warped Armor'"),
(@ENTRY,0,2,0,25,0,100,0,0,0,0,0,11,50503,0,0,0,0,0,1,0,0,0,0,0,0,0,"Rainspeaker Oracle - On Reset - Cast 'Rainspeaker Oracle State'");

-- Rainspeaker Warrior SAI
SET @GUID := -107029;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=28024;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,0,0,0,100,0,3000,7000,5000,8000,11,50533,0,0,0,0,0,2,0,0,0,0,0,0,0,"Rainspeaker Warrior - In Combat - Cast 'Flip Attack'"),
(@GUID,0,1,0,4,0,100,0,0,0,0,0,28,50917,0,0,0,0,0,1,0,0,0,0,0,0,0,"Rainspeaker Warrior - On Aggro - Remove Aura 'Sleeping Sleep'");

-- Rainspeaker Oracle SAI
SET @GUID := -107130;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=28025;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,0,0,0,100,0,0,0,6000,8000,11,15305,64,0,0,0,0,2,0,0,0,0,0,0,0,"Rainspeaker Oracle - Combat CMC - Cast 'Chain Lightning'"),
(@GUID,0,1,0,0,0,100,0,3000,6000,12000,15000,11,54919,1,0,0,0,0,5,0,0,0,0,0,0,0,"Rainspeaker Oracle - Combat - Cast 'Warped Armor'"),
(@GUID,0,2,0,25,0,100,0,0,0,0,0,11,50503,0,0,0,0,0,1,0,0,0,0,0,0,0,"Rainspeaker Oracle - On Reset - Cast 'Rainspeaker Oracle State'"),
(@GUID,0,3,0,4,0,100,0,0,0,0,0,28,52102,0,0,0,0,0,1,0,0,0,0,0,0,0,"Rainspeaker Oracle - On Aggro - Remove Aura 'Gorloc Sleep'");



