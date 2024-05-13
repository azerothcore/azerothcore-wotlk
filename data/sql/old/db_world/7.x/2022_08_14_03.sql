-- DB update 2022_08_14_02 -> 2022_08_14_03
--
UPDATE `smart_scripts` SET `link`=2 WHERE `entryorguid` = 15323 AND `source_type` = 0 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15323 AND `source_type` = 0 AND `id` IN (2,3,4,5,6,7);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(15323,0,2,3,61,0,100,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hive'Zara Sandstalker - In Combat - Disable melee attack"),
(15323,0,3,0,61,0,100,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hive'Zara Sandstalker - In Combat - Set Phase 1"),
(15323,0,4,5,0,1,100,0,3000,6000,3000,6000,28,26381,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hive'Zara Sandstalker - IC - Remove Borrow"),
(15323,0,5,6,61,0,100,0,0,0,0,0,11,41390,0,0,0,0,0,2,0,0,0,0,0,0,0,"Hive'Zara Sandstalker - IC - Cast Ambush"),
(15323,0,6,7,61,0,100,0,0,0,0,0,20,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hive'Zara Sandstalker - In Combat - Enable melee attack"),
(15323,0,7,0,61,0,100,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Hive'Zara Sandstalker - In Combat - Set Phase 0");
