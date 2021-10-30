-- DB update 2021_10_10_06 -> 2021_10_10_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_06 2021_10_10_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633110270390665427'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633110270390665427');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (5595) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5595,0,1,0,22,0,100,0,101,5000,5000,0,80,6800,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Wave' - Run Script"),
(5595,0,2,0,22,0,100,0,78,5000,5000,0,80,6801,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Salute' - Run Script"),
(5595,0,3,0,22,0,100,0,58,5000,5000,0,80,6802,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Kiss' - Run Script"),
(5595,0,4,0,22,0,100,0,84,5000,5000,0,80,6803,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Shy' - Run Script"),
(5595,0,5,0,22,0,100,0,77,5000,5000,0,80,6804,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Rude' - Run Script"),
(5595,0,7,0,22,0,100,0,17,5000,5000,0,80,6802,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Bow' - Run Script");
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=5595;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_07' WHERE sql_rev = '1633110270390665427';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
