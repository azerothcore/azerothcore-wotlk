-- DB update 2022_09_28_07 -> 2022_09_28_08
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15252 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15252,0,0,0,11,0,100,256,0,0,0,0,211,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Champion - On Respawn - Set not phase reset"),
(15252,0,1,0,0,0,100,0,500,500,6000,15000,11,40504,0,0,0,0,0,2,0,0,0,0,0,0,0,"Qiraji Champion - In Combat - Cast 'Cleave'"),
(15252,0,2,0,0,0,100,0,20000,40000,20000,40000,11,19134,0,0,0,0,0,2,0,0,0,0,0,0,0,"Qiraji Champion - In Combat - Cast 'Frightening Shout'"),
(15252,0,3,0,0,0,100,0,7500,12500,10000,20000,11,11130,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Champion - In Combat - Cast 'Knock Away'"),
(15252,0,4,5,38,0,100,0,0,1,0,0,11,25164,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Champion - On Data Set 0 1 - Cast 'Vengeance'"),
(15252,0,5,6,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Champion - On Link - Say Line 0"),
(15252,0,6,0,61,0,100,256,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Champion - On Link - Set Phase 1"),
(15252,0,7,0,0,1,100,0,60000,60000,60000,60000,11,25164,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Champion - IC - Cast 'Vengeance' (Phase 1)");

DELETE FROM `creature_text` WHERE `CreatureID`=15252;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15252,0,0,'%s becomes enraged!',16,0,100,0,0,0,24144,0,'Qiraji Champion');
