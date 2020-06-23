-- DB update 2020_06_23_00 -> 2020_06_23_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_23_00 2020_06_23_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588709577858892600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588709577858892600');

ALTER TABLE `item_template`
	CHANGE COLUMN `stat_value1` `stat_value1` INT NOT NULL DEFAULT 0 AFTER `stat_type1`,
	CHANGE COLUMN `stat_value2` `stat_value2` INT NOT NULL DEFAULT 0 AFTER `stat_type2`,
	CHANGE COLUMN `stat_value3` `stat_value3` INT NOT NULL DEFAULT 0 AFTER `stat_type3`,
	CHANGE COLUMN `stat_value4` `stat_value4` INT NOT NULL DEFAULT 0 AFTER `stat_type4`,
	CHANGE COLUMN `stat_value5` `stat_value5` INT NOT NULL DEFAULT 0 AFTER `stat_type5`,
	CHANGE COLUMN `stat_value6` `stat_value6` INT NOT NULL DEFAULT 0 AFTER `stat_type6`,
	CHANGE COLUMN `stat_value7` `stat_value7` INT NOT NULL DEFAULT 0 AFTER `stat_type7`,
	CHANGE COLUMN `stat_value8` `stat_value8` INT NOT NULL DEFAULT 0 AFTER `stat_type8`,
	CHANGE COLUMN `stat_value9` `stat_value9` INT NOT NULL DEFAULT 0 AFTER `stat_type9`,
	CHANGE COLUMN `stat_value10` `stat_value10` INT NOT NULL DEFAULT 0 AFTER `stat_type10`;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;