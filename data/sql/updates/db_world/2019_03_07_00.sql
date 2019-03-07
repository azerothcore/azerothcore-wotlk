-- DB update 2019_03_03_00 -> 2019_03_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_03_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_03_03_00 2019_03_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1551539925032805900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1551539925032805900');

DELETE FROM `trinity_string` WHERE `entry` = 1031;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(1031, 'An account password can NOT be longer than 16 characters (client limit). Account NOT created.');

UPDATE `trinity_string` SET `content_default` = 'Account name can\'t be longer than 20 characters (client limit), account not created!' WHERE (`entry` = '1005');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
