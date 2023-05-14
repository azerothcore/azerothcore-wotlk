-- DB update 2023_04_04_07 -> 2023_04_04_08
--
DELETE FROM `areatrigger_scripts` WHERE `entry`=4295;
INSERT INTO `areatrigger_scripts` VALUES
(4295,'at_quagmirran_lair');

-- Pathing for Quagmirran Entry: 17942
SET @PATH := 1794200;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-272.12997,-671.50586,8.970236,NULL,0,0,0,100,0),
(@PATH,2,-261.6143,-675.77155,10.541557,NULL,0,0,0,100,0),
(@PATH,3,-246.73248,-683.1629,15.529007,NULL,0,0,0,100,0),
(@PATH,4,-238.07864,-686.42316,18.473059,NULL,0,0,0,100,0),
(@PATH,5,-227.73457,-690.909,22.025816,NULL,0,0,0,100,0),
(@PATH,6,-217.95325,-695.7503,26.769361,NULL,0,0,0,100,0),
(@PATH,7,-204.01328,-702.2695,37.230885,NULL,0,0,0,100,0),
(@PATH,8,-199.49352,-705.59766,37.802734,NULL,0,0,0,100,0);
