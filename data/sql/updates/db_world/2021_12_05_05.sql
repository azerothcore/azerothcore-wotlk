-- DB update 2021_12_05_04 -> 2021_12_05_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_05_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_05_04 2021_12_05_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638112959691757857'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638112959691757857');

-- Fix up npc Elder Torntusk
DELETE FROM `gossip_menu` WHERE `MenuID`=6102;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES(6102,7257);
UPDATE `creature_template` SET `gossip_menu_id`=6102, `unit_flags`=33280, `flags_extra`=66, `AIName`='SmartAI' WHERE `entry`=14757;
DELETE FROM `smart_scripts` WHERE `entryorguid`=14757 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1475700 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14757,0,0,0,20,0,100,0,7846,0,0,0,0,80,1475700,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Quest Recover the Key! Finished - Run Script'),
(14757,0,1,0,4,0,100,0,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Aggro - Remove Flag Standstate Dead'),
(1475700,9,0,0,0,0,100,0,0,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Script - Remove Flag Standstate Dead'),
(1475700,9,1,0,0,0,100,0,0,0,0,0,0,83,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Script - Remove Npc Flag Gossip'),
(1475700,9,2,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Script - Say Line 0'),
(1475700,9,3,0,0,0,100,0,60000,60000,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Script - Set Flag Standstate Dead'),
(1475700,9,4,0,0,0,100,0,0,0,0,0,0,82,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Elder Torntusk - On Script - Add Npc Flag Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_05_05' WHERE sql_rev = '1638112959691757857';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
