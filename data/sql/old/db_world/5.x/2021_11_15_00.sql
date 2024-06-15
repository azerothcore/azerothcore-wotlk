-- DB update 2021_11_14_01 -> 2021_11_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_14_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_14_01 2021_11_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636656798364802400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636656798364802400');

DELETE FROM `command` WHERE `name` IN ('inventory','inventory count');
INSERT INTO `command` VALUES
('inventory',1,'Syntax: .inventory $subcommand \nType .inventory to see the list of possible subcommands or .help inventory $subcommand to see info on subcommands'),
('inventory count',1,'Syntax: .inventory count $playerName or $plaerGuid \nCount free slots in bags divided into different bag types.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_15_00' WHERE sql_rev = '1636656798364802400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
