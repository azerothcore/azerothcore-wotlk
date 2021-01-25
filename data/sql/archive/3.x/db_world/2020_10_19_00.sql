-- DB update 2020_10_15_00 -> 2020_10_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_15_00 2020_10_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1600739072121853409'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1600739072121853409');

/* brewfest camp hostile mobs */
DELETE FROM `game_event_creature` WHERE `guid` IN (7370, 22181, 22188, 22473);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(-24,7370),
(-24,22181),
(-24,22188),
(-24,22473);

/* brewfest camp non-hostile mobs */
DELETE FROM `game_event_creature` WHERE `guid` IN (12369, 12372, 21020, 21022, 21026);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(-24,12369),
(-24,12372),
(-24,21020),
(-24,21022),
(-24,21026);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
