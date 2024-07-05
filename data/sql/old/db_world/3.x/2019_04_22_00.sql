-- DB update 2019_04_20_00 -> 2019_04_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_20_00 2019_04_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555597548140620700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555597548140620700');

-- Field Marshal Afrasiabi SAI
SET @ENTRY := 14721;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,20,0,100,0,7782,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Quest The Lord of Blackrock Finished - Run Script'),
(@ENTRY,0,1,0,61,0,100,0,7782,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Quest The Lord of Blackrock Finished - Store Targetlist');

-- Actionlist SAI
SET @ENTRY := 1472100;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Set Active On'), -- need NPC to be active in order to be able to despawn the GO even when no player is near
(@ENTRY,9,1,0,0,0,100,0,1000,1000,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Remove Npc Flag Questgiver'),
(@ENTRY,9,2,0,0,0,100,0,5000,5000,0,0,1,0,8000,0,0,0,0,12,1,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Say Line 0'),
(@ENTRY,9,3,0,0,0,100,0,8000,8000,0,0,1,1,10000,0,0,0,0,12,1,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Say Line 1'),
(@ENTRY,9,4,0,0,0,100,0,3000,3000,0,0,50,179882,7200,1,0,0,0,8,0,0,0,-8925.57,496.042,103.767,2.42801,'Field Marshal Afrasiabi - On Script - Summon Gameobject ''The Severed Head of Nefarian'' and despawn after 2 hours'),
(@ENTRY,9,5,0,0,0,100,0,1000,1000,0,0,9,0,0,0,0,0,0,20,179882,100,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Activate Gameobject ''The Severed Head of Nefarian'''),
(@ENTRY,9,6,0,0,0,100,0,6000,6000,0,0,11,22888,0,0,0,0,0,1,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Cast ''Rallying Cry of the Dragonslayer'''),
(@ENTRY,9,7,0,0,0,100,0,1000,1000,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Add Npc Flag Questgiver'),
(@ENTRY,9,8,0,0,0,100,0,7200000,7200000,0,0,41,0,0,0,0,0,0,14,0,179882,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Force Despawn Gameobject ''The Severed Head of Nefarian'''),
(@ENTRY,9,9,0,0,0,100,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Field Marshal Afrasiabi - On Script - Set Active Off');

DELETE FROM `creature_text` WHERE `creatureid` IN (14721);
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES 
(14721, 0, 0, 'Citizens of the Alliance, the Lord of Blackrock is slain! Nefarian has been subdued by the combined might of $N and $Ghis:her; allies!', 14, 0, 100, 0, 0, 0, 'Field Marshal Afrasiabi', 9870),
(14721, 1, 0, 'Let your spirits rise! Rally around your champion, bask in $Ghis:her; glory! Revel in the rallying cry of the dragon slayer!', 14, 0, 100, 0, 0, 0, 'Field Marshal Afrasiabi', 9872);

-- Overlord Runthak SAI
SET @ENTRY := 14392;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,20,0,100,0,7784,0,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Quest The Lord of Blackrock Finished - Run Script'),
(@ENTRY,0,1,2,61,0,100,0,7784,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Overlord Runthak - On Quest The Lord of Blackrock Finished - Store Targetlist');

-- Actionlist SAI
SET @ENTRY := 1439200;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Script - Set Active On'), -- need NPC to be active in order to be able to despawn the GO even when no player is near
(@ENTRY,9,1,0,0,0,100,0,1000,1000,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Script - Remove Npc Flag Questgiver'),
(@ENTRY,9,2,0,0,0,100,0,2000,2000,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Script - Set Run Off'),
(@ENTRY,9,3,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,1544,-4425.87,10.9056,3.323,'Overlord Runthak - On Script - Move To Position'),
(@ENTRY,9,4,0,0,0,100,0,14000,14000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0.6367,'Overlord Runthak - On Script - Set Orientation 0,6367'),
(@ENTRY,9,5,0,0,0,100,0,3000,3000,0,0,1,0,17000,0,0,0,0,12,1,0,0,0,0,0,0,'Overlord Runthak - On Script - Say Line 0'),
(@ENTRY,9,6,0,0,0,100,0,17000,17000,0,0,1,1,10000,0,0,0,0,12,1,0,0,0,0,0,0,'Overlord Runthak - On Script - Say Line 1'),
(@ENTRY,9,7,0,0,0,100,0,3000,3000,0,0,50,179881,7200,0,0,0,0,8,0,0,0,1540.28,-4422.19,7.0051,5.22833,'Overlord Runthak - On Script - Summon Gameobject ''The Severed Head of Nefarian'' and despawn after 2 hours'),
(@ENTRY,9,8,0,0,0,100,0,5000,5000,0,0,9,0,0,0,0,0,0,20,179881,100,0,0,0,0,0,'Overlord Runthak - On Script - Activate Gameobject ''The Severed Head of Nefarian'''),
(@ENTRY,9,9,0,0,0,100,0,5000,5000,0,0,11,22888,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Script - Cast ''Rallying Cry of the Dragonslayer'''),
(@ENTRY,9,10,0,0,0,100,0,10000,10000,0,0,69,0,0,0,0,0,0,8,0,0,0,1568,-4405.87,8.13371,0.3434,'Overlord Runthak - On Script - Move To Position'),
(@ENTRY,9,11,0,0,0,100,0,15000,15000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.31613,'Overlord Runthak - On Script - Set Orientation 3,31613'),
(@ENTRY,9,12,0,0,0,100,0,1000,1000,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Script - Add Npc Flag Questgiver'),
(@ENTRY,9,13,0,0,0,100,0,7200000,7200000,0,0,41,0,0,0,0,0,0,14,0,179881,0,0,0,0,0,'Overlord Runthak - On Script - Force Despawn Gameobject ''The Severed Head of Nefarian'''),
(@ENTRY,9,14,0,0,0,100,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Overlord Runthak - On Script - Set Active Off');

DELETE FROM `creature_text` WHERE `creatureid` IN (14392);
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES 
(14392, 0, 0, 'NEFARIAN IS SLAIN! people of Orgrimmar, bow down before the might of $N and his allies for they have laid a blow against the Black Dragonflight that is sure to stir the Aspects from their malaise! This defeat shall surely be felt by the father of the Black Flight: Deathwing reels in pain and anguish this day!', 14, 0, 100, 0, 0, 0, 'Overlord Runthak', 9867),
(14392, 1, 0, 'Be lifted by $N accomplishment! Revel in his rallying cry!', 14, 0, 100, 0, 0, 0, 'Overlord Runthak', 9868);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
