-- DB update 2022_04_02_12 -> 2022_04_02_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_02_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_02_12 2022_04_02_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648810356834040900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648810356834040900');

DELETE FROM `command` WHERE `name` IN ('respawn', 'respawn all');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('respawn', 2, 'Syntax: .respawn\nRespawn the selected unit without waiting respawn time expiration.'),
('respawn all', 2, 'Syntax: .respawn all\nRespawn all nearest creatures and GO without waiting respawn time expiration.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_02_13' WHERE sql_rev = '1648810356834040900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
