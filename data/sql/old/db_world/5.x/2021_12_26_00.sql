-- DB update 2021_12_25_03 -> 2021_12_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_25_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_25_03 2021_12_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638641366613580300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638641366613580300');

DELETE FROM `command` WHERE `name` IN ('settings', 'settings announcer');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('settings', 1, 'Syntax: .settings $subcommand\nType .setting to see the list of all available commands.'),
('settings announcer', 1, 'Syntax: .settings announcer <type> <on/off>.\nDisables receiving announcements. Valid announcement types are: \'autobroadcast\', \'arena\' and \'bg\'');

DELETE FROM `acore_string` WHERE `entry` IN (5079, 5080, 5081);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5079, 'You must be at least level %u to disable autobroadcast messages.'),
(5080, 'You are now receiving global %s messages.'),
(5081, 'You will no longer receive global %s messages.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_26_00' WHERE sql_rev = '1638641366613580300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
