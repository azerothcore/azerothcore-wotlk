-- DB update 2021_12_17_06 -> 2021_12_17_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_06 2021_12_17_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639345459266873783'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639345459266873783');

-- Shalandis Isle missing Darnassian Huntress, missing Darnassian Huntress pathing, update SAI for Darnassian Druid

-- Darnassian Druid SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=16331 AND `source_type`=0 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-82289,-82291) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1633100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16331, 0, 2, 0, 1, 0, 100, 0, 10000, 110000, 90000, 110000, 80, 1633100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Druid - OOC - Run Script'),
(-82289,0,0,0,0,0,100,0,3000,7000,30000,35000,11,25602,0,0,0,0,0,2,0,0,0,0,0,0,0,'Darnassian Druid - In Combat - Cast ''Faerie Fire'''),
(-82289,0,1,0,74,0,100,0,0,40,15000,25000,11,11431,1,0,0,0,0,9,0,0,0,0,0,0,0,'Darnassian Druid - On Friendly Between 0-40% Health - Cast ''Healing Touch'''),
(-82291,0,0,0,0,0,100,0,3000,7000,30000,35000,11,25602,0,0,0,0,0,2,0,0,0,0,0,0,0,'Darnassian Druid - In Combat - Cast ''Faerie Fire'''),
(-82291,0,1,0,74,0,100,0,0,40,15000,25000,11,11431,1,0,0,0,0,9,0,0,0,0,0,0,0,'Darnassian Druid - On Friendly Between 0-40% Health - Cast ''Healing Touch'''),
(1633100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 28892, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Druid - Script - Cast ''Nature Channeling'''),
(1633100, 9, 1, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 92, 0, 28892, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Darnassian Druid - Script - Stop casting');

-- Spawn missing Darnassian Huntress at Shalandis Isle
DELETE FROM `creature` WHERE `guid` IN (24175,24176,24177,24178,24179,24180);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(24175, 16332, 530, 0, 0, 1, 1, 0, 0, 7724.4707, -5631.3774, 2.2786543, 0.470632851123809814, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(24176, 16332, 530, 0, 0, 1, 1, 0, 0, 7745.9116, -5595.0493, 5.2814293, 4.084070205688476562, 300, 3, 0, 1, 0, 1, 0, 0, 0, '', 0),
(24177, 16332, 530, 0, 0, 1, 1, 0, 0, 7764.0845, -5621.7393, 12.738094, 2.234021425247192382, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(24178, 16332, 530, 0, 0, 1, 1, 0, 0, 7730.8384, -5575.275, 6.9594684, 4.467683792114257812, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(24179, 16332, 530, 0, 0, 1, 1, 0, 0, 7775.2915, -5634.5273, 17.824335, 0.929924488067626953, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0),
(24180, 16332, 530, 0, 0, 1, 1, 0, 0, 7772.73, -5629.081, 17.915586, 2.687807083129882812, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);
DELETE FROM `creature_addon` WHERE `guid` IN (24175,24176,24177,24178,24179,24180);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(24175,0,0,0,1,0,0, ''),
(24176,0,0,0,1,0,0, ''),
(24177,0,0,0,1,0,0, ''),
(24178,0,0,0,1,0,0, ''),
(24179,0,0,0,1,0,0, ''),
(24180,0,0,0,1,0,0, '');

-- Pathing for Darnassian Huntress Entry: 16332
SET @NPC := 82292;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=7668.2197,`position_y`=-5755.6235,`position_z`=3.8377824 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7668.2197,-5755.6235,3.8377824,0,1000,0,0,100,0),
(@PATH,2,7695.7456,-5752.6553,4.666762,0,0,0,0,100,0),
(@PATH,3,7699.032,-5733.879,3.7127824,0,0,0,0,100,0),
(@PATH,4,7731.7085,-5731.2363,3.80022,0,0,0,0,100,0),
(@PATH,5,7754.8423,-5700.8687,3.9994347,0,0,0,0,100,0),
(@PATH,6,7749.916,-5666.7593,3.5531814,0,1000,0,0,100,0),
(@PATH,7,7754.8423,-5700.8687,3.9994347,0,0,0,0,100,0),
(@PATH,8,7731.7085,-5731.2363,3.80022,0,0,0,0,100,0),
(@PATH,9,7699.032,-5733.879,3.7127824,0,0,0,0,100,0),
(@PATH,10,7695.7456,-5752.6553,4.666762,0,0,0,0,100,0);

-- Pathing for Darnassian Huntress Entry: 16332
SET @NPC := 24178;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7730.902,-5575.2056,6.875223,0,0,0,0,100,0),
(@PATH,2,7729.6963,-5579.8394,6.7105427,0,0,0,0,100,0),
(@PATH,3,7732.3457,-5586.9214,6.2064276,0,0,0,0,100,0),
(@PATH,4,7739.3994,-5597.0625,5.1765356,0,0,0,0,100,0),
(@PATH,5,7743.164,-5603.155,5.3691096,0,0,0,0,100,0),
(@PATH,6,7750.7754,-5606.6,5.8016696,0,0,0,0,100,0),
(@PATH,7,7755.2476,-5603.3574,5.795503,0,0,0,0,100,0),
(@PATH,8,7754,-5596.923,5.4391575,0,0,0,0,100,0),
(@PATH,9,7748.6787,-5590.26,5.1773467,0,0,0,0,100,0),
(@PATH,10,7741.099,-5580.612,6.1862845,0,0,0,0,100,0),
(@PATH,11,7735.624,-5575.783,6.6851053,0,0,0,0,100,0);

-- Pathing for Darnassian Huntress Entry: 16332
SET @NPC := 24179;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7775.2153,-5634.5225,17.787031,0,0,0,0,100,0),
(@PATH,2,7781.776,-5625.834,17.69422,0,0,0,0,100,0),
(@PATH,3,7780.244,-5622.344,16.683323,0,0,0,0,100,0),
(@PATH,4,7778.632,-5620.921,15.061182,0,0,0,0,100,0),
(@PATH,5,7773.259,-5620.7246,12.78203,0,0,0,0,100,0),
(@PATH,6,7767.975,-5624.541,12.765456,0,0,0,0,100,0),
(@PATH,7,7762.6157,-5628.4653,12.778454,0,0,0,0,100,0),
(@PATH,8,7761.0054,-5634.1597,14.975964,0,0,0,0,100,0),
(@PATH,9,7762.2866,-5636.7803,17.259832,0,0,0,0,100,0),
(@PATH,10,7767.257,-5638.0933,17.73101,0,0,0,0,100,0);

-- Pathing for Darnassian Huntress Entry: 16332
SET @NPC := 24175;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,7724.512,-5631.303,2.2373705,0,1000,0,0,100,0),
(@PATH,2,7730.208,-5628.4614,1.2466478,0,0,0,0,100,0),
(@PATH,3,7747.982,-5614.319,6.5644927,0,0,0,0,100,0),
(@PATH,4,7758.2876,-5604.123,5.9537497,0,1000,0,0,100,0),
(@PATH,5,7747.982,-5614.319,6.5644927,0,0,0,0,100,0),
(@PATH,6,7730.208,-5628.4614,1.2466478,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_17_07' WHERE sql_rev = '1639345459266873783';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
