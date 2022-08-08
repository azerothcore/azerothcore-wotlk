--
SET @NPC := 15369;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9689.981,1548.2961,33.27733,0,0,0,0,100,0),
(@PATH,2,-9682.716,1554.252,31.416214,0,0,0,0,100,0),
(@PATH,3,-9677.917,1558.839,27.249535,0,0,0,0,100,0);
