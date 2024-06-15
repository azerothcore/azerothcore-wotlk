-- DB update 2023_02_16_02 -> 2023_02_16_03
-- Delete all previous spawns
DELETE FROM `creature` WHERE `id1`=21815;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 76347 AND 76376;
DELETE FROM `waypoint_data` WHERE `id` BETWEEN 763470 AND 763760;

-- Update Template
UPDATE `creature_template_addon` SET `bytes1` = 0, `bytes2` = 0, `auras` = '37509 37497' WHERE (`entry` = 21815);

SET @GUID := 76347;

DELETE FROM `creature` WHERE `id1`=21815 AND `guid` BETWEEN @GUID+0 AND @GUID+29;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(@GUID+0 , 21815, 530, 3520, 0, -3887.04, 713.771, 8.29782, 1.82762, 300, 10, 1, 48069),
(@GUID+1 , 21815, 530, 3520, 0, -3849.29, 694.933, 5.71439, 3.87034, 300, 10, 1, 48069),
(@GUID+2 , 21815, 530, 3520, 0, -3854.41, 698.188, 6.53198, 0.306488, 300, 10, 1, 48069),
(@GUID+3 , 21815, 530, 3520, 0, -3766.98, 700.139, 8.31596, 4.407, 300, 10, 1, 48069),
(@GUID+4 , 21815, 530, 3520, 0, -3750.56, 716.819, 8.73649, 4.53786, 300, 0, 0, 48069),
(@GUID+5 , 21815, 530, 3520, 0, -3744.44, 676.38, 6.24564, 2.32439, 300, 10, 1, 48069),
(@GUID+6 , 21815, 530, 3520, 0, -3733.26, 733.125, 8.4431, 4.72984, 300, 0, 0, 48069),
(@GUID+7 , 21815, 530, 3520, 0, -3717.39, 716.184, 5.91291, 4.31096, 300, 0, 0, 48069),
(@GUID+8 , 21815, 530, 3520, 0, -3716.77, 684.095, 2.97334, 4.59022, 300, 0, 0, 48069),
(@GUID+9 , 21815, 530, 3520, 0, -3714.98, 702.358, 4.65603, 3.05748, 300, 10, 1, 48069),
(@GUID+10, 21815, 530, 3520, 0, -3710.93, 745.914, 4.09289, 2.98865, 300, 10, 1, 48069),
(@GUID+11, 21815, 530, 3520, 0, -3682.72, 715.336, 1.83526, 4.5204, 300, 0, 0, 48069),
(@GUID+12, 21815, 530, 3520, 0, -3690.71, 636.486, 2.23195, 0.83101, 300, 10, 1, 48069),
(@GUID+13, 21815, 530, 3520, 0, -3699.59, 733.226, 2.86307, 4.59022, 300, 0, 0, 48069),
(@GUID+14, 21815, 530, 3520, 0, -3707.96, 745.452, 3.56198, 2.98575, 300, 10, 1, 48069),
(@GUID+15, 21815, 530, 3520, 0, -3682.75, 684.471, 4.11465, 4.67748, 300, 0, 0, 48069),
(@GUID+16, 21815, 530, 3520, 0, -3658.89, 678.813, 2.39562, 4.08407, 300, 0, 0, 48069),
(@GUID+17, 21815, 530, 3520, 0, -3649.91, 715.165, -0.439142, 4.81711, 300, 0, 0, 48069),
(@GUID+18, 21815, 530, 3520, 0, -3633.06, 688.628, -0.872612, 4.60767, 300, 0, 0, 48069),
(@GUID+19, 21815, 530, 3520, 0, -3618.23, 712.812, -5.62207, 4.55531, 300, 0, 0, 48069),
(@GUID+20, 21815, 530, 3520, 0, -3449.61, 651.914, 5.48536, 4.41568, 300, 0, 0, 48069),
(@GUID+21, 21815, 530, 3520, 0, -3448.87, 681.795, 1.83994, 4.39823, 300, 0, 0, 48069),
(@GUID+22, 21815, 530, 3520, 0, -3417.83, 683.332, 3.42784, 4.5204, 300, 0, 0, 48069),
(@GUID+23, 21815, 530, 3520, 0, -3417.53, 655.185, 8.10019, 4.45059, 300, 0, 0, 48069),
(@GUID+24, 21815, 530, 3520, 0, -3389.03, 685.481, 4.64398, 4.55531, 300, 0, 0, 48069),
(@GUID+25, 21815, 530, 3520, 0, -3381.63, 690.305, 2.30061, 0.896055, 300, 10, 1, 48069),
(@GUID+26, 21815, 530, 3520, 0, -3368.94, 689.885, 0.267471, 4.19106, 300, 10, 1, 48069),
(@GUID+27, 21815, 530, 3520, 0, -3352.51, 653.728, 8.90633, 4.55531, 300, 0, 0, 48069),
(@GUID+28, 21815, 530, 3520, 0, -3311.53, 681.949, 3.57055, 4.50295, 300, 0, 0, 48069),
(@GUID+29, 21815, 530, 3520, 0, -3298.01, 737.507, -12.9353, 4.28148, 300, 10, 1, 48069);

-- Delete Useless SAI (obsoleted by auras field
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21815) AND (`source_type` = 0);

-- Stationary GUIDs do random emotes (these don't have any other SAI)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-(@GUID+4 ),-(@GUID+6 ),-(@GUID+7 ),-(@GUID+8 ),-(@GUID+11),-(@GUID+13),-(@GUID+15),-(@GUID+17),-(@GUID+18),-(@GUID+19),-(@GUID+20),-(@GUID+21),-(@GUID+22),-(@GUID+23),-(@GUID+24),-(@GUID+27),-(@GUID+28)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@GUID+4 ), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+6 ), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+7 ), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+8 ), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+11), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+13), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+15), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+17), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+18), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+19), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+20), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+21), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+22), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+23), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+24), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+27), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)'),
(-(@GUID+28), 0, 0, 0, 1, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 10, 18, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cleric of Karabor - Out of Combat - Play Random Emote (18, 20)');

-- The Cleric near the Meeting Stone has an EmoteState
DELETE FROM `creature_addon` WHERE `guid`=@GUID+16;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@GUID+16,0,0,0,0,69,0, '37509 37497');

-- Pathing
SET @NPC := @GUID+0;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3869.5764,`position_y`=759.3223,`position_z`=10.068203 WHERE `guid`=@GUID+0;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-3869.5764,`position_y`=759.3223,`position_z`=10.068203 WHERE `guid`=@GUID+1;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1 ,-3869.5764,759.3223,10.068203,NULL,0,0,0,100,0),
(@PATH,2 ,-3834.4094,750.589,11.009603,NULL,0,0,0,100,0),
(@PATH,3 ,-3800.625,749.4453,10.881915,NULL,0,0,0,100,0),
(@PATH,4 ,-3770.5815,746.9241,8.975661,NULL,0,0,0,100,0),
(@PATH,5 ,-3739.184,750.26605,7.625188,NULL,0,0,0,100,0),
(@PATH,6 ,-3705.9006,745.1378,3.2208452,NULL,0,0,0,100,0),
(@PATH,7 ,-3675.9314,737.9171,-0.3524542,NULL,0,0,0,100,0),
(@PATH,8 ,-3651.636,731.10114,-3.2281065,NULL,0,0,0,100,0),
(@PATH,9 ,-3634.649,725.6624,-5.1051817,NULL,0,0,0,100,0),
(@PATH,10,-3613.014,734.74524,-9.089146,NULL,0,0,0,100,0),
(@PATH,11,-3578.7466,738.03754,-11.877126,NULL,0,0,0,100,0),
(@PATH,12,-3613.014,734.74524,-9.089146,NULL,0,0,0,100,0),
(@PATH,13,-3634.649,725.6624,-5.1051817,NULL,0,0,0,100,0),
(@PATH,14,-3651.636,731.10114,-3.2281065,NULL,0,0,0,100,0),
(@PATH,15,-3675.9314,737.9171,-0.3524542,NULL,0,0,0,100,0),
(@PATH,16,-3705.9006,745.1378,3.2208452,NULL,0,0,0,100,0),
(@PATH,17,-3739.184,750.26605,7.625188,NULL,0,0,0,100,0),
(@PATH,18,-3770.5815,746.9241,8.975661,NULL,0,0,0,100,0),
(@PATH,19,-3800.625,749.4453,10.881915,NULL,0,0,0,100,0),
(@PATH,20,-3834.4094,750.589,11.009603,NULL,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (@GUID+0, @GUID+1);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@GUID+0, @GUID+0, 0, 0, 3),
(@GUID+0, @GUID+1, 4, 180, 515);

SET @NPC := @GUID+2;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3747.236,`position_y`=696.5975,`position_z`=6.5840187 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3747.236,696.5975,6.5840187,NULL,0,0,0,100,0),
(@PATH,2,-3730.9023,698.65857,3.9634356,NULL,0,0,0,100,0),
(@PATH,3,-3722.947,690.0796,3.4161944,NULL,0,0,0,100,0),
(@PATH,4,-3729.0647,673.63995,4.2409015,NULL,0,0,0,100,0),
(@PATH,5,-3740.9297,672.6357,5.4780617,NULL,0,0,0,100,0),
(@PATH,6,-3751.7456,684.16174,7.1030617,NULL,0,0,0,100,0);

SET @NPC := @GUID+3;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3760.0994,`position_y`=701.21185,`position_z`=8.138514 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3760.0994,701.21185,8.138514,NULL,0,0,0,100,0),
(@PATH,2,-3735.13,704.054,5.157435,NULL,0,0,0,100,0),
(@PATH,3,-3704.3057,701.4581,3.496435,NULL,0,0,0,100,0),
(@PATH,4,-3682.0999,701.26227,3.1714263,NULL,0,0,0,100,0),
(@PATH,5,-3651.9983,700.2391,0.22538471,NULL,0,0,0,100,0),
(@PATH,6,-3618.2942,698.29016,-4.0110435,NULL,0,0,0,100,0);

SET @NPC := @GUID+5;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3254.29,`position_y`=698.9422,`position_z`=-0.21338493 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3254.29,698.9422,-0.21338493,NULL,0,0,0,100,0),
(@PATH,2,-3269.0117,731.6173,-9.155927,NULL,0,0,0,100,0),
(@PATH,3,-3286.4524,743.7444,-13.61463,NULL,0,0,0,100,0),
(@PATH,4,-3296.0322,741.8055,-14.152838,NULL,0,0,0,100,0),
(@PATH,5,-3303.5566,725.4404,-9.488642,NULL,0,0,0,100,0),
(@PATH,6,-3298.8667,703.29083,-2.2325869,NULL,0,0,0,100,0),
(@PATH,7,-3281.4404,695.50433,-0.15322602,NULL,0,0,0,100,0),
(@PATH,8,-3270.842,697.1268,-0.31582367,NULL,0,0,0,100,0);

SET @NPC := @GUID+9;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3880.9531,`position_y`=743.5303,`position_z`=10.1663475 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3880.9531,743.5303,10.1663475,NULL,0,0,0,100,0),
(@PATH,2,-3861.636,742.01324,11.263143,NULL,0,0,0,100,0),
(@PATH,3,-3856.0808,731.877,12.064431,NULL,0,0,0,100,0),
(@PATH,4,-3855.645,711.5427,9.751931,NULL,0,0,0,100,0),
(@PATH,5,-3871.3838,700.5008,7.004488,NULL,0,0,0,100,0),
(@PATH,6,-3885.0618,706.26013,7.678072,NULL,0,0,0,100,0),
(@PATH,7,-3890.3376,726.3714,8.703218,NULL,0,0,0,100,0);

SET @NPC := @GUID+10;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3785.0684,`position_y`=683.5791,`position_z`=5.889006 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3785.0684,683.5791,5.889006,NULL,0,0,0,100,0),
(@PATH,2,-3803.7048,690.65753,6.0817604,NULL,0,0,0,100,0),
(@PATH,3,-3811.6797,707.48224,9.257961,NULL,0,0,0,100,0),
(@PATH,4,-3804.8096,734.0828,13.369342,NULL,0,0,0,100,0),
(@PATH,5,-3786.9722,736.4728,12.661452,NULL,0,0,0,100,0),
(@PATH,6,-3770.7656,734.17395,11.812331,NULL,0,0,0,100,0),
(@PATH,7,-3766.2847,718.8295,9.656214,NULL,0,0,0,100,0),
(@PATH,8,-3765.27,705.5667,8.656458,NULL,0,0,0,100,0),
(@PATH,9,-3770.7708,688.1346,7.402678,NULL,0,0,0,100,0);

SET @NPC := @GUID+12;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3843.1797,`position_y`=672.1553,`position_z`=3.1999207 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3843.1797,672.1553,3.1999207,NULL,0,0,0,100,0),
(@PATH,2,-3822.7634,678.561,3.681614,NULL,0,0,0,100,0),
(@PATH,3,-3820.191,690.44226,5.6217995,NULL,0,0,0,100,0),
(@PATH,4,-3825.3499,700.38947,7.2865257,NULL,0,0,0,100,0),
(@PATH,5,-3839.6736,703.5138,7.699929,NULL,0,0,0,100,0),
(@PATH,6,-3852.221,692.3139,5.230194,NULL,0,0,0,100,0);

SET @NPC := @GUID+14;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3681.981,`position_y`=672.6074,`position_z`=2.5414386 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3681.981,672.6074,2.5414386,NULL,0,0,0,100,0),
(@PATH,2,-3697.5095,679.7098,1.6525227,NULL,0,0,0,100,0),
(@PATH,3,-3716.136,662.59656,1.9161946,NULL,0,0,0,100,0),
(@PATH,4,-3695.6536,631.07117,2.1196935,NULL,0,0,0,100,0),
(@PATH,5,-3675.394,653.26544,1.074654,NULL,0,0,0,100,0);

SET @NPC := @GUID+25;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3361.677,`position_y`=663.71295,`position_z`=7.0698924 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3361.677,663.71295,7.0698924,NULL,0,0,0,100,0),
(@PATH,2,-3340.6047,658.2445,7.2334666,NULL,0,0,0,100,0),
(@PATH,3,-3330.0156,661.8594,7.659556,NULL,0,0,0,100,0),
(@PATH,4,-3324.579,681.2995,3.2608604,NULL,0,0,0,100,0),
(@PATH,5,-3334.5027,695.6724,-2.6810365,NULL,0,0,0,100,0),
(@PATH,6,-3352.145,705.7665,-7.396452,NULL,0,0,0,100,0),
(@PATH,7,-3363.9849,698.51746,-4.011969,NULL,0,0,0,100,0),
(@PATH,8,-3372.8135,683.12305,3.467493,NULL,0,0,0,100,0);

SET @NPC := @GUID+26;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3353.7112,`position_y`=738.6812,`position_z`=-21.589752 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3353.7112,738.6812,-21.589752,NULL,0,0,0,100,0),
(@PATH,2,-3368.1436,707.1668,-7.8815174,NULL,0,0,0,100,0),
(@PATH,3,-3390.9631,678.6413,6.280115,NULL,0,0,0,100,0),
(@PATH,4,-3424.6484,666.9002,5.771608,NULL,0,0,0,100,0),
(@PATH,5,-3450.5193,667.2751,3.0163298,NULL,0,0,0,100,0),
(@PATH,6,-3482.091,679.81305,0.5905714,NULL,0,0,0,100,0),
(@PATH,7,-3450.5193,667.2751,3.0163298,NULL,0,0,0,100,0),
(@PATH,8,-3424.6484,666.9002,5.771608,NULL,0,0,0,100,0),
(@PATH,9,-3390.9631,678.6413,6.280115,NULL,0,0,0,100,0),
(@PATH,10,-3368.1436,707.1668,-7.8815174,NULL,0,0,0,100,0);

SET @NPC := @GUID+29;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-3857.2578,`position_y`=670.34406,`position_z`=3.6999207 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,0,0,0, '37509 37497');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3857.2578,670.34406,3.6999207,NULL,0,0,0,100,0),
(@PATH,2,-3876.7979,679.27246,3.8857965,NULL,0,0,0,100,0),
(@PATH,3,-3876.2832,691.2627,5.2607965,NULL,0,0,0,100,0),
(@PATH,4,-3854.0938,698.28723,6.538788,NULL,0,0,0,100,0),
(@PATH,5,-3848.75,681.0957,3.6999207,NULL,0,0,0,100,0);
