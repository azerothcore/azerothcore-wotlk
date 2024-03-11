-- DB update 2021_01_07_00 -> 2021_01_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_07_00 2021_01_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1609803806703890000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609803806703890000');

-- add initial delay of half a second to In Combat - Cast 'Lightning Shield' + add comments to all rows
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17982);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17982, 0, 0, 0, 19, 0, 100, 0, 9759, 0, 0, 0, 0, 53, 1, 17982, 0, 0, 0, 2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Quest \'Ending Their World\' Taken - Start Waypoint'),
(17982, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 8000, 8000, 0, 11, 8056, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - In Combat - Cast \'Frost Shock\''),
(17982, 0, 2, 0, 0, 0, 100, 0, 7000, 9000, 11000, 11000, 0, 11, 913, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - In Combat - Cast \'Healing Wave\''),
(17982, 0, 4, 0, 0, 0, 100, 0, 500, 500, 15000, 15000, 0, 11, 325, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - In Combat - Cast \'Lightning Shield\''),
(17982, 0, 5, 0, 40, 0, 100, 0, 25, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 25 Reached - Say Line 0'),
(17982, 0, 6, 7, 40, 0, 100, 0, 27, 0, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 27 Reached - Pause Waypoint'),
(17982, 0, 7, 0, 61, 0, 100, 0, 27, 0, 0, 0, 0, 80, 1798200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 27 Reached - Run Script'),
(17982, 0, 8, 0, 40, 0, 100, 0, 28, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 28 Reached - Say Line 2'),
(17982, 0, 9, 10, 40, 0, 100, 0, 31, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 31 Reached - Pause Waypoint'),
(17982, 0, 10, 0, 61, 0, 100, 0, 31, 0, 0, 0, 0, 80, 1798201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 31 Reached - Run Script'),
(17982, 0, 11, 12, 40, 0, 100, 0, 40, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 40 Reached - Pause Waypoint'),
(17982, 0, 12, 0, 61, 0, 100, 0, 40, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 40 Reached - Say Line 7'),
(17982, 0, 13, 0, 56, 0, 100, 0, 40, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 12, 16777215, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint Resumed - Say Line 8'),
(17982, 0, 14, 15, 40, 0, 100, 0, 43, 0, 0, 0, 0, 54, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 43 Reached - Pause Waypoint'),
(17982, 0, 15, 0, 61, 0, 100, 0, 43, 0, 0, 0, 0, 1, 9, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 43 Reached - Say Line 9'),
(17982, 0, 16, 0, 52, 0, 100, 0, 9, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Text 9 Over - Say Line 10'),
(17982, 0, 17, 18, 40, 0, 100, 0, 45, 0, 0, 0, 0, 54, 28000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 45 Reached - Pause Waypoint'),
(17982, 0, 18, 0, 61, 0, 100, 0, 45, 0, 0, 0, 0, 80, 1798202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 45 Reached - Run Script'),
(17982, 0, 19, 0, 40, 0, 100, 0, 49, 0, 0, 0, 0, 80, 1798203, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Waypoint 49 Reached - Run Script'),
(17982, 0, 20, 0, 7, 1, 100, 1, 0, 0, 0, 0, 0, 80, 1798204, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Demolitionist Legoso - On Evade - Run Script (Phase 1) (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
