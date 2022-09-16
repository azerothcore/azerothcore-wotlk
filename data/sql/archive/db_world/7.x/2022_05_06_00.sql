-- DB update 2022_05_05_01 -> 2022_05_06_00
-- Gravis Slipknot

-- Waypoint and equipment taken from cmangos/tbc-db@ea2fab0 cmangos/tbc-db@381c515
UPDATE `creature_model_info` SET `DisplayID_Other_Gender` = 0 WHERE `DisplayID` = 2582;
UPDATE `creature_equip_template` SET `ItemID1` = 4560, `VerifiedBuild` = 0 WHERE `CreatureID` = 14221 AND `ID` = 1;
UPDATE `creature` SET `position_x` = 717.6572, `position_y` = -846.4034, `position_z` = 160.7536, `orientation` = 3.351032 WHERE `id1` = 14221;
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14221);

SET @NPC := 86756;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `wander_distance`= 0, `MovementType`= 2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH,1,710.176,-847.23,158.978,0,0),
(@PATH,2,700.134,-853.063,158.516,0,0),
(@PATH,3,684.42,-847.68,158.498,0,0),
(@PATH,4,666.937,-858.739,158.498,0,0),
(@PATH,5,663.885,-866.644,158.499,0,0),
(@PATH,6,662.637,-879.389,158.291,0,0),
(@PATH,7,659.842,-884.845,158.617,0,0),
(@PATH,8,666.729,-899.79,164.624,0,0),
(@PATH,9,669.022,-904.201,164.414,0,0),
(@PATH,10,667.229,-921.961,164.414,0,0),
(@PATH,11,666.778,-939.546,164.85,0,0),
(@PATH,12,673.587,-950.274,164.35,0,0),
(@PATH,13,684.347,-959.261,164.35,0,0),
(@PATH,14,698.708,-966.321,164.653,0,0),
(@PATH,15,708.321,-976.576,165.562,0,30000),
(@PATH,16,700.121,-957.096,164.68,0,0),
(@PATH,17,715.224,-933.369,164.344,0,0),
(@PATH,18,716.543,-899.917,166.366,0,0),
(@PATH,19,715.204,-866.595,161.66,0,0),
(@PATH,20,717.657,-846.403,160.754,0,0),
(@PATH,21,717.657,-846.403,160.754,3.35103,30000);

