-- DB update 2022_05_06_01 -> 2022_05_06_02
-- Quest 1452 "Rhapsody's Kalimdor Kocktail" turn in script

-- Rhapsody Shindigger SAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=5634;
DELETE FROM `smart_scripts` WHERE `entryorguid`=5634 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=56340 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(5634,0,0,0,1,0,100,0,180000,210000,180000,210000,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - OOC - Say text 3'),
(5634,0,1,0,1,0,100,0,160000,220000,160000,220000,0,5,92,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - OOC - Emote Drink'),
(5634,0,2,0,20,0,100,0,1452,0,0,0,0,80,56340,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - On Quest Reward - Run Script'),
(56340,9,0,0,0,0,100,0,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Remove questgiver flag'),
(56340,9,1,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Say text 0'),
(56340,9,2,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set run off'),
(56340,9,3,0,0,0,100,0,4000,4000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,219.01102,-2614.0579,160.5317,0,'Rhapsody Shindigger - Script - Move to'),
(56340,9,4,0,0,0,100,0,2000,2000,0,0,0,17,133,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set emotestate'),
(56340,9,5,0,0,0,100,0,6000,6000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set emotestate'),
(56340,9,6,0,0,0,100,0,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,221.79509,-2613.766,160.41942,0,'Rhapsody Shindigger - Script - Move to'),
(56340,9,7,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Say text 1'),
(56340,9,8,0,0,0,100,0,2000,2000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Say text 2'),
(56340,9,9,0,0,0,100,0,4000,4000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,223.71512,-2609.9314,160.19234,0,'Rhapsody Shindigger - Script - Move to'),
(56340,9,10,0,0,0,100,0,0,0,0,0,0,17,93,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set emotestate'),
(56340,9,11,0,0,0,100,0,3000,3000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set emotestate'),
(56340,9,12,0,0,0,100,0,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set standstate'),
(56340,9,13,0,0,0,100,0,0,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Say text 4'),
(56340,9,14,0,0,0,100,0,5000,5000,0,0,0,17,93,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set emotestate'),
(56340,9,15,0,0,0,100,0,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Set standstate'),
(56340,9,16,0,0,0,100,0,1000,1000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,219.59831,-2612.208,160.44882,0,'Rhapsody Shindigger - Script - Move to'),
(56340,9,17,0,0,0,100,0,4000,4000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.151917,'Rhapsody Shindigger - Script - Set Orientation'),
(56340,9,18,0,0,0,100,0,1000,1000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Say text 5'),
(56340,9,19,0,0,0,100,0,3000,3000,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Add questgiver flag'),
(56340,9,20,0,0,0,100,0,1000,1000,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rhapsody Shindigger - Script - Say text 6');

-- Fix emotes in Rhapsody Shindigger creature text
UPDATE `creature_text` SET `Emote`=0 WHERE `CreatureID`=5634 AND `GroupID` IN (0,3,4,6);
UPDATE `creature_text` SET `Emote`=92 WHERE `CreatureID`=5634 AND `GroupID` IN (5);
