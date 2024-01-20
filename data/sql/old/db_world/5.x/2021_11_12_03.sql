-- DB update 2021_11_12_02 -> 2021_11_12_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_12_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_12_02 2021_11_12_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636416788284117500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636416788284117500');

DELETE FROM `command` WHERE `name`='debug dummy';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('debug dummy',3,'Syntax: .debug dummy <???>

Catch-all debug command. Does nothing by default. If you want it to do things for testing, add the things to its script in cs_debug.cpp.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_12_03' WHERE sql_rev = '1636416788284117500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
