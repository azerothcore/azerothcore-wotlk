-- DB update 2022_01_06_10 -> 2022_01_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_06_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_06_10 2022_01_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641503993585656232'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641503993585656232');

-- Darkshire

-- Pathing for Watcher Backus Entry: 840 "Was incorrect"
SET @NPC := 4230;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10512.175,`position_y`=-1186.8351,`position_z`=28.15375 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10512.175,-1186.8351,28.15375,0,0,0,0,100,0),
(@PATH,2,-10483.371,-1182.9861,27.852217,0,0,0,0,100,0),
(@PATH,3,-10455.653,-1178.642,27.411245,0,0,0,0,100,0),
(@PATH,4,-10434.214,-1166.3579,28.016329,0,0,0,0,100,0),
(@PATH,5,-10416.363,-1138.391,24.639795,0,0,0,0,100,0),
(@PATH,6,-10391.54,-1118.014,22.53904,0,0,0,0,100,0),
(@PATH,7,-10351.729,-1116.8644,21.512098,0,0,0,0,100,0),
(@PATH,8,-10320.507,-1125.6871,21.68385,0,0,0,0,100,0),
(@PATH,9,-10302.246,-1146.2643,22.726215,0,0,0,0,100,0),
(@PATH,10,-10320.507,-1125.6871,21.68385,0,0,0,0,100,0),
(@PATH,11,-10351.729,-1116.8644,21.512098,0,0,0,0,100,0),
(@PATH,12,-10391.54,-1118.014,22.53904,0,0,0,0,100,0),
(@PATH,13,-10416.291,-1138.3262,24.569239,0,0,0,0,100,0),
(@PATH,14,-10434.214,-1166.3579,28.016329,0,0,0,0,100,0),
(@PATH,15,-10455.653,-1178.642,27.411245,0,0,0,0,100,0),
(@PATH,16,-10483.371,-1182.9861,27.852217,0,0,0,0,100,0);

-- Pathing for Watcher Jordan Entry: 887 "Was incorrect"
SET @NPC := 5941;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10624.589,`position_y`=-1185.5638,`position_z`=28.968943 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10624.589,-1185.5638,28.968943,0,0,0,0,100,0),
(@PATH,2,-10648.632,-1192.0426,28.565548,0,0,0,0,100,0),
(@PATH,3,-10683.194,-1193.247,27.458822,0,0,0,0,100,0),
(@PATH,4,-10709.024,-1176.6018,26.478468,0,0,0,0,100,0),
(@PATH,5,-10736.007,-1159.654,26.582659,0,0,0,0,100,0),
(@PATH,6,-10755.747,-1144.1693,26.936907,0,0,0,0,100,0),
(@PATH,7,-10768.78,-1129.4673,27.876637,0,0,0,0,100,0),
(@PATH,8,-10779.995,-1110.3231,30.820972,0,0,0,0,100,0),
(@PATH,9,-10784.427,-1099.5131,33.08753,0,0,0,0,100,0),
(@PATH,10,-10787.088,-1079.9607,36.6554,0,0,0,0,100,0),
(@PATH,11,-10784.427,-1099.5131,33.08753,0,0,0,0,100,0),
(@PATH,12,-10779.995,-1110.3231,30.820972,0,0,0,0,100,0),
(@PATH,13,-10768.78,-1129.4673,27.876637,0,0,0,0,100,0),
(@PATH,14,-10755.747,-1144.1693,26.936907,0,0,0,0,100,0),
(@PATH,15,-10736.007,-1159.654,26.582659,0,0,0,0,100,0),
(@PATH,16,-10709.024,-1176.6018,26.478468,0,0,0,0,100,0),
(@PATH,17,-10683.194,-1193.247,27.458822,0,0,0,0,100,0),
(@PATH,18,-10648.632,-1192.0426,28.565548,0,0,0,0,100,0);

-- Pathing for Mabel Solaj Entry: 227 "Was Missing"
SET @NPC := 4203;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10531.927,`position_y`=-1156.8091,`position_z`=28.03629 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10531.927,-1156.8091,28.03629,4.86946868896484375,55000,0,0,100,0),
(@PATH,2,-10531.08,-1165.1173,28.222954,0,0,0,0,100,0),
(@PATH,3,-10524.33,-1164.6173,27.722954,0,0,0,0,100,0),
(@PATH,4,-10523.234,-1170.4255,27.409616,0,38000,0,0,100,0),
(@PATH,5,-10524.33,-1164.6173,27.722954,0,0,0,0,100,0),
(@PATH,6,-10531.08,-1165.1173,28.222954,0,0,0,0,100,0),
(@PATH,7,-10531.927,-1156.8091,28.03629,0,0,0,0,100,0);

-- Pathing for Avette Fellwood Entry: 228 "Was Missing"
SET @NPC := 4204;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10517.155,`position_y`=-1138.5286,`position_z`=26.303164 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,2,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10517.155,-1138.5286,26.303164,0,24000,0,0,100,0),
(@PATH,2,-10522.429,-1145.0801,27.71869,0,13000,0,0,100,0);

-- Pathing for Chef Grual Entry: 272 "Was incorrect"
SET @NPC := 4192;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-10507.725,`position_y`=-1161.9618,`position_z`=28.099518 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-10507.725,-1161.9618,28.099518,0,0,0,0,100,0),
(@PATH,2,-10509.697,-1160.2037,28.099518,0,7000,0,0,100,0),
(@PATH,3,-10499.272,-1159.3142,28.086538,0,0,0,0,100,0),
(@PATH,4,-10499.347,-1157.9818,28.086538,0,68000,0,0,100,0),
(@PATH,5,-10498.602,-1160.361,28.086538,0,0,0,0,100,0),
(@PATH,6,-10498.769,-1161.604,28.086538,0,10000,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_07_00' WHERE sql_rev = '1641503993585656232';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
