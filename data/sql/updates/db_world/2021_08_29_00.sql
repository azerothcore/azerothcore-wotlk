-- DB update 2021_08_27_00 -> 2021_08_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_27_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_27_00 2021_08_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629233438552386300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629233438552386300');

UPDATE `command` SET `help` = 'Syntax: .modify mount #id #speed\nSet CreatureDisplayID as #id and set speed to #speed value between 0.1 - 50.0' WHERE `name` = 'modify mount';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_29_00' WHERE sql_rev = '1629233438552386300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
