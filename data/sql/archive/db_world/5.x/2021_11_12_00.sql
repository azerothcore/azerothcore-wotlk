-- DB update 2021_11_11_00 -> 2021_11_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_11_00 2021_11_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636652299107244900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636652299107244900');

DELETE FROM `creature_text` WHERE `CreatureID` = 10316;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10316, 0, 0, '%s attempts to run away in fear!', 16, 0, 100, 0, 0, 0, 1150, 0, 'Blackhand Incarcerator - EMOTE_FLEE');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_12_00' WHERE sql_rev = '1636652299107244900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
