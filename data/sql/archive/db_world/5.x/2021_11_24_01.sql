-- DB update 2021_11_24_00 -> 2021_11_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_24_00 2021_11_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637516999973651100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637516999973651100');

UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) removed.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 473;
UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) rewarded.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 474;
UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) completed.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 475;
UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) is already active.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 476;

DELETE FROM `acore_string` WHERE `entry` IN (1516, 5067, 5068, 5069);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(1516, 'Quest ID %u does not exist'),
(5067, 'Quest %s (%u) added.'),
(5068, 'Quest %s (%u) not found in quest log.'),
(5069, 'The quest must be active and complete before rewarding');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_24_01' WHERE sql_rev = '1637516999973651100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
