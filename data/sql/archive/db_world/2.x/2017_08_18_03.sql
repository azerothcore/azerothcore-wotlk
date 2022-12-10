-- DB update 2017_08_18_02 -> 2017_08_18_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_18_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_18_02 2017_08_18_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1499118515042687600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1499118515042687600');

-- D.E.T.H.A TEXT AND SAI
DELETE FROM `creature_text` WHERE `entry` IN (25808, 25809, 25819, 25812, 25811, 25810, 25838) AND `groupid` = 0; 
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(25808,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25808,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25808,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,''),
--
(25809,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25809,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25809,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,''),
--
(25812,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25812,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25812,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,''),
--
(25811,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25811,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25811,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,''),
--
(25810,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25810,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25810,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,''),
--
(25838,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25838,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25838,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,''),
--
(25819,0,0,' Do you think us fools! You\'re covered in animal blood!',12,0,100,5,4000,0,0,0,''),
(25819,0,1,' BUTCHER! DIE!',12,0,100,5,4000,0,0,0,''),
(25819,0,2,' Calf killer! Murderer! You will pay for this!',12,0,100,5,4000,0,0,0,'');

SET @ENTRY := 25808;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"D.E.H.T.A. Enforcer - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,10,0,100,0,1,20,0,0,49,2,0,0,0,0,0,25,20,1,0,0,0,0,0,"D.E.H.T.A. Enforcer - Within 1-20 Range Out of Combat LoS - Start Attacking");

DELETE FROM `creature_formations` WHERE `leaderGUID`= 132974;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(132974,132974,0,0,2,0,0),
(132974,132976,0,0,2,0,0);

SET @ENTRY := 25819;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"D.E.H.T.A. Enforcer - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,10,0,100,0,1,20,0,0,49,0,0,0,0,0,0,25,20,1,0,0,0,0,0,"D.E.H.T.A. Enforcer - Within 1-20 Range Out of Combat LoS - Start Attacking"),
(@ENTRY,0,2,0,4,0,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"D.E.H.T.A. Enforcer - On Aggro - Remove Flag Standstate Sit Down"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"D.E.H.T.A. Enforcer - On Reset - Set Flag Standstate Sit Down");

SET @ENTRY := 25809;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arch Druid Lathorius - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,83,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arch Druid Lathorius - On Aggro - Remove Npc Flags Gossip & Questgiver"),
(@ENTRY,0,2,0,10,0,100,0,1,20,0,0,49,0,0,0,0,0,0,25,20,1,0,0,0,0,0,"Arch Druid Lathorius - Within 1-20 Range Out of Combat LoS - Start Attacking"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Arch Druid Lathorius - On Reset - Set Npc Flags Gossip & Questgiver");

SET @ENTRY := 25811;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zaza - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zaza - On Aggro - Remove Npc Flag Questgiver"),
(@ENTRY,0,2,0,10,0,100,0,1,20,0,0,49,0,0,0,0,0,0,25,20,1,0,0,0,0,0,"Zaza - Within 1-20 Range Out of Combat LoS - Start Attacking"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zaza - On Reset - Set Npc Flag Questgiver");

SET @ENTRY := 25810;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Cenius - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Cenius - On Aggro - Remove Npc Flag Questgiver"),
(@ENTRY,0,2,0,10,0,100,0,1,20,0,0,49,0,0,0,0,0,0,25,20,1,0,0,0,0,0,"Hierophant Cenius - Within 1-20 Range Out of Combat LoS - Start Attacking"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Cenius - On Reset - Set Npc Flag Questgiver");

SET @ENTRY := 25812;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Killinger the Den Watcher - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Killinger the Den Watcher - On Aggro - Remove Npc Flag Questgiver"),
(@ENTRY,0,2,0,10,0,100,0,1,20,0,0,49,0,0,0,0,0,0,25,20,1,0,0,0,0,0,"Killinger the Den Watcher - Within 1-20 Range Out of Combat LoS - Start Attacking"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Killinger the Den Watcher - On Reset - Set Npc Flag Questgiver");

SET @ENTRY := 25838;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Liandra - On Aggro - Say Line 0"),
(@ENTRY,0,1,0,4,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Liandra - On Aggro - Remove Npc Flag Questgiver"),
(@ENTRY,0,2,0,10,0,100,0,1,25,0,0,49,0,0,0,0,0,0,25,25,1,0,0,0,0,0,"Hierophant Liandra - Within 1-25 Range Out of Combat LoS - Start Attacking"),
(@ENTRY,0,3,0,25,0,100,0,0,0,0,0,81,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Liandra - On Reset - Set Npc Flag Questgiver"),
(@ENTRY,0,4,0,4,0,100,0,0,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Liandra - On Aggro - Remove Flag Standstate Sit Down"),
(@ENTRY,0,5,0,25,0,100,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hierophant Liandra - On Reset - Set Flag Standstate Sit Down");

SET @ENTRY := 25839;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,60000,65000,11,5915,0,0,0,0,0,1,0,0,0,0,0,0,0,"Northsea Mercenary - In Combat - Cast 'Crazed'");

SET @ENTRY := 25844;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,60000,65000,11,5915,0,0,0,0,0,1,0,0,0,0,0,0,0,"Northsea Thug - In Combat - Cast 'Crazed'");--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
