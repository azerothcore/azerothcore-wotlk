--
UPDATE `creature_template` SET `ScriptName`='npc_general_andorov' WHERE `entry`=15471;
UPDATE `creature_template` SET `npcflag`=129, `speed_walk`=1.4, `speed_run`=1.4, `gossip_menu_id`=7047, `type_flags`=`type_flags`|0x08000000 WHERE  `entry`=15471;

DELETE FROM `script_waypoint` WHERE `entry`=15471;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES 
(15471, 0, -8876.79, 1634.59, 21.3864, 0, 'Andorov'),
(15471, 1, -8877.69, 1627.65, 21.3864, 0, 'Andorov'),
(15471, 2, -8884.18, 1606.13, 21.3864, 0, 'Andorov'),
(15471, 3, -8892.82, 1591.76, 21.3864, 0, 'Andorov'),
(15471, 4, -8905.6, 1575.1, 21.387, 0, 'Andorov'),
(15471, 5, -8914.31, 1564.14, 21.387, 0, 'Andorov'),
(15471, 6, -8928.91, 1551.86, 21.387, 0, 'Andorov'),
(15471, 7, -8937.75, 1551.09, 21.388, 0, 'Andorov'),
(15471, 8, -8941.71, 1550.75, 21.7797, 90000000, 'Andorov');

DELETE FROM `gossip_menu_option` WHERE `menuid`=7047;
INSERT INTO `gossip_menu_option` (`menuid`, `optionId`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES 
(7047, 0, 1, 'Let me see your goods', 3, 128, 0, 0, 0, 0, ''), -- 15471
(7047, 1, 1, 'I would be happy to support you in the fight!', 1, 1, 0, 0, 0, 0, '');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=7047;
INSERT INTO `conditions` VALUES
(15,7047,0,0,0,13,0,1,3,2,0,0,0,'','Show gossip option if Rajaxx is done'),
(15,7047,1,0,0,13,0,1,3,2,1,0,0,'','Show gossip option if Rajaxx is not done');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=15471;
INSERT INTO `conditions` VALUES
(23,15471,0,0,0,13,0,1,3,2,0,0,0,'','Show vendor npc flag option if Rajaxx is done');

-- Kaldorei Elite SAI
SET @ENTRY := 15473;
UPDATE `creature_template` SET `ScriptName`='', `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,6000,9000,6000,9000,11,26350,0,0,0,0,0,2,0,0,0,0,0,0,0,"Kaldorei Elite - In Combat - Cast 'Cleave'"),
(@ENTRY,0,1,0,0,0,100,0,9000,13000,9000,13000,11,16856,0,0,0,0,0,2,0,0,0,0,0,0,0,"Kaldorei Elite - In Combat - Cast 'Mortal Strike'");

