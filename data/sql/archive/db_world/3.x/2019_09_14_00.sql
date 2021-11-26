-- DB update 2019_09_10_00 -> 2019_09_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_10_00 2019_09_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567460303929588791'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567460303929588791');

-- Bath'rah the Windwatcher SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 6176 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (617601,617600) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(6176,0,0,0,19,0,100,0,1713,0,0,0,0,80,617600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Quest ''The Summoning'' Taken - Run Script'),
(6176,0,1,2,40,0,100,0,6,6176,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On WP 6 Reached - Set Run Off'),
(6176,0,2,0,61,0,100,0,0,0,0,0,0,54,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - Linked - Pause Waypoint Movement'),
(6176,0,3,0,40,0,100,0,7,6176,0,0,0,80,617601,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On WP 7 Reached - Run Script'),
(6176,0,4,0,40,0,100,0,7,61760,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.39626,'Bath''rah the Windwatcher - On WP 7 Reached - Set Orientation'),

(617600,9,0,0,0,0,100,0,1000,1000,0,0,0,53,1,6176,0,0,0,2,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Script - Start Waypoint'),
(617600,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Script - Say Line 0'),

(617601,9,0,0,0,0,100,0,1000,1000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,6.09042,'Bath''rah the Windwatcher - On Script - Set Orientation'),
(617601,9,1,0,0,0,100,0,1000,1000,0,0,0,5,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Script - Play Emote ''ONESHOT_BOW'''),
(617601,9,2,0,0,0,100,0,2500,2500,0,0,0,11,8606,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Script - Cast ''Summon Cyclonian'''),
(617601,9,3,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Script - Say Line 1'),
(617601,9,4,0,0,0,100,0,15000,15000,0,0,0,53,1,61760,0,0,0,2,1,0,0,0,0,0,0,0,0,'Bath''rah the Windwatcher - On Script - Start Waypoint');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
