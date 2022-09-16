-- DB update 2019_04_07_00 -> 2019_04_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_07_00 2019_04_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1554420147566038300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554420147566038300');

-- Gelkis Windchaser SAI
SET @ENTRY := 4649;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,500,1000,3000,4500,11,9532,32,0,0,0,0,2,0,0,0,0,0,0,0,'Gelkis Windchaser - In Combat - Cast \'Lightning Bolt\''),
(@ENTRY,0,1,0,2,0,100,0,10,35,15000,20000,11,959,32,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Windchaser - Between 10-35% Health - Cast \'Healing Wave\''),
(@ENTRY,0,2,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Windchaser - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Gelkis Stamper SAI
SET @ENTRY := 4648;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,0,1,10,3500,5000,11,5568,0,0,0,0,0,2,0,0,0,0,0,0,0,'Gelkis Stamper - Within 1-10 Range - Cast \'Trample\''),
(@ENTRY,0,1,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Stamper - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Gelkis Scout SAI
SET @ENTRY := 4647;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,0,5,30,2000,2500,11,6660,32,0,0,0,0,2,0,0,0,0,0,0,0,'Gelkis Scout - Within 5-30 Range - Cast \'Shoot\''),
(@ENTRY,0,1,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Scout - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Gelkis Outrunner SAI
SET @ENTRY := 4646;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Outrunner - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Gelkis Mauler SAI
SET @ENTRY := 4652;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Mauler - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Gelkis Earthcaller SAI
SET @ENTRY := 4651;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,1000,3000,3500,11,20815,32,0,0,0,0,2,0,0,0,0,0,0,0,'Gelkis Earthcaller - In Combat - Cast \'Fireball\''),
(@ENTRY,0,1,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Earthcaller - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Gelkis Marauder SAI
SET @ENTRY := 4653;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,2000,5000,5000,11,7366,32,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Marauder - Out of Combat - Cast \'Berserker Stance\''),
(@ENTRY,0,1,0,0,0,100,0,0,1500,5000,5000,11,7366,32,0,0,0,0,1,0,0,0,0,0,0,0,'Gelkis Marauder - In Combat - Cast \'Berserker Stance\''),
(@ENTRY,0,2,0,0,0,100,0,2500,4000,3500,4500,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,'Gelkis Marauder - In Combat - Cast \'Cleave\'');

-- Magram Marauder SAI
SET @ENTRY := 4644;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,1000,2000,5000,5000,11,7366,32,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Marauder - Out of Combat - Cast \'Berserker Stance\''),
(@ENTRY,0,1,0,0,0,100,0,0,1500,5000,5000,11,7366,32,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Marauder - In Combat - Cast \'Berserker Stance\''),
(@ENTRY,0,2,0,0,0,100,0,2500,4000,3500,4500,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,'Magram Marauder - In Combat - Cast \'Cleave\'');

-- Magram Mauler SAI
SET @ENTRY := 4645;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Mauler - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Magram Outrunner SAI
SET @ENTRY := 4639;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Outrunner - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Magram Pack Runner SAI
SET @ENTRY := 4643;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Pack Runner - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Magram Scout SAI
SET @ENTRY := 4638;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,9,0,100,0,5,30,2000,2500,11,6660,32,0,0,0,0,2,0,0,0,0,0,0,0,'Magram Scout - Within 5-30 Range - Cast \'Shoot\''),
(@ENTRY,0,1,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Scout - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Magram Stormer SAI
SET @ENTRY := 4642;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,0,2000,5000,5000,11,8788,32,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Stormer - Out of Combat - Cast \'Lightning Shield\''),
(@ENTRY,0,1,0,0,0,100,0,0,1000,5000,5000,11,8788,32,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Stormer - In Combat - Cast \'Lightning Shield\''),
(@ENTRY,0,2,0,0,0,100,0,0,2500,7000,10000,11,6535,0,0,0,0,0,2,0,0,0,0,0,0,0,'Magram Stormer - In Combat - Cast \'Lightning Cloud\''),
(@ENTRY,0,3,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Stormer - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Magram Windchaser SAI
SET @ENTRY := 4641;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,500,1000,3000,4500,11,9532,32,0,0,0,0,2,0,0,0,0,0,0,0,'Magram Windchaser - In Combat - Cast \'Lightning Bolt\''),
(@ENTRY,0,1,0,2,0,100,0,10,35,15000,20000,11,959,32,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Windchaser - Between 10-35% Health - Cast \'Healing Wave\''),
(@ENTRY,0,2,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Windchaser - Between 1-10% Health - Flee For Assist (No Repeat)');

-- Magram Wrangler SAI
SET @ENTRY := 4640;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,1000,4500,15000,20000,11,6533,32,0,0,0,0,2,0,0,0,0,0,0,0,'Magram Wrangler - In Combat - Cast \'Net\''),
(@ENTRY,0,1,0,2,0,100,1,1,10,0,0,25,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Magram Wrangler - Between 1-10% Health - Flee For Assist (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
