-- DB update 2020_05_25_00 -> 2020_05_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_25_00 2020_05_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588099547971545300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588099547971545300');

UPDATE `command` SET `name` = "lookup teleport", `help` = "Syntax: .lookup teleport $substring\r\nSearch and output all .teleport command locations with provide $substring in name." WHERE `name` = "lookup tele";
UPDATE `command` SET `name` = "teleport", `help` = "Syntax: .teleport #location\r\nTeleport player to a given location." WHERE `name` = "tele";
UPDATE `command` SET `name` = "teleport add", `help` = "Syntax: .teleport add $name\r\nAdd current your position to .teleport command target locations list with name $name." WHERE `name` = "tele add";
UPDATE `command` SET `name` = "teleport del", `help` = "Syntax: .teleport del $name\r\nRemove location with name $name for .teleport command locations list." WHERE `name` = "tele del";
UPDATE `command` SET `name` = "teleport group", `help` = "Syntax: .teleport group#location\r\nTeleport a selected player and his group members to a given location." WHERE `name` = "tele group";
UPDATE `command` SET `name` = "teleport name", `help` = "Syntax: .teleport name [#playername] #location\r\nTeleport the given character to a given location. Character can be offline.\r\nTo teleport to homebind, set #location to \"$home\" (without quotes)." WHERE `name` = "tele name";

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
