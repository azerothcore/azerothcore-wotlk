INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635441257434103531');

-- Add SAI to Rousch
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=16090;
DELETE FROM `smart_scripts` WHERE `entryorguid`=16090 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1609000 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16090,0,0,0,1,0,100,0,0,0,28000,28000,0,80,1609000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rousch - OOC - Run ActionList'),
(1609000,9,0,0,0,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rousch - OOC - Kneel'),
(1609000,9,1,0,0,0,100,0,20000,20000,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rousch - OOC - Stand'),
(1609000,9,2,0,0,0,100,0,2000,2000,0,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Rousch - OOC - Salute');
