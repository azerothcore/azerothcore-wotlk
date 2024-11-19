-- DB update 2021_01_24_00 -> 2021_01_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_24_00 2021_01_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1611229279609470857'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1611229279609470857');

-- Fix issue #4304, a cemetary for Horde in Darkshore
-- The graveyards are shared between Horde and Alliance, so remove the Horde specific one first

DELETE FROM `graveyard_zone` WHERE `ID`=512 AND `GhostZone`=148 AND `Faction`=67;
UPDATE `graveyard_zone` SET `Faction`=0 WHERE `ID`=469 AND `GhostZone`=148;
UPDATE `graveyard_zone` SET `Faction`=0 WHERE `ID`=35 AND `GhostZone`=148;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
