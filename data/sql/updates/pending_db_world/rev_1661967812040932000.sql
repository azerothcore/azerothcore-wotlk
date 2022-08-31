-- Set random movement to all of them
UPDATE `creature` SET `MovementType`=1, `wander_distance`=3 WHERE `id1` IN (15316,15317) AND `map`=531;

-- Add new spawns for patrolling critters
SET @GUID=144679;
DELETE FROM `creature` WHERE (`id1` = 15252) AND `guid` BETWEEN @GUID AND @GUID+7;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`) VALUES
(@GUID, 15316, 0, 0, 531, 0, 0, 1, 1, 0, -9084.354, 1468.4955, -106.0379, 5.43525, 604800, 0, 0, 1, 0, 2, 0, 0, 0, ''),

-- Add addons
SET @GUID=88000;
SET @PATH=@GUID*10;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN @GUID AND @GUID+7;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES 
(@GUID, @PATH),
(@GUID+1, @PATH+10),

-- Add waypoints
SET @NPC := XXXXXX;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9095.084,1390.2705,-105.85795,0,0,0,0,100,0),
(@PATH,2,-9126.132,1378.705,-105.72979,0,0,0,0,100,0),
(@PATH,3,-9122.575,1402.7551,-105.24444,0,0,0,0,100,0),
(@PATH,4,-9145.673,1408.1447,-105.48799,0,0,0,0,100,0),
(@PATH,5,-9137.399,1432.448,-102.555534,0,0,0,0,100,0),
(@PATH,6,-9163.476,1429.0597,-103.73565,0,0,0,0,100,0),
(@PATH,7,-9153.607,1454.8204,-100.4185,0,0,0,0,100,0),
(@PATH,8,-9176.5,1455.4498,-101.46861,0,0,0,0,100,0),
(@PATH,9,-9147.856,1481.0919,-100.3486,0,0,0,0,100,0),
(@PATH,10,-9187.243,1476.0885,-98.5702,0,0,0,0,100,0),
(@PATH,11,-9177.395,1509.4562,-91.8547,0,0,0,0,100,0),
(@PATH,12,-9187.243,1476.0885,-98.5702,0,0,0,0,100,0),
(@PATH,13,-9147.856,1481.0919,-100.3486,0,0,0,0,100,0),
(@PATH,14,-9176.5,1455.4498,-101.46861,0,0,0,0,100,0),
(@PATH,15,-9153.607,1454.8204,-100.4185,0,0,0,0,100,0),
(@PATH,16,-9163.476,1429.0597,-103.73565,0,0,0,0,100,0),
(@PATH,17,-9137.399,1432.448,-102.555534,0,0,0,0,100,0),
(@PATH,18,-9145.673,1408.1447,-105.48799,0,0,0,0,100,0),
(@PATH,19,-9122.575,1402.7551,-105.24444,0,0,0,0,100,0),
(@PATH,20,-9126.132,1378.705,-105.72979,0,0,0,0,100,0);
