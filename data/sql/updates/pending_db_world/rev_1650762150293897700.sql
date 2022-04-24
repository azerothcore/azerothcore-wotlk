INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650762150293897700');

SET @NPC := 14020;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-7488.41,-1074.58,476.54404,0.197437033057212829,0,0,0,100,0),
(@PATH,2,-7488.41,-1074.58,476.54404,5.272660255432128906,0,0,0,100,0),
(@PATH,3,-7488.41,-1074.58,476.54404,0,0,0,0,100,0),
(@PATH,4,-7488.41,-1074.58,476.54404,0.46780097484588623,0,0,0,100,0);
