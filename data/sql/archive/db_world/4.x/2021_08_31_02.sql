-- DB update 2021_08_31_01 -> 2021_08_31_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_31_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_31_01 2021_08_31_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629918244800506403'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629918244800506403');

-- Add scripting to Wait for Sirra to Finish quest
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= 268;

DELETE FROM `smart_scripts` WHERE `entryorguid`= 268 AND `source_type`= 0;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 26800 AND `source_type`= 9;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(268,0,0,0,19,0,100,0,401,0,0,0,80,26800,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sirra Von'Indi - On Quest 'Wait for Sirra to Finish' Taken - Run Script"),
(26800,9,0,0,0,0,100,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sirra Von'Indi - On Script - Remove Questgiver npcflag"),
(26800,9,1,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Sirra Von'Indi - On Script - Say Line 0"),
(26800,9,2,0,0,0,100,0,0,0,0,0,17,69,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sirra Von'Indi - On Script - Set Emote State 69"),
(26800,9,3,0,0,0,100,0,5000,5000,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sirra Von'Indi - On Script - Set Emote State 0"),
(26800,9,4,0,0,0,100,0,0,0,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,"Sirra Von'Indi - On Script - Say Line 1"),
(26800,9,5,0,0,0,100,0,0,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sirra Von'Indi - On Script - Add Questgiver npcflag");


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_31_02' WHERE sql_rev = '1629918244800506403';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
