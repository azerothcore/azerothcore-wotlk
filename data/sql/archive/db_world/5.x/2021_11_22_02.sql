-- DB update 2021_11_22_01 -> 2021_11_22_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_22_01 2021_11_22_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635972083556511200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635972083556511200');

-- Majordomo texts
DELETE FROM `creature_text` WHERE `CreatureID`=12018 AND `GroupID`=11 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12018, 11, 0, 'My flame... Please, don\'t take away my flame...', 14, 0, 100, 0, 0, 8042, 0, 0, 'majordomo SAY_DEATH');

-- Ragnaros auras
UPDATE `creature_template_addon` SET `auras`='20563 21387' WHERE `entry`=11502;

-- Ragnaros Texts
UPDATE `creature_text` SET `comment`='ragnaros SAY_KNOCKBACK' WHERE  `CreatureID`=11502 AND `GroupID`=7 AND `ID`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_22_02' WHERE sql_rev = '1635972083556511200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
