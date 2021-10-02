-- DB update 2021_05_13_01 -> 2021_05_13_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_13_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_13_01 2021_05_13_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620437148392158200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620437148392158200');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=23941;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 23941 AND `source_type`= 0;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 2394100 AND `source_type`= 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23941,0,0,0,2,0,100,1,0,15,0,0,11,42660,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - Between 0-15% Health - Cast 'Gavis Greyshield Credit' (No Repeat)"),
(23941,0,1,2,2,0,100,1,0,15,0,0,80,2394100,2,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - Between 0-15% Health - Run Script (No Repeat)"),
(23941,0,2,3,61,0,100,1,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - Between 0-15% Health - Set Faction 35"),
(23941,0,3,4,61,0,100,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - Between 0-15% Health - Evade"),
(23941,0,4,0,61,0,100,1,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - Between 0-15% Health - Set Root On"),
(2394100,9,0,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - On Script - Say Line 0"),
(2394100,9,1,0,0,0,100,0,4000,4000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - On Script - Say Line 1"),
(2394100,9,2,0,0,0,100,0,10000,10000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Gavis Greyshield - On Script - Despawn");


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
