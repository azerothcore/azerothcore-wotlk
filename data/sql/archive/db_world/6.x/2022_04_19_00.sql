-- DB update 2022_04_18_04 -> 2022_04_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_18_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_18_04 2022_04_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644531208243387100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644531208243387100');

DELETE FROM `command` WHERE `name`='reload mail_server_template';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload mail_server_template', 3, 'Syntax: .reload mail_server_template\nReload server_mail_template table.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_19_00' WHERE sql_rev = '1644531208243387100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
