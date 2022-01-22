-- DB update 2021_10_14_12 -> 2021_10_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_14_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_14_12 2021_10_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634136291669439800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634136291669439800');

-- Flee && Call for Help
DELETE FROM `acore_string` WHERE `entry` IN (5030, 5035);

-- Vaelastrasz boss fight
-- Nefarian texts
DELETE FROM `creature_text` WHERE `CreatureID`=10162 AND `GroupID`=14 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(10162, 14, 0, 'Ah...the heroes. You are persistent, aren''t you? Your ally here attempted to match his power against mine - and paid the price. Now he shall serve me...by slaughtering you. Get up, little red wyrm...and destroy them!', 14, 0, 100, 23, 0, 8279, 100003, 0, 'Lord Victor Nefarius SAY_NEFARIAN_VAEL_INTRO (BWL)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_15_00' WHERE sql_rev = '1634136291669439800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
