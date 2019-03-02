-- DB update 2017_02_03_21 -> 2017_02_03_22
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_21';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_21 2017_02_03_22 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1485431926939955800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1485431926939955800');
-- Gothik the Harvester Entry 2 event
-- Scarlet Deserter
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` IN (130402,130403,130404,130405);
UPDATE `creature` SET `position_x` = 2817.77, `position_y` = -5453.906, `position_z` = 159.4021, `orientation` = 1.937315 WHERE `guid` = 130405;

-- Scarlet Deserter SAI
SET @GUID := -130405;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=29193;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@GUID AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GUID,0,0,0,25,0,100,0,0,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Scarlet Deserter - On Reset - Set Fly On");

-- Gothik the Harvester SAI
SET @ENTRY := 29112;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,2000,2000,640000,640000,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - Out of Combat - Run Script");

-- Actionlist SAI
SET @ENTRY := 2911200;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Set Active On"),
(@ENTRY,9,1,0,0,0,100,0,3000,3000,0,0,1,0,4000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 0"),
(@ENTRY,9,2,0,0,0,100,0,4000,4000,0,0,1,0,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,63000,63000,0,0,1,1,4000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 1"),
(@ENTRY,9,4,0,0,0,100,0,4000,4000,0,0,1,1,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 1"),
(@ENTRY,9,5,0,0,0,100,0,73000,73000,0,0,1,2,4000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 2"),
(@ENTRY,9,6,0,0,0,100,0,4000,4000,0,0,1,2,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 2"),
(@ENTRY,9,7,0,0,0,100,0,68000,68000,0,0,1,3,4000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 3"),
(@ENTRY,9,8,0,0,0,100,0,4000,4000,0,0,1,3,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 3"),
(@ENTRY,9,9,0,0,0,100,0,78000,78000,0,0,1,4,4000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 4"),
(@ENTRY,9,10,0,0,0,100,0,4000,4000,0,0,1,4,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 4"),
(@ENTRY,9,11,0,0,0,100,0,73000,73000,0,0,1,5,4000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 5"),
(@ENTRY,9,12,0,0,0,100,0,4000,4000,0,0,1,5,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 5"),
(@ENTRY,9,13,0,0,0,100,0,53000,53000,0,0,1,6,30000,0,0,0,0,10,130405,29193,0,0,0,0,0,"Gothik the Harvester - On Script - Say Line 6"),
(@ENTRY,9,14,0,0,0,100,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gothik the Harvester - On Script - Set Active Off");

DELETE FROM `creature_text` WHERE `entry` IN (29193, 29112);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `comment`) VALUES 
-- Scarlet Deserter
(29193, 0, 0, 'You\'re a monster!', 12, 0, 100, 0, 0, 0, 29644, 'Scarlet Deserter'),
(29193, 1, 0, 'Please! Spare me! I...', 12, 0, 100, 0, 0, 0, 29645, 'Scarlet Deserter'),
(29193, 2, 0, 'Wi... Will it hurt?', 12, 0, 100, 0, 0, 0, 29641, 'Scarlet Deserter'),
(29193, 3, 0, 'It tingles...', 12, 0, 100, 0, 0, 0, 29642, 'Scarlet Deserter'),
(29193, 4, 0, 'Why don\'t you Just Kill me Already', 12, 0, 100, 0, 0, 0, 0, 'Scarlet Deserter'),
(29193, 5, 0, 'Is it too late to change my mind? How about you just kill me instead?', 12, 0, 100, 0, 0, 0, 29643, 'Scarlet Deserter'),
(29193, 6, 0, 'The horror! THE HORROR!', 12, 0, 100, 0, 0, 0, 29646, 'Scarlet Deserter'),
-- Gothik the Harvester
(29112, 0, 0, 'Flattery will get you nowhere.', 12, 0, 100, 1, 0, 0, 29650, 'Gothik the Harvester'),
(29112, 1, 0, 'Don\'t be ridiculous. Where would you even go if I did spare you? We just finished eradicating your civilization, remember?', 12, 0, 100, 1, 0, 0, 29651, 'Gothik the Harvester'),
(29112, 2, 0, 'Oh yes. Immensely. The pain will propably render you unconcious - hence the vat of slime you\'re floating in!', 12, 0, 100, 1, 0, 0, 0, 'Gothik the Harvester'), 
(29112, 3, 0, 'That\'s how you know it\'s working.', 12, 0, 100, 1, 0, 0, 29648, 'Gothik the Harvester'),
(29112, 4, 0, 'You idiot! That\'s What I\'m Doing Right Now!', 12, 0, 100, 5, 0, 0, 0, 'Gothik the Harvester'),
(29112, 5, 0, 'I AM going to kill you. What\'s the rush?', 12, 0, 100, 6, 0, 0, 29649, 'Gothik the Harvester');--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
