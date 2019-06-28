INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561636568439132700');

-- Caverndeep Burrower SAI
SET @ENTRY := 6206;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,5000,9000,13000,11,1604,0,0,0,0,0,2,0,0,0,0,0,0,0,'Caverndeep Burrower - In Combat - Cast Dazed'),
(@ENTRY,0,1,0,0,0,100,0,2000,4000,4000,6000,11,9770,64,0,0,0,0,2,0,0,0,0,0,0,0,'Caverndeep Burrower - In Combat CMC - Cast Radiation'),
(@ENTRY,0,2,0,0,0,100,0,6000,7000,4000,8000,11,16145,0,0,0,0,0,2,0,0,0,0,0,0,0,'Caverndeep Burrower - In Combat - Cast Sunder Armor'),
(@ENTRY,0,3,0,2,0,100,1,0,15,0,0,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Caverndeep Burrower - Between 0-15% Health - Flee For Assist No Repeat');

-- Caverndeep Reaver SAI
SET @ENTRY := 6211;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,1,0,0,0,0,11,7366,2,0,0,0,0,1,0,0,0,0,0,0,0,'Caverndeep Reaver - On Aggro - Cast Berserker Stance (No Repeat)'),
(@ENTRY,0,1,0,0,0,100,0,2000,6000,5000,8000,11,8374,2,0,0,0,0,2,0,0,0,0,0,0,0,'Caverndeep Reaver - In Combat - Cast Arcing Smash'),
(@ENTRY,0,2,0,0,0,100,0,4000,4000,4000,4000,11,845,2,0,0,0,0,2,0,0,0,0,0,0,0,'Caverndeep Reaver - In Combat - Cast Cleave');

-- Scarlet Abbot
UPDATE `creature_text` SET `GroupID` = 1 WHERE `CreatureID` = 4303 AND `GroupID` = 0 AND `ID` = 0;

-- Blackwood Ursa SAI
SET @ENTRY := 2170;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE `creature_template` SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,14,0,100,0,200,40,18000,21000,11,1058,0,0,0,0,0,7,0,0,0,0.0,0.0,0.0,0.0,'Blackwood Ursa - Friendly At 200 Health - Cast Rejuvenation');

-- "Scarlet Peasant" and "Citizen of Havenshire" have to use target "self" for their "talk" actions
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `action_type` = 1 AND `target_type` = 7 AND `source_type` = 0 AND `entryorguid` IN (28576,28577,28557);

-- "Scarlet Medic" has to use target "self" for the "talk" action
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `action_type` = 1 AND `target_type` = 2 AND `source_type` = 0 AND `entryorguid` = 28608;
