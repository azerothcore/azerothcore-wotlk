-- Pathing for Entry: 11368
SET @NPC := 49146;
SET @path := @NPC * 10;
UPDATE creature SET wander_distance=0,MovementType=2,position_x=-12051.524,position_y=-1427.2681,position_z=130.14175 WHERE guid=@NPC;
DELETE FROM creature_addon WHERE guid=@NPC;
INSERT INTO creature_addon (guid,path_id,mount,bytes1,bytes2,emote,visibilityDistanceType,auras) VALUES (@NPC,@path,0,0,1,0,0, '');
DELETE FROM waypoint_data WHERE id=@path;
INSERT INTO waypoint_data (id,point,position_x,position_y,position_z,orientation,delay,move_type,action,action_chance,wpguid) VALUES
(@path,1,-12051.524,-1427.2681,130.14175,0,0,0,0,100,0),
(@path,2,-12056.444,-1439.4609,130.26523,0,0,0,0,100,0),
(@path,3,-12064.653,-1446.329,130.2684,0,0,0,0,100,0),
(@path,4,-12076.898,-1450.6375,130.39133,0,0,0,0,100,0),
(@path,5,-12088.711,-1450.2057,130.85104,0,0,0,0,100,0),
(@path,6,-12064.653,-1446.329,130.2684,0,0,0,0,100,0),
(@path,7,-12056.444,-1439.4609,130.26523,0,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderguid` IN (49090, 49751, 49752, 49146, 49147);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
('49751', '49751', '0', '0', '515', '0', '0'),
('49751', '49752', '2', '270', '515', '0', '0'),
('49090', '49090', '0', '0', '515', '0', '0'),
('49090', '49091', '2', '90', '515', '0', '0'),
('49146', '49146', '0', '0', '515', '0', '0'),
('49146', '49145', '10', '165', '515', '0', '0'),
('49146', '49144', '10', '195', '515', '0', '0'),
('49146', '49143', '10', '185', '515', '0', '0'),
('49146', '49147', '10', '170', '515', '0', '0');
