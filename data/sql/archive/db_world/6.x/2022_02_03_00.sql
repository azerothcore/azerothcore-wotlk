-- DB update 2022_02_01_01 -> 2022_02_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_01_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_01_01 2022_02_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642946406666106700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642946406666106700');

DELETE FROM `command` WHERE `name` = 'guild rename';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('guild rename', 3, 'Syntax: .guild rename "$GuildName" "$NewGuildName" \n\n Rename a guild named $GuildName with $NewGuildName. Guild name and new guild name must in quotes.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_03_00' WHERE sql_rev = '1642946406666106700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
