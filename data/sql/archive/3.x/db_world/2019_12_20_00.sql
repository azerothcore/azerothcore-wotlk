-- DB update 2019_12_18_00 -> 2019_12_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_18_00 2019_12_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1575409612123583009'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575409612123583009');

DELETE FROM `command` WHERE `name` IN ('player learn','player unlearn');
INSERT INTO `command` (`name`, `security`, `help`)
VALUES
('player learn',2,'Syntax: .player learn #playername #spell [all].'),
('player unlearn',2,'Syntax: .player unlearn #playername #spell [all].');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
