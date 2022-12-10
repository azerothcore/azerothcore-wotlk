-- DB update 2019_04_30_01 -> 2019_05_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_30_01 2019_05_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1556034383320746900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556034383320746900');

DELETE FROM `creature_text` WHERE `CreatureID` IN(32718, 32714, 32720) AND `GroupID`=0 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(32718, 0, 0, 'Be well, champion.', 12, 0, 50, 0, 0, 0, 0, 0, 'Dalaran shamy'),
(32714, 0, 0, 'Elune bless you, champion.', 12, 0, 100, 0, 0, 0, 0, 0, 'Dalaran priest'),
(32720, 0, 0, 'Good to see you, champion.', 12, 0, 50, 0, 0, 0, 0, 0, 'Dalaran mage');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
