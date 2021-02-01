-- DB update 2018_01_28_01 -> 2018_01_28_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_01_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_01_28_01 2018_01_28_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1515920217003409800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1515920217003409800');

DELETE FROM `command` WHERE `name` = 'guild info';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('guild info', 2, 'Shows information about the target''s guild or a given Guild Id or Name.');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
