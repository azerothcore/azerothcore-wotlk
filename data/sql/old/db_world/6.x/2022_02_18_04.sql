-- DB update 2022_02_18_03 -> 2022_02_18_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_18_03 2022_02_18_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645220638173840730'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645220638173840730');

-- Telaar Fixup #1

-- Pathing for Telaari Elekk Rider Entry: 19071
SET @NPC := 68372;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2543.5664,`position_y`=7140.118,`position_z`=17.027489 WHERE `guid`=@NPC;
UPDATE `creature` SET `MovementType`=0,`position_x`=-2543.5664,`position_y`=7140.118,`position_z`=17.027489 WHERE `guid`=68373;
UPDATE `creature_addon` SET `path_id`=0 WHERE `guid`=68373;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,18511,0,0,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
DELETE FROM `waypoint_data` WHERE `id`=683730;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2543.5664,7140.118,17.027489,0,0,0,0,100,0),
(@PATH,2,-2545.7668,7145.167,16.650003,0,0,0,0,100,0),
(@PATH,3,-2561.6326,7179.9717,7.71917,0,0,0,0,100,0),
(@PATH,4,-2574.56,7206.497,13.13416,0,0,0,0,100,0),
(@PATH,5,-2578.63,7216.7466,17.175762,0,0,0,0,100,0),
(@PATH,6,-2579.734,7219.723,17.378357,0,0,0,0,100,0),
(@PATH,7,-2584.8442,7236.9707,13.430054,0,0,0,0,100,0),
(@PATH,8,-2571.252,7257.952,14.334106,0,0,0,0,100,0),
(@PATH,9,-2555.8198,7267.29,14.953473,0,0,0,0,100,0),
(@PATH,10,-2550.231,7280.9204,14.668561,0,0,0,0,100,0),
(@PATH,11,-2555.5933,7292.204,14.18736,0,0,0,0,100,0),
(@PATH,12,-2563.0608,7307.2534,13.76042,0,0,0,0,100,0),
(@PATH,13,-2583.1125,7320.264,13.823907,0,0,0,0,100,0),
(@PATH,14,-2596.285,7330.887,18.361626,0,0,0,0,100,0),
(@PATH,15,-2606.457,7337.029,22.91198,0,0,0,0,100,0),
(@PATH,16,-2618.7043,7329.77,24.373463,0,0,0,0,100,0),
(@PATH,17,-2618.7393,7326.0103,24.123264,0,0,0,0,100,0),
(@PATH,18,-2619.8486,7303.307,20.955067,0,0,0,0,100,0),
(@PATH,19,-2629.0073,7284.644,21.596992,0,0,0,0,100,0),
(@PATH,20,-2652.5286,7279.9536,29.818726,0,0,0,0,100,0),
(@PATH,21,-2676.237,7283.7603,37.25228,0,0,0,0,100,0),
(@PATH,22,-2677.4722,7282.761,37.45241,0,0,0,0,100,0),
(@PATH,23,-2657.694,7280.192,31.442505,0,0,0,0,100,0),
(@PATH,24,-2657.389,7231.8315,22.644266,0,0,0,0,100,0),
(@PATH,25,-2648.8577,7219.885,21.312723,0,0,0,0,100,0),
(@PATH,26,-2626.5977,7221.264,19.35439,0,0,0,0,100,0),
(@PATH,27,-2623.3584,7222.705,18.654215,0,0,0,0,100,0),
(@PATH,28,-2603.1829,7231.564,13.910997,0,0,0,0,100,0),
(@PATH,29,-2599.2817,7233.337,13.180054,0,0,0,0,100,0),
(@PATH,30,-2585.7334,7236.3096,13.430054,0,0,0,0,100,0),
(@PATH,31,-2580.3098,7219.4844,17.418884,0,0,0,0,100,0),
(@PATH,32,-2562.048,7179.9766,7.716011,0,0,0,0,100,0),
(@PATH,33,-2545.698,7145.381,16.604149,0,0,0,0,100,0),
(@PATH,34,-2543.4644,7139.901,17.027489,0,0,0,0,100,0),
(@PATH,35,-2535.9849,7119.2524,10.245167,0,0,0,0,100,0),
(@PATH,36,-2532.908,7120.2734,9.192595,0,0,0,0,100,0);
-- Formation
DELETE FROM `creature_formations` WHERE `leaderGUID`=68372;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(68372,68373,9,180,514,0,0),
(68372,68372,0,0,2,0,0);

-- Pathing for Huntress Kima Entry: 18416
SET @NPC := 65808;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2552.3865,`position_y`=7337.846,`position_z`=7.3699293 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2552.3865,7337.846,7.3699293,0,0,0,0,100,0),
(@PATH,2,-2547.3914,7352.3525,7.0471754,0,0,0,0,100,0),
(@PATH,3,-2544.8416,7358.259,7.0471754,0,0,0,0,100,0),
(@PATH,4,-2562.0989,7370.443,10.193512,0,0,0,0,100,0),
(@PATH,5,-2567.5786,7369.3716,10.297231,0,0,0,0,100,0),
(@PATH,6,-2566.1743,7349.837,9.922175,0,0,0,0,100,0),
(@PATH,7,-2567.7886,7341.593,9.872525,0,0,0,0,100,0),
(@PATH,8,-2577.9949,7329.614,12.472589,0,0,0,0,100,0),
(@PATH,9,-2585.8938,7320.886,13.898736,0,0,0,0,100,0),
(@PATH,10,-2605.1047,7337.934,22.773064,0,0,0,0,100,0),
(@PATH,11,-2611.916,7335.989,23.810905,0,0,0,0,100,0),
(@PATH,12,-2616.9458,7333.1978,24.087208,0,0,0,0,100,0),
(@PATH,13,-2619.6611,7324.955,24.100931,0,0,0,0,100,0),
(@PATH,14,-2619.6294,7304.2964,21.160732,0,0,0,0,100,0),
(@PATH,15,-2620.565,7298.807,20.79023,0,0,0,0,100,0),
(@PATH,16,-2626.4062,7292.671,21.252632,0,0,0,0,100,0),
(@PATH,17,-2628.7712,7286.888,21.809639,0,0,0,0,100,0),
(@PATH,18,-2630.9937,7283.8604,21.854439,0,0,0,0,100,0),
(@PATH,19,-2651.2737,7280.1436,29.366821,0,0,0,0,100,0),
(@PATH,20,-2671.1506,7282.2266,35.967514,0,0,0,0,100,0),
(@PATH,21,-2671.386,7282.8613,36.024155,0,0,0,0,100,0),
(@PATH,22,-2661.9692,7281.936,32.842163,0,0,0,0,100,0),
(@PATH,23,-2658.1257,7276.939,31.341309,0,0,0,0,100,0),
(@PATH,24,-2656.3474,7260.406,27.906845,0,0,0,0,100,0),
(@PATH,25,-2656.909,7234.9165,23.100449,0,0,0,0,100,0),
(@PATH,26,-2654.6003,7223.4907,21.670877,0,0,0,0,100,0),
(@PATH,27,-2649.2122,7219.171,21.312723,0,0,0,0,100,0),
(@PATH,28,-2639.123,7217.4824,21.187723,0,0,0,0,100,0),
(@PATH,29,-2623.3154,7222.3584,18.688942,0,0,0,0,100,0),
(@PATH,30,-2604.5999,7231.4604,14.26196,0,0,0,0,100,0),
(@PATH,31,-2598.9917,7233.284,13.1935425,0,0,0,0,100,0),
(@PATH,32,-2589.095,7238.978,13.305054,0,0,0,0,100,0),
(@PATH,33,-2572.7046,7258.1973,14.189087,0,0,0,0,100,0),
(@PATH,34,-2563.3296,7262.915,14.683092,0,0,0,0,100,0),
(@PATH,35,-2551.0857,7272.119,14.828473,0,0,0,0,100,0),
(@PATH,36,-2551.5376,7282.8057,14.5792055,0,0,0,0,100,0),
(@PATH,37,-2551.4038,7291.638,13.93443,0,0,0,0,100,0),
(@PATH,38,-2543.581,7297.7734,11.825421,0,0,0,0,100,0),
(@PATH,39,-2523.9182,7301.837,7.011393,0,0,0,0,100,0),
(@PATH,40,-2511.7822,7307.3257,3.181559,0,0,0,0,100,0),
(@PATH,41,-2499.1921,7314.907,-4.6651077,0,0,0,0,100,0),
(@PATH,42,-2487.7703,7329.173,-13.408516,0,0,0,0,100,0),
(@PATH,43,-2498.5537,7315.363,-5.00605,0,0,0,0,100,0),
(@PATH,44,-2512.1306,7307.3994,3.247477,0,0,0,0,100,0),
(@PATH,45,-2522.9253,7308.137,6.075236,0,0,0,0,100,0),
(@PATH,46,-2531.038,7316.987,6.8986,0,0,0,0,100,0),
(@PATH,47,-2547.3105,7326.7563,7.0104194,0,0,0,0,100,0);

-- Pathing for Telaari Watcher Entry: 18488
SET @NPC := 66629;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2566.7363,`position_y`=7378.6606,`position_z`=11.52477 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-2566.6487,`position_y`=7373.6,`position_z`=10.994327 WHERE `guid`=66631;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid` IN (66631);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
DELETE FROM `waypoint_data` WHERE `id` IN (666310);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2566.7363,7378.6606,11.52477,0,0,0,0,100,0),
(@PATH,2,-2566.851,7382.4126,11.011333,0,0,0,0,100,0),
(@PATH,3,-2569.9622,7418.315,1.5761018,0,0,0,0,100,0),
(@PATH,4,-2572.8147,7445.869,4.3503313,0,0,0,0,100,0),
(@PATH,5,-2573.675,7460.541,10.163662,0,0,0,0,100,0),
(@PATH,6,-2573.9563,7464.9175,11.243015,0,0,0,0,100,0),
(@PATH,7,-2573.675,7460.541,10.163662,0,0,0,0,100,0),
(@PATH,8,-2572.8147,7445.869,4.3503313,0,0,0,0,100,0),
(@PATH,9,-2569.9622,7418.315,1.5761018,0,0,0,0,100,0),
(@PATH,10,-2566.851,7382.4126,11.011333,0,0,0,0,100,0);
-- Formation
DELETE FROM `creature_formations` WHERE `leaderGUID`=66629;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(66629,66631,4,180,514,0,0),
(66629,66629,0,0,2,0,0);

-- Pathing for Telaari Watcher Entry: 18488
SET @NPC := 66639;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2480.6487,`position_y`=7336.6,`position_z`=-17.784327 WHERE `guid`=@NPC;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-2483.6487,`position_y`=7334.6,`position_z`=-16.994327 WHERE `guid`=66640;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2480.6487,7336.6,-17.784327,0,0,0,0,100,0),
(@PATH,2,-2448.015,7352.907,-28.189636,0,0,0,0,100,0),
(@PATH,3,-2405.7273,7372.271,-32.12887,0,0,0,0,100,0),
(@PATH,4,-2372.3142,7384.0435,-31.575289,0,0,0,0,100,0),
(@PATH,5,-2347.1301,7393.9634,-29.781559,0,0,0,0,100,0),
(@PATH,6,-2324.5203,7403.6953,-25.300947,0,0,0,0,100,0),
(@PATH,7,-2300.847,7414.8394,-16.90953,0,0,0,0,100,0),
(@PATH,8,-2292.4114,7415.5146,-16.560312,0,0,0,0,100,0),
(@PATH,9,-2300.847,7414.8394,-16.90953,0,0,0,0,100,0),
(@PATH,10,-2324.5203,7403.6953,-25.300947,0,0,0,0,100,0),
(@PATH,11,-2347.1301,7393.9634,-29.781559,0,0,0,0,100,0),
(@PATH,12,-2372.3142,7384.0435,-31.575289,0,0,0,0,100,0),
(@PATH,13,-2405.7273,7372.271,-32.12887,0,0,0,0,100,0),
(@PATH,14,-2448.015,7352.907,-28.189636,0,0,0,0,100,0);
-- Formation
DELETE FROM `creature_formations` WHERE `leaderGUID`=66639;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(66639,66640,4,180,514,0,0),
(66639,66639,0,0,2,0,0);

-- Pathing for Captured Halaani Blood Knight Entry: 19151
SET @NPC := 68488;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-2699.1077,`position_y`=7191.807,`position_z`=26.096796 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-2699.1077,7191.807,26.096796,0,1000,0,0,100,0),
(@PATH,2,-2702.3586,7186.784,26.096796,0,1000,0,0,100,0);

DELETE FROM `creature` WHERE `guid`=86753;
DELETE FROM `creature_addon` WHERE `guid`=86753;
UPDATE `creature` SET `equipment_id`=-1 WHERE `id1`=18488;
UPDATE `creature` SET `equipment_id`=0 WHERE `guid` IN (66612,66613);
UPDATE `creature_model_info` SET `DisplayID_Other_Gender`=18514 WHERE `DisplayID` IN (18513);

DELETE FROM `creature_equip_template` WHERE `CreatureID`=18488 AND `ID` IN (2,3,4);
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`) VALUES
(18488,2,27850,27850,0,0),
(18488,3,27850,27851,0,0),
(18488,4,27852,0,0,0);

-- Telaari Jailor SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=19156;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19156) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19156,0,0,0,11,0,100,0,0,0,0,0,0,3,0,18571,0,0,0,0,1,0,0,0,0,0,0,0,0,'Telaari Jailor - On Respawn - Set Model');

-- Interrogator Khan <Hand of Argus> SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=19152;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19152) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19152,0,0,0,11,0,100,0,0,0,0,0,0,3,0,18561,0,0,0,0,1,0,0,0,0,0,0,0,0,'Interrogator Khan - On Respawn - Set Model');

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (19152,15241);
INSERT INTO `creature_template_movement` (`CreatureId`,`Ground`,`Swim`,`Flight`,`Rooted`,`Chase`,`Random`,`InteractionPauseTimer`) VALUES
(19152,1,0,1,1,0,0,NULL),(15241,1,0,1,1,0,0,NULL);

DELETE FROM `creature` WHERE `guid` IN (86753);
INSERT INTO `creature` (`guid`,`id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(86753,18488,530,0,0,1,1,-1,-2506.048,7235.3228,16.321045,5.427973747253417968,300,0,0,1,0,0,0,0,0,'',0);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19141) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1914100,1914101,1914102) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19141,0,0,0,1,0,100,0,2000,2000,2000,2000,0,87,1914100,1914101,1914102,0,0,0,1,0,0,0,0,0,0,0,0,'Kurenai Pitfighter - Out of Combat - Run Random Script'),
(1914100,9,0,0,0,0,100,0,0,0,0,0,0,11,33423,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kurenai Pitfighter - Script - Cast Punch'),
(1914101,9,0,0,0,0,100,0,0,0,0,0,0,11,33424,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kurenai Pitfighter - Script - Cast Kick'),
(1914102,9,0,0,0,0,100,0,0,0,0,0,0,11,33425,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kurenai Pitfighter - Script - Cast Lights Out');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (19139) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1913900,1913901) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19139,0,0,0,8,0,100,0,33423,0,0,0,0,80,1913900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Nagrand Target Dummy - On Spell Hit - Run Script'),
(19139,0,1,0,8,0,100,0,33425,0,0,0,0,80,1913901,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Nagrand Target Dummy - On Spell Hit - Run Script'),
(1913900,9,0,0,0,0,100,0,500,500,0,0,0,5,33,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Nagrand Target Dummy - Script - Play emote OneShotWound'),
(1913901,9,0,0,0,0,100,0,500,500,0,0,0,5,34,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Nagrand Target Dummy - Script - Play emote OneShotWoundCritical');

-- Pathing for Warden Moi'bff Jill Entry: 18408
SET @NPC := 65800;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0,`position_x`=-2568.8352,`position_y`=7271.46,`position_z`=15.486481,`orientation`=4.694936 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
DELETE FROM `waypoint_scripts` WHERE `id`=112;

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=18408;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18408) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1840800) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(18408,0,0,0,1,0,100,0,60000,60000,324000,324000,0,80,1840800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warden Moi''bff Jill - Out of Combat - Run Random Script'),
(1840800,9,0,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warden Moi''bff Jill - Script - Set run off'),
(1840800,9,1,0,0,0,100,0,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,-2565.7766,7274.1777,15.578473,0,'Warden Moi''bff Jill - Script - Move to Position'),
(1840800,9,2,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,20,182393,5,0,0,0,0,0,0,'Warden Moi''bff Jill - Script - Face Gameobject'),
(1840800,9,3,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warden Moi''bff Jill - Script - Say 0'),
(1840800,9,4,0,0,0,100,0,0,0,0,0,0,17,234,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warden Moi''bff Jill - Script - Set Emotestate'),
(1840800,9,5,0,0,0,100,0,16000,16000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warden Moi''bff Jill - Script - Clear Emotestate'),
(1840800,9,6,0,0,0,100,0,1000,1000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Warden Moi''bff Jill - Script - Say 1'),
(1840800,9,7,0,0,0,100,0,3000,3000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,-2568.8352,7271.46,15.486481,0,'Warden Moi''bff Jill - Script - Move to Position'),
(1840800,9,8,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,4.694936,'Warden Moi''bff Jill - Script - Face Direction');

DELETE FROM `creature_text` WHERE `CreatureID`=18408;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(18408,0,0,'New posting going up! Adventurers and heroes, gather round the bulletin board!',12,7,100,0,0,0,15373,0,'Warden Moi''bff Jill'),
(18408,1,0,'That should get Telaar the assistance it needs!',12,7,100,5,0,0,15374,0,'Warden Moi''bff Jill');

UPDATE `creature` SET `id1`=18488, `id2`=18549 WHERE `guid` IN (68474,68475,68476,68477,68478);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_18_04' WHERE sql_rev = '1645220638173840730';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
