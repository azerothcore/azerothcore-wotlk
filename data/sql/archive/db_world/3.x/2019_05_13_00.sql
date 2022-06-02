-- DB update 2019_05_12_00 -> 2019_05_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_12_00 2019_05_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1557081152867649198'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557081152867649198');

DELETE FROM `command` WHERE `name` IN ('arena create', 'arena disband', 'arena rename', 'arena captain', 'arena info', 'arena lookup');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('arena create', 3, 'Syntax: .arena create $name "arena name" #type\n\nA command to create a new Arena-team in game. #type  = [2/3/5]'),
('arena disband', 3, 'Syntax: .arena disband #TeamID\n\nA command to disband Arena-team in game.'),
('arena rename', 3, 'Syntax: .arena rename "oldname" "newname"\n\nA command to rename Arena-team name.'),
('arena captain', 3, 'Syntax: .arena captain #TeamID $name\n\nA command to set new captain to the team $name must be in the team'),
('arena info', 2, 'Syntax: .arena info #TeamID\n\nA command that show info about arena team'),
('arena lookup', 2, 'Syntax: .arena lookup $name\n\nA command that give a list of arenateam with the given $name');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
