DELETE FROM `creature` WHERE (`id1` = 11372 AND guid = 49090) OR (`id1` = 11371 AND guid = 49090);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49090, 11371, 0, 0, 309, 0, 0, 1, 1, 0, -11862.2, -1317.21, 79.0372, 4.15388, 7200, 0, 0, 15260, 0, 0, 0, 0, 0, '', 0);
-- Pathing for Entry: 11371
SET @NPC := 49090;
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-11874.843,position_y=-1325.8516,position_z=78.68711 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-11874.843,-1325.8516,78.68711,0,0,0,0,100,0),
(@path,2,-11888.364,-1338.8317,74.93052,0,0,0,0,100,0),
(@path,3,-11904.724,-1344.1305,75.75995,0,0,0,0,100,0),
(@path,4,-11905.38,-1360.0092,70.85077,0,0,0,0,100,0),
(@path,5,-11901.88,-1377.7013,68.11927,0,0,0,0,100,0),
(@path,6,-11884.866,-1380.3492,66.02857,0,0,0,0,100,0),
(@path,7,-11880.479,-1399.4225,62.97413,0,0,0,0,100,0),
(@path,8,-11878.038,-1407.888,62.201817,0,0,0,0,100,0),
(@path,9,-11894.919,-1416.4415,57.01041,0,0,0,0,100,0),
(@path,10,-11921.158,-1428.7435,46.9667,0,2000,0,0,100,0),
(@path,11,-11894.919,-1416.4415,57.01041,0,0,0,0,100,0),
(@path,12,-11878.038,-1407.888,62.201817,0,0,0,0,100,0),
(@path,13,-11880.479,-1399.4225,62.97413,0,0,0,0,100,0),
(@path,14,-11884.866,-1380.3492,66.02857,0,0,0,0,100,0),
(@path,15,-11901.88,-1377.7013,68.11927,0,0,0,0,100,0),
(@path,16,-11905.361,-1360.0527,70.93378,0,0,0,0,100,0),
(@path,17,-11904.724,-1344.1305,75.75995,0,0,0,0,100,0),
(@path,18,-11888.364,-1338.8317,74.93052,0,0,0,0,100,0),
(@path,19,-11874.843,-1325.8516,78.68711,0,0,0,0,100,0),
(@path,20,-11863.753,-1313.4701,78.72681,0,2000,0,0,100,0);

SET @NPC := 49761;
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-11966.846,position_y=-1528.8047,position_z=41.97195 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-11966.846,-1528.8047,41.97195,0,0,0,0,100,0),
(@path,2,-11999.917,-1520.9025,58.9844,0,0,0,0,100,0),
(@path,3,-12023.279,-1518.9547,72.43448,0,0,0,0,100,0),
(@path,4,-12028.042,-1500.1376,77.62198,0,0,0,0,100,0),
(@path,5,-12029.563,-1488.6721,79.530396,0,0,0,0,100,0),
(@path,6,-12033.312,-1478.7206,80.10852,0,0,0,0,100,0),
(@path,7,-12066.744,-1478.9442,101.670784,0,0,0,0,100,0),
(@path,8,-12100.744,-1478.7441,128.72264,0,0,0,0,100,0),
(@path,9,-12066.744,-1478.9442,101.670784,0,0,0,0,100,0),
(@path,10,-12033.312,-1478.7206,80.10852,0,0,0,0,100,0),
(@path,11,-12029.563,-1488.6721,79.530396,0,0,0,0,100,0),
(@path,12,-12028.042,-1500.1376,77.62198,0,0,0,0,100,0),
(@path,13,-12023.279,-1518.9547,72.43448,0,0,0,0,100,0),
(@path,14,-11999.917,-1520.9025,58.9844,0,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderguid` IN (49090);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
('49090', '49090', '2', '0', '515', '0', '0'),
('49090', '49091', '2', '90', '515', '0', '0');
