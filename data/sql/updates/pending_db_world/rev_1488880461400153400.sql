INSERT INTO version_db_world (`sql_rev`) VALUES ('1488880461400153400');
DELETE FROM `creature_addon` WHERE `guid` = 114140;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(114140, 0, 0, 0, 1, 0, ''); -- 28097 - 51344 - 51344

-- Pitch SAI
SET @ENTRY := 28097;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,512,5,30,9000,12000,11,54487,2,0,0,0,0,2,0,0,0,0,0,0,0,"Pitch - Within 5-30 Range - Cast 'Jump Attack' (No Repeat)"),
(@ENTRY,0,1,0,0,0,100,512,5000,8000,7000,13000,11,24332,2,0,0,0,0,2,0,0,0,0,0,0,0,"Pitch - In Combat - Cast 'Rake' (No Repeat)"),
(@ENTRY,0,2,0,11,0,100,512,0,0,0,0,45,1,1,0,0,0,0,9,28095,0,200,0,0,0,0,"Pitch - On Respawn - Set Data 1 1 (No Repeat)"),
(@ENTRY,0,3,0,6,0,100,512,0,0,0,0,45,1,2,0,0,0,0,9,28095,0,200,0,0,0,0,"Pitch - On Just Died - Set Data 1 2 (No Repeat)"),
(@ENTRY,0,4,0,4,0,100,512,0,0,0,0,45,1,3,0,0,0,0,9,28095,0,200,0,0,0,0,"Pitch - On Aggro - Set Data 1 3 (No Repeat)"),
(@ENTRY,0,5,0,7,0,100,512,0,0,0,0,45,1,4,0,0,0,0,9,28095,0,200,0,0,0,0,"Pitch - On Evade - Set Data 1 4 (No Repeat)"),
(@ENTRY,0,6,0,1,0,100,0,1000,1000,8000,8000,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Pitch - Out of Combat - Play Emote 35");




