-- DB update 2022_08_21_00 -> 2022_08_21_01
--
UPDATE `creature_template` SET `ScriptName`='npc_general_andorov' WHERE `entry`=15471;
UPDATE `creature_template` SET `npcflag`=129, `speed_walk`=1.4, `speed_run`=1.4, `gossip_menu_id`=7048, `type_flags`=`type_flags`|0x08000000 WHERE  `entry`=15471;
UPDATE `creature_template` SET `speed_walk`=1.4, `speed_run`=1.4 WHERE `entry`=15473;

DELETE FROM `script_waypoint` WHERE `entry`=15471;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES
(15471,0,-8623.171,1470.4077,32.006413,0,'Andorov'),
(15471,1,-8657.297,1506.1847,32.586697,0,'Andorov'),
(15471,2,-8679.187,1535.1178,31.96736,0,'Andorov'),
(15471,3,-8701.477,1561.7574,32.17472,0,'Andorov'),
(15471,4,-8720.072,1580.9626,21.511324,0,'Andorov'),
(15471,5,-8746.162,1603.494,21.613367,0,'Andorov'),
(15471,6,-8780.431,1617.8787,21.455776,0,'Andorov'),
(15471,7,-8823.478,1624.6688,19.80574,0,'Andorov'),
(15471,8,-8855.329,1637.9473,19.790516,0,'Andorov'),
(15471,9,-8870.721,1648.4009,21.511328,0,'Andorov'),
(15471,10,-8870.721,1648.4009,21.511328,0,'Andorov'),
(15471,11,-8886.095,1598.713,21.4053,0,'Andorov'),
(15471,12,-8904.383,1578.6167,21.511332,0,'Andorov'),
(15471,13,-8920.576,1551.9479,21.407932,0,'Andorov'),
(15471,14,-8939.951,1551.127,21.566868,0,'Andorov');

DELETE FROM `gossip_menu_option` WHERE `menuid`=7048;
INSERT INTO `gossip_menu_option` (`menuid`, `optionId`, `optionicon`, `optiontext`, `optiontype`, `optionnpcflag`, `actionmenuid`, `actionpoiid`, `boxcoded`, `boxmoney`, `boxtext`) VALUES 
(7048, 0, 1, 'Let me see your goods', 3, 128, 0, 0, 0, 0, ''), -- 15471
(7048, 1, 0, 'Let\'s find out.', 1, 1, 0, 0, 0, 0, '');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup`=7048;
INSERT INTO `conditions` VALUES
(14,7048,7883,0,0,13,0,1,3,2,1,0,0,'','Show gossip option if Rajaxx is not done'),
(14,7048,8304,0,0,13,0,1,3,2,0,0,0,'','Show gossip option if Rajaxx is not done'),
(14,7048,8305,0,0,13,0,1,3,2,0,0,0,'','Show gossip option if Rajaxx is done'),
(15,7048,0,0,0,13,0,1,3,2,0,0,0,'','Show gossip option if Rajaxx is done'),
(15,7048,1,0,0,13,0,1,3,2,1,0,0,'','Show gossip option if Rajaxx is not done');

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
