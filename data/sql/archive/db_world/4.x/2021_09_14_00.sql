-- DB update 2021_09_13_11 -> 2021_09_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_13_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_13_11 2021_09_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624914323095978900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624914323095978900');

DELETE FROM `acore_string` WHERE `entry` IN (30096, 30097);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
  (30096, 'LFG is set to 1 player queue for debugging.'),
  (30097, 'LFG is set to normal queue.');

DELETE FROM `command` WHERE `name` = 'debug lfg';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
  ('debug lfg', 3, 'Syntax: .debug lfg\r\nToggle debug mode for lfg. In debug mode GM can start lfg queue with one player.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_14_00' WHERE sql_rev = '1624914323095978900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
