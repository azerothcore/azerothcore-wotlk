-- DB update 2021_11_04_00 -> 2021_11_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_04_00 2021_11_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634327540840591400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634327540840591400');

DELETE FROM `command` WHERE `name` IN ('bags','bags clear');
INSERT INTO `command` VALUES
('bags',2,'Syntax: .bags $subcommand \nType .bags to see the list of possible subcommands or .help bags $subcommand to see info on subcommands'),
('bags clear',2,'Syntax: .bags clear $itemQuality \nClear from players\' bags all items including and below $itemQuality (or all items if used .bags clear all).');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_04_01' WHERE sql_rev = '1634327540840591400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
