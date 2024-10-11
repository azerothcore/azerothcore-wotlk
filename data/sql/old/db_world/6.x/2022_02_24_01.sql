-- DB update 2022_02_24_00 -> 2022_02_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_24_00 2022_02_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644947346227111600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644947346227111600');

DELETE FROM `creature_text` WHERE `CreatureID`=19255 AND `GroupID`=0 AND `ID`=4;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19255, 0, 4, "The warchief's put a price on Arazzius's head! As of right now, that no-good piece of demon refuse is enemy number one.", 12, 1, 100, 1, 0, 0, 16391, 0, "General Krakork");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_24_01' WHERE sql_rev = '1644947346227111600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
