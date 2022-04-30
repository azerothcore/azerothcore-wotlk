-- DB update 2022_03_14_01 -> 2022_03_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_14_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_14_01 2022_03_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645819759880724600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645819759880724600');

DELETE FROM `acore_string` WHERE `entry` = 726;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(726, '|cffff0000[Arena Queue]:|r %s (skirmish %s) -- [%u-%u] [%u/%u]|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_15_00' WHERE sql_rev = '1645819759880724600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
