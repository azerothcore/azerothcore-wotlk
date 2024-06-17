-- DB update 2018_07_16_00 -> 2018_08_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_07_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_07_16_00 2018_08_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1534115647861309430'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1534115647861309430');

DELETE FROM `command` WHERE `name` IN
('npc set factionid',
'npc set faction temp',
'npc set faction original',
'npc set faction permanent');

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc set faction temp', 3, 'Syntax: .npc set faction temp #factionid\r\n\r\nTemporarily set the faction of the selected creature to #factionid.'),
('npc set faction original', 3, 'Syntax: .npc set faction original\r\n\r\nRevert the temporal faction of the selected creature.'),
('npc set faction permanent', 3, 'Syntax: .npc set faction permanent #factionid\r\n\r\nPermanently set the faction of the selected creature to #factionid.');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
