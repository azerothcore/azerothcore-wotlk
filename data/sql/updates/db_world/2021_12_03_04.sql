-- DB update 2021_12_03_03 -> 2021_12_03_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_03 2021_12_03_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637968467142598700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637968467142598700');

DELETE FROM `creature_text` WHERE `CreatureID` = 16097;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16097, 0, 0, 'My torture is ended and now I can join the Goddess. Thank you so very much!', 14, 0, 100, 0, 0, 0, 11860, 0, 'Isalien - ON DEATH');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_isalien' WHERE `entry` = 16097;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 16097 AND `source_type` = 0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_03_04' WHERE sql_rev = '1637968467142598700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
