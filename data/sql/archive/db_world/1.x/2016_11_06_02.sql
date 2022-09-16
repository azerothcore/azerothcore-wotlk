-- DB update 2016_11_06_01 -> 2016_11_06_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2016_11_06_01 2016_11_06_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1478458446109383200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world(`sql_rev`) VALUES ('1478458446109383200');

DELETE FROM `command` WHERE `name` = 'reload broadcast_text';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload broadcast_text', 3, 'Syntax: .reload broadcast_text\r\n\r\nReload broadcast_text table.');
--
-- END UPDATING QUERIES
--
COMMIT;
END;
//
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
