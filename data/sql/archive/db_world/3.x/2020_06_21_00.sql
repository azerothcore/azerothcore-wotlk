-- DB update 2020_06_19_01 -> 2020_06_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_19_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_19_01 2020_06_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588709577858892600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588709577858892600');

DELETE FROM `acore_string` WHERE `entry` IN (30085,30086);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(30085, 'Battleground Debugging is already enabled in the config, thus you are unable to enable/disable it with command.'),
(30086, 'Arena Debugging is already enabled in the config, thus you are unable to enable/disable it with command.');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
