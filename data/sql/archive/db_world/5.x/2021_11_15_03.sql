-- DB update 2021_11_15_02 -> 2021_11_15_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_15_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_15_02 2021_11_15_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636956243535419760'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636956243535419760');

DELETE FROM `command` WHERE `name` = 'character rename';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('character rename', 2, 'Syntax: .character rename [$name] [reserveName] [$newName]\r\n\r\nMark selected in game or by $name in command character for rename at next login.\r\n\r\nIf [reserveName] is 1 then the player\'s current name is added to the list of reserved names.\r\nIf [newName] then the player will be forced rename.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_15_03' WHERE sql_rev = '1636956243535419760';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
