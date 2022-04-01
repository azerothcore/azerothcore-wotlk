INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648780747131852300');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_drakonid_spawner' WHERE `entry` IN (14307, 14309, 14310, 14311, 14312);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (14307, 14309, 14310, 14311, 14312) AND `source_type` = 0;

SET @GUID := 84557;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `position_x` = -7496.66, `position_y` = -1038.1, `position_z` = 449.242, `orientation` = 3.77, `MovementType` = 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@GUID, @PATH, 1);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`,`wpguid`) VALUES
(@PATH, 1, -7496.66, -1038.1, 449.242, 3.80725, 5000, 0, 0, 100, 0),
(@PATH, 2, -7525.39, -1059.24, 449.242, 3.77583, 5000, 0, 0, 100, 0);

SET @GUID := 84558;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `position_x` = -7527.93, `position_y` = -979.702, `position_z` = 449.242, `orientation` = 0.57, `MovementType` = 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@GUID, @PATH, 1);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`,`wpguid`) VALUES
(@PATH, 1, -7530.46, -991.187, 449.243, 0.575341, 5000, 0, 0, 100, 0),
(@PATH, 2, -7513.23, -978.857, 449.243, 0.602829, 5000, 0, 0, 100, 0);

SET @GUID := 85756;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `position_x` = -7419.65, `position_y` = -913.131, `position_z` = 464.984, `orientation` = 3.77272, `MovementType` = 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@GUID, @PATH, 1);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`,`wpguid`) VALUES
(@PATH, 1, -7412.51, -930.747, 465.035, 5.31515, 5000, 0, 0, 100, 0),
(@PATH, 2, -7432.42, -902.277, 465.032, 2.16414, 5000, 0, 0, 100, 0);

SET @GUID := 85759;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `position_x` = -7448.3, `position_y` = -934.665, `position_z` = 464.984, `orientation` = 3.4581, `MovementType` = 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@GUID, @PATH, 1);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`,`wpguid`) VALUES
(@PATH, 1, -7433.41, -946.726, 465.036, 5.3285, 5000, 0, 0, 100, 0),
(@PATH, 2, -7455.8, -915.137, 465.016, 2.18612, 5000, 0, 0, 100, 0);

SET @GUID := 84840;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `position_x` = -7476.91, `position_y` = -878.195, `position_z` = 464.984, `orientation` = 4.09632, `MovementType` = 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@GUID, @PATH, 1);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`,`wpguid`) VALUES
(@PATH, 1, -7475.45, -894.514, 465.218, 3.73025, 5000, 0, 0, 100, 0),
(@PATH, 2, -7452.86, -878.005, 465.218, 3.7381, 5000, 0, 0, 100, 0);

SET @GUID := 84625;
SET @PATH := @GUID * 10;
UPDATE `creature` SET `position_x` = -7515.62, `position_y` = -910.707, `position_z` = 457.576, `orientation` = 5.11366, `MovementType` = 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(@GUID, @PATH, 1);

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`,`wpguid`) VALUES
(@PATH, 1, -7494.78, -914.672, 457.856, 3.76402, 5000, 0, 0, 100, 0),
(@PATH, 2, -7513.27, -927.939, 457.856, 3.76402, 5000, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` BETWEEN 84519 AND 84532;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`) VALUES
(84519,12467,469,1,1,1,-7525.67,-925.212,427.908,2.226160,604800,0,0,242775,0,0,0,0,0,''),
(84520,12467,469,1,1,1,-7590.30,-930.078,428.261,5.859410,604800,0,0,242775,0,0,0,0,0,''),
(84521,12464,469,1,1,1,-7580.70,-945.092,428.161,1.699940,604800,0,0,113295,0,0,0,0,0,''),
(84522,12464,469,1,1,1,-7583.51,-924.026,428.317,4.854110,604800,0,0,113295,0,0,0,0,0,''),
(84523,12464,469,1,1,1,-7527.41,-911.406,427.920,4.517160,604800,0,0,113295,0,0,0,0,0,''),
(84524,12464,469,1,1,1,-7534.23,-926.704,427.963,1.292320,604800,0,0,113295,0,0,0,0,0,''),
(84525,12465,469,1,1,1,-7539.97,-921.612,428.016,0.495137,604800,0,0,88025,24860,0,0,0,0,''),
(84526,12465,469,1,1,1,-7523.96,-917.881,427.921,3.282520,604800,0,0,88025,24860,0,0,0,0,''),
(84527,12465,469,1,1,1,-7573.80,-927.041,428.258,4.127620,604800,0,0,88025,24860,0,0,0,0,''),
(84528,12465,469,1,1,1,-7590.22,-939.636,428.222,0.745684,604800,0,0,88025,24860,0,0,0,0,''),
(84529,12463,469,1,1,1,-7568.89,-934.958,428.192,3.054760,604800,0,0,129480,0,0,0,0,0,''),
(84530,12463,469,1,1,1,-7539.57,-914.064,428.012,5.615940,604800,0,0,129480,0,0,0,0,0,'');

DELETE FROM `creature_formations` WHERE `memberGUID` BETWEEN 84519 AND 84532;

SET @LEADERGUID := 84519;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84523, 0, 0, 3),
(@LEADERGUID, 84524, 0, 0, 3),
(@LEADERGUID, 84525, 0, 0, 3),
(@LEADERGUID, 84526, 0, 0, 3),
(@LEADERGUID, 84530, 0, 0, 3);

SET @LEADERGUID := 84520;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID, @LEADERGUID, 0, 0, 3),
(@LEADERGUID, 84521, 0, 0, 3),
(@LEADERGUID, 84522, 0, 0, 3),
(@LEADERGUID, 84527, 0, 0, 3),
(@LEADERGUID, 84528, 0, 0, 3),
(@LEADERGUID, 84529, 0, 0, 3);
