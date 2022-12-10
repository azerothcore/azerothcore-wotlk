-- DB update 2022_01_31_01 -> 2022_01_31_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_31_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_31_01 2022_01_31_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643502379399332300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643502379399332300');

DELETE FROM `command` WHERE `name` = 'go quest';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('go quest', 1, 'Syntax: .go quest <starter/ender> <quest>.\nTeleports you to the quest starter/ender creature or object.');

DELETE FROM `acore_string` WHERE `entry` = 5082;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_deDE`) VALUES
(5082, 'Incorrect syntax. Specify either \'starter\' or \'ender\'.', 'Falsche syntax. Entweder \'starter\' oder \'ender\' angeben.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_31_02' WHERE sql_rev = '1643502379399332300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
