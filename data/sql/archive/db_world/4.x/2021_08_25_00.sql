-- DB update 2021_08_24_07 -> 2021_08_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_24_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_24_07 2021_08_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629485842027723200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629485842027723200');

ALTER TABLE `playercreateinfo_item`
    CHANGE `amount` `amount` INT SIGNED NOT NULL DEFAULT 1;

DELETE FROM `playercreateinfo_item` WHERE `itemid` = 40582;
INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `Note`) VALUES (0, 6, 40582, -1, "[TDB PH] - unsused Scourgestone");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_25_00' WHERE sql_rev = '1629485842027723200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
