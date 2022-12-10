-- DB update 2021_07_24_02 -> 2021_07_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_24_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_24_02 2021_07_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626854857651022900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626854857651022900');

-- Reduced the speed from 3.16 to 1.6 as the rest of the ogres in that place
UPDATE `creature_template` SET `speed_walk` = 1.6 WHERE (`entry` = 7371);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_25_00' WHERE sql_rev = '1626854857651022900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
