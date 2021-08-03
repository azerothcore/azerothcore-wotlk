-- DB update 2021_07_29_04 -> 2021_07_29_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_29_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_29_04 2021_07_29_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627115613806415400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627115613806415400');

-- Relocate Peacebloom gameobject (guid=26813) to avoid collision with Darkmoon Faire and remove it from game_event_gameobject (de-)spawns
UPDATE `gameobject` SET `position_x` = -9570.9, `position_y` = 120.2, `position_z` = 59.594 WHERE `guid` = 26813;
DELETE FROM `game_event_gameobject` WHERE `guid` = 26813 AND `eventEntry` = -4;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_29_05' WHERE sql_rev = '1627115613806415400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
