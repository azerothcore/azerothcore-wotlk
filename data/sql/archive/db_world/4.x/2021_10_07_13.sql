-- DB update 2021_10_07_12 -> 2021_10_07_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_12 2021_10_07_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633260465157196700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633260465157196700');

DELETE FROM `creature_text` WHERE `CreatureID` = 9938 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9938, 0, 0, 'Emperor Thaurissan does not wish to be disturbed! Turn back now or face your doom, weak mortals!', 14, 0, 100, 0, 0, 0, 5430, 3, 'Magmus - SAY_MAGMUS_BRAZIERS_LIT');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_13' WHERE sql_rev = '1633260465157196700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
