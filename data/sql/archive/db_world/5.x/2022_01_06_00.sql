-- DB update 2022_01_05_04 -> 2022_01_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_05_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_05_04 2022_01_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641421027611299094'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641421027611299094');
-- Correct Values from sniffer for npcs involved in this quest chain
UPDATE `creature_template` SET `speed_walk`='0.6666', `speed_run`='0.9285' WHERE `entry`='17379';
UPDATE `creature_template` SET `speed_walk`='0.6666', `speed_run`='0.8571' WHERE `entry`='17391';
UPDATE `creature_template` SET `speed_walk`='0.6666', `speed_run`='0.8571' WHERE `entry`='17392';
UPDATE `creature_template` SET `speed_walk`='1', `speed_run`='0.8571' WHERE `entry`='17393';
UPDATE `creature_template` SET `speed_walk`='0.6666', `speed_run`='0.8571' WHERE `entry`='17410';

-- Entire Quest Chain for: https://tbc.wowhead.com/quest=9538/learning-the-language
-- Corrected timer to work with the new speed values

-- Stillpine Ancestor Akida
SET @ENTRY := 1737900;
SET @SOURCETYPE := 9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,3,0,16995,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Morph To Model 16995"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Set Orientation Invoker"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,0,0,0,0,11,25035,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0174532,"Stillpine Ancestor Akida - On Script - Cast 'Elemental Spawn-in'"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Set Run On"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,4000,4000,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Say Line 0"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,0,1000,1000,0,0,69,0,0,0,0,0,0,8,0,0,0,-4154.22,-12514.8,45.3553,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,0,2000,2000,0,0,69,0,0,0,0,0,0,8,0,0,0,-4123.56,-12517.2,44.9127,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,7,0,0,0,100,0,3500,3500,0,0,69,0,0,0,0,0,0,8,0,0,0,-4091.88,-12524.0,42.3735,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,8,0,0,0,100,0,5500,5500,0,0,69,0,0,0,0,0,0,8,0,0,0,-4058.04,-12538.6,43.961,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,9,0,0,0,100,0,4500,4500,0,0,69,0,0,0,0,0,0,8,0,0,0,-4026.53,-12568.4,45.8222,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,10,0,0,0,100,0,3000,3000,0,0,69,0,0,0,0,0,0,8,0,0,0,-4000.16,-12598.5,54.1972,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,11,0,0,0,100,0,7500,7500,0,0,69,0,0,0,0,0,0,8,0,0,0,-3977.5,-12627.2,63.1442,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,12,0,0,0,100,0,3500,3500,0,0,69,0,0,0,0,0,0,8,0,0,0,-3952.25,-12660.4,74.2378,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,13,0,0,0,100,0,6500,6500,0,0,69,0,0,0,0,0,0,8,0,0,0,-3933.18,-12698.3,85.6515,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,14,0,0,0,100,0,4500,4500,0,0,69,0,0,0,0,0,0,8,0,0,0,-3925.84,-12718.8,89.9455,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,15,0,0,0,100,0,3500,3500,0,0,69,0,0,0,0,0,0,8,0,0,0,-3915.91,-12743.4,98.5678,0.0,"Stillpine Ancestor Akida - Script - Move To Position"),
(@ENTRY,@SOURCETYPE,16,0,0,0,100,0,15000,15000,0,0,66,0,0,0,0,0,0,19,17361,10,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Set Orientation Closest Creature 'Totem of Coo'"),
(@ENTRY,@SOURCETYPE,17,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Say Line 1"),
(@ENTRY,@SOURCETYPE,18,0,0,0,100,0,3000,3000,0,0,11,30428,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Cast 'Stillpine Ancestor Despawn DND'"),
(@ENTRY,@SOURCETYPE,19,0,0,0,100,0,1000,1000,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Akida - On Script - Despawn Instant");

-- Totem of Coo
SET @ENTRY := 17361;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,19,0,100,0,9540,0,0,0,85,30442,2,16384,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Totem of Coo - Quest accepted - Cast Spell on player");

-- Stillpine Ancestor Coo
SET @ENTRY := 17391;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,54,0,100,0,0,1,0,0,80,1739100,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Just Summoned - Run Script");

-- Stillpine Ancestor Coo
SET @ENTRY := 1739100;
SET @SOURCETYPE := 9;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,3,0,16995,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Morph To Model 16995"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Set Orientation Invoker"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,0,0,0,0,11,25035,4,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0174532,"Stillpine Ancestor Coo - On Script - Cast 'Elemental Spawn-in'"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,3000,3000,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Say Line 0"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,1000,1000,0,0,69,0,0,0,0,0,0,8,0,0,0,-3926.04,-12746.7,96.0678,0.0,"Stillpine Ancestor Coo - On Script - Move To Position"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,0,1000,1000,0,0,69,0,0,0,0,0,0,8,0,0,0,-3926.33,-12753.7,98.4428,0.0,"Stillpine Ancestor Coo - On Script - Move To Position"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,0,2000,2000,0,0,69,0,0,0,0,0,0,8,0,0,0,-3924.27,-12761.5,101.693,0.0,"Stillpine Ancestor Coo - On Script - Move To Position"),
(@ENTRY,@SOURCETYPE,7,0,0,0,100,0,6000,6000,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Say Line 1"),
(@ENTRY,@SOURCETYPE,8,0,0,0,100,0,4000,4000,0,0,11,30424,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0174532,"Stillpine Ancestor Coo - On Script - Cast 'Ghost Walk'"),
(@ENTRY,@SOURCETYPE,9,0,0,0,100,0,1000,1000,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Say Line 2"),
(@ENTRY,@SOURCETYPE,10,0,0,0,100,0,4000,4000,0,0,11,30473,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Cast 'Coo Transform Furbolg DND'"),
(@ENTRY,@SOURCETYPE,11,0,0,0,100,0,0,0,0,0,3,0,17019,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Morph To Model 17019"),
(@ENTRY,@SOURCETYPE,12,0,0,0,100,0,3000,3000,0,0,60,1,0,1,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Set Fly On"),
(@ENTRY,@SOURCETYPE,13,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,-3926.07,-12767.3,104.38,0.0,"Stillpine Ancestor Coo - On Script - Move To Position"),
(@ENTRY,@SOURCETYPE,14,0,0,0,100,0,1000,1000,0,0,69,0,0,0,0,0,0,8,0,0,0,-3923.5,-12795.0,98.4632,0.0,"Stillpine Ancestor Coo - On Script - Move To Position"),
(@ENTRY,@SOURCETYPE,15,0,0,0,100,0,4000,4000,0,0,69,0,0,0,0,0,0,8,0,0,0,-3922.69,-12832.4,89.241,0.0,"Stillpine Ancestor Coo - On Script - Move To Position"),
(@ENTRY,@SOURCETYPE,16,0,0,0,100,0,8000,8000,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Coo - On Script - Despawn Instant");

-- Totem of Tikti
SET @ENTRY := 17362;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,19,0,100,0,9541,0,0,0,85,30443,2,16384,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Totem of Tikti - Quest accepted - Cast Spell on player");

-- Stillpine Ancestor Tikti
SET @ENTRY := 17392;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,54,0,100,0,0,1,0,0,80,1739200,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Tikti - On Just Summoned - Run Script");

-- Totem of Yor
SET @ENTRY := 17363;
SET @SOURCETYPE := 0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,19,0,100,0,9542,0,0,0,85,30444,2,16384,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Totem of Yor - Quest accepted - Cast Spell on player");

-- Stillpine Ancestor Yor
SET @ENTRY := 17393;
SET @SOURCETYPE := 0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,1,54,0,100,0,0,0,0,0,3,0,17002,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Just Summoned - Run Script"),
(@ENTRY,@SOURCETYPE,1,0,61,0,100,0,0,0,0,0,80,1739300,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Just Summoned - Run Script"),
(@ENTRY,@SOURCETYPE,2,3,40,0,100,0,1,17393,0,0,54,3000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Waypoint 1 Reached - Pause Pathing"),
(@ENTRY,@SOURCETYPE,3,0,61,0,100,0,0,0,0,0,80,1739301,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Waypoint 1 Reached - Run Script"),
(@ENTRY,@SOURCETYPE,4,5,40,0,100,0,3,17393,0,0,54,20000,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Waypoint 3 Reached - Pause Pathing"),
(@ENTRY,@SOURCETYPE,5,0,61,0,100,0,0,0,0,0,80,1739302,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Waypoint 3 Reached - Run Script"),
(@ENTRY,@SOURCETYPE,6,7,40,0,100,0,54,17393,0,0,55,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Waypoint 54 Reached - Pause Pathing"),
(@ENTRY,@SOURCETYPE,7,0,61,0,100,0,0,0,0,0,80,1739303,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Waypoint 54 Reached - Run Script");

-- Stillpine Ancestor Yor Timed Actionlist
SET @ENTRY := 1739300;
SET @SOURCETYPE := 9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,3,0,17002,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Morph To Model 17002"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Orientation Invoker"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,0,0,0,0,11,25035,4,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Cast 'Elemental Spawn-in'"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Say Line 0"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,0,3000,3000,0,0,61,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Swim On"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,0,3000,3000,0,0,53,0,17393,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Start Waypoints");

-- Stillpine Ancestor Yor Timed Actionlist
SET @ENTRY := 1739301;
SET @SOURCETYPE := 9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,0,0,0,0,61,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Swim On"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,3000,3000,0,0,11,30446,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Cast 'Yor Transform Furbolg DND"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,0,0,0,0,3,0,16995,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Morph To Model 16995"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Walk On");

-- Stillpine Ancestor Yor Timed Actionlist
SET @ENTRY := 1739302;
SET @SOURCETYPE := 9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,3000,3000,0,0,66,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Orientation Invoker"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Say Line 1"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,2000,2000,0,0,11,30448,2,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Cast `Shadow of the Forest`"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,2000,2000,0,0,11,30447,2,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Cast `Tiger Form`"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,2000,2000,0,0,66,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Orientation Invoker"),
(@ENTRY,@SOURCETYPE,5,0,0,0,100,0,3000,3000,0,0,1,2,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Say Line 2"),
(@ENTRY,@SOURCETYPE,6,0,0,0,100,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Run On");

-- Stillpine Ancestor Yor Timed Actionlist
SET @ENTRY := 1739303;
SET @SOURCETYPE := 9;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,5000,5000,0,0,66,0,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Set Orientation Invoker"),
(@ENTRY,@SOURCETYPE,1,0,0,0,100,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Say Line 3"),
(@ENTRY,@SOURCETYPE,2,0,0,0,100,0,5000,5000,0,0,11,30428,4,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Stillpine Ancestor Despawn DND"),
(@ENTRY,@SOURCETYPE,3,0,0,0,100,0,0,0,0,0,3,0,17003,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Morph To Model 17003"),
(@ENTRY,@SOURCETYPE,4,0,0,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Stillpine Ancestor Yor - Script - Despawn");

-- Waypoints for Stillpine Ancestor Yor from sniffed data

-- Pathing for Stillpine Ancestor Yor Entry: 17393 'SAI FORMAT' 
SET @NPC := 17393;
DELETE FROM `waypoints` WHERE `entry`=@NPC;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@NPC,1,-4646.6274,-13015.363,-1.386728,'Stillpine Ancestor Yor'),
(@NPC,2,-4679.1406,-12984.977,0.5803,'Stillpine Ancestor Yor'),
(@NPC,3,-4679.1406,-12984.977,0.5803,'Stillpine Ancestor Yor'),
(@NPC,4,-4687.8647,-12949.552,3.0872989,'Stillpine Ancestor Yor'),
(@NPC,5,-4683.147,-12930.065,3.5664437,'Stillpine Ancestor Yor'),
(@NPC,6,-4669.631,-12912.276,2.0527718,'Stillpine Ancestor Yor'),
(@NPC,7,-4642.2124,-12881.508,4.34367,'Stillpine Ancestor Yor'),
(@NPC,8,-4623.7637,-12837.017,5.523203,'Stillpine Ancestor Yor'),
(@NPC,9,-4611.349,-12813.138,7.1231403,'Stillpine Ancestor Yor'),
(@NPC,10,-4598.923,-12789.411,4.1702867,'Stillpine Ancestor Yor'),
(@NPC,11,-4589.2295,-12774.911,7.4722886,'Stillpine Ancestor Yor'),
(@NPC,12,-4571.645,-12755.009,7.0030255,'Stillpine Ancestor Yor'),
(@NPC,13,-4557.206,-12734.058,11.840908,'Stillpine Ancestor Yor'),
(@NPC,14,-4546.748,-12710.123,9.837413,'Stillpine Ancestor Yor'),
(@NPC,15,-4535.69,-12682.16,13.675971,'Stillpine Ancestor Yor'),
(@NPC,16,-4532.9067,-12665.749,16.82585,'Stillpine Ancestor Yor'),
(@NPC,17,-4533.329,-12618.874,12.256811,'Stillpine Ancestor Yor'),
(@NPC,18,-4530.3765,-12605.46,12.883276,'Stillpine Ancestor Yor'),
(@NPC,19,-4535.566,-12573.896,12.0213375,'Stillpine Ancestor Yor'),
(@NPC,20,-4519.5273,-12543.231,7.4484234,'Stillpine Ancestor Yor'),
(@NPC,21,-4510.07,-12525.349,4.511101,'Stillpine Ancestor Yor'),
(@NPC,22,-4498.348,-12505.462,4.6822286,'Stillpine Ancestor Yor'),
(@NPC,23,-4478.837,-12472.255,2.8348017,'Stillpine Ancestor Yor'),
(@NPC,24,-4462.5576,-12438.15,2.619331,'Stillpine Ancestor Yor'),
(@NPC,25,-4427.293,-12441.997,2.6910262,'Stillpine Ancestor Yor'),
(@NPC,26,-4413.8086,-12416.674,3.9957137,'Stillpine Ancestor Yor'),
(@NPC,27,-4408.8784,-12400.644,5.1390243,'Stillpine Ancestor Yor'),
(@NPC,28,-4414.5264,-12370.945,6.0320573,'Stillpine Ancestor Yor'),
(@NPC,29,-4423.4517,-12345.4,8.312355,'Stillpine Ancestor Yor'),
(@NPC,30,-4432.4805,-12325.473,10.039841,'Stillpine Ancestor Yor'),
(@NPC,31,-4437.556,-12313.213,10.596848,'Stillpine Ancestor Yor'),
(@NPC,32,-4470.0254,-12298.238,13.521049,'Stillpine Ancestor Yor'),
(@NPC,33,-4490.1777,-12280.992,15.278861,'Stillpine Ancestor Yor'),
(@NPC,34,-4506.427,-12242.669,16.717472,'Stillpine Ancestor Yor'),
(@NPC,35,-4510.89,-12225.302,17.371742,'Stillpine Ancestor Yor'),
(@NPC,36,-4514.449,-12197.06,17.18167,'Stillpine Ancestor Yor'),
(@NPC,37,-4503.036,-12159.077,16.294647,'Stillpine Ancestor Yor'),
(@NPC,38,-4509.5093,-12123.574,16.961056,'Stillpine Ancestor Yor'),
(@NPC,39,-4505.7886,-12092.211,19.238947,'Stillpine Ancestor Yor'),
(@NPC,40,-4501.1543,-12069.858,21.54632,'Stillpine Ancestor Yor'),
(@NPC,41,-4528.139,-12038.622,25.998667,'Stillpine Ancestor Yor'),
(@NPC,42,-4531.142,-12014.648,27.817528,'Stillpine Ancestor Yor'),
(@NPC,43,-4543.3193,-11968.287,29.599657,'Stillpine Ancestor Yor'),
(@NPC,44,-4537.629,-11935.665,27.204681,'Stillpine Ancestor Yor'),
(@NPC,45,-4533.0293,-11906.794,22.829082,'Stillpine Ancestor Yor'),
(@NPC,46,-4505.259,-11880.296,17.813578,'Stillpine Ancestor Yor'),
(@NPC,47,-4500.2856,-11846.753,15.026818,'Stillpine Ancestor Yor'),
(@NPC,48,-4510.4556,-11817.56,13.851518,'Stillpine Ancestor Yor'),
(@NPC,49,-4531.629,-11787.209,15.557687,'Stillpine Ancestor Yor'),
(@NPC,50,-4556.1245,-11757.583,17.683008,'Stillpine Ancestor Yor'),
(@NPC,51,-4537.018,-11712.65,18.483347,'Stillpine Ancestor Yor'),
(@NPC,52,-4510.735,-11697.223,14.548721,'Stillpine Ancestor Yor'),
(@NPC,53,-4490.1094,-11672.723,10.858275,'Stillpine Ancestor Yor'),
(@NPC,54,-4486.507,-11657.934,10.678984,'Stillpine Ancestor Yor');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_06_00' WHERE sql_rev = '1641421027611299094';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
