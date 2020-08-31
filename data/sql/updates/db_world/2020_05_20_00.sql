-- DB update 2020_05_19_01 -> 2020_05_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_19_01 2020_05_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1587630388241612100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587630388241612100');

ALTER TABLE `acore_string`
	CHANGE `content_loc1` `locale_koKR` TEXT,
	CHANGE `content_loc2` `locale_frFR` TEXT,
	CHANGE `content_loc3` `locale_deDE` TEXT,
	CHANGE `content_loc4` `locale_zhCN` TEXT,
	CHANGE `content_loc5` `locale_zhTW` TEXT,
	CHANGE `content_loc6` `locale_esES` TEXT,
	CHANGE `content_loc7` `locale_esMX` TEXT,
	CHANGE `content_loc8` `locale_ruRU` TEXT;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
