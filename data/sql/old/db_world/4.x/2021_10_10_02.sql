-- DB update 2021_10_10_01 -> 2021_10_10_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_01 2021_10_10_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633025172920876389'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633025172920876389');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (68) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(68,0,1,0,22,0,100,0,101,5000,5000,0,80,6800,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Wave' - Run Script"),
(68,0,2,0,22,0,100,0,78,5000,5000,0,80,6801,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Salute' - Run Script"),
(68,0,3,0,22,0,100,0,58,5000,5000,0,80,6802,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Kiss' - Run Script"),
(68,0,4,0,22,0,100,0,84,5000,5000,0,80,6803,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Shy' - Run Script"),
(68,0,5,0,22,0,100,0,77,5000,5000,0,80,6804,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Rude' - Run Script"),
(68,0,7,0,22,0,100,0,17,5000,5000,0,80,6802,0,0,0,0,0,1,0,0,0,0,0,0,0,"Ironforge Guard - On Received Emote 'Bow' - Run Script");
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=68;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (6800,6801,6802,6803,6804) AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6800,9,0,0,0,0,100,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted On"),
(6800,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6800,9,2,0,0,0,100,0,2000,2000,0,0,5,3,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Play Emote 'Wave'"),
(6800,9,3,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6800,9,4,0,0,0,100,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted Off"),
(6801,9,0,0,0,0,100,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted On"),
(6801,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6801,9,2,0,0,0,100,0,2000,2000,0,0,5,66,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Play Emote 'Salute'"),
(6801,9,3,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6801,9,4,0,0,0,100,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted Off"),
(6802,9,0,0,0,0,100,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted On"),
(6802,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6802,9,2,0,0,0,100,0,2000,2000,0,0,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Play Emote 'Bow'"),
(6802,9,3,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6802,9,4,0,0,0,100,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted Off"),
(6803,9,0,0,0,0,100,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted On"),
(6803,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6803,9,2,0,0,0,100,0,2000,2000,0,0,5,23,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Play Emote 'Flex'"),
(6803,9,3,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6803,9,4,0,0,0,100,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted Off"),
(6804,9,0,0,0,0,100,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted On"),
(6804,9,1,0,0,0,100,0,0,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6804,9,2,0,0,0,100,0,2000,2000,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Play Emote 'Point'"),
(6804,9,3,0,0,0,100,0,4000,4000,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Orientation"),
(6804,9,4,0,0,0,100,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Stormwind City Guard - On Script - Set Rooted Off");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_02' WHERE sql_rev = '1633025172920876389';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
