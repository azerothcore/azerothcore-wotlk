-- DB update 2022_03_07_00 -> 2022_03_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_07_00 2022_03_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646326494303486400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646326494303486400');

DELETE FROM `creature_text` WHERE `CreatureID` = 10184 AND `GroupID` = 5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10184, 5, 0, 'You seek to lure me from my clutch? You shall pay for your insolence!', 14, 0, 100, 0, 0, 0, 8570, 0, 'Onyxia - Boundary Evade');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_07_01' WHERE sql_rev = '1646326494303486400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
