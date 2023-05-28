UPDATE `creature_template` SET `ScriptName` = 'npc_shattered_hand_scout' WHERE `entry` = 17693;

SET @PATH := 17693 * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH,1,389.98074,315.4098,1.9338964,NULL,0,1,0,100,0),
(@PATH,2,419.4097,315.15308,1.940825,NULL,0,1,0,100,0),
(@PATH,3,460.31537,316.02213,1.9368871,NULL,0,1,0,100,0),
(@PATH,4,488.62424,315.73007,1.9498857,NULL,0,1,0,100,0);
