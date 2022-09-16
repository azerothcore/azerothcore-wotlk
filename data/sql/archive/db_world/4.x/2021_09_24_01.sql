-- DB update 2021_09_24_00 -> 2021_09_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_24_00 2021_09_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632228638474923220'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632228638474923220');

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=12803;
DELETE FROM `smart_scripts` WHERE `entryorguid`=12803 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12803,0,0,0,1,0,100,0,500,1000,600000,600000,11,20545,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Lakmaeran - Out of Combat - Cast Lightning Shield"),
(12803,0,1,0,16,0,100,0,20545,1,15000,30000,11,20545,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Lakmaeran - On Friendly Unit Missing Buff 'Lightning Shield' - Cast Lightning Shield"),
(12803,0,2,0,0,0,100,0,3000,5000,12000,16000,11,20543,0,0,0,0,0,2,0,0,0,0,0,0,0,"Lord Lakmaeran - In Combat - Cast Lightning Breath"),
(12803,0,3,0,0,0,100,0,6000,12000,19000,21000,11,20542,0,0,0,0,0,5,0,0,0,0,0,0,0,"Lord Lakmaeran - In Combat - Cast Static Conduit"),
(12803,0,4,0,2,0,100,1,0,20,0,0,11,8269,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Lakmaeran - Between 0-20% Health - Cast Frenzy (No Repeat)"),
(12803,0,5,0,2,0,100,1,0,20,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Lord Lakmaeran - Between 0-20% Health - Say Line 0 (No Repeat)");

DELETE FROM `creature_text` WHERE `CreatureID`=12803;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12803,0,0,"%s goes into a frenzy!",16,0,100,0,0,0,10645,0,"Lord Lakmaeran");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_24_01' WHERE sql_rev = '1632228638474923220';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
