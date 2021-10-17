-- DB update 2018_01_08_02 -> 2018_01_21_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_01_08_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_01_08_02 2018_01_21_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1515648036333645900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1515648036333645900');

/* Create the command. */
DELETE FROM `command` WHERE `name` = "mutehistory";
INSERT INTO `command` (`name`,`security`,`help`) VALUES ('mutehistory', 2, "Syntax: .mutehistory $accountName. Shows mute history for an account.");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
