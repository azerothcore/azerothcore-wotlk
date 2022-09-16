-- DB update 2021_05_30_02 -> 2021_05_30_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_30_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_30_02 2021_05_30_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621718778456057300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621718778456057300');

DELETE FROM `command` WHERE `name` = 'server debug';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('server debug', 3, 'Syntax: .server debug\r\nShows detailed information about the server setup, useful when reporting a bug.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_05_30_03' WHERE sql_rev = '1621718778456057300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
