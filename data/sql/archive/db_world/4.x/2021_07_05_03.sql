-- DB update 2021_07_05_02 -> 2021_07_05_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_05_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_05_02 2021_07_05_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624718377760938108'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624718377760938108');

-- Deletes Ratchet as Ally GY when dying in Thunder Bluff
DELETE FROM `graveyard_zone` WHERE `ID`= 249 AND `GhostZone`= 1638;

-- Adds Bloodhoof Village as Ally GY when dying in Thunder Bluff
DELETE FROM `graveyard_zone` WHERE `ID`= 1435 AND `GhostZone`= 1638;
INSERT INTO `graveyard_zone` (`ID`, `GhostZone`, `Faction`, `Comment`) VALUES
(1435, 1638, 469, 'Mulgore, Bloodhoof Village GY - Mulgore');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_05_03' WHERE sql_rev = '1624718377760938108';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
