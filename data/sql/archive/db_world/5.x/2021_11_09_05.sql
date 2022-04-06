-- DB update 2021_11_09_04 -> 2021_11_09_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_09_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_09_04 2021_11_09_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636434085380352700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636434085380352700');

UPDATE `creature_template` SET `ScriptName` = 'boss_quartermaster_zigris', `AIName` = '' WHERE `entry` = 9736;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 9736;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_09_05' WHERE sql_rev = '1636434085380352700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
