-- DB update 2021_12_09_01 -> 2021_12_09_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_09_01 2021_12_09_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638818214'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638818214');

-- Command: Move ".itemmove" to ".item move"
UPDATE `command` SET `name`='item move' WHERE `name`='itemmove';

-- Add new command: ".item restore"
DELETE FROM `command` WHERE `name` = 'item restore';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore', '2', 'Syntax: .item restore [#recoveryItemId] [#playername]\r\n\r\nRestore an disposed item for the specified player. Get recoveryId from ".item restore list" command.');

-- Add new command: ".item restore list"
DELETE FROM `command` WHERE `name` = 'item restore list';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES ('item restore list', '2', 'Syntax: .item restore list [#playername]\r\n\r\nSee restorable items for the specified player.');

-- Add new string: "LANG_COMMAND_DISABLED"
DELETE FROM `acore_string` WHERE `entry` = 5070;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (5070, 'The command is disabled by config');

-- Add new string: "LANG_ITEM_RESTORE_LIST"
DELETE FROM `acore_string` WHERE `entry` = 197;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (197, 'Recover id: %u | Item: %s (%u) | Count: %u');

-- Add new string: "LANG_ITEM_RESTORE_LIST_EMPTY"
DELETE FROM `acore_string` WHERE `entry` = 198;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (198, 'Player has no recoverable items');

-- Add new string: "LANG_ITEM_RESTORE_MISSING"
DELETE FROM `acore_string` WHERE `entry` = 199;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (199, 'Player has no recoverable item with id %u');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_09_02' WHERE sql_rev = '1638818214';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
