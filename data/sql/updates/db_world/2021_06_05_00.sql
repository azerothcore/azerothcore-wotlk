-- DB update 2021_06_04_01 -> 2021_06_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_04_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_04_01 2021_06_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622447836581960000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622447836581960000');

UPDATE `item_template_locale` SET `Name` = '完美反光茶晶石' , `Description` = '对应红色或黄色插槽。' WHERE `ID` = '41491' AND `locale` = 'zhCN';
UPDATE `item_template_locale` SET `Name` = '完美閃爍的巨黃晶' , `Description` = '與紅色或黃色插槽相容。' WHERE `ID` = '41491' AND `locale` = 'zhTW';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_05_00' WHERE sql_rev = '1622447836581960000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
