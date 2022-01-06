INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641426458023302944');

-- Add scriptnames
UPDATE `creature_template` SET `ScriptName` = "npc_eastvale_peasent" WHERE `entry` IN (11328);
UPDATE `creature_template` SET `ScriptName` = "npc_supervisor_raelen" WHERE `entry` IN (10616);

-- Update Eastvale Peasants
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0 WHERE `id`=11328;
UPDATE `creature_template_addon` SET `emote`=234 WHERE `entry`= 11328;
UPDATE `creature` SET `position_x`=-9523.21,`position_y`=-1290.2489,`position_z`=44.11742, `orientation`=5.238773 WHERE `guid`=81249;
UPDATE `creature` SET `position_x`=-9536.207,`position_y`=-1273.0508,`position_z`=43.418743, `orientation`=2.936915 WHERE `guid`=81250;
UPDATE `creature` SET `position_x`=-9535.653,`position_y`=-1329.8119,`position_z`=47.341866, `orientation`=1.939004 WHERE `guid`=81349;

-- Update Eastvale Lumberjacks
UPDATE `creature` SET `wander_distance`=2 WHERE `guid` IN (81259,81345);


(XXXXXX, 13159, 0, 0, 0, 1, 1, 0, 0, -9493.731, -1193.5862, 49.64713, 3.89947509765625, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0), -- .go xyz -9493.731 -1193.5862 49.64713

-- Pathing for Eastvale Lumberjack Entry: 1975
SET @NPC := 81257;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9400.745,-1336.9156,50.027412,0,15000,0,0,100,0),
(@PATH,2,-9404.866,-1339.135,50.027412,0,0,0,0,100,0),
(@PATH,3,-9409.12,-1338.372,50.027412,0,0,0,0,100,0),
(@PATH,4,-9411.633,-1336.6923,50.74399,0,0,0,0,100,0),
(@PATH,5,-9416.485,-1331.1586,51.441143,0,0,0,0,100,0),
(@PATH,6,-9421.154,-1326.5717,51.46511,0,0,0,0,100,0),
(@PATH,7,-9426.076,-1323.9713,51.4651,0,15000,0,0,100,0),
(@PATH,8,-9417.531,-1330.5028,51.441174,0,0,0,0,100,0),
(@PATH,9,-9412.813,-1334.5887,51.52948,0,0,0,0,100,0),
(@PATH,10,-9408.221,-1337.9055,50.027412,0,0,0,0,100,0);

-- Pathing for Eastvale Peasant Entry: 11328
SET @NPC := 81348;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,0,0,0,1,234,0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (@PATH,@PATH+1,@PATH+2);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9517.114,-1333.8582,45.9155,0,0,0,0,100,0),
(@PATH,2,-9494.799,-1322.8846,41.20464,0,0,0,0,100,0),
(@PATH,3,-9466.731,-1296.875,41.543285,0,0,0,0,100,0),
(@PATH+1,1,-9471.852,-1292.7347,41.054028,0,0,0,0,100,0),
(@PATH+1,2,-9471.444,-1289.9312,41.134594,0,0,0,0,100,0),
(@PATH+2,1,-9496.343,-1322.3462,41.325,0,0,0,0,100,0),
(@PATH+2,2,-9516.777,-1333.658,45.834446,0,0,0,0,100,0),
(@PATH+2,3,-9526.894,-1324.7913,45.84667,0,0,0,0,100,0),
(@PATH+2,4,-9529.32,-1323.672,45.950916,0,0,0,0,100,0);

-- Pathing for Eastvale Peasant Entry: 11328
SET @NPC := 81252;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,0,0,0,1,234,0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (@PATH,@PATH+1,@PATH+2);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9524.052,-1283.8728,43.82079,0,0,0,0,100,0),
(@PATH,2,-9500.586,-1283.8563,43.402332,0,0,0,0,100,0),
(@PATH,3,-9469.168,-1298.1064,41.57429,0,0,0,0,100,0),
(@PATH,4,-9466.686,-1296.875,41.549145,0,0,0,0,100,0),
(@PATH+1,1,-9472.049,-1293.2257,41.030346,0,0,0,0,100,0),
(@PATH+1,2,-9471.718,-1289.9913,41.12727,0,0,0,0,100,0),
(@PATH+2,1,-9500.046,-1283.9575,43.255604,0,0,0,0,100,0),
(@PATH+2,2,-9525.792,-1284.0898,43.640614,0,0,0,0,100,0),
(@PATH+2,3,-9536.142,-1303.3818,44.576973,0,0,0,0,100,0),
(@PATH+2,4,-9535.299,-1304.701,44.701973,0,0,0,0,100,0);

-- Pathing for Eastvale Peasant Entry: 11328
SET @NPC := 81349;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,0,0,0,1,234,0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (@PATH,@PATH+1,@PATH+2);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9506.966,-1333.8741,44.104954,0,0,0,0,100,0),
(@PATH,2,-9475.493,-1304.2109,42.403614,0,0,0,0,100,0),
(@PATH,3,-9466.71,-1296.875,41.546215,0,0,0,0,100,0),
(@PATH+1,1,-9471.955,-1292.7456,40.988842,0,0,0,0,100,0),
(@PATH+1,2,-9471.373,-1289.8252,41.14729,0,0,0,0,100,0),
(@PATH+2,1,-9498.48,-1327.6045,42.092823,0,0,0,0,100,0),
(@PATH+2,2,-9524.156,-1335.9268,47.01755,0,0,0,0,100,0),
(@PATH+2,3,-9534.49,-1332.8064,47.652657,0,0,0,0,100,0),
(@PATH+2,4,-9535.653,-1329.8119,47.341866,0,0,0,0,100,0);

-- Pathing for Eastvale Peasant Entry: 11328
SET @NPC := 81250;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,0,0,0,1,234,0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (@PATH,@PATH+1,@PATH+2);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9501.6,-1282.86,43.637928,0,0,0,0,100,0),
(@PATH,2,-9469.226,-1297.9215,41.552074,0,0,0,0,100,0),
(@PATH,3,-9466.679,-1296.875,41.549877,0,0,0,0,100,0),
(@PATH+1,1,-9471.516,-1293.1033,41.09431,0,0,0,0,100,0),
(@PATH+1,2,-9471.361,-1289.7982,41.150463,0,0,0,0,100,0),
(@PATH+2,1,-9505.872,-1279.3485,44.435535,0,0,0,0,100,0),
(@PATH+2,2,-9536.207,-1273.0508,43.418743,0,0,0,0,100,0);

-- Pathing for Eastvale Peasant Entry: 11328
SET @NPC := 81249;
SET @PATH := @NPC * 10;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,0,0,0,1,234,0, '');
DELETE FROM `waypoint_data` WHERE `id` IN (@PATH,@PATH+1,@PATH+2);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9520.802,-1284.2855,44.085926,0,0,0,0,100,0),
(@PATH,2,-9501.877,-1282.7637,43.644764,0,0,0,0,100,0),
(@PATH,3,-9468.622,-1298.6906,41.752514,0,0,0,0,100,0),
(@PATH,4,-9466.68,-1296.875,41.549633,0,0,0,0,100,0),
(@PATH+1,1,-9471.81,-1293.9409,41.05891,0,0,0,0,100,0),
(@PATH+1,2,-9471.407,-1290.0531,41.119946,0,0,0,0,100,0),
(@PATH+2,1,-9517.359,-1283.467,44.269764,0,0,0,0,100,0),
(@PATH+2,2,-9524.299,-1288.3755,43.83373,0,0,0,0,100,0),
(@PATH+2,3,-9523.21,-1290.2489,44.11742,0,0,0,0,100,0);

-- Ridgepoint Tower Guards

-- Pathing for Stormwind Guard Entry: 1423
SET @NPC := 81365;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-9771.3,`position_y`=-1406.9572,`position_z`=97.88677 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9771.3,-1406.9572,97.88677,0,0,0,0,100,0),
(@PATH,2,-9771.3,-1406.9572,97.88677,1.169370651245117187,60000,0,0,100,0),
(@PATH,3,-9776.593,-1394.8129,97.88729,0,0,0,0,100,0),
(@PATH,4,-9776.593,-1394.8129,97.88729,2.740167140960693359,60000,0,0,100,0),
(@PATH,5,-9788.505,-1399.9374,97.88729,0,0,0,0,100,0),
(@PATH,6,-9788.505,-1399.9374,97.88729,4.345870018005371093,60000,0,0,100,0),
(@PATH,7,-9783.521,-1412.0233,97.88729,0,0,0,0,100,0),
(@PATH,8,-9783.521,-1412.0233,97.88729,5.846853256225585937,60000,0,0,100,0);

-- Pathing for Stormwind Guard Entry: 1423
SET @NPC := 81362;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-9776.632,`position_y`=-1383.5325,`position_z`=62.792778 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9776.632,-1383.5325,62.792778,0,2000,0,0,100,0),
(@PATH,2,-9787.192,-1384.7284,62.70096,0,0,0,0,100,0),
(@PATH,3,-9796.349,-1393.6975,62.78296,0,0,0,0,100,0),
(@PATH,4,-9799.684,-1403.431,62.7103,0,0,0,0,100,0),
(@PATH,5,-9797.448,-1413.294,62.797836,0,0,0,0,100,0),
(@PATH,6,-9791.156,-1420.47,62.699223,0,0,0,0,100,0),
(@PATH,7,-9780.899,-1422.8915,62.66864,0,0,0,0,100,0),
(@PATH,8,-9771.842,-1421.9237,62.697872,0,0,0,0,100,0),
(@PATH,9,-9762.633,-1412.1235,62.792976,0,0,0,0,100,0),
(@PATH,10,-9760.813,-1402.7131,62.72537,0,0,0,0,100,0),
(@PATH,11,-9763.664,-1392.0123,62.800457,0,2000,0,0,100,0),
(@PATH,12,-9760.813,-1402.7131,62.72537,0,0,0,0,100,0),
(@PATH,13,-9762.633,-1412.1235,62.792976,0,0,0,0,100,0),
(@PATH,14,-9771.842,-1421.9237,62.697872,0,0,0,0,100,0),
(@PATH,15,-9780.899,-1422.8915,62.66864,0,0,0,0,100,0),
(@PATH,16,-9791.156,-1420.47,62.699223,0,0,0,0,100,0),
(@PATH,17,-9797.448,-1413.294,62.797836,0,0,0,0,100,0),
(@PATH,18,-9799.684,-1403.431,62.7103,0,0,0,0,100,0),
(@PATH,19,-9796.349,-1393.6975,62.78296,0,0,0,0,100,0),
(@PATH,20,-9787.192,-1384.7284,62.70096,0,0,0,0,100,0);
