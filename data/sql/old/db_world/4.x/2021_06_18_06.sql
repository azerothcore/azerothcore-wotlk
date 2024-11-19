-- DB update 2021_06_18_05 -> 2021_06_18_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_05 2021_06_18_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623263911660022500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623263911660022500');

UPDATE `creature_template` SET `speed_walk` = 0.66, `speed_run` = 1  WHERE (`entry` = 14428); -- Set Uruson walk speed to 0.66 and speed run to 1 from sniffs.

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_06' WHERE sql_rev = '1623263911660022500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
