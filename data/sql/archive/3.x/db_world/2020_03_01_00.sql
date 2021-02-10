-- DB update 2020_02_17_00 -> 2020_03_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_02_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_02_17_00 2020_03_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1580747652284896800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1580747652284896800');
DELETE FROM `command` WHERE  `name`='demorph';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('morph target', '1', 'Syntax: .morph target #displayid - Change the selected target''s current model id to #displayid.');
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('morph reset', '1', 'Syntax: .morph reset - Doesn''t use any parameters to reset the selected target''s model');
UPDATE `command` SET `help`='Syntax: .morph $subcommand\r\nType .morph to see the list of possible subcommands or ".help morph" to see info on subcommands' WHERE  `name`='morph';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
