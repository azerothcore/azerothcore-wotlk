-- DB update 2022_08_14_01 -> 2022_08_14_02
--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15324 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15324,0,0,0,11,0,100,256,0,0,0,0,211,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Gladiator - On Respawn - Set not phase reset"),
(15324,0,1,0,0,0,100,0,5400,8500,6000,17000,11,5568,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Gladiator - In Combat - Cast 'Trample'"),
(15324,0,2,0,0,0,100,0,8500,13000,8000,16000,11,10966,0,0,0,0,0,2,0,0,0,0,0,0,0,"Qiraji Gladiator - In Combat - Cast 'Uppercut'"),
(15324,0,3,4,38,0,100,0,0,1,0,0,11,25164,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Gladiator - On Data Set 0 1 - Cast 'Vengeance'"),
(15324,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Gladiator - On Link - Say Line 0"),
(15324,0,5,0,61,0,100,256,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Gladiator - On Link - Set Phase 1"),
(15324,0,6,0,6,0,100,0,0,0,0,0,45,0,1,0,0,0,0,19,15324,30,0,0,0,0,0,"Qiraji Gladiator - On Death - Set Data 0 1"),
(15324,0,7,0,0,1,100,0,60000,60000,60000,60000,11,25164,0,0,0,0,0,1,0,0,0,0,0,0,0,"Qiraji Gladiator - IC - Cast 'Vengeance' (Phase 1)");

DELETE FROM `creature_text` WHERE `CreatureID`=15324;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15324,0,0,'%s becomes enraged!',16,0,100,0,0,0,24144,0,'Qiraji Gladiator');
