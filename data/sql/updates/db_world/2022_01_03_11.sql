-- DB update 2022_01_03_10 -> 2022_01_03_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_10 2022_01_03_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641001827126152885'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641001827126152885');

-- Hammerfall

-- Add missing equipment.
DELETE FROM `creature_equip_template` WHERE `CreatureID`=2621 AND `ID`=2;
INSERT INTO `creature_equip_template` (`CreatureID`,`ID`,`ItemID1`,`ItemID2`,`ItemID3`,`VerifiedBuild`) VALUES
(2621,2,5956,12453,0,0);
UPDATE `creature` SET `equipment_id`=2 WHERE `guid`=11210;


-- Fixup some bad movement
DELETE FROM `creature_addon` WHERE `guid`=11589;
DELETE FROM `waypoint_data` WHERE `id`=115890;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=0 WHERE `guid` IN (11589,11222);
UPDATE `creature` SET `wander_distance`=1,`MovementType`=1 WHERE `guid`=11207;
UPDATE `creature` SET `wander_distance`=3,`MovementType`=1 WHERE `guid`=11293;

-- Pathing for Hammerfall Guardian Entry: 2621
SET @NPC := 11295;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1011.1584,-3573.495,56.632404,0,1000,0,0,100,0),
(@PATH,2,-1012.6545,-3565.4055,56.808064,0,0,0,0,100,0),
(@PATH,3,-1011.9686,-3554.8086,56.808064,0,0,0,0,100,0),
(@PATH,4,-1009.1331,-3540.5098,56.649616,0,0,0,0,100,0),
(@PATH,5,-1000.6819,-3531.6072,57.0437,0,0,0,0,100,0),
(@PATH,6,-996.0226,-3525.3323,57.269054,0,0,0,0,100,0),
(@PATH,7,-986.2667,-3511.8877,57.064953,0,0,0,0,100,0),
(@PATH,8,-971.7515,-3501.6238,55.84132,0,0,0,0,100,0),
(@PATH,9,-962.48755,-3504.9856,56.302494,0,0,0,0,100,0),
(@PATH,10,-956.9258,-3510.7363,57.016605,0,1000,0,0,100,0),
(@PATH,11,-962.4883,-3504.9863,56.141605,0,0,0,0,100,0),
(@PATH,12,-971.7515,-3501.6238,55.84132,0,0,0,0,100,0),
(@PATH,13,-986.2667,-3511.8877,57.064953,0,0,0,0,100,0),
(@PATH,14,-996.0226,-3525.3323,57.269054,0,0,0,0,100,0),
(@PATH,15,-1000.6819,-3531.6072,57.0437,0,0,0,0,100,0),
(@PATH,16,-1009.1331,-3540.5098,56.649616,0,0,0,0,100,0),
(@PATH,17,-1011.9686,-3554.8086,56.808064,0,0,0,0,100,0),
(@PATH,18,-1012.6545,-3565.4055,56.808064,0,0,0,0,100,0);

-- Pathing for Hammerfall Guardian Entry: 2621
SET @NPC := 11254;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-825.4749,`position_y`=-3545.914,`position_z`=73.14514 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-825.4749,-3545.914,73.14514,0,0,0,0,100,0),
(@PATH,2,-839.9216,-3543.8716,73.0546,0,0,0,0,100,0),
(@PATH,3,-841.6971,-3535.8723,72.75675,0,0,0,0,100,0),
(@PATH,4,-839.7161,-3524.5366,72.77614,0,0,0,0,100,0),
(@PATH,5,-823.1416,-3513.9563,73.2527,0,0,0,0,100,0),
(@PATH,6,-835.50433,-3521.827,72.65114,0,0,0,0,100,0),
(@PATH,7,-849.0433,-3511.968,72.75685,0,0,0,0,100,0),
(@PATH,8,-865.886,-3511.5571,72.52614,0,0,0,0,100,0),
(@PATH,9,-877.5074,-3519.8352,71.91784,0,0,0,0,100,0),
(@PATH,10,-878.596,-3556.749,70.99036,0,0,0,0,100,0),
(@PATH,11,-881.025,-3531.4849,70.711296,0,0,0,0,100,0),
(@PATH,12,-889.9618,-3514.6545,71.548454,0,0,0,0,100,0),
(@PATH,13,-904,-3512.1025,70.96672,0,0,0,0,100,0),
(@PATH,14,-926.9959,-3512.177,70.39079,0,2000,0,0,100,0),
(@PATH,15,-904,-3512.1025,70.96672,0,0,0,0,100,0),
(@PATH,16,-889.9618,-3514.6545,71.548454,0,0,0,0,100,0),
(@PATH,17,-881.025,-3531.4849,70.711296,0,0,0,0,100,0),
(@PATH,18,-878.596,-3556.749,70.99036,0,0,0,0,100,0),
(@PATH,19,-877.5074,-3519.8352,71.91784,0,0,0,0,100,0),
(@PATH,20,-865.886,-3511.5571,72.52614,0,0,0,0,100,0),
(@PATH,21,-849.0433,-3511.968,72.75685,0,0,0,0,100,0),
(@PATH,22,-835.50433,-3521.827,72.65114,0,0,0,0,100,0),
(@PATH,23,-823.1416,-3513.9563,73.2527,0,0,0,0,100,0),
(@PATH,24,-839.7161,-3524.5366,72.77614,0,0,0,0,100,0),
(@PATH,25,-841.6971,-3535.8723,72.75675,0,0,0,0,100,0),
(@PATH,26,-839.9216,-3543.8716,73.0546,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_11' WHERE sql_rev = '1641001827126152885';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
