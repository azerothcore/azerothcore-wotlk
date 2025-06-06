-- DB update 2023_09_17_12 -> 2023_09_17_13
SET @ENTRY := 17433;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,20,0,100,0,9567,0,0,0,80,@ENTRY*100,2,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Quest \'Know Thine Enemy\' Finished - Run Script'),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Vindicator Aalesia - On Quest \'Know Thine Enemy\' Finished - Store Targetlist');

-- Actionlist SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY*100 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Remove Npc Flag Questgiver'),
(@ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,17,69,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Set Emote State 69'),
(@ENTRY*100,9,2,0,0,0,100,0,4000,4000,0,0,17,26,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Set Emote State 26'),
(@ENTRY*100,9,3,0,0,0,100,0,0,0,0,0,1,0,4000,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Say Line 0'),
(@ENTRY*100,9,4,0,0,0,100,0,4000,4000,0,0,1,1,4000,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Say Line 1'),
(@ENTRY*100,9,5,0,0,0,100,0,4000,4000,0,0,1,2,2000,0,0,0,0,12,1,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Say Line 2'),
(@ENTRY*100,9,6,0,0,0,100,0,2000,2000,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Vindicator Aalesia - On Script - Add Npc Flag Questgiver');

UPDATE `creature_text` SET `Text`='No, this can\'t be... It says this creature willingly became a servant of the Legion. He transforms into a satyr and receives the Legion\'s "blessing."' WHERE `CreatureID`=@ENTRY AND `GroupID` = 2;
